Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4867FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107672084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i6OmSIBz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbfCYN2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:28:05 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40924 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbfCYN2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:28:04 -0400
Received: by mail-vs1-f65.google.com with SMTP id f22so1656109vso.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 06:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3l6tElSJTqmXDNCu/Vyf4XMp3VWPq7QwuG0fLzDOGqo=;
        b=i6OmSIBzM2CnOylH8AYCCIQupmrrPCN6oIZ/EkHGeWBHCCBlePDkNkjqOs0nyGcbsY
         LqRzMKS32RPtpTzcp8Su/Zr+FPccsuk3JgiDyFATALPEoieIhIV1X4tAl2U0Y9KtDtpM
         WKgFzd+H7yF4cvd7EjTLKPsgXxjJeCiUO38syw3WlbENyY6xfRLN/bZtHVCjCtIEo/XK
         kUNwWuhBuIkQXXz+lRBjoa6tFK7MdDNveRclBHIGuvsKRjaFNipy/eeXSvcQSHQtxOE/
         qI2nVx//Jj/VqL08nfB3w1Ct6hGlkOjrgmHdT/g5fixJkypOt9KDGVDfdxtym6qgzY+d
         pERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3l6tElSJTqmXDNCu/Vyf4XMp3VWPq7QwuG0fLzDOGqo=;
        b=mWNuT4sxO5Mm8ADTu4ttHBLQb9U4hYX26t0BFJrQkhLMioS3ZmCnk/RPUNtUJ2IQAH
         Lo0a/5lGgIcbOv3y6vTIt5wemdMXHd///e281VoPEWOHCDhltbpy5AdOjTqbNIe1x7xZ
         gyoYANtrWyJ1Qafmy/+Ep5IeuwSs/XT3x2fGoAxiUHfhT8c5MfFjWFYzfiMB5172wpBG
         8yzyS4zQZwyRQvan5G54298NE2Y7Aa73XZsLJS/9NL3tWZAkmk3ArX64Xak/8qJP79KJ
         KRCJ4ih3biTl19mPRgV+ttSqouSyuATv1wWwFGeZq+sIyv5RdypE6oDYwbyPgXrw4oen
         Yx9A==
X-Gm-Message-State: APjAAAUfCHvAVaeGOJZLivlAD7Yv9a4d62mf8ymWjlx5AupW57voYQ1G
        JBRpQMJ13sZwEa1BsWE1lnHu3YlELAX+a+jYBAfbrg==
X-Google-Smtp-Source: APXvYqxZ0vNPA6CZqojmm11g88eCLjhZgbzmj/Ila2Qc/TiaqPpG+Erg6AI2sdpz2FD/k0yc+8FuiObi4QhfLQMZ8+Q=
X-Received: by 2002:a67:ec03:: with SMTP id d3mr7597309vso.165.1553520482632;
 Mon, 25 Mar 2019 06:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190322113808.16858-1-christoph.muellner@theobroma-systems.com> <20190322113808.16858-3-christoph.muellner@theobroma-systems.com>
In-Reply-To: <20190322113808.16858-3-christoph.muellner@theobroma-systems.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 Mar 2019 14:27:26 +0100
Message-ID: <CAPDyKFpPh7TZqRfUX7x52aUeY69-i3NSo5XtuwTjN8yHqdAVDw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: Disable DCMDs on RK3399's
 eMMC controller.
To:     Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Lin Huang <hl@rock-chips.com>, Randy Li <ayaka@soulik.info>,
        Tony Xie <tony.xie@rock-chips.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2019 at 12:39, Christoph Muellner
<christoph.muellner@theobroma-systems.com> wrote:
>
> When using direct commands (DCMDs) on an RK3399, we get spurious
> CQE completion interrupts for the DCMD transaction slot (#31):
>
> [  931.196520] ------------[ cut here ]------------
> [  931.201702] mmc1: cqhci: spurious TCN for tag 31
> [  931.206906] WARNING: CPU: 0 PID: 1433 at /usr/src/kernel/drivers/mmc/host/cqhci.c:725 cqhci_irq+0x2e4/0x490
> [  931.206909] Modules linked in:
> [  931.206918] CPU: 0 PID: 1433 Comm: irq/29-mmc1 Not tainted 4.19.8-rt6-funkadelic #1
> [  931.206920] Hardware name: Theobroma Systems RK3399-Q7 SoM (DT)
> [  931.206924] pstate: 40000005 (nZcv daif -PAN -UAO)
> [  931.206927] pc : cqhci_irq+0x2e4/0x490
> [  931.206931] lr : cqhci_irq+0x2e4/0x490
> [  931.206933] sp : ffff00000e54bc80
> [  931.206934] x29: ffff00000e54bc80 x28: 0000000000000000
> [  931.206939] x27: 0000000000000001 x26: ffff000008f217e8
> [  931.206944] x25: ffff8000f02ef030 x24: ffff0000091417b0
> [  931.206948] x23: ffff0000090aa000 x22: ffff8000f008b000
> [  931.206953] x21: 0000000000000002 x20: 000000000000001f
> [  931.206957] x19: ffff8000f02ef018 x18: ffffffffffffffff
> [  931.206961] x17: 0000000000000000 x16: 0000000000000000
> [  931.206966] x15: ffff0000090aa6c8 x14: 0720072007200720
> [  931.206970] x13: 0720072007200720 x12: 0720072007200720
> [  931.206975] x11: 0720072007200720 x10: 0720072007200720
> [  931.206980] x9 : 0720072007200720 x8 : 0720072007200720
> [  931.206984] x7 : 0720073107330720 x6 : 00000000000005a0
> [  931.206988] x5 : ffff00000860d4b0 x4 : 0000000000000000
> [  931.206993] x3 : 0000000000000001 x2 : 0000000000000001
> [  931.206997] x1 : 1bde3a91b0d4d900 x0 : 0000000000000000
> [  931.207001] Call trace:
> [  931.207005]  cqhci_irq+0x2e4/0x490
> [  931.207009]  sdhci_arasan_cqhci_irq+0x5c/0x90
> [  931.207013]  sdhci_irq+0x98/0x930
> [  931.207019]  irq_forced_thread_fn+0x2c/0xa0
> [  931.207023]  irq_thread+0x114/0x1c0
> [  931.207027]  kthread+0x128/0x130
> [  931.207032]  ret_from_fork+0x10/0x20
> [  931.207035] ---[ end trace 0000000000000002 ]---
>
> The driver shows this message only for the first spurious interrupt
> by using WARN_ONCE(). Changing this to WARN() shows, that this is
> happening quite frequently (up to once a second).
>
> Since the eMMC 5.1 specification, where CQE and CQHCI are specified,
> does not mention that spurious TCN interrupts for DCMDs can be simply
> ignored, we must assume that using this feature is not working reliably.
>
> The current implementation uses DCMD for REQ_OP_FLUSH only, and
> I could not see any performance/power impact when disabling
> this optional feature for RK3399.
>
> Therefore this patch disables DCMDs for RK3399.
>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>

FYI, I leave this for arm-soc to pick up.

Kind regards
Uffe


> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index db9d948c0b03..1a16d6ce3ea8 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -333,6 +333,7 @@
>                 phys = <&emmc_phy>;
>                 phy-names = "phy_arasan";
>                 power-domains = <&power RK3399_PD_EMMC>;
> +               disable-cqe-dcmd;
>                 status = "disabled";
>         };
>
> --
> 2.11.0
>
