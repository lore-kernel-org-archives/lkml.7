Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024D6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF04321734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfCLNSS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:18:18 -0400
Received: from gloria.sntech.de ([185.11.138.130]:60206 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfCLNSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:18:17 -0400
Received: from we0652.dip.tu-dresden.de ([141.76.178.140] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h3hI4-0001pp-39; Tue, 12 Mar 2019 14:17:56 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Christoph =?ISO-8859-1?Q?M=FCllner?= 
        <christoph.muellner@theobroma-systems.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, shawn.lin@rock-chips.com,
        ulf.hansson@linaro.org,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Douglas Anderson <dianders@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Randy Li <ayaka@soulik.info>,
        Tony Xie <tony.xie@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Lin Huang <hl@rock-chips.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 2/3] dt-bindings: mmc: Add a new property disable-cqe-dcmd.
Date:   Tue, 12 Mar 2019 14:17:55 +0100
Message-ID: <4793843.T1TZ7EF8k3@phil>
In-Reply-To: <3BCC2A27-3AF4-4E5E-BBD4-6A5B49831D3C@theobroma-systems.com>
References: <20190307084329.25416-1-christoph.muellner@theobroma-systems.com> <37a96eda-196e-bacf-7ae2-5b9354c70273@intel.com> <3BCC2A27-3AF4-4E5E-BBD4-6A5B49831D3C@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 8. März 2019, 14:10:45 CET schrieb Christoph Müllner:
> 
> > On 08.03.2019, at 13:46, Adrian Hunter <adrian.hunter@intel.com> wrote:
> > 
> > On 7/03/19 10:43 AM, Christoph Muellner wrote:
> >> This patch documents the new property disable-cqe-dcmd
> >> for the Arasan eMMC 5.1 driver.
> >> 
> >> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> >> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> >> ---
> >> Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
> >> 1 file changed, 4 insertions(+)
> >> 
> >> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> >> index 1edbb049cccb..ec699bf98b7c 100644
> >> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> >> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> >> @@ -44,6 +44,10 @@ Optional Properties:
> >>     properly. Test mode can be used to force the controller to function.
> >>   - xlnx,int-clock-stable-broken: when present, the controller always reports
> >>     that the internal clock is stable even when it is not.
> >> +  - disable-cqe-dcmd: The eMMC 5.1 standard specifies direct commands (DCMDs)
> >> +    as part of the command queue engine (CQE). On controllers with a CQHCI,
> >> +    such as the Arasan eMMC 5.1 host controller, the driver has to enable DCMDs.
> >> +    This is done unless disable-cqe-dcmd is specified.

This needs a rewording please. See below for hw-description vs. driver, so
the description should be centered around why this is a property of the hw
[like faulty controller implementation or whatever]


> > If "supports-cqe" is in mmc.txt, should "disable-cqe-dcmd" be there also?
> 
> The file mmc.txt says on top:
> "These properties are common to multiple MMC host controllers".
> As my patchset introduces "disable-cqe-dcmd" just for sdhci-of-arasan,
> I would say it should not go into that file.
> 
> Also I wonder why "supports-cqe" is in mmc.txt, because
> only sdhci-tegra.c is evaluating that property.
> So I would expect it to be documented in
> Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> 
> However, I see that "disable-cqe-dcmd" could go into other drivers as well.
> But is this enough to document it in mmc.txt?

Devicetree is always about describing the hardware capabilites and never
about the actual nitty-gritty of driver implementation, aka it is not meant
as a space for hardware-independent config-settings or such.

As for only tegra evaluating this, is probably because it is still so new, like
january 2019 and Rob explicitly suggested it becoming common [0], which
suggests that the disable-cqe-dcmds should probably also be common.

Heiko

[0] https://lore.kernel.org/patchwork/patch/1031163/


