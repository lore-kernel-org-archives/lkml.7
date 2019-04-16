Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6409C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7841223C0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ikd0o67Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfDPOHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:07:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44402 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfDPOHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:07:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id y7so27232809wrn.11;
        Tue, 16 Apr 2019 07:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2+D4bewqFy4nGLicEOZn/Id12fvAtNwEFAcyOEIgm4I=;
        b=Ikd0o67ZrKxOaHpUssQg/OnYxGqylkllsNPGtrxJcnLkit4UW56jW+4/EbOSUKwKQH
         dS8NsY3nLTC+oAModX+id5nPXiuxtVNWmbXFA4o4LhP1xsTND+/EdAoYuRReX8DsKQ+7
         HJGChT42xfQwZFBgdkUHYD3zgcKVylkTp0ubKpp8BHl6ZJs9SRe0oN1/05XmgDOarRnF
         def1zr018F8pYwKaEdlUJR7V403ZLpsDclfIjpv0141MLBdOlJxo/rUp+xehxozjm3Pq
         XQU84t3teNr/8xeu3GRtJ74afsG4VNDqSsmD2BD2Cppa2kWI5r++czp1eO2l90yT6v/x
         PiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2+D4bewqFy4nGLicEOZn/Id12fvAtNwEFAcyOEIgm4I=;
        b=VPNVvMKaeSE2kXHUxlGxamAch5DJWwey91eVzoHku88QWovXPt6HfHxlRkyytZWZ3Q
         Og0th2aUYDh5Tv8GLGIQnJ4dIwrpU/TSVk31KaO8PAZZSqLlOmOByuFys5G7+fMqDQug
         cYZ1O26rNY5i6DZKr98mG49KsdXm0hrC/UH+93m0ZPlXsUcOj00Ha8RQ8y8Vyr2skGal
         K0quxLaO2pFgMVH3j91p/1L4Z0u9ttCvWpHXDOZAwMFH5hX+4qsbhYLex+D5Z14tuUEi
         ZSXMpYTCsdHZefLaPmIthPkJAZL6jkQOitW01ZcOP7Wdl/wxpQ9igWiR7OeIqYnJza0V
         9fMA==
X-Gm-Message-State: APjAAAXm0a/76DPjgnEi94Di3lwl1n7Qh3UmNwZ0xc0al4dCnkxjENTW
        Q8vACSJzRNYcE/QfRNd3OcQ=
X-Google-Smtp-Source: APXvYqwu2QX5QEz/JV3kPKI8dNHgOVqeHbvceTAs9Qx1OK5IqI+3fzyTpfshEBPokoK0R7pQAJHS1Q==
X-Received: by 2002:a5d:424b:: with SMTP id s11mr43565750wrr.158.1555423666052;
        Tue, 16 Apr 2019 07:07:46 -0700 (PDT)
Received: from 5WDYG62.mdi (static-css-cqn-143221.business.bouyguestelecom.com. [176.149.143.221])
        by smtp.gmail.com with ESMTPSA id v192sm24008494wme.24.2019.04.16.07.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 07:07:45 -0700 (PDT)
From:   Romain Izard <romain.izard.pro@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH 1/2] usb: gadget: f_ncm: Fix NTP-32 support
Date:   Tue, 16 Apr 2019 16:07:31 +0200
Message-Id: <20190416140732.21941-1-romain.izard.pro@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When connecting a CDC-NCM gadget to an host that uses the NTP-32 mode,
or that relies on the default CRC setting, the current implementation gets
confused, and does not expect the correct signature for its packets.

Fix this, by ensuring that the ndp_sign member in the f_ncm structure
always contain a valid value.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/usb/gadget/function/f_ncm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 5780fba620ab..d5c47e7a7f61 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -35,9 +35,7 @@
 
 /* to trigger crc/non-crc ndp signature */
 
-#define NCM_NDP_HDR_CRC_MASK	0x01000000
 #define NCM_NDP_HDR_CRC		0x01000000
-#define NCM_NDP_HDR_NOCRC	0x00000000
 
 enum ncm_notify_state {
 	NCM_NOTIFY_NONE,		/* don't notify */
@@ -526,6 +524,7 @@ static inline void ncm_reset_values(struct f_ncm *ncm)
 {
 	ncm->parser_opts = &ndp16_opts;
 	ncm->is_crc = false;
+	ncm->ndp_sign = ncm->parser_opts->ndp_sign;
 	ncm->port.cdc_filter = DEFAULT_FILTER;
 
 	/* doesn't make sense for ncm, fixed size used */
@@ -805,25 +804,20 @@ static int ncm_setup(struct usb_function *f, const struct usb_ctrlrequest *ctrl)
 	case ((USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE) << 8)
 		| USB_CDC_SET_CRC_MODE:
 	{
-		int ndp_hdr_crc = 0;
-
 		if (w_length != 0 || w_index != ncm->ctrl_id)
 			goto invalid;
 		switch (w_value) {
 		case 0x0000:
 			ncm->is_crc = false;
-			ndp_hdr_crc = NCM_NDP_HDR_NOCRC;
 			DBG(cdev, "non-CRC mode selected\n");
 			break;
 		case 0x0001:
 			ncm->is_crc = true;
-			ndp_hdr_crc = NCM_NDP_HDR_CRC;
 			DBG(cdev, "CRC mode selected\n");
 			break;
 		default:
 			goto invalid;
 		}
-		ncm->ndp_sign = ncm->parser_opts->ndp_sign | ndp_hdr_crc;
 		value = 0;
 		break;
 	}
@@ -840,6 +834,8 @@ static int ncm_setup(struct usb_function *f, const struct usb_ctrlrequest *ctrl)
 			ctrl->bRequestType, ctrl->bRequest,
 			w_value, w_index, w_length);
 	}
+	ncm->ndp_sign = ncm->parser_opts->ndp_sign |
+		(ncm->is_crc ? NCM_NDP_HDR_CRC : 0);
 
 	/* respond with data transfer or status phase? */
 	if (value >= 0) {
-- 
2.17.1

