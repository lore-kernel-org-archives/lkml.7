Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7C2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D0B2133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138903;
	bh=bOEbv97eVOTyrs1zkuO2wC/rpdCpRtcq7MYShRl+ZG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iDc56vfo9i808+GfoWYWRJEMCqUC7B84BdbB22RWTadh940GRJ/UMcmEi18baEPih
	 MLCcXuLZzPvB9pB4txbsyynI5hMmKKFbQnfRH9iWCsyczAxpmqUi8fWI8foMRNyNqT
	 E6LEYe5uE4LsgLcsHp1ZnOBkQXxxmmi12j/k14Sw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfDARPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:15:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730828AbfDARO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:14:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7035920856;
        Mon,  1 Apr 2019 17:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138898;
        bh=bOEbv97eVOTyrs1zkuO2wC/rpdCpRtcq7MYShRl+ZG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HRq+cqHwopQcC7oCKsto5wVTIK+gi9M4/pT7W0LMaZRgCRKb7EzyS/bXPpVU2aFku
         qSe3dmZRzVOKRK9QhoYJaanr+eJDwWQOvOkEZWPjZ69ThhLV0r0buhMZfxFCaXg1ln
         MUUr2yUzeBBPbd5DWuauXak0mMbcIjEbnHbHrpdU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Farman <farman@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 4.19 053/134] vfio: ccw: only free cp on final interrupt
Date:   Mon,  1 Apr 2019 19:01:29 +0200
Message-Id: <20190401170049.495077280@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

From: Cornelia Huck <cohuck@redhat.com>

commit 50b7f1b7236bab08ebbbecf90521e84b068d7a17 upstream.

When we get an interrupt for a channel program, it is not
necessarily the final interrupt; for example, the issuing
guest may request an intermediate interrupt by specifying
the program-controlled-interrupt flag on a ccw.

We must not switch the state to idle if the interrupt is not
yet final; even more importantly, we must not free the translated
channel program if the interrupt is not yet final, or the host
can crash during cp rewind.

Fixes: e5f84dbaea59 ("vfio: ccw: return I/O results asynchronously")
Cc: stable@vger.kernel.org # v4.12+
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/cio/vfio_ccw_drv.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -72,20 +72,24 @@ static void vfio_ccw_sch_io_todo(struct
 {
 	struct vfio_ccw_private *private;
 	struct irb *irb;
+	bool is_final;
 
 	private = container_of(work, struct vfio_ccw_private, io_work);
 	irb = &private->irb;
 
+	is_final = !(scsw_actl(&irb->scsw) &
+		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
 	if (scsw_is_solicited(&irb->scsw)) {
 		cp_update_scsw(&private->cp, &irb->scsw);
-		cp_free(&private->cp);
+		if (is_final)
+			cp_free(&private->cp);
 	}
 	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
 
 	if (private->io_trigger)
 		eventfd_signal(private->io_trigger, 1);
 
-	if (private->mdev)
+	if (private->mdev && is_final)
 		private->state = VFIO_CCW_STATE_IDLE;
 }
 


