Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F89EC07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 18:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A79820815
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 18:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DX6mAzke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfEYSK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 14:10:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51838 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfEYSJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 14:09:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id f10so4898049wmb.1;
        Sat, 25 May 2019 11:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=83YdGTTjdVEgbMX9Pve7cooV7ArUmubUq0eyLyKNWLY=;
        b=DX6mAzkeprbAS8LEcZHXWGfX8FmT9LxCk+W9MNQARSEtOVNEeb5MpfnVHYd8v68GPF
         XphJ1dHafwu64rV2J6d7gAE2kwuEPHZuM+wGza8xAJAZh3PbYQ8cGjzxIioyrXUnbCiT
         H0sBjfaG3WBFMdjF8aA80lCIASJIBgHYKlBIlLyVko9Q0zeliBEgRD697rfHFKwqCOih
         cwckQP5DTM84BRQk89IIZH/PBKUERHqk2SvvGfc5LktIuaWjNQmf4HNnvF538DXu6ntD
         EjSdwKYMe7WZ2qFPbZRRjGWir6KR7M5fcsAGclh+gWP0aWGyFD95ZQjB6XnJQeLab/IG
         RQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=83YdGTTjdVEgbMX9Pve7cooV7ArUmubUq0eyLyKNWLY=;
        b=arBupDC4UxTMjTlaN8+gcnWfn6TljjsL99gu/lAjzUxQ6tL6KdfdyJrET+St/4UduY
         YgmvdW3tkDiWrj+jKtoosFLBaY/uevLU13tHml0bBgYAo6H6W8W5mLWQWIcBqyhix9pQ
         Nk/7+Hi6DHjAsZeYg5c8w1QhXzD90KK+Gq8Kal7nA6K8ztMMtnfbEGTsu505hlkgQBDk
         3XpTmhzVazJOpR/xVd3JNXzSfAgeP1hI9TG+vDrdFbEwMX+rXqPWYlblblocBGdqWCGC
         XbG2ZiYSarQmhf1SR3ZHi0/n2bBGCIxtsTYZgRdlWLYNYLfF4SA6C4CZxXh8Qam9oDN8
         V3jw==
X-Gm-Message-State: APjAAAWeZarFDyjcWdZqbhGfz5VhFsm8rIpr4mWi2hhFCq+nR3n5J174
        Dx+tk6PnpKydVVg9/1wqcnI=
X-Google-Smtp-Source: APXvYqzQvx/00v1QDf5WbzmOXOq/hJfS/KM85m1a+8CNmf3tCuAdcXLFH7KbENB6gixGMVuYqgW+zw==
X-Received: by 2002:a1c:f111:: with SMTP id p17mr20168600wmh.62.1558807773768;
        Sat, 25 May 2019 11:09:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id s127sm5656914wmf.48.2019.05.25.11.09.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 11:09:33 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 04/10] dt-bindings: media: sunxi-ir: Add A64 compatible
Date:   Sat, 25 May 2019 20:09:17 +0200
Message-Id: <20190525180923.6105-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525180923.6105-1-peron.clem@gmail.com>
References: <20190525180923.6105-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is some minor differences between A31 and A64 driver.

But A31 IR driver is compatible with A64.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 Documentation/devicetree/bindings/media/sunxi-ir.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/sunxi-ir.txt b/Documentation/devicetree/bindings/media/sunxi-ir.txt
index 53e88ebb53fe..da5aeba843de 100644
--- a/Documentation/devicetree/bindings/media/sunxi-ir.txt
+++ b/Documentation/devicetree/bindings/media/sunxi-ir.txt
@@ -5,6 +5,7 @@ Required properties:
 	"allwinner,sun4i-a10-ir"
 	"allwinner,sun5i-a13-ir"
 	"allwinner,sun6i-a31-ir"
+	"allwinner,sun50i-a64-ir", "allwinner,sun6i-a31-ir"
 - clocks	    : list of clock specifiers, corresponding to
 		      entries in clock-names property;
 - clock-names	    : should contain "apb" and "ir" entries;
-- 
2.20.1

