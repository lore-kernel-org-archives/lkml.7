Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08CDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698A920863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582036;
	bh=rO62X66w9GixiCjwfoDThcNQzJeuYOyDaZNvRBrVBjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xcN2IVdcE+zQMbLIMx/prnV+QREkNtknD0x8o2zqXeOAwpmJIBuRPVb4wXogDrLlH
	 iAuxHJALu8zRPFk8UpNr99g7Ra9q1mghCrsmJ21lhXABrouU9bM8W6q5OlDm3OuBr9
	 /ZK3M/L3YBp/FP5xT9QVETAjuZZZmbCE26ytL89Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731761AbfCZGdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:33:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731324AbfCZGdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:33:52 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF1E820857;
        Tue, 26 Mar 2019 06:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582031;
        bh=rO62X66w9GixiCjwfoDThcNQzJeuYOyDaZNvRBrVBjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IWosiVkOb0w7/paSleH1EbTkQx0yg2+CIqk6xnh1jjUYquUVcV4uIkHMP5IIUC6Pi
         RREMQ0esK2zCjUi9tgoLNAFc47Q2FQnyZ/zODaSqFpmVzexqI0/XjznvZEcZfIu3Zt
         lkpWSnD0fGR+3N290A81+fvWNMngKC7KBa2IqQxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 09/41] scsi: ibmvscsi: Protect ibmvscsi_head from concurrent modificaiton
Date:   Tue, 26 Mar 2019 15:29:46 +0900
Message-Id: <20190326042650.389330590@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042649.889479098@linuxfoundation.org>
References: <20190326042649.889479098@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

commit 7205981e045e752ccf96cf6ddd703a98c59d4339 upstream.

For each ibmvscsi host created during a probe or destroyed during a remove
we either add or remove that host to/from the global ibmvscsi_head
list. This runs the risk of concurrent modification.

This patch adds a simple spinlock around the list modification calls to
prevent concurrent updates as is done similarly in the ibmvfc driver and
ipr driver.

Fixes: 32d6e4b6e4ea ("scsi: ibmvscsi: add vscsi hosts to global list_head")
Cc: <stable@vger.kernel.org> # v4.10+
Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/ibmvscsi/ibmvscsi.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -96,6 +96,7 @@ static int client_reserve = 1;
 static char partition_name[96] = "UNKNOWN";
 static unsigned int partition_number = -1;
 static LIST_HEAD(ibmvscsi_head);
+static DEFINE_SPINLOCK(ibmvscsi_driver_lock);
 
 static struct scsi_transport_template *ibmvscsi_transport_template;
 
@@ -2274,7 +2275,9 @@ static int ibmvscsi_probe(struct vio_dev
 	}
 
 	dev_set_drvdata(&vdev->dev, hostdata);
+	spin_lock(&ibmvscsi_driver_lock);
 	list_add_tail(&hostdata->host_list, &ibmvscsi_head);
+	spin_unlock(&ibmvscsi_driver_lock);
 	return 0;
 
       add_srp_port_failed:
@@ -2296,7 +2299,9 @@ static int ibmvscsi_probe(struct vio_dev
 static int ibmvscsi_remove(struct vio_dev *vdev)
 {
 	struct ibmvscsi_host_data *hostdata = dev_get_drvdata(&vdev->dev);
+	spin_lock(&ibmvscsi_driver_lock);
 	list_del(&hostdata->host_list);
+	spin_unlock(&ibmvscsi_driver_lock);
 	unmap_persist_bufs(hostdata);
 	release_event_pool(&hostdata->pool, hostdata);
 	ibmvscsi_release_crq_queue(&hostdata->queue, hostdata,


