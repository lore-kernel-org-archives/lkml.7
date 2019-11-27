Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29AEC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81F62154A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889340;
	bh=6V7r6TB9qW/1X5KnQjTT2gyh0o0FqU2iM3qP87EZEXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FUSANQwgBuC+2IBPYouH63nMoZFo5PW5tTbn8iLnChcBNePk73Mt8cqbT5cIEOJkC
	 ezJlY/vtekUv89+E6vsRi2ElFOGSnNx2vJZjfQ6LbGqt8wFtrX1DNhtDVNQHNahMgR
	 LwHMMKv5JnXu2uXjUlaPHBCPR5UFp5ri+sIvoPtc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387712AbfK0VPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:15:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:50596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387670AbfK0VPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:15:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E425621789;
        Wed, 27 Nov 2019 21:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574889318;
        bh=6V7r6TB9qW/1X5KnQjTT2gyh0o0FqU2iM3qP87EZEXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pyRMavpY/hgKzJv4KZrQghOQU0Da7auW6CULRCl1++YTokY1LiEtYj96krJzqyxMk
         iu9XMgdXaPOdGpHZHcDUVYBAnjIej/RJzNFXtpfv3zF9rXc9khlkD/P79GpUT+NQMC
         597rT200t0I5hL+XaZzkKMJ+gHUHBzIF9xs/knFI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        syzbot+495dab1f175edc9c2f13@syzkaller.appspotmail.com
Subject: [PATCH 5.4 58/66] appledisplay: fix error handling in the scheduled work
Date:   Wed, 27 Nov 2019 21:32:53 +0100
Message-Id: <20191127202739.120131623@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202632.536277063@linuxfoundation.org>
References: <20191127202632.536277063@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

commit 91feb01596e5efc0cc922cc73f5583114dccf4d2 upstream.

The work item can operate on

1. stale memory left over from the last transfer
the actual length of the data transfered needs to be checked
2. memory already freed
the error handling in appledisplay_probe() needs
to cancel the work in that case

Reported-and-tested-by: syzbot+495dab1f175edc9c2f13@syzkaller.appspotmail.com
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191106124902.7765-1-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/appledisplay.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/usb/misc/appledisplay.c
+++ b/drivers/usb/misc/appledisplay.c
@@ -164,7 +164,12 @@ static int appledisplay_bl_get_brightnes
 		0,
 		pdata->msgdata, 2,
 		ACD_USB_TIMEOUT);
-	brightness = pdata->msgdata[1];
+	if (retval < 2) {
+		if (retval >= 0)
+			retval = -EMSGSIZE;
+	} else {
+		brightness = pdata->msgdata[1];
+	}
 	mutex_unlock(&pdata->sysfslock);
 
 	if (retval < 0)
@@ -299,6 +304,7 @@ error:
 	if (pdata) {
 		if (pdata->urb) {
 			usb_kill_urb(pdata->urb);
+			cancel_delayed_work_sync(&pdata->work);
 			if (pdata->urbdata)
 				usb_free_coherent(pdata->udev, ACD_URB_BUFFER_LEN,
 					pdata->urbdata, pdata->urb->transfer_dma);


