Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB997C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8320520673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QGT9LAJa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgAIJI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:08:59 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39855 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbgAIJI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:08:58 -0500
Received: by mail-qt1-f196.google.com with SMTP id e5so5278158qtm.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 01:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iWKF4KF9Y1CtiEun++0rxUUQMRPGqGyeC6hWhJkdSUc=;
        b=QGT9LAJanjfXKoCERl6lGxDO5mX9gXrEuQ7sDttgSjCnzBSKSYfwnG4X9f+Ngw4O1v
         Jkhrpm+DlIJNPfdLLVhSKTc7QDIodBcyMEhHwaxzV8RY5q+Ffgk+1IFXnbZvNBlyfPV8
         UQwFDYjv97NNGovIbt5sPou5JjNNOYGlmCfeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iWKF4KF9Y1CtiEun++0rxUUQMRPGqGyeC6hWhJkdSUc=;
        b=Bsm4Kgu/A7I0kniu7qzo7UCzsJn150eOUkZ+LPx8JCsnUIcws3L4EIhr5vLR+RvsR0
         ILB9LhVt/RjhTxHAtkV+u+k70/Pb7f8mzMPpDymGhCCNuzHJVaY+RAs8D8lccQadB9CV
         Qnqdy1YbhxH9Hi20bmLnYdEQGwNQL5p87zlJwHj4+m/sJxRCI09mbJZ2IkUOZ5jMuz0g
         2+Y5dwc7GS56fo+CCuQ05PJjRggnlK1Wjp3N05a4QoKfbagniaGwBPAaPuiQoziNIoOX
         h8WUp3mrz/cF45JM3I1fS/0eWGfiM+FhhcrFiw2XuUYIvXHAvHR97nHOGwy95cjdyw3U
         41SA==
X-Gm-Message-State: APjAAAUFCxFX+s00acri+LFb7dut1w3esd6Vnfb1vShPA6IGmAtyRInm
        6GB0eqfblfGyOs03x6FNkl8IXNsy2J4wgy9ksXrohQ==
X-Google-Smtp-Source: APXvYqzHUEojTodwcrGuQpgaBY41guNbk/ZtFyS1AoJQRt5Iu+x8Niu+YYkIDEdBurliWcTM+tgf2nUl95GTV1rYpXA=
X-Received: by 2002:aed:2f45:: with SMTP id l63mr7382614qtd.221.1578560937298;
 Thu, 09 Jan 2020 01:08:57 -0800 (PST)
MIME-Version: 1.0
References: <20200108052337.65916-1-drinkcat@chromium.org>
In-Reply-To: <20200108052337.65916-1-drinkcat@chromium.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 9 Jan 2020 17:08:46 +0800
Message-ID: <CANMq1KCKuOTvyDxhnL1baEeRSxnaPdgMp9Lj2pcHwj-30n2-5g@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Add dts for mt8183 GPU (and misc panfrost patches)
To:     Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 1:23 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> Hi!
>
> Sorry for the long delay since https://patchwork.kernel.org/patch/11132381/,
> finally got around to give this a real try.
>
> The main purpose of this series is to upstream the dts change and the binding
> document, but I wanted to see how far I could probe the GPU, to check that the
> binding is indeed correct. The rest of the patches are RFC/work-in-progress, but
> I think some of them could already be picked up.
>
> So this is tested on MT8183 with a chromeos-4.19 kernel, and a ton of
> backports to get the latest panfrost driver (I should probably try on
> linux-next at some point but this was the path of least resistance).
>
> I tested it as a module as it's more challenging (originally probing would
> work built-in, on boot, but not as a module, as I didn't have the power
> domain changes, and all power domains are on by default during boot).
>
> Probing logs looks like this, currently:
> [  221.867726] panfrost 13040000.gpu: clock rate = 511999970
> [  221.867929] panfrost 13040000.gpu: Linked as a consumer to regulator.14
> [  221.868600] panfrost 13040000.gpu: Linked as a consumer to regulator.31
> [  221.870586] panfrost 13040000.gpu: Linked as a consumer to genpd:0:13040000.gpu
> [  221.871492] panfrost 13040000.gpu: Linked as a consumer to genpd:1:13040000.gpu
> [  221.871866] panfrost 13040000.gpu: Linked as a consumer to genpd:2:13040000.gpu
> [  221.872427] panfrost 13040000.gpu: mali-g72 id 0x6221 major 0x0 minor 0x3 status 0x0
> [  221.872439] panfrost 13040000.gpu: features: 00000000,13de77ff, issues: 00000000,00000400
> [  221.872445] panfrost 13040000.gpu: Features: L2:0x07120206 Shader:0x00000000 Tiler:0x00000809 Mem:0x1 MMU:0x00002830 AS:0xff JS:0x7
> [  221.872449] panfrost 13040000.gpu: shader_present=0x7 l2_present=0x1
> [  221.873526] panfrost 13040000.gpu: error powering up gpu stack
> [  221.878088] [drm] Initialized panfrost 1.1.0 20180908 for 13040000.gpu on minor 2
> [  221.940817] panfrost 13040000.gpu: error powering up gpu stack
> [  222.018233] panfrost 13040000.gpu: error powering up gpu stack
> (repeated)
>
> So the GPU is probed, but there's an issue when powering up the STACK, not
> quite sure why, I'll try to have a deeper look, at some point.

Just as a follow-up to that one. stack_present=0x00000007 on my GPU.

However, the ARM-provided driver I use on this platform doesn't have
CONFIG_MALI_CORESTACK enabled so the "stack" is never turned on.
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.19/drivers/gpu/arm/midgard/Kconfig#101
. So possibly this does not need to be done on Bifrost GPUs (and the
error should be harmless).

> Thanks!
>
> Nicolas
>
> v2:
>  - Use sram instead of mali_sram as SRAM supply name.
>  - Rename mali@ to gpu@.
>  - Add dt-bindings changes
>  - Stacking patches after the device tree change that allow basic
>    probing (still incomplete and broken).
>
> Nicolas Boichat (7):
>   dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183
>   arm64: dts: mt8183: Add node for the Mali GPU
>   drm/panfrost: Improve error reporting in panfrost_gpu_power_on
>   drm/panfrost: Add support for a second regulator for the GPU
>   drm/panfrost: Add support for multiple power domain support
>   RFC: drm/panfrost: Add bifrost compatible string
>   RFC: drm/panfrost: devfreq: Add support for 2 regulators
>
>  .../bindings/gpu/arm,mali-bifrost.yaml        |  20 ++++
>  arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |   7 ++
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 104 +++++++++++++++++
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c   |  18 +++
>  drivers/gpu/drm/panfrost/panfrost_device.c    | 108 ++++++++++++++++--
>  drivers/gpu/drm/panfrost/panfrost_device.h    |   7 ++
>  drivers/gpu/drm/panfrost/panfrost_drv.c       |   1 +
>  drivers/gpu/drm/panfrost/panfrost_gpu.c       |  15 ++-
>  8 files changed, 267 insertions(+), 13 deletions(-)
>
> --
> 2.24.1.735.g03f4e72817-goog
>
