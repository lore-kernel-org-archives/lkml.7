Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E97C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9019D20854
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnywVXdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392583AbfIFOGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:06:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43063 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729719AbfIFOF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:05:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id q17so2001991wrx.10;
        Fri, 06 Sep 2019 07:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sVRT27xgfEva/e1C67Zzs31eL0ogg1a2U8ejdj2fXBc=;
        b=ZnywVXdzjivUjfuWw8KWRGVDzFu6IuuVOmY6Mn58dcYWQlXed26VL4Rp68k9DjU4dv
         7V0VfDNvbx4A6XFv4lW0gM9xekpm8Ar8OsE/+THFTt8dmCUWxf1qE/ReGjkSNUe1RIJG
         Ye1UYNwok/zCByqPsaqlCJHXn+SZLd2/C9hh+CRwMsx6+BEV8/7guQQJIlK99rTEjPdB
         3lC6qJzUmNpvA/uvLPpE9HWbqJ1C0r8ecnshk1lVRGoCxGLI/MgJhvof8DycTCAdtzAa
         Lu6oiXbeunkhLNXnaMlhCLGoddF+k22b2w70rlhTHV+5X/RCFeKzrw9zanOuaL26bf4a
         3o7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sVRT27xgfEva/e1C67Zzs31eL0ogg1a2U8ejdj2fXBc=;
        b=PoGZ7u1o3Qqhl2t84WN+HYp4Bw5EJjd1asSdFg4/pyunPLoA9SDDvTPqDa4LTvMcKr
         epxLrWRW5mI6K3M6mGOOPJrsyOsXfUu/hvVLFOPVxoLCxQP8XC+/Zv8i/ZuHh1lIWKVS
         VFZ2gZu90DL0XmXvOQJ48mpNSMuyDJb213sCpcm7GBeV7NENmqTwklXVfyx7eBl8/AUh
         d5pBS/9DNLaNTijctqdIO2tuev5Q393GuFqdEH7jc0so/wcaDS9uZlysVWd3jzWgHIvx
         hmxtLsBU+06h1B4kCRWxGjx9US8Tn4UpKeLrLCgSY6cDZbEMgT8UCB8H3MWFNFrWqjOy
         Ta5g==
X-Gm-Message-State: APjAAAWJLZA2+vAR5FQ+T01v1URqxgB2RRdfh2kJysVAsgYV2tI+xc6M
        QLOR1fjyOj9e+wHn8nP89dQ=
X-Google-Smtp-Source: APXvYqwHNjN84vTb0aFBpduETgbA5BSuKjVhRZOlvvvWhde7IDe/uBFdy1S7Rp6t2FWJZ++iNFUVRQ==
X-Received: by 2002:adf:8b13:: with SMTP id n19mr4125783wra.203.1567778754943;
        Fri, 06 Sep 2019 07:05:54 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id e20sm7480542wrc.34.2019.09.06.07.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 07:05:54 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>,
        Oleg Ivanov <balbes-150@yandex.ru>
Subject: [PATCH v3 1/3] dt-bindings: Add vendor prefix for Ugoos
Date:   Fri,  6 Sep 2019 18:04:58 +0400
Message-Id: <1567778699-59231-3-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567778699-59231-1-git-send-email-christianshewitt@gmail.com>
References: <1567778699-59231-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From c9402f747c02605fd8bf7e6495271edf855476c7 Mon Sep 17 00:00:00 2001
From: Christian Hewitt <christianshewitt@gmail.com>
Date: Fri, 6 Sep 2019 05:38:48 +0400
Subject: [PATCH v3 2/3] dt-bindings: arm: amlogic: Add support for the Ugoos AM6

The Ugoos AM6 is based on the Amlogic W400 (G12B) reference design using the
S922X chipset.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 325c6fd..2ded61d 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -139,6 +139,7 @@ properties:
         items:
           - enum:
               - hardkernel,odroid-n2
+              - ugoos,am6
           - const: amlogic,g12b
 
 ...
-- 
2.7.4

