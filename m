Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA67C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0925B2089E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fGFv2mw4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfEBMK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 08:10:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43155 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfEBMK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 08:10:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id a12so2990317wrq.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 05:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WV5PITTv1apIvGOQpl0Oue1rXCYUzZjLQa3jrOACL0k=;
        b=fGFv2mw4iL0cv2bG/GRA7d1X4HgNeWqkFUlKM+Y/IqRoYZkLd0lJQcSAr9hZhYwfJ6
         hOPQ2Lvq9gbk+Sd5w5JijwJEeNRrewo04HsjsjC4UFrKfgiKFa9pYpbbdZ3VFnEkmYtV
         7apA/VD3apl7Qf0l8II8mQYF0IM7z5F7ujT3GPaile4zDTk/anUVf5ndCF1HvidAejb9
         RDNZpwoYffe52dGwv0N9zyhFGxjRfihGe58Cb++wdZZwKD9NW1ztJc36uCy3vE+0uRn5
         tZDcSJcNeWAmC+5W/TabQR/vaJWPWnNCVawCbNyKLSflnfO05LztfL+RP8FkKJh4TDuV
         9hFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WV5PITTv1apIvGOQpl0Oue1rXCYUzZjLQa3jrOACL0k=;
        b=IuyGeijs5ZGGLHjtEJhYn1+zNseRoUKnKh/Xlbj3GqO6+7B5Xx/I9xwinVw0PRlmyT
         6I+G3G74pumAIixlFfJHShEuT3aas0B6wV2g9T4UXnbyKEN5Dd0U+XSbxNd8UgPMk61t
         5EJBLc8fEXxxXgsO4zC9JuGkh9/GZJTIr3OpKdsjAvWWqYc2d72F5mhdMk3fNCwECNpn
         tLAHzpjhV+rDB9VXwXTLHEWxNiKQF8+PfGBdJ6P1sjVwHRx4UUpKxvQKTXlp4YPcK3P1
         i5enUpXSp6P7LQmRM8O4ri7W2ZKLydQDtILeBhbJ/zf6fH3swpYBisnPMCyho7usItWV
         UFtA==
X-Gm-Message-State: APjAAAVQ2UJg46uJcpulqSX/l1gmotG+DqKVvIpoTPsjF+kulE/gGqnZ
        TFc1fqbankWay3oihFH5zc2cNA==
X-Google-Smtp-Source: APXvYqxHbdw86DQT9DLiLhVUZhwVSNryaz0tC87K271cS45Tz+OjI7rgzVXULNJc92nQD2UrLXWBOQ==
X-Received: by 2002:a5d:5383:: with SMTP id d3mr2573633wrv.105.1556799055563;
        Thu, 02 May 2019 05:10:55 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-8-187.w90-86.abo.wanadoo.fr. [90.86.125.187])
        by smtp.gmail.com with ESMTPSA id u9sm3648348wmd.14.2019.05.02.05.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 05:10:54 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, matthias.bgg@gmail.com, perex@perex.cz,
        tiwai@suse.com, kaichieh.chuang@mediatek.com,
        shunli.wang@mediatek.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 2/5] dt-bindings: sound: Add MT8516 AFE PCM bindings
Date:   Thu,  2 May 2019 14:10:38 +0200
Message-Id: <20190502121041.8045-3-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502121041.8045-1-fparent@baylibre.com>
References: <20190502121041.8045-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the bindings of the MT8516 AFE PCM driver.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../bindings/sound/mt8516-afe-pcm.txt         | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt8516-afe-pcm.txt

diff --git a/Documentation/devicetree/bindings/sound/mt8516-afe-pcm.txt b/Documentation/devicetree/bindings/sound/mt8516-afe-pcm.txt
new file mode 100644
index 000000000000..c5fb3c55a7f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mt8516-afe-pcm.txt
@@ -0,0 +1,28 @@
+Mediatek AFE PCM controller for mt8516
+
+Required properties:
+- compatible:  "mediatek,mt8516-audio"
+- interrupts: should contain AFE interrupt
+- clocks: Must contain an entry for each entry in clock-names
+- clock-names: should have these clock names:
+		"top_pdn_audio",
+		"aud_dac_clk",
+		"aud_dac_predis_clk",
+		"aud_adc_clk";
+
+Example:
+
+
+	afe: mt8516-afe-pcm@11140000  {
+		compatible = "mediatek,mt8516-audio";
+		reg = <0 0x11140000 0 0x1000>;
+		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_AUDIO>,
+			 <&audiotop CLK_AUD_DAC>,
+			 <&audiotop CLK_AUD_DAC_PREDIS>,
+			 <&audiotop CLK_AUD_ADC>;
+		clock-names = "top_pdn_audio",
+			      "aud_dac_clk",
+			      "aud_dac_predis_clk",
+			      "aud_adc_clk";
+	};
-- 
2.20.1

