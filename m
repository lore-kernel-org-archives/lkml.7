Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FE9C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A711728110
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+n68LNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfFCLP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 07:15:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39246 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfFCLPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 07:15:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so11617595wrt.6;
        Mon, 03 Jun 2019 04:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QB+KRWQyEvFJ6NF1QW+2V4OsJn2/GknxGQT/dO5nBXQ=;
        b=A+n68LNK/V7XMa9AhrfdGNMdMmXz4+16KxD2xav5JcBWwDnUhSpAWwK5ry3WDgNC+8
         3dR+bvp/l/X+2z6CwFuLux9QEJ0gqJD7mmszHbgylUuaLGK33tsuLL6H3JkvJ7VXvw+E
         Wh9IuhdIS9jE2u2nCHTm551MrVg3iPj09dm6guWC21lJtAHZqtbZu8iE30Jlnx5fneMl
         ubjaLYiBiu52+QGjpE6UdtZsx3fGmV8RkHQdHmpnbNAeDBOhlyVRS22MoIhILeAZlZrg
         7ejMYfxXtoKYGSL+CtOWH762k85LF0+RcY3s9NUaYy6a79/vDLrz9ZvKV7pL8fiTYJgd
         bOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QB+KRWQyEvFJ6NF1QW+2V4OsJn2/GknxGQT/dO5nBXQ=;
        b=Uzg93vBUAiC0yqVYP+6312Do5f/EM9FJ5I9+mIQ7mwv28RzATqhLRmWDfC3sPlX/We
         ymxBhKQuJeKAvQRtGnOI5qabWDCNGagMHV6BFALRUgkhekgaToFgYU9PDcuW8ob6cRhH
         oimXgJV3EHQ3Urxr7qQGJjVzPFEvJLOI2NOP4P1sq7jqAiP0PrzyI+X5sjqa9Lyir9Ev
         YCy4CYBOAS102RGe3GZV5TVPqfeDp4j5+Zo+00d/87iMsSa/wRHXIYSE9PF4eanM80Z5
         wC+0gRUNhVOaD/RxKTb0EjdP2jhZqIUiWFbPePqgju2f2/H9Lp2CQ92qELfSDlv+68Yz
         v3hg==
X-Gm-Message-State: APjAAAUuZk6AaP2a4qjVnJ1jvM/p348DxE8Lrpjvq2d+vYLxFx0JpDAC
        KvIvZzhHY69kwc3PeT/kUfE=
X-Google-Smtp-Source: APXvYqzoT8H0VTkgXvyNfXsw9pGquUry83J8VpY4e0SLNyvPeOsdCfsvzCqVo9qTsrHgcfz3CK7qRA==
X-Received: by 2002:adf:fc85:: with SMTP id g5mr15990524wrr.324.1559560524145;
        Mon, 03 Jun 2019 04:15:24 -0700 (PDT)
Received: from localhost.localdomain ([213.172.156.217])
        by smtp.gmail.com with ESMTPSA id o14sm14171217wrp.77.2019.06.03.04.15.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 03 Jun 2019 04:15:23 -0700 (PDT)
From:   Colin Sindle <csindle@gmail.com>
To:     Eric Piel <eric.piel@tremplin-utc.net>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Colin Sindle <csindle@gmail.com>
Subject: [PATCH] hp_accel: Add support for HP ProBook 450 G0.
Date:   Mon,  3 Jun 2019 13:14:46 +0200
Message-Id: <20190603111446.5395-1-csindle@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP ProBook 450 G0 needs a non-standard mapping (x_inverted).

Signed-off-by: Colin Sindle <csindle@gmail.com>
---
 drivers/platform/x86/hp_accel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/hp_accel.c b/drivers/platform/x86/hp_accel.c
index f61b8a176e20..7a2747455237 100644
--- a/drivers/platform/x86/hp_accel.c
+++ b/drivers/platform/x86/hp_accel.c
@@ -229,6 +229,7 @@ static const struct dmi_system_id lis3lv02d_dmi_ids[] = {
 	AXIS_DMI_MATCH("HPB440G3", "HP ProBook 440 G3", x_inverted_usd),
 	AXIS_DMI_MATCH("HPB440G4", "HP ProBook 440 G4", x_inverted),
 	AXIS_DMI_MATCH("HPB442x", "HP ProBook 442", xy_rotated_left),
+	AXIS_DMI_MATCH("HPB450G0", "HP ProBook 450 G0", x_inverted),
 	AXIS_DMI_MATCH("HPB452x", "HP ProBook 452", y_inverted),
 	AXIS_DMI_MATCH("HPB522x", "HP ProBook 522", xy_swap),
 	AXIS_DMI_MATCH("HPB532x", "HP ProBook 532", y_inverted),
-- 
2.20.1

