Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201D2C04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8B321019
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557154161;
	bh=RyF1wlVi21/bLL3I5s5Ar3Bqp+a2A4TvDOvYubn9KjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SdxwzOHymqeGU+aGkYG4EJfQu2wubABgxhGZRjDRLHH4ipuqRYYG1Gswal+ZIy77d
	 YYgJO2MZDqqGCnglyji9puEgWrCGw/7LCz43sKhuLvPB9aMPvB7e5cqVKsM/VEETGI
	 OB2KrxUbFaxSKTtIMKuftbvwk7UJcIIvHd8nPaWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfEFOtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:49:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728377AbfEFOtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:49:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEC90205ED;
        Mon,  6 May 2019 14:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557154157;
        bh=RyF1wlVi21/bLL3I5s5Ar3Bqp+a2A4TvDOvYubn9KjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hURBCsDNwJPZoXtInqypMndYLEN1oppDcGE3ybjhakgKwb45MI6x+GmJ1favVQe8W
         xwci8GQrY/LXPxc7l031+DYOQJ1krJ7FXsTsnCxRqVNqh130A3QhkVoM112yko+GDO
         frBwraktxyDUjPMTS42Yh11An3HXXgE5+f+rUB0k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.9 58/62] scsi: RDMA/srpt: Fix a credit leak for aborted commands
Date:   Mon,  6 May 2019 16:33:29 +0200
Message-Id: <20190506143056.425837830@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143051.102535767@linuxfoundation.org>
References: <20190506143051.102535767@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

commit 40ca8757291ca7a8775498112d320205b2a2e571 upstream.

Make sure that the next time a response is sent to the initiator that the
credit it had allocated for the aborted request gets freed.

Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicholas Bellinger <nab@linux-iscsi.org>
Cc: Mike Christie <mchristi@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Fixes: 131e6abc674e ("target: Add TFO->abort_task for aborted task resources release") # v3.15
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/ulp/srpt/ib_srpt.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2368,8 +2368,19 @@ static void srpt_queue_tm_rsp(struct se_
 	srpt_queue_response(cmd);
 }
 
+/*
+ * This function is called for aborted commands if no response is sent to the
+ * initiator. Make sure that the credits freed by aborting a command are
+ * returned to the initiator the next time a response is sent by incrementing
+ * ch->req_lim_delta.
+ */
 static void srpt_aborted_task(struct se_cmd *cmd)
 {
+	struct srpt_send_ioctx *ioctx = container_of(cmd,
+				struct srpt_send_ioctx, cmd);
+	struct srpt_rdma_ch *ch = ioctx->ch;
+
+	atomic_inc(&ch->req_lim_delta);
 }
 
 static int srpt_queue_status(struct se_cmd *cmd)


