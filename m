Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53353C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 15:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083E121670
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 15:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dohGZE1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfEAPED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 11:04:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46332 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfEAPED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 11:04:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id j11so8704431pff.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 08:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Qd9vLN/uYtTHcvh53VYCk0sgdAPldYjSpxhnGE2v42I=;
        b=dohGZE1RAbaK2rNhOHij+TMgBLZsEgEHypTa1qct72G1R3/oU3+SWHfVMgYUjYuyTD
         RejCOVx1MRvdWw8GhOjnTWQ9b2KHL9voUau8p+9MEHXdfUVPYF5tWQl30SJnG3xOOcxN
         U5PXJZNELn2WM1GLK7QskyT4ncP6B4CPsy1tDwMDVkFtqiGp+DzqqWGp+MNKwP+45w2z
         jnIOK7BnR7PZDrbWIYIvsR/8zwwh15Q0dXQADiw5FkLJit1e2BTf6SEXQnpvywN6709+
         eu3v7HrfQhDzJj7hDWO0U5XI5HjQokXKRt28HgtPST+CdAClB+8ysuYNsjqPHm233nN+
         fL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Qd9vLN/uYtTHcvh53VYCk0sgdAPldYjSpxhnGE2v42I=;
        b=WBGmnGN+41+d2GYHzM0hos+qXWaP9GV4G1S9xYlBywIl+TJFILEEPuOOGoBpLlE9Sp
         JEn9WK64pkjBASUG7GduIeWNJobZg6xML/KvMGYhqeW7WycMm5V8JmJ7/9Iu5+Ryw9sr
         Z7g4zMmFAPAEnWOAJ7bf4l+nX2t4WYOtfge/zracqTeTdsHo6yMzImmj6otlLAmSne9S
         rU21x7yKuzk8PxRWrj6Umu2hIsKaX13QWoTaL4Wpk/cZ8HyLpb6rw1kXOIc8htZjm5Um
         VjJknEdYJpiBrHCkgYaPn3bMHAG1T+Gf2GOry3XEb/1ccmtc9T9ihHTbgXFP9ztu/qXu
         Cxfw==
X-Gm-Message-State: APjAAAVvvPM4EfJ78lGz2x4LwLzB9i3s4wsQDxQJKmG7Z4mDXnTsSvun
        MZX0h1oRJEHdL1CNEiUQims=
X-Google-Smtp-Source: APXvYqxbz6B01LF0q6KoohjXYDUIk4TtWpWF2BK/JBxzWt1/zcGCu1J4ScXMP5QJdWP88b4lfVDGZg==
X-Received: by 2002:a63:8449:: with SMTP id k70mr24144861pgd.53.1556723042639;
        Wed, 01 May 2019 08:04:02 -0700 (PDT)
Received: from localhost.localdomain ([103.87.57.94])
        by smtp.gmail.com with ESMTPSA id m9sm6996701pfh.99.2019.05.01.08.03.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 08:04:01 -0700 (PDT)
From:   Vatsala Narang <vatsalanarang@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hadess@hadess.net, hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        julia.lawall@lip6.fr, Vatsala Narang <vatsalanarang@gmail.com>
Subject: [PATCH] staging: rtl8723bs: core: Prefer using the BIT Macro.
Date:   Wed,  1 May 2019 20:33:44 +0530
Message-Id: <20190501150344.14443-1-vatsalanarang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace bit shifting on 1 with the BIT(x) macro.

Issue found using coccinelle.

Signed-off-by: Vatsala Narang <vatsalanarang@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index d4842ba64951..d110d4514771 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1981,7 +1981,7 @@ unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_fra
 			if (status == 0) {
 				/* successful */
 				DBG_871X("agg_enable for TID =%d\n", tid);
-				psta->htpriv.agg_enable_bitmap |= 1 << tid;
+				psta->htpriv.agg_enable_bitmap |= BIT(tid);
 				psta->htpriv.candidate_tid_bitmap &= ~BIT(tid);
 			} else {
 				psta->htpriv.agg_enable_bitmap &= ~BIT(tid);
@@ -1999,8 +1999,10 @@ unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_fra
 
 		case RTW_WLAN_ACTION_DELBA: /* DELBA */
 			if ((frame_body[3] & BIT(3)) == 0) {
-				psta->htpriv.agg_enable_bitmap &= ~(1 << ((frame_body[3] >> 4) & 0xf));
-				psta->htpriv.candidate_tid_bitmap &= ~(1 << ((frame_body[3] >> 4) & 0xf));
+				psta->htpriv.agg_enable_bitmap &=
+					~BIT((frame_body[3] >> 4) & 0xf);
+				psta->htpriv.candidate_tid_bitmap &=
+					~BIT((frame_body[3] >> 4) & 0xf);
 
 				/* reason_code = frame_body[4] | (frame_body[5] << 8); */
 				reason_code = RTW_GET_LE16(&frame_body[4]);
-- 
2.17.1

