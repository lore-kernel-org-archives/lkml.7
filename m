Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28E9C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 04:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B264420652
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 04:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfDPEsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 00:48:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:59482 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725770AbfDPEsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 00:48:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 86254AD56;
        Tue, 16 Apr 2019 04:48:05 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>
Date:   Tue, 16 Apr 2019 14:47:29 +1000
Subject: [PATCH 0/5] mtk-sd enhancement to support MT7621
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        thirtythreeforty@gmail.com
Message-ID: <155538933003.25108.3338569916935462285.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT7621 MIPS-based SOC contains an sdhci unit that is
much the same as the units supported by mtk-sd.c.

These patches enhance the driver so that I can use it on my MT7621
board (gnubee.org).

Some thoughts:
- I wonder if voltage-ranges should be a standard option, processed
    by mmc_of_parse(), rather than requiring mmc_of_parse_voltage()
    to be called as well?

- the "compatible" name "ralink,mt7620-sdhci" doesn't fit the pattern
  of other names.  It is a name I found in openwrt - I was previously
  using a driver from there.  I have no objection to changing it,
  but I have no way to determine what the "correct" name it.

- I have tested the card-detect logic but not the write-protect, as
  that doesn't seem to be wired on this board.

- My SOC doesn't have software-controlled clocks (that I can find).
  To get the clocks that the driver requires, I define a "fixed-clock"
  with the appropriate frequency and use that for both  "source" and
  "hclk".  Many these clocks should be optional - at least hclk ??

- I don't need to reconfigure the pins for "uhs" so I just use the
  same pinctrl setting for "default" and for "state_uhs".  Maybe
  "state_uhs" should be optional?


For reference, excerpts from my dts file are below.

Thanks,
NeilBrown


       mmc_clock: mmc_clock@0 {
               #clock-cells = <0>;
               compatible = "fixed-clock";
               clock-frequency = <48000000>;
       };

and

       sdhci: sdhci@1E130000 {
               status = "disabled";

               compatible = "ralink,mt7620-sdhci";
               reg = <0x1E130000 0x4000>;

               bus-width = <4>;
               max-frequency = <48000000>;
               cap-sd-highspeed;
               cap-mmc-highspeed;
               voltage-ranges = <2800 3300>;

               pinctrl-names = "default", "state_uhs";
               pinctrl-0 = <&sdhci_pins>;
               pinctrl-1 = <&sdhci_pins>;
               clocks = <&mmc_clock &mmc_clock>;
               clock-names = "source", "hclk";

               interrupt-parent = <&gic>;
               interrupts = <GIC_SHARED 20 IRQ_TYPE_LEVEL_HIGH>;
       };

---

NeilBrown (5):
      mmc: mtk-sd: support "voltage-ranges" setting.
      mmc: mtk-sd: don't hard-code interrupt trigger type
      mmc: mtk-sd: add support for config found in mt7620 family SOCs.
      mmc: mtk-sd: enable internal card-detect logic.
      mmc: mtk-sd: enable internal write-protect logic.


 Documentation/devicetree/bindings/mmc/mtk-sd.txt |    7 +
 drivers/mmc/host/mtk-sd.c                        |  105 +++++++++++++++++++++-
 2 files changed, 104 insertions(+), 8 deletions(-)

--
Signature

