Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2864FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC64F2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257440;
	bh=YLQq4ZWAh0/97OeDyjtqkbTxhdzhEGG9XQBuIkQ4R38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h5NPiv8eXGI4UKjnEZKE0N3gMElfD7TldysxT8TJ8sa9B4B9yDjwuUES80PBbFRtX
	 tzYXYzEXGXk7Y09mCriJ8nt3m2Z80vlmxlCGWBxV440PPPjI2IzqNum/cC2OQef083
	 iDJRnLQqTZHWRXhuAmEY/Ow9svq/9XBqxVpSHjdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391211AbfCVMX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391190AbfCVMX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:23:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C59A3218A1;
        Fri, 22 Mar 2019 12:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257436;
        bh=YLQq4ZWAh0/97OeDyjtqkbTxhdzhEGG9XQBuIkQ4R38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DGSpnIQYxt+ICanKck5yzgNQVTpQWgxFq49UhFv1/Q/G9uydU5szWS++sE1qe0Gsx
         iRlS1vAKg0BaBQFiy6ChP7nixiOLPli1mbyKOCBLymL5q/dC46FGF5l9O3Rg9D5QvA
         ZDvo5j4MoWwRJgTSnQoF7zor/yKfhKus6O3yn0f4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Whitehead <tedheadster@gmail.com>,
        Nicolas Pitre <nico@linaro.org>
Subject: [PATCH 5.0 198/238] vt: perform safe console erase in the right order
Date:   Fri, 22 Mar 2019 12:16:57 +0100
Message-Id: <20190322111309.873698342@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Pitre <nicolas.pitre@linaro.org>

commit a6dbe442755999960ca54a9b8ecfd9606be0ea75 upstream.

Commit 4b4ecd9cb853 ("vt: Perform safe console erase only once") removed
what appeared to be an extra call to scr_memsetw(). This missed the fact
that set_origin() must be called before clearing the screen otherwise
old screen content gets restored on the screen when using vgacon. Let's
fix that by moving all the scrollback handling to flush_scrollback()
where it logically belongs, and invoking it before the actual screen
clearing in csi_J(), making the code simpler in the end.

Reported-by: Matthew Whitehead <tedheadster@gmail.com>
Signed-off-by: Nicolas Pitre <nico@linaro.org>
Tested-by: Matthew Whitehead <tedheadster@gmail.com>
Fixes: 4b4ecd9cb853 ("vt: Perform safe console erase only once")
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/vt/vt.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -935,8 +935,11 @@ static void flush_scrollback(struct vc_d
 {
 	WARN_CONSOLE_UNLOCKED();
 
+	set_origin(vc);
 	if (vc->vc_sw->con_flush_scrollback)
 		vc->vc_sw->con_flush_scrollback(vc);
+	else
+		vc->vc_sw->con_switch(vc);
 }
 
 /*
@@ -1503,8 +1506,10 @@ static void csi_J(struct vc_data *vc, in
 			count = ((vc->vc_pos - vc->vc_origin) >> 1) + 1;
 			start = (unsigned short *)vc->vc_origin;
 			break;
+		case 3: /* include scrollback */
+			flush_scrollback(vc);
+			/* fallthrough */
 		case 2: /* erase whole display */
-		case 3: /* (and scrollback buffer later) */
 			vc_uniscr_clear_lines(vc, 0, vc->vc_rows);
 			count = vc->vc_cols * vc->vc_rows;
 			start = (unsigned short *)vc->vc_origin;
@@ -1513,13 +1518,7 @@ static void csi_J(struct vc_data *vc, in
 			return;
 	}
 	scr_memsetw(start, vc->vc_video_erase_char, 2 * count);
-	if (vpar == 3) {
-		set_origin(vc);
-		flush_scrollback(vc);
-		if (con_is_visible(vc))
-			update_screen(vc);
-	} else if (con_should_update(vc))
-		do_update_region(vc, (unsigned long) start, count);
+	update_region(vc, (unsigned long) start, count);
 	vc->vc_need_wrap = 0;
 }
 


