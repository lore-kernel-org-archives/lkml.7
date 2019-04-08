Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EB5C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4215B208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DThOdTdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfDHJWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:22:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44231 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfDHJWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:22:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id y7so15403349wrn.11;
        Mon, 08 Apr 2019 02:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o7d9VRpeoInofCh/f8L4CRjAOhJNkNjfCgVSpQrToTc=;
        b=DThOdTdU3tCfJip8xIfgW15Pqux2SzJu0q9vzCdntnDGHwBTBjH+AcTOVfz6fUqyhO
         SctGRuJU2WrQ6BReIearitpCskN9A6PFy+OHFbRlH40lKilV9KmdmCbLSICXetaytTQh
         OXjYSPe2CuvWa5sJZkP9aULMlL2L8Np2ZLmVInV0gyPnMVZjpQPUZqfR46eqjV0LUCMY
         UJZiOeCVxyaurPktzTVNTdddb0x/Ot9ta/rYuHaZ6/ryzSNUBlvK6IEim0kFsM2omV0U
         da1ss3GPdc0v/teRV/bNE/+WAmlQfozOPnNem1N0YKq8iehQ3yJ5iNAuNuQXgwqEQVYD
         r4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o7d9VRpeoInofCh/f8L4CRjAOhJNkNjfCgVSpQrToTc=;
        b=O2H8XpZKN12cZxCA4UxxR0vt85osebB08lmlHYlisCdqE2a5F2PZc0aJJMnSCsrs6o
         3VEK6nS+I4khI+MIdYCfqeZePgE/dEyjkQPLDAuHYxwi9y/mA47u73PbfzhGehHKgg9m
         KYaOBiiUYW55b5ncSk3xwUsbzXNtPBdY8CDWD0myDYB03e5mLZgSKsYqhbWsn1hcpa6+
         orXR3GXyxrhuif5FP0uKRPvQ/cvq70y+p0c4vOuld6fyPNLeso0N7C5p1uImotwuJIa/
         w+f0GGO5BUHlovdvfMSDWB7u3eNCl9YOd02oXDuJIBpzRolohNrT4Ogv78wMJ+moVrH8
         VjxA==
X-Gm-Message-State: APjAAAXny4icw5UZOB3NHAAxHcHLmszU7ToJpC6O8EyfFPnxz6BfzMxJ
        tj7Cz6Mkjjd0u65CzajQtPg=
X-Google-Smtp-Source: APXvYqx5jUswl2ycdaxTVpHN0OPCv+kqBu30j8SU9ZPw4htsupJui/YncUHtwfWK/MGOsDqyNs7LUA==
X-Received: by 2002:adf:f102:: with SMTP id r2mr3264212wro.136.1554715349382;
        Mon, 08 Apr 2019 02:22:29 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id u17sm22671883wmu.36.2019.04.08.02.22.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 02:22:28 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 2/6] dt-bindings: vendor-prefixes: add AZW
Date:   Mon,  8 Apr 2019 11:26:15 +0200
Message-Id: <20190408092619.23152-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190408092619.23152-1-peron.clem@gmail.com>
References: <20190408092619.23152-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shenzhen AZW Technology Co. Ltd. is a manufacturer specialized in Android
smart TV boxes, Intel mini PCs and home cloud TV boxes with NAS.

Add the vendor prefix for AZW.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 208889476a38..4933403c4b57 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -54,6 +54,7 @@ avic	Shanghai AVIC Optoelectronics Co., Ltd.
 avnet	Avnet, Inc.
 axentia	Axentia Technologies AB
 axis	Axis Communications AB
+azw     Shenzhen AZW Technology Co., Ltd.
 bananapi BIPAI KEJI LIMITED
 bhf	Beckhoff Automation GmbH & Co. KG
 bitmain	Bitmain Technologies
-- 
2.17.1

