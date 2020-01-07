Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D254C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472A924672
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431427;
	bh=GghM542/5An/xAVWZ1zB34NTn3sFJq1kzYBrhM2IJPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GBabQrXKTux/kcIbbe/ciQHaKnxWAy8naXJgwd+rj0J4bU01bDmVdFr9tXTC+k9qJ
	 oC/XKEcZbGu2jcLuHeRQ7vpTLxoS5jbWWrlCsVlXmGx+UVBNf/NN6+Ch4cAYC12HCA
	 qauW+JeyZqBPFqhxi9dBdm1Dvdv+vfyY6QHd07MA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbgAGVK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:10:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729944AbgAGVKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:10:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A24452080A;
        Tue,  7 Jan 2020 21:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431420;
        bh=GghM542/5An/xAVWZ1zB34NTn3sFJq1kzYBrhM2IJPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tyNuQz1qFol0iRpYrC4Cbhvrjv+kZNaZiBJMBZ5KqcQlRV3kb6Qzz1MHMasvtb3jW
         Q5GhjsakfuoxueEVyEQuPh4s8kY2wVrJLsppByOIJX9CbaZDTjdJ32TQzecMwYVZu1
         8eY1c2mlahjbiJivjZNpRi3N4jHtkYVaRsUQkZhI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <qutran@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 49/74] scsi: qla2xxx: Drop superfluous INIT_WORK of del_work
Date:   Tue,  7 Jan 2020 21:55:14 +0100
Message-Id: <20200107205216.096086745@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205135.369001641@linuxfoundation.org>
References: <20200107205135.369001641@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Bolshakov <r.bolshakov@yadro.com>

commit 600954e6f2df695434887dfc6a99a098859990cf upstream.

del_work is already initialized inside qla2x00_alloc_fcport, there's no
need to overwrite it. Indeed, it might prevent complete traversal of
workqueue list.

Fixes: a01c77d2cbc45 ("scsi: qla2xxx: Move session delete to driver work queue")
Cc: Quinn Tran <qutran@marvell.com>
Link: https://lore.kernel.org/r/20191125165702.1013-5-r.bolshakov@yadro.com
Acked-by: Himanshu Madhani <hmadhani@marvell.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Tested-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_target.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1210,7 +1210,6 @@ void qlt_schedule_sess_for_deletion(stru
 	    "Scheduling sess %p for deletion %8phC\n",
 	    sess, sess->port_name);
 
-	INIT_WORK(&sess->del_work, qla24xx_delete_sess_fn);
 	queue_work(sess->vha->hw->wq, &sess->del_work);
 }
 


