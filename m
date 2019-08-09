Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD490C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F09214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565358421;
	bh=Bll61FBxQFEAZ7jzNiAdReu8C4E77sdRKdifBhJ4bmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gl2smVAlWGSdRwKwEKpqF798RvAcfGjTTMMzhSXCMGwag86fy6yRe12n+iv0L8Tpj
	 uYLlCokqWndVKb8DLml5v0HBjmAjFmoslcUQ8GDIRCGB7rsyjKtmHYdhdcO1bl6H6X
	 uIyD5XEGGBgc1CF+2QV3AJ0jlXs5uacyr/l2v3Xc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407190AbfHINrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 09:47:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407157AbfHINq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 09:46:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F55521874;
        Fri,  9 Aug 2019 13:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565358417;
        bh=Bll61FBxQFEAZ7jzNiAdReu8C4E77sdRKdifBhJ4bmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zlsv9G6MuhFBr3zXmIqrQilQynDk8SQUYPHbpWhInyIDW+6R9B7svjNsXtZbFJgVC
         h3hke56vMjZITSNYC1knMIaZ/d4dFW/j6379UG1IjNYN+8e2FawaK5YuH2fPg5Jfcx
         8MtP0t8mh2iLO8D8RfICeFy56RUtoXOV6HF1+fYE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Aaron Armstrong Skomra <aaron.skomra@wacom.com>,
        Ping Cheng <ping.cheng@wacom.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.9 08/32] HID: wacom: fix bit shift for Cintiq Companion 2
Date:   Fri,  9 Aug 2019 15:45:11 +0200
Message-Id: <20190809133923.218536897@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190809133922.945349906@linuxfoundation.org>
References: <20190809133922.945349906@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Armstrong Skomra <skomra@gmail.com>

commit 693c3dab4e50403f91bca4b52fc6d8562a3180f6 upstream.

The bit indicating BTN_6 on this device is overshifted
by 2 bits, resulting in the incorrect button being
reported.

Also fix copy-paste mistake in comments.

Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
Reviewed-by: Ping Cheng <ping.cheng@wacom.com>
Link: https://github.com/linuxwacom/xf86-input-wacom/issues/71
Fixes: c7f0522a1ad1 ("HID: wacom: Slim down wacom_intuos_pad processing")
Cc: <stable@vger.kernel.org> # v4.5+
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/wacom_wac.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -529,14 +529,14 @@ static int wacom_intuos_pad(struct wacom
 		 */
 		buttons = (data[4] << 1) | (data[3] & 0x01);
 	} else if (features->type == CINTIQ_COMPANION_2) {
-		/* d-pad right  -> data[4] & 0x10
-		 * d-pad up     -> data[4] & 0x20
-		 * d-pad left   -> data[4] & 0x40
-		 * d-pad down   -> data[4] & 0x80
-		 * d-pad center -> data[3] & 0x01
+		/* d-pad right  -> data[2] & 0x10
+		 * d-pad up     -> data[2] & 0x20
+		 * d-pad left   -> data[2] & 0x40
+		 * d-pad down   -> data[2] & 0x80
+		 * d-pad center -> data[1] & 0x01
 		 */
 		buttons = ((data[2] >> 4) << 7) |
-		          ((data[1] & 0x04) << 6) |
+		          ((data[1] & 0x04) << 4) |
 		          ((data[2] & 0x0F) << 2) |
 		          (data[1] & 0x03);
 	} else if (features->type >= INTUOS5S && features->type <= INTUOSPL) {


