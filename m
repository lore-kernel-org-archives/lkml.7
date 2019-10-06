Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC01FC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 19:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2B42133F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 19:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWuTmuNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfJFTkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 15:40:40 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42904 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfJFTkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 15:40:40 -0400
Received: by mail-qk1-f194.google.com with SMTP id f16so10668075qkl.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 12:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tAvJBPPuJlaqIzmhwS7DOMxS9kFELAL1Kh1UTZJWTvw=;
        b=aWuTmuNt/cwf8xULZEND+TalnK7/OAylSM+8h2yu5z428rgEIM0BsJ/0eOvXo9/aC/
         M7DGMXrK4yEVfLKfU3hMTawTOOpcqTok4rAViUDfa8ewzwkasBzShe7RK45nkfX58ixX
         4ZjRcqUV1UL9iOzVAhmB3Iqj+awIcRUD3Zoj1DnJGTyUNoMV6/qoBh9QdrT8itbitH7V
         +eTadj6u6bakQ2ntNHEJ6+9KfyTupIgrihmqvAnhbrfOfaMixsqwCkVoYZ5q2uR4N/c2
         Y/oelBZyYzlyBcLZroa0C7210RDoO0RVQh4LZMKX/AlKSBGjUliIDLLCl8ufRFK8qoFM
         25vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tAvJBPPuJlaqIzmhwS7DOMxS9kFELAL1Kh1UTZJWTvw=;
        b=PN2Q5PZ+1k8TIF70mI6ZlYb3TPikJGsozlVtnxBuOVdSJ2cTA9MMJg8oiJnhpp0Xgj
         pFYvnEtgwyc+dd0bBJ9vYVbSWY7GlHTXHoAo4/Nx4D5VYaPhYka8W2Y8w6Ip5S+huZ0z
         pYQhrHxPdsDjPmtIMMvjyyOwowbq52JsVeWd8kpyvH02478jSME2gT5E3bqWg1Icmpxl
         1bii+IfyNEQZ9KkjQbrjZREVuKSFauzm07FLlaJN2SyyqRPTFlzWHCkDZCfVthrCB8fK
         XlQaVoKnTGtUAYVsR83IQ4lL19dMzD/SWdZ0c8p1vDbmaNthpLpb2pBdroLkKt7/lVlw
         NF0A==
X-Gm-Message-State: APjAAAXFcNberHWVmGoGAnX/VvklTAjIzIOKfVkqUE1tc8ztDkt8hIOi
        vVHj4rpDr3EXwVJ01fgicDc=
X-Google-Smtp-Source: APXvYqx7YXHPZO3/zImxSPgAk8ZTVWllN8562XHrz12UHwRmTN7W5vgwTmg93hSbrawEuiEtxzFs0g==
X-Received: by 2002:a37:4ecb:: with SMTP id c194mr19976895qkb.126.1570390839361;
        Sun, 06 Oct 2019 12:40:39 -0700 (PDT)
Received: from GBdebian.terracota.local ([177.103.155.130])
        by smtp.gmail.com with ESMTPSA id l48sm7912450qtb.50.2019.10.06.12.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 12:40:38 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, forest@alittletooquiet.net,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH] staging: vt6656: reorganize characters so the lines are under 80 ch
Date:   Sun,  6 Oct 2019 16:40:30 -0300
Message-Id: <20191006194030.8854-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up warnings of "line over 80 characters"

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/vt6656/rxtx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index c7522841c8cf..922872b62994 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -112,11 +112,11 @@ static u32 vnt_get_rsvtime(struct vnt_private *priv, u8 pkt_type,
 				       frame_length, rate);
 
 	if (pkt_type == PK_TYPE_11B)
-		ack_time = vnt_get_frame_time(priv->preamble_type, pkt_type,
-					      14, (u16)priv->top_cck_basic_rate);
+		ack_time = vnt_get_frame_time(priv->preamble_type, pkt_type, 14,
+					      (u16)priv->top_cck_basic_rate);
 	else
-		ack_time = vnt_get_frame_time(priv->preamble_type, pkt_type,
-					      14, (u16)priv->top_ofdm_basic_rate);
+		ack_time = vnt_get_frame_time(priv->preamble_type, pkt_type, 14,
+					      (u16)priv->top_ofdm_basic_rate);
 
 	if (need_ack)
 		return data_time + priv->sifs + ack_time;
-- 
2.20.1

