Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F0FC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 23:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92DEF20825
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 23:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sybVLoJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731806AbfFGXLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 19:11:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50868 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731700AbfFGXLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 19:11:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id c66so3500587wmf.0;
        Fri, 07 Jun 2019 16:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PqR/4nQ0kMEXVQlzSnSXdJ4vrq0kGPr980mhH5i0djg=;
        b=sybVLoJiDJnW343uwPnsM5S0HNjMSLDL48ncmZRtj7mgfrBAr3I0s4Hs0qLIJPzFww
         /4xhK8BD+hIPhr4i0Fv5ybyRCGXQesuCl6NKAiI1BCD4B2hq+fc6tud+WvAoLwitIrdP
         tabsUlT1/0VQQu1XwWxGPdeaxzH4nXCBg48RUWfCBFpCcYNvEY2aSq2oIN0kU2YX/3Q/
         gEr/xVMF/Tmqju9DJAXw3QdP9o85u7cIdhsG/yAdU8F8CJ8ehvhg0VYhZEL8ZbwmX1kE
         O3HxxS93luXNkfMiRqX3X8Iwx+wC9ZFck1P9WiEjMLjkok7zXoo+xG5vRhev6XxbTnF4
         Ez+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PqR/4nQ0kMEXVQlzSnSXdJ4vrq0kGPr980mhH5i0djg=;
        b=GDjYvs0fI8LPMhyiptnLmhqzCaeKjnhNz7CsUXDr2Ol32j56lMQcZ2NzY5Igctx7Qi
         WgzMa28/5Sj6QThSHvPe5kgPd33vwebrmlykV3CLCMHC0fqWzEPSs3CwwAkr9W66/H7O
         z4wmHpVVDWCeFm3LE/H/aUz84XnjTeYUJc0O5gQsw+7GBrS+M9ZRvzMT8wXRbRxTHlOf
         NSitXxhAWUbGnwBCGKwEHHsaAe6VEi0XvYrluaDz9UtTyzKTT2Ss/UtffLEfYIa5/NdT
         YlYVBGU2U2wYvjYDM75RrBVHl+HEsbM/5FG0pUKE4yTiiEU1xtyM4iXhnaDnVkQxSlG/
         LbPQ==
X-Gm-Message-State: APjAAAWjVVb5k4gtL2KwkcCXjsBqs9ytRkB9Yv1KMfO4ZaEDA5j5aIl8
        kCBU7wXzmtQASNFL5cb09To=
X-Google-Smtp-Source: APXvYqzCKM/QhWEqfR073eumDXe5BXIfBA3ismSGYlRmD88R5qIgkreKWQ2hlT9fpfbTa8GVbAMSWw==
X-Received: by 2002:a1c:6c08:: with SMTP id h8mr5514087wmc.62.1559949078962;
        Fri, 07 Jun 2019 16:11:18 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id h84sm4108559wmf.43.2019.06.07.16.11.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 16:11:18 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Sean Young <sean@mess.org>
Subject: [PATCH v5 10/13] dt-bindings: media: sunxi-ir: Add H6 compatible
Date:   Sat,  8 Jun 2019 01:10:57 +0200
Message-Id: <20190607231100.5894-11-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607231100.5894-1-peron.clem@gmail.com>
References: <20190607231100.5894-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some minor differences between A31 or A64 with H6 IR peripheral.

But A31 IR driver is compatible with H6.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
Acked-by: Sean Young <sean@mess.org>
---
 Documentation/devicetree/bindings/media/sunxi-ir.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/sunxi-ir.txt b/Documentation/devicetree/bindings/media/sunxi-ir.txt
index 1dd287a4ab3a..81eaf95fb764 100644
--- a/Documentation/devicetree/bindings/media/sunxi-ir.txt
+++ b/Documentation/devicetree/bindings/media/sunxi-ir.txt
@@ -6,6 +6,7 @@ Required properties:
 	"allwinner,sun5i-a13-ir"
 	"allwinner,sun6i-a31-ir"
 	"allwinner,sun50i-a64-ir", "allwinner,sun6i-a31-ir"
+	"allwinner,sun50i-h6-ir", "allwinner,sun6i-a31-ir"
 - clocks	    : list of clock specifiers, corresponding to
 		      entries in clock-names property;
 - clock-names	    : should contain "apb" and "ir" entries;
-- 
2.20.1

