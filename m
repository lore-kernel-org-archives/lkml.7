Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC1AC432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 14:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63762084C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 14:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mBKRzVbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfKQOHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 09:07:43 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35842 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfKQOHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 09:07:42 -0500
Received: by mail-wm1-f65.google.com with SMTP id c22so15847218wmd.1;
        Sun, 17 Nov 2019 06:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sfzf92CL96vr/sJWUdQn1rqPMmFFI9Y4IH1A/bb5Cto=;
        b=mBKRzVbA3Tv3a6pbW64Ow5gGE3LSx9JeXieKON1RqjRi5XeYL3JzMm84p89fUR+Se8
         m7C2+rmyLe6BY1KQvdWo+3EQWTgK5mQxO/bKZw7UeQA4u8xpXfDJBL6s48aaprOjTeFF
         Jhym38GFkOeNU3AiqC3aC6jDA2EQ2t73XTnzfphrM8hSUD5rJfVKKXAwIlhmZUWd78iO
         IdTieocxOxxi6dz6Vp5wJGZmrZOtBVjFyvdDfAn/c1vsGleLwHYFayRUDpnufEX1lQaL
         SamknSR/Nw7KdgUSV0EZZYrAldz2L1Em/Uh+HMKaffnR0RwWTppmT+ly+pnKy5IOKsUR
         5ojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sfzf92CL96vr/sJWUdQn1rqPMmFFI9Y4IH1A/bb5Cto=;
        b=FZDFKyn+RtW3df4gNn8DRS2px+soaBMxlWFfL+iUnDRKjYLprwnjg5jWw+I98uQt0N
         sOLbQPsOgZANJp+4dlbR79ukBPuGpxWZwbt801Tb48N0Bsf/KYnxv9a4BpaFd/DMeotl
         ZjMIDlPbIv57IWu98I9QefEJR3ymtvtlyxO+0kiB4SxymUN9KRTxsNy+jjRHo3tgczPp
         bZi1d5GA70y15I5d3xPhjba6w0HGlRmTSXQ+XA5YqnNKsvzguD8KA4Cd8kJ0Q56Sg40Y
         fxMLUaAUsyldwLfBj2NCg9c0wI3LOpcfdzO0micU9mNvr7/HhZ0CMpjuG8CUIO0bd1VE
         y1cQ==
X-Gm-Message-State: APjAAAV7uJONFzM2+EuKUS7e814HRb3OyunW8UwkDWPtrglDuw6SDXne
        i/jHyy6ZERJCIBeicSMtSg9HDExy
X-Google-Smtp-Source: APXvYqwAK3MUz6opV/wXXyZ7DKoixlQvwdlMtfwitUFt5Oh7JGsEVPfq9X/zMatAONAuA3HEjgmlUA==
X-Received: by 2002:a1c:7708:: with SMTP id t8mr24189852wmi.29.1573999660252;
        Sun, 17 Nov 2019 06:07:40 -0800 (PST)
Received: from localhost.localdomain (p200300F1371CB100428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371c:b100:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id n23sm16632977wmc.18.2019.11.17.06.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 06:07:39 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 0/2] add the DDR clock controller on Meson8 and Meson8b
Date:   Sun, 17 Nov 2019 15:07:29 +0100
Message-Id: <20191117140731.137378-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Meson8 and Meson8b SoCs embed a DDR clock controller in their MMCBUS
registers. This series:
- adds support for this DDR clock controller (patches 0 and 1)
- wires up the DDR PLL as input for two audio clocks (patches 2 and 3)
- adds the DDR clock controller to meson8.dtsi and meson8b.dtsi

Special thanks go out to Alexandre Mergnat for switching the Amlogic
clock drivers over to parent_hws and parent_data. That made this series
a lot easier for me!

This series depends on v3 my other series from [0]:
"provide the XTAL clock via OF on Meson8/8b/8m2"


Changes since v2 at [2]:
- add #include <linux/clk-provider.h> as suggested by Stephen Boyd
- drop unused includes
- use devm_platform_ioremap_resource instead of open-coding it as
  suggested by Stephen Boyd
- drop trailing comma after sentinel element as suggested by Stephen
  Boyd
- dropped patch #3 "clk: meson: meson8b: use of_clk_hw_register to
  register the clocks" because it's now moved to my other series at
  [0]
- dropped dts changes so this series exclusively targets clk-meson

Changes since v1 at [1]:
- fixed the license of the .yaml binding and added Rob's Reviewed-by
- drop unused syscon.h include (spotted by Jerome - thanks)
- drop fast_io from regmap_config and add max_register as suggested
  by Jerome
- dropped original patch #4 "clk: meson: meson8b: add the ddr_pll
  input for the audio clocks" because I could not test that yet (that
  patch was a forward-port from Amlogic's 3.10 BSP kernel)


[0] https://patchwork.kernel.org/cover/11248377/
[1] https://patchwork.kernel.org/cover/11155553/
[2] https://patchwork.kernel.org/cover/11214227/


Martin Blumenstingl (2):
  dt-bindings: clock: add the Amlogic Meson8 DDR clock controller
    binding
  clk: meson: add a driver for the Meson8/8b/8m2 DDR clock controller

 .../clock/amlogic,meson8-ddr-clkc.yaml        |  50 ++++++
 drivers/clk/meson/Makefile                    |   2 +-
 drivers/clk/meson/meson8-ddr.c                | 149 ++++++++++++++++++
 include/dt-bindings/clock/meson8-ddr-clkc.h   |   4 +
 4 files changed, 204 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,meson8-ddr-clkc.yaml
 create mode 100644 drivers/clk/meson/meson8-ddr.c
 create mode 100644 include/dt-bindings/clock/meson8-ddr-clkc.h

-- 
2.24.0

