Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474F6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197F420880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139555;
	bh=V9fSB0Sfd9Rp7OeSDMBIyypJmxAyVPMS/K8iEzLfIhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fnwmluT7bSLzujRHEF5dL4FXXlOmfbIflj2VSblAgdaOd8f6aiiVGNgiQ4l5rgFVn
	 Ja3WHfYVYOvGFWHPXJg/nUcbqCpGUtHpOUn4r6gfYDvO6lMnRlohaWG1+pMMVtJnx/
	 M7KfTfP9Rg2sKXiRcNX/XHBOVOmwbK84IFDXwoQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732473AbfDARZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:25:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732452AbfDARZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:25:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CF9320830;
        Mon,  1 Apr 2019 17:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139548;
        bh=V9fSB0Sfd9Rp7OeSDMBIyypJmxAyVPMS/K8iEzLfIhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rX72O11LUc5rVma2borjT7B9NlcYsZl1PIC/1d5qGyV9l9SPt5QlKBF/IqG1hPGPi
         OFFqTtDrxiWhPgG6nAwVZkUa5ziMAL/Usb2oSsZ6Ml5mvFdFuJvB8wdPZv046xS+ru
         sm+iqB/wbxXzKH/O4IIKTkFW+5af3XysBHKCsGpk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Farman <farman@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 4.14 107/107] vfio: ccw: only free cp on final interrupt
Date:   Mon,  1 Apr 2019 19:03:02 +0200
Message-Id: <20190401170055.554382018@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
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
@@ -70,20 +70,24 @@ static void vfio_ccw_sch_io_todo(struct
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
 	memcpy(private->io_region.irb_area, irb, sizeof(*irb));
 
 	if (private->io_trigger)
 		eventfd_signal(private->io_trigger, 1);
 
-	if (private->mdev)
+	if (private->mdev && is_final)
 		private->state = VFIO_CCW_STATE_IDLE;
 }
 


