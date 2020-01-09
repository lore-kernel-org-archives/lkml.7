Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155C8C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E943920661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbgAIN3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:29:43 -0500
Received: from foss.arm.com ([217.140.110.172]:59056 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731054AbgAIN3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:29:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6179E31B;
        Thu,  9 Jan 2020 05:29:42 -0800 (PST)
Received: from arm.com (e112269-lin.cambridge.arm.com [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65F263F534;
        Thu,  9 Jan 2020 05:29:40 -0800 (PST)
Date:   Thu, 9 Jan 2020 13:29:35 +0000
From:   Steven Price <steven.price@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 0/7] Add dts for mt8183 GPU (and misc panfrost patches)
Message-ID: <20200109132934.GA6198@arm.com>
References: <20200108052337.65916-1-drinkcat@chromium.org>
 <79fe7055-c11b-c9f6-64e5-48e3d5687dfe@arm.com>
 <ca77cd74-b747-20c4-b07c-60df23421690@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca77cd74-b747-20c4-b07c-60df23421690@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 01:10:33PM +0000, Robin Murphy wrote:
> On 09/01/2020 12:01 pm, Steven Price wrote:
> > On 08/01/2020 05:23, Nicolas Boichat wrote:
> >> Hi!
> >>
> >> Sorry for the long delay since 
> >> https://patchwork.kernel.org/patch/11132381/,
> >> finally got around to give this a real try.
> >>
> >> The main purpose of this series is to upstream the dts change and the 
> >> binding
> >> document, but I wanted to see how far I could probe the GPU, to check 
> >> that the
> >> binding is indeed correct. The rest of the patches are 
> >> RFC/work-in-progress, but
> >> I think some of them could already be picked up.
> >>
> >> So this is tested on MT8183 with a chromeos-4.19 kernel, and a ton of
> >> backports to get the latest panfrost driver (I should probably try on
> >> linux-next at some point but this was the path of least resistance).
> >>
> >> I tested it as a module as it's more challenging (originally probing 
> >> would
> >> work built-in, on boot, but not as a module, as I didn't have the power
> >> domain changes, and all power domains are on by default during boot).
> >>
> >> Probing logs looks like this, currently:
> >> [  221.867726] panfrost 13040000.gpu: clock rate = 511999970
> >> [  221.867929] panfrost 13040000.gpu: Linked as a consumer to 
> >> regulator.14
> >> [  221.868600] panfrost 13040000.gpu: Linked as a consumer to 
> >> regulator.31
> >> [  221.870586] panfrost 13040000.gpu: Linked as a consumer to 
> >> genpd:0:13040000.gpu
> >> [  221.871492] panfrost 13040000.gpu: Linked as a consumer to 
> >> genpd:1:13040000.gpu
> >> [  221.871866] panfrost 13040000.gpu: Linked as a consumer to 
> >> genpd:2:13040000.gpu
> >> [  221.872427] panfrost 13040000.gpu: mali-g72 id 0x6221 major 0x0 
> >> minor 0x3 status 0x0
> >> [  221.872439] panfrost 13040000.gpu: features: 00000000,13de77ff, 
> >> issues: 00000000,00000400
> >> [  221.872445] panfrost 13040000.gpu: Features: L2:0x07120206 
> >> Shader:0x00000000 Tiler:0x00000809 Mem:0x1 MMU:0x00002830 AS:0xff JS:0x7
> >> [  221.872449] panfrost 13040000.gpu: shader_present=0x7 l2_present=0x1
> >> [  221.873526] panfrost 13040000.gpu: error powering up gpu stack
> >> [  221.878088] [drm] Initialized panfrost 1.1.0 20180908 for 
> >> 13040000.gpu on minor 2
> >> [  221.940817] panfrost 13040000.gpu: error powering up gpu stack
> >> [  222.018233] panfrost 13040000.gpu: error powering up gpu stack
> >> (repeated)
> > 
> > It's interesting that it's only the stack that is failing. In hardware 
> > there's a dependency: L2->stack->shader - so in theory the shader cores 
> > shouldn't be able to power up either. There are some known hardware bugs 
> > here though[1]:
> > 
> >      MODULE_PARM_DESC(corestack_driver_control,
> >              "Let the driver power on/off the GPU core stack 
> > independently "
> >              "without involving the Power Domain Controller. This should "
> >              "only be enabled on platforms for which integration of the 
> > PDC "
> >              "to the Mali GPU is known to be problematic.");
> > 
> > [1] 
> > https://github.com/ianmacd/d2s/blob/master/drivers/gpu/arm/b_r16p0/backend/gpu/mali_kbase_pm_driver.c#L57 
> > 
> > 
> > It might be worth just dropping the code for powering up/down stacks and 
> > let the GPU's own dependency management handle it.
> 
> FWIW I remember digging into that same message a while back (although 
> I've forgotten which particular GPU I was playing with at the time), and 
> concluded that the STACK_PWRON/STACK_READY registers might just not be 
> implemented on some GPUs,

They are indeed not implemented on some GPUs. Specifically none of the
Midgard GPUs. I believe G71 also doesn't have it. However the register
addresses were picked so that on these older GPUs they should
read-as-zero and write-ignore so this shouldn't actually cause any
problems.

> and/or this easy-to-overlook register bit 
> could be some kind of enable for the functionality:
> 
> https://github.com/ianmacd/d2s/blob/master/drivers/gpu/arm/b_r16p0/backend/gpu/mali_kbase_pm_driver.c#L1631
> 
> Since even in kbase this is all behind an 'expert' config option, I'm 
> inclined to agree that just dropping it from panfrost unless and until 
> it proves necessary is probably preferable to adding more logic and 
> inscrutable register-magic.

Indeed - I'll post a patch removing it.

Thanks,

Steve

> Robin.
> 
> > 
> > Steve
> > 
> >>
> >> So the GPU is probed, but there's an issue when powering up the STACK, 
> >> not
> >> quite sure why, I'll try to have a deeper look, at some point.
> >>
> >> Thanks!
> >>
> >> Nicolas
> >>
> >> v2:
> >>   - Use sram instead of mali_sram as SRAM supply name.
> >>   - Rename mali@ to gpu@.
> >>   - Add dt-bindings changes
> >>   - Stacking patches after the device tree change that allow basic
> >>     probing (still incomplete and broken).
> >>
> >> Nicolas Boichat (7):
> >>    dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183
> >>    arm64: dts: mt8183: Add node for the Mali GPU
> >>    drm/panfrost: Improve error reporting in panfrost_gpu_power_on
> >>    drm/panfrost: Add support for a second regulator for the GPU
> >>    drm/panfrost: Add support for multiple power domain support
> >>    RFC: drm/panfrost: Add bifrost compatible string
> >>    RFC: drm/panfrost: devfreq: Add support for 2 regulators
> >>
> >>   .../bindings/gpu/arm,mali-bifrost.yaml        |  20 ++++
> >>   arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |   7 ++
> >>   arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 104 +++++++++++++++++
> >>   drivers/gpu/drm/panfrost/panfrost_devfreq.c   |  18 +++
> >>   drivers/gpu/drm/panfrost/panfrost_device.c    | 108 ++++++++++++++++--
> >>   drivers/gpu/drm/panfrost/panfrost_device.h    |   7 ++
> >>   drivers/gpu/drm/panfrost/panfrost_drv.c       |   1 +
> >>   drivers/gpu/drm/panfrost/panfrost_gpu.c       |  15 ++-
> >>   8 files changed, 267 insertions(+), 13 deletions(-)
> >>
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
