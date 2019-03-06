Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F01C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C26D20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="l8FjdTmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfCFRBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:01:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34685 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbfCFRBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:01:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id u9so9090947pfn.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 09:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7gml9CgAgTMxOZO0Pb0JU6STJ10qcaKff7uSTnbaesk=;
        b=l8FjdTmiQZN0iPMd1A2nRx/6N+WCiPeHGxFFmFmKW9knw6Kxd6g/rV8LKDo6TDA7zB
         w04n3DGxJaUy9MXVERb3+rHI2PUr9gPn7XHfUPfDTOoT8M4BLN2Q4AkOFM5ZEGKtLjwP
         9A+CylRZ9HdygquoJBOFExSOPnTDYXVtXyAZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7gml9CgAgTMxOZO0Pb0JU6STJ10qcaKff7uSTnbaesk=;
        b=OIuTPLZEeMikKdDXzPjXz7O5p2vpqMPfdnIPuGUINJlyGHo139E/1hBJU2dBVLJNHt
         Bg9H4PaAUMi5nJNtSI+Ko+M2s552mTHGogn4ry91YcSfTCBI0ChCRD+TKDD+7nGlvjjO
         uVOk9cvET7ltOUwaBAtrQHEkXrOPyzBsQGirxgRW0xiG6XaiJP8IDsOleE4aAnd0Yu/o
         aWXplYGnbD/NWGPFtt3nf3klAT2GNL7hH9PG2m2923zjkYrRjien+DlMpxgw7HT3Pn8B
         UzZXDSnLIW+YXZVfYuT0fUsxIRxS3x4jrzzFrH9+WwovlEX1aus6IlL3D3GBIUm7q9ah
         GJAw==
X-Gm-Message-State: APjAAAUjDzX0rSDRCBxuEI2gslLj/Ce+KN4jWZbAOhY6BnzfOoNkMuQt
        d6Pk8bsYQvm6llVUmLLnnj+0Kw==
X-Google-Smtp-Source: APXvYqz3KrmEVyjKm3/var5pSl5TZks71N7ps9q4OBZ5w8Pe1exC2WzEXyBfjAgkMhaFgLJVue9W3w==
X-Received: by 2002:aa7:8c97:: with SMTP id p23mr8322888pfd.229.1551891692530;
        Wed, 06 Mar 2019 09:01:32 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:27b8:fdbf:6489:a238:847b:3486])
        by smtp.gmail.com with ESMTPSA id t10sm7797916pfa.151.2019.03.06.09.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 09:01:31 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ryan Pannell <ryan@osukl.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 1/2] dt-bindings: Add vendor prefix for oceanic
Date:   Wed,  6 Mar 2019 22:31:09 +0530
Message-Id: <20190306170110.27342-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add oceanic vendor prefix.

Oceanic Systems (UK) Ltd design and manufacture world-class marine
systems for control and monitoring vessels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- none

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index bb6f6e8a2eee..e32d460408dc 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -287,6 +287,7 @@ nuvoton	Nuvoton Technology Corporation
 nvd	New Vision Display
 nvidia	NVIDIA
 nxp	NXP Semiconductors
+oceanic	Oceanic Systems (UK) Ltd.
 okaya	Okaya Electric America, Inc.
 oki	Oki Electric Industry Co., Ltd.
 olimex	OLIMEX Ltd.
-- 
2.18.0.321.gffc6fa0e3

