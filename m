Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3E9C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D0220840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lucaceresoli.net header.i=@lucaceresoli.net header.b="x3cVPyZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfCGVpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:45:34 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:52163 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726241AbfCGVpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lucaceresoli.net; s=default; h=References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hHg1mb7TSkmHiTYB+UJGRp9wMGGfOHKAALbYV2lABWA=; b=x3cVPyZfQ9tXl5xNqgtpd44Hp
        ydIRDC/QeR4/XapG3kXzgb+c6e4xAhN0IzrtkLzBTrV21ZkZEeYjxuO02V2LqkmzJxGRMAZ9iYqna
        qWi4NepH8t7UvorDYGlyu6+Q0JuHcICS4QxyxtzUp2S/e3Ol7tCqBaAtXfXeIjl5X+USE=;
Received: from [88.147.86.226] (port=35048 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.91)
        (envelope-from <luca@lucaceresoli.net>)
        id 1h20pY-0017NM-5L; Thu, 07 Mar 2019 22:45:32 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: ASoC: axi-i2s: make both "rx" and "tx" optional
Date:   Thu,  7 Mar 2019 22:44:56 +0100
Message-Id: <20190307214456.16445-2-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190307214456.16445-1-luca@lucaceresoli.net>
References: <20190307214456.16445-1-luca@lucaceresoli.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the capture and playback channels are optional in the axi_i2s IP
block. Document how to tell the driver which channels are
instantiated.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 Documentation/devicetree/bindings/sound/adi,axi-i2s.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/adi,axi-i2s.txt b/Documentation/devicetree/bindings/sound/adi,axi-i2s.txt
index 4248b662deff..229ad1392cdc 100644
--- a/Documentation/devicetree/bindings/sound/adi,axi-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/adi,axi-i2s.txt
@@ -1,5 +1,8 @@
 ADI AXI-I2S controller
 
+The core can be generated with transmit (playback), only receive
+(capture) or both directions enabled.
+
 Required properties:
  - compatible : Must be "adi,axi-i2s-1.00.a"
  - reg : Must contain I2S core's registers location and length
@@ -9,8 +12,8 @@ Required properties:
  - clock-names : "axi" for the clock to the AXI interface, "ref" for the sample
    rate reference clock.
  - dmas: Pairs of phandle and specifier for the DMA channels that are used by
-   the core. The core expects two dma channels, one for transmit and one for
-   receive.
+   the core. The core expects two dma channels if both transmit and receive are
+   enabled, one channel otherwise.
  - dma-names : "tx" for the transmit channel, "rx" for the receive channel.
 
 For more details on the 'dma', 'dma-names', 'clock' and 'clock-names' properties
-- 
2.17.1

