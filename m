Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E543C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8B3218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FT1WzEVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbfCWVRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 17:17:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45775 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728599AbfCWVRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 17:17:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so5964564wra.12
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 14:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lxFyf3iGCzky6hYo5GBIQf4Vm1JfhvCOSwUzC5ba4VM=;
        b=FT1WzEVFRl2Mc4LCsx9r8aU1OM1JlPanNNk/sIfuv7GiGjtpMTfCd5GEMInr4v+gnJ
         o/VUtCJxB5Zvq5pfF61Ppnp76b3lVzop6e09LY4BC3GOhZROAfLTltxW+IbxehlKzxpy
         J5T12PYGt4eZpGk7lI/0IjWEmxx2bSPcfmdlLmkXB6RB/tNFIEOzGJgVCmlcepXzxaiQ
         elVMmJppS9aB0T5I7pGMn4TrvbWhiU1VBE9GAaRgIilFfW8GZp1KtIHnBb6WHR538FZu
         mCDcPlyucrDQbtft4vMkiGp9aZvoprjZ5lsbPmlZtfjb4kSNmjxPcI/kGd2DIHAz9kZy
         QJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lxFyf3iGCzky6hYo5GBIQf4Vm1JfhvCOSwUzC5ba4VM=;
        b=tqzcPuC7MJiYt+YSIwkA7Sf2I71tEwT0nOZyR+1OlgL+elNnwXjh6SjfoaP1wr0OWB
         FtJh9m1/TMZnEReEqtxBodUpbVF7qLQb8+zF23K9O68oee/ZRJMlIZwZxQvH45PnobN+
         0Wt09WIta+kaNrM/cXaU3gGPzI61oCMb6imLnvRfirap73Ib7UGSX5m5jqn2xNJyxUBb
         wzr24hJi4gJGlV0A8rAKKu1C9xNIFv92JOLMY+ZsWdVSdgLm3pG7A2vhQ6yD8sy+JNEP
         FgbPxGNM1E5ulxuH1Gj+qEIehE+StGOPPKbWmhmwwey0O0mkB8x9FxSvPdSVsn33Pcia
         12og==
X-Gm-Message-State: APjAAAWTnOf1nDsMi10TRKMhB4vkhOqHK1aPx88mC0OAxM+c/e6h6mav
        7eBSp9Irs7wdnt2+rk4u4Dakrw==
X-Google-Smtp-Source: APXvYqwQbslBtW3BEz6P7fx084A7x94qUBVWZHEB8F2Vc9kI0VXkL3AafNkKIhvIuNwjnIQ+5hx5Sw==
X-Received: by 2002:adf:afee:: with SMTP id y46mr10592700wrd.217.1553375838551;
        Sat, 23 Mar 2019 14:17:18 -0700 (PDT)
Received: from localhost.localdomain (cag06-8-78-203-165-84.fbx.proxad.net. [78.203.165.84])
        by smtp.gmail.com with ESMTPSA id y66sm8050503wmd.37.2019.03.23.14.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 14:17:17 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     matthias.bgg@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     sean.wang@kernel.org, ryder.lee@mediatek.com,
        hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com,
        chaotian.jing@mediatek.com, yong.mao@mediatek.com,
        jjian.zhou@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 15/24] dt-bindings: pinctrl: pinctrl-mt65xx: add support for MT8516
Date:   Sat, 23 Mar 2019 22:16:03 +0100
Message-Id: <20190323211612.860-16-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190323211612.860-1-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation of pinctrl-mt65xx for MT8516 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
index e7d6f81c227f..205be98ae078 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
@@ -11,6 +11,7 @@ Required properties:
 	"mediatek,mt8127-pinctrl", compatible with mt8127 pinctrl.
 	"mediatek,mt8135-pinctrl", compatible with mt8135 pinctrl.
 	"mediatek,mt8173-pinctrl", compatible with mt8173 pinctrl.
+	"mediatek,mt8516-pinctrl", compatible with mt8516 pinctrl.
 - pins-are-numbered: Specify the subnodes are using numbered pinmux to
   specify pins.
 - gpio-controller : Marks the device node as a gpio controller.
-- 
2.20.1

