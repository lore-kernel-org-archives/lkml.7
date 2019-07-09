Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422A0C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 19:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165282073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 19:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562700396;
	bh=FNQmgvFw4Aq6fUys5cigBZac5Fyb6mjPiTDli0HhRL4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=a8RFR+dVXurE2PKgD6GBTu6d53HEmkqD0sXROpXZRsZF/mRbP5gchKTquB8Oct7eb
	 Z0KS9+ch44AWwhw6NPd58clYNfcRPGC/peRiv/7CY8bffEfMKOUP+STxdNA0/FH+aO
	 3GWqcpNOiZPeRR5nhpFJsnN/nndCQ53e+rjftHMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfGIT0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 15:26:35 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34148 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfGIT0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 15:26:34 -0400
Received: by mail-io1-f65.google.com with SMTP id k8so454614iot.1;
        Tue, 09 Jul 2019 12:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YJCxWDqrIACeyw572XUN88X748QX9Vah3vz0WR7ceS0=;
        b=YCpxB+sehO4NnSiV+g6W2Xa1MMwpIoZVq4FwBkp5z+xJL6Zpqqvnvgf8JkCc5Ir2+4
         6+Kdo5oY++mF2hqWIZJKiB3YgV3qlMZP5IwaQXpePNtKhCg1H8waZrxzEzQVB21xz4sX
         wx9dfDY+V/TIH4jsTmpj+KFKLwagRI8f2oxd8L/uQwuEEjWIrUJMas3MIHDlIKD4t2Jl
         LlgGwdVednr2sStHoPAxe76UzOLfdtwUGw0ZYDnoOo2MjA0RBFn/FcVELjdOV15xGWqk
         cqUPrEtqnl8MCREIJjcXMP4lG/Xaf8nQ1ma3hlAZoi6qvmbVrxGYag1DzAELMfNoSrDi
         yIbA==
X-Gm-Message-State: APjAAAWhsSV3b3jMrtJa2tp7f80aX6xuTE46q/n5LnryDJfHRTv2v02Y
        g8IHB69hKdeE99ZAfo4uu5EHrCF1CQ==
X-Google-Smtp-Source: APXvYqzFQYn+xq0I9wKEnggnMxeBx0XK0qbhuePWj72qrLE7hJHFol3dpjQxB5aYLpvyr7Hg82Dl9w==
X-Received: by 2002:a05:6638:3d2:: with SMTP id r18mr30146201jaq.13.1562700393681;
        Tue, 09 Jul 2019 12:26:33 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id c17sm18671708ioo.82.2019.07.09.12.26.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 12:26:33 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-spi@vger.kernel.org
Subject: [PATCH] spi: dt-bindings: spi-controller: remove unnecessary 'maxItems: 1' from reg
Date:   Tue,  9 Jul 2019 13:26:31 -0600
Message-Id: <20190709192631.16394-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mixing array constraints like 'maxItems' and string or integer value
constraints like 'minimum' don't make sense. Also, with only value
constraints, it is implied we have a single value. So lets remove
'maxItems: 1'.

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 876c0623f322..a02e2fe2bfb2 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -73,7 +73,6 @@ patternProperties:
           Compatible of the SPI device.
 
       reg:
-        maxItems: 1
         minimum: 0
         maximum: 256
         description:
-- 
2.20.1

