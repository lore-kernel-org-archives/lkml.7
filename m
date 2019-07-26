Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C0CC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA8922BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bau49PHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfGZSFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:05:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39576 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbfGZSFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:05:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id u25so38024312wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 11:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GRv1uPtp3JZb2L9jLLvJekEXywnzsMYNKfjR4TArm3Y=;
        b=bau49PHa34MEV8yDI/WbGik16Z/hKg7kLSfyGI7v3akORbEZp27XRSQkXp1XzUQLjz
         CFus+rWBbyGCcl8ygt/fb50JMMgWkPuB9rEkGvxu/olVrh67rfwvOOzv8m+agDWCtK41
         7YRVl33MHVAgZCEu21Wjjl9Rw6+LKJ/zEO0u8RdNjNPv8wzAD+EukqjfJNiMKtlxjDRF
         +jmeLOHtq6vAdypieXDKzUHFa/9kkyNv7yZ7Gvfb5w+gqw6914o0VzCmDPW8XgD34eBN
         WfnVP6eq49QBE3Gl/gUHSwxP8Mi/+dziv5+QO+WzleLOMEIDmZOzWn4LpeddfXK/fM0O
         pz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GRv1uPtp3JZb2L9jLLvJekEXywnzsMYNKfjR4TArm3Y=;
        b=PMl/T+V/U2LKLxwZgO7+DPVDAleZop0sxJuQv/ChYys2crr/AcT89wZLvckq5g8xvt
         VGw5QCjHkWOhaFSueFfPezhqw8tIov4C5B9ZpPXvKqjDv9GojPXTktta00+P9aImncCw
         pqQaw61UZXdfK1qRhaw/4ZP4akhxstkXJfc8LoD1+CYnA2YTYKLzUA6Op4z32W2DSwVl
         qQqf08BA/d11p8xStzmxaqZhgle7RBIhXZHiMly/W8V7ckXhvYi3m2vCsL+LzWJ92y1C
         lK8Ec45eB9AE5Wo19K7W8Pow+l/NhgCiq9aK059GV80EPBr1IPFRARnYxWE9B+WoZjCg
         hHPA==
X-Gm-Message-State: APjAAAUinX1j0/u5805ICYkSVWYXu1u8V3gDPGVohMmAM9gAwxXF4Uc7
        YqOmQ9ESyT3eyWdGbLAsHVWmuVpL
X-Google-Smtp-Source: APXvYqyLbzvuhCvDINqvCBQ19P7eZpTf/lDa/jrblhIW+kYmO+Z40erre5PrRcQxpiBpvsucnDnOEQ==
X-Received: by 2002:a05:600c:225a:: with SMTP id a26mr90622604wmm.81.1564164304810;
        Fri, 26 Jul 2019 11:05:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id p14sm43535931wrx.17.2019.07.26.11.05.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 11:05:04 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/6] staging: rtl8188eu: cleanup comparsion to NULL in usb_halinit.c
Date:   Fri, 26 Jul 2019 20:04:48 +0200
Message-Id: <20190726180448.2290-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726180448.2290-1-straube.linux@gmail.com>
References: <20190726180448.2290-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use if(!x) instead of if(x == NULL).
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/usb_halinit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index 0f54fde2f47b..16a57b31a439 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -1889,7 +1889,7 @@ void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 	if (mac_id >= NUM_STA) /* CAM_SIZE */
 		return;
 	psta = pmlmeinfo->FW_sta_info[mac_id].psta;
-	if (psta == NULL)
+	if (!psta)
 		return;
 	switch (mac_id) {
 	case 0:/*  for infra mode */
-- 
2.22.0

