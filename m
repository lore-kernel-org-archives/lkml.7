Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF68C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 18:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0055206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 18:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMJEV2Lh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfJMSsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 14:48:10 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46371 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbfJMSsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 14:48:10 -0400
Received: by mail-pl1-f194.google.com with SMTP id q24so6973567plr.13
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 11:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CeolOloPmeT1KftxvZqohSF0GTQr4950rvmG7EqO4RI=;
        b=LMJEV2LhnI60/Nw7SKRueRtun4v6UR9IX/6grkybDx8B+B0v9Ehmq6AwMQD3EnrlLz
         T31x4qCb0dMOf96n28fKNB7hh9OLhM+Gen0FZnmcaQi5qagwAWTwUurck+1UcqCNvQJm
         eKkovSONyDfHxxNvIVqjDHRfn4uRAtXwsX5wu0e8o+U1xDma0HpRZz2QP+UqEKyoL9sN
         nW+nKDBLr38INuRZIvYyEqIKUtH3TcQK8hA8Tbm8E9zpyUqYlm3psGqz08rio7VRLRd3
         Ysg6cQCKIBmQmssIEBwctG8ph8/cwb7BTONUhV8DvCnwDzDx6Y4O7M5hUa/rUWf2uMHp
         mXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CeolOloPmeT1KftxvZqohSF0GTQr4950rvmG7EqO4RI=;
        b=MFWP/O2Szn9jc8dr58B+Cy6AYxr6DszhGv/rdqb4P8zoC76UWev+XERQQTNmXqlkFp
         nblzdT4F8IzOEWYu8i9pwdpzHOmUpdXKOjDbENTuQu1wF7CbJ1Yuu8D/gy4RASNsGSJQ
         RXiP5L0Ih6ZKCnRK70QpUqsiNWz76xbRBla/UQ79TJFwnYNXCA3a41C4repuK/r7g2sE
         MAiCFvmLP3dE09QZS6lLw3h3Xp/kz9lZyZ/sRosc85ThU+THDCJ5MLFpwpAAS6k0d9OE
         LALBC11D2zztlz2VLdyEJEox1dZ+bjPxZAE7JcehDjncAIAf0Ml2S78+r0F7rfsOJhRo
         sb1Q==
X-Gm-Message-State: APjAAAXF/Ebk5FykQauQowpY9k05csRhvybRDpE/R0DYR8NYw9kadjvp
        0D+PVcbahr8iU530ycS4Q30=
X-Google-Smtp-Source: APXvYqwgOspCeAA1P9HhtOsCDHA+mh6Kslt8WDA4XoK+Jt4+cpb0481gXLa03aXA8nFDe2MgtkqcEg==
X-Received: by 2002:a17:902:bd05:: with SMTP id p5mr25785990pls.203.1570992489363;
        Sun, 13 Oct 2019 11:48:09 -0700 (PDT)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id 4sm13813926pja.29.2019.10.13.11.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 11:48:08 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, eric@anholt.net, wahrenst@gmx.net,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] staging: vc04_services: use DIV_ROUND_UP helper macro
Date:   Sun, 13 Oct 2019 21:47:50 +0300
Message-Id: <20191013184750.32766-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open-coded division calculation with the DIV_ROUND_UP
helper macro for better readability.
Issue found using coccinelle:
@@
expression n,d;
@@
(
- ((n + d - 1) / d)
+ DIV_ROUND_UP(n,d)
|
- ((n + (d - 1)) / d)
+ DIV_ROUND_UP(n,d)
)

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.h    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 63f71b2a492f..75104986201b 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -60,8 +60,8 @@ vchiq_static_assert(IS_POW2(VCHIQ_MAX_SLOTS_PER_SIDE));
 
 #define VCHIQ_SLOT_MASK        (VCHIQ_SLOT_SIZE - 1)
 #define VCHIQ_SLOT_QUEUE_MASK  (VCHIQ_MAX_SLOTS_PER_SIDE - 1)
-#define VCHIQ_SLOT_ZERO_SLOTS  ((sizeof(struct vchiq_slot_zero) + \
-	VCHIQ_SLOT_SIZE - 1) / VCHIQ_SLOT_SIZE)
+#define VCHIQ_SLOT_ZERO_SLOTS  DIV_ROUND_UP(sizeof(struct vchiq_slot_zero), \
+					    VCHIQ_SLOT_SIZE)
 
 #define VCHIQ_MSG_PADDING            0  /* -                                 */
 #define VCHIQ_MSG_CONNECT            1  /* -                                 */
-- 
2.23.0

