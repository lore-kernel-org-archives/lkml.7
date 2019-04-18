Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD7DC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C332183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ahUqNLlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388994AbfDRMux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:50:53 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:56008 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388277AbfDRMux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:50:53 -0400
X-Greylist: delayed 574 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Apr 2019 08:50:53 EDT
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 98140C0BD6;
        Thu, 18 Apr 2019 12:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555591277; bh=/SRF7vOFBYb7QKHQsQeAwXWHui+Sqh2bBLp+mK68XqQ=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=ahUqNLlRbGcJpAjV4ccdLZ1S6loytY5MXF2jMxlqYeIDyG1lEk6vX1Sxc9r4ypXTr
         eSD836xPbNzXC2zQvv20Y90y71G5ecKil7A2PdJe6xMg1K2BAHmjTO7CMD5UWVhmt+
         0Ss6Y5uIO9oGhFgyJdteJxpkgLXMpRtRZZdtibqVRQSZIouYMkYs/0T6AotQ8lr2Ah
         +o3sWXltVbXYbjiGnyDoMe9HYcV9WBiraosJBXdrdcaew/fHoe8Yl4IRK6WjqJir4w
         ypi6vjyDO/K3sn0sOCXwg+O6Ucgu+SABjIXR7o45Wh3d5rYIaPE0azSuG7g0Fak8Ap
         q34SAJCnmZgRQ==
Received: from [10.116.70.132] (hminas-7480.internal.synopsys.com [10.116.70.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 5A8BCA005A;
        Thu, 18 Apr 2019 12:40:59 +0000 (UTC)
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Subject: Re: [PATCH v2 0/5] USB: dwc2: Allow wakeup from suspend; enable for
 rk3288-veyron
To:     Douglas Anderson <dianders@chromium.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "heiko@sntech.de" <heiko@sntech.de>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        "amstan@chromium.org" <amstan@chromium.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        William Wu <william.wu@rock-chips.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Randy Li <ayaka@soulik.info>,
        "zyw@rock-chips.com" <zyw@rock-chips.com>,
        "mka@chromium.org" <mka@chromium.org>,
        "ryandcase@chromium.org" <ryandcase@chromium.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        "jwerner@chromium.org" <jwerner@chromium.org>,
        "dinguyen@opensource.altera.com" <dinguyen@opensource.altera.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
References: <20190418001356.124334-1-dianders@chromium.org>
Message-ID: <e4b3cd69-1c91-dfbe-bea7-bbca89ca1348@synopsys.com>
Date:   Thu, 18 Apr 2019 16:40:51 +0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418001356.124334-1-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas,

On 4/18/2019 4:15 AM, Douglas Anderson wrote:
> This re-hashes two older series I posted a long time ago, re-basing
> them to mainline.  ...well, technically, atop another dwc2 series I
> recently posted:
> 
> * usb: dwc2: Another attempt handling rk3288's remote wake quirk
>    https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.kernel.org_r_20190416215351.242246-2D1-2Ddianders-40chromium.org&d=DwIDAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=cQBKt4q-qzNVC53rNAwuwplH23V61rHQhhULvdLA0U8&m=tZD-jhA4bSymns9pwqhaT0Ico1SVCYevQaaQclHX8jY&s=b-IYjc3cgFyZYC_B9zSA_xbSLE2ODwAZX0Png-G4SwA&e=
>    https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_patchwork_cover_1062972_&d=DwIDAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=cQBKt4q-qzNVC53rNAwuwplH23V61rHQhhULvdLA0U8&m=tZD-jhA4bSymns9pwqhaT0Ico1SVCYevQaaQclHX8jY&s=VCNBuDGf2VeFFWUUyE3wUdn-sDnUu0nFipeNpyWPXts&e=
> 
> In general I've tried to add links to each patch pointing to relevant
> older discussion.  Here are overall links to the cover letters though.
> Note that for the previous "allow wakeup" series the discussion was
> scattered a bit between the original post and the repost.
> 
> * usb: dwc2: bus suspend/resume that's not hibernate
>    https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.kernel.org_r_1446237173-2D15263-2D1-2Dgit-2Dsend-2Demail-2Ddianders-40chromium.org&d=DwIDAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=cQBKt4q-qzNVC53rNAwuwplH23V61rHQhhULvdLA0U8&m=tZD-jhA4bSymns9pwqhaT0Ico1SVCYevQaaQclHX8jY&s=FSVMrPFuSM--uXrAZN9GzCEXP60Li7miMsC4ydv6oDQ&e=
>    https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_patchwork_patch_613761_&d=DwIDAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=cQBKt4q-qzNVC53rNAwuwplH23V61rHQhhULvdLA0U8&m=tZD-jhA4bSymns9pwqhaT0Ico1SVCYevQaaQclHX8jY&s=omRYPw4XVgY8Rq2UgJhApk2poeKXWCBc5QsYMlQkqk4&e=
> 
> * dwc2 patches to allow wakeup on Rockchip rk3288
>    https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.kernel.org_r_1435017144-2D2971-2D1-2Dgit-2Dsend-2Demail-2Ddianders-40chromium.org&d=DwIDAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=cQBKt4q-qzNVC53rNAwuwplH23V61rHQhhULvdLA0U8&m=tZD-jhA4bSymns9pwqhaT0Ico1SVCYevQaaQclHX8jY&s=ep7GoHZcPlQbiOkXlwy9xXZEKdbd4o2erhLSblDL5Rg&e=
>    https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_patchwork_cover_572944_&d=DwIDAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=cQBKt4q-qzNVC53rNAwuwplH23V61rHQhhULvdLA0U8&m=tZD-jhA4bSymns9pwqhaT0Ico1SVCYevQaaQclHX8jY&s=hq4errAA9YvVpHJaVoWGTIHnlwiq1iuadWW1WJavtCI&e=
> 
> * dwc2 patches to allow wakeup on Rockchip rk3288 (REPOST)
>    https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.kernel.org_r_1436207224-2D21849-2D1-2Dgit-2Dsend-2Demail-2Ddianders-40chromium.org&d=DwIDAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=cQBKt4q-qzNVC53rNAwuwplH23V61rHQhhULvdLA0U8&m=tZD-jhA4bSymns9pwqhaT0Ico1SVCYevQaaQclHX8jY&s=n-nD8EdqtgTyPdPPJ06t2pxyjC1M65g5aXLT1OiuouY&e=
>    https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_patchwork_cover_576120_&d=DwIDAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=cQBKt4q-qzNVC53rNAwuwplH23V61rHQhhULvdLA0U8&m=tZD-jhA4bSymns9pwqhaT0Ico1SVCYevQaaQclHX8jY&s=YkisA-u9q0yewqaRoOWWpps9E2QFh1asgnwkbM1B7mc&e=
> 
> I'm hoping there's a better chance of these things landing this time
> around, but I guess we'll see.  ;-)
> 
> In case it's helpful I've put what I tested (which is based on Heiko's
> for-next branch and includes patches to enable deep suspend plus two
> other s2r fixes) at:
> 
> https://urldefense.proofpoint.com/v2/url?u=https-3A__chromium.googlesource.com_chromiumos_third-5Fparty_kernel_-2Blog_refs_sandbox_dianders_190417-2Dtesting-2Ddwc2-2Dwakeup&d=DwIDAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=cQBKt4q-qzNVC53rNAwuwplH23V61rHQhhULvdLA0U8&m=tZD-jhA4bSymns9pwqhaT0Ico1SVCYevQaaQclHX8jY&s=ws6kQVDDGxYJnhR693pQP9fYL-PH_TUGzSVmD4u-S9Q&e=
> 
> Changes in v2:
> - Rebased to mainline atop rk3288 remote wake quirk series.
> - rk3288-veyron dts patch new for v2.
> 
> Douglas Anderson (5):
>    usb: dwc2: bus suspend/resume for hosts with
>      DWC2_POWER_DOWN_PARAM_NONE
>    USB: Export usb_wakeup_enabled_descendants()
>    Documentation: dt-bindings: Add snps,need-phy-for-wake for dwc2 USB
>    USB: dwc2: Don't turn off the usbphy in suspend if wakeup is enabled
>    ARM: dts: rockchip: Allow wakeup from rk3288-veyron's dwc2 USB ports
> 
>   .../devicetree/bindings/usb/dwc2.txt          |  3 +
>   arch/arm/boot/dts/rk3288-veyron.dtsi          |  2 +
>   drivers/usb/core/hub.c                        |  7 +-
>   drivers/usb/dwc2/core.h                       |  5 ++
>   drivers/usb/dwc2/hcd.c                        | 84 ++++++++++++-------
>   drivers/usb/dwc2/platform.c                   | 43 +++++++++-
>   include/linux/usb/hcd.h                       |  5 ++
>   7 files changed, 113 insertions(+), 36 deletions(-)
> 

Did you consider/reviewed patch series from Artur Petrosyan "[PATCH 
00/14] usb: dwc2: Fix and improve power saving modes" (submitted on 
April 12) which fixing partial power down and hibernation flows for both 
modes: host and device?
I suspect that this both patch series can be in conflict.

Thanks,
Minas

