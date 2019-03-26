Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F05C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1762086C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582177;
	bh=WC8xcnsz9CXCNykI5eaLsGiOGkAfw7RGJivnY0kIBeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X3Ef06r2J4KEzz9QnNCpKuvbx4kVx2/GWjt7UlTQpyuhuJrZCPqCpnxJ2fc9di8PJ
	 pGdii3UZgremUO4X2CmvQmwv3FrLjOj6I7n0e7rL3xdVKq4p6WnzhA+xHoExR7FWYD
	 ZhpflOdI3tXg/Pi0mju3Uo1oA2QwGOW77/4GmLfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732185AbfCZGgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:36:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731580AbfCZGgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:36:13 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1183620863;
        Tue, 26 Mar 2019 06:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582172;
        bh=WC8xcnsz9CXCNykI5eaLsGiOGkAfw7RGJivnY0kIBeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HsYR6RpzH80sRJ0hiA4F+bo/z0Sp8L4JENfhIigOpOsPxt4QDmuMMLe9qes2Kcdzl
         nMnbQbIGZ70KRLlZ2MZBfGopmz9DPbDlgaBJSz03zisX7B5RpDhDlK1XH1id00ZZ9v
         DEPLMnoaCxF7Ob8v2xl0vMuo22aTc/f1/oV+Vpwo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 15/45] scsi: ibmvscsi: Protect ibmvscsi_head from concurrent modificaiton
Date:   Tue, 26 Mar 2019 15:29:58 +0900
Message-Id: <20190326042703.490706211@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042702.565683325@linuxfoundation.org>
References: <20190326042702.565683325@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
 
@@ -2271,7 +2272,9 @@ static int ibmvscsi_probe(struct vio_dev
 	}
 
 	dev_set_drvdata(&vdev->dev, hostdata);
+	spin_lock(&ibmvscsi_driver_lock);
 	list_add_tail(&hostdata->host_list, &ibmvscsi_head);
+	spin_unlock(&ibmvscsi_driver_lock);
 	return 0;
 
       add_srp_port_failed:
@@ -2293,7 +2296,9 @@ static int ibmvscsi_probe(struct vio_dev
 static int ibmvscsi_remove(struct vio_dev *vdev)
 {
 	struct ibmvscsi_host_data *hostdata = dev_get_drvdata(&vdev->dev);
+	spin_lock(&ibmvscsi_driver_lock);
 	list_del(&hostdata->host_list);
+	spin_unlock(&ibmvscsi_driver_lock);
 	unmap_persist_bufs(hostdata);
 	release_event_pool(&hostdata->pool, hostdata);
 	ibmvscsi_release_crq_queue(&hostdata->queue, hostdata,


