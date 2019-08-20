Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15B4C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C89322DD3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbfHTUBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:01:48 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:60864 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729950AbfHTUBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:01:48 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 2BC9F20094;
        Tue, 20 Aug 2019 22:01:43 +0200 (CEST)
Date:   Tue, 20 Aug 2019 22:01:41 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 00/25] drm: Kirin driver cleanups to prep for Kirin960
 support
Message-ID: <20190820200141.GA23191@ravnborg.org>
References: <20190819230321.56480-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819230321.56480-1-john.stultz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=KKAkSRfTAAAA:8
        a=Wes08NWIifAUlHyeTIUA:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John.

On Mon, Aug 19, 2019 at 11:02:56PM +0000, John Stultz wrote:
> Sending this out again, to get it based on drm-misc-next.
> 
> This patchset contains one fix (in the front, so its easier to
> eventually backport), and a series of changes from YiPing to
> refactor the kirin drm driver so that it can be used on both
> kirin620 based devices (like the original HiKey board) as well
> as kirin960 based devices (like the HiKey960 board).
> 
> The full kirin960 drm support is still being refactored, but as
> this base kirin rework was getting to be substantial, I wanted
> to send out the first chunk, so that the review burden wasn't
> overwhelming.
> 
> The full HiKey960 patch stack can be found here:
>   https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/hikey960-mainline-WIP
> 
> thanks
> -john
> 
> 
> New in v4:
> * Rebased to drm-misc-next, minor tweaks to merge changes
> * Dropped "drm: kirin: Get rid of drmP.h includes" as similar change
>   was already in drm-misc next
> * Added acked-by tag from Xinliang

There was some checkpatch noises in some of the patches - please verify
with "--strict".
Mostly alignment of parameters with open parantesis
Sample - but there was similar issues in other patches:

8788b59decc8 (HEAD -> drm-misc-next) drm: kirin: Move ade drm init to kirin drm drv
-:208: CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#208: FILE: drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c:41:
+static int kirin_drm_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
+				struct drm_plane *plane,

-:244: CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#244: FILE: drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c:77:
+	ret = drm_universal_plane_init(dev, plane, 1, data->plane_funcs,
+				data->channel_formats,

-:271: CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#271: FILE: drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c:104:
+static int kirin_drm_private_init(struct drm_device *dev,
+				const struct kirin_drm_data *driver_data)




And then the build failed like this:
 LD [M]  drivers/gpu/drm/hisilicon/kirin/kirin-drm.o
aarch64-linux-gnu-ld: drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.o: in function `init_module':
dw_drm_dsi.c:(.init.text+0x0): multiple definition of `init_module'; drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.o:kirin_drm_drv.c:(.init.text+0x0): first defined here
aarch64-linux-gnu-ld: drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.o: in function `cleanup_module':
dw_drm_dsi.c:(.exit.text+0x0): multiple definition of `cleanup_module'; drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.o:kirin_drm_drv.c:(.exit.text+0x0): first defined here
make[3]: *** [/home/sam/drm/linux.git/scripts/Makefile.build:464: drivers/gpu/drm/hisilicon/kirin/kirin-drm.o] Error 1
make[2]: *** [/home/sam/drm/linux.git/scripts/Makefile.build:490: drivers/gpu/drm/hisilicon/kirin] Error 2
make[1]: *** [/home/sam/drm/linux.git/Makefile:1776: drivers/gpu/drm/hisilicon/] Error 2
make[1]: Leaving directory '/home/sam/drm/linux.git/.build/arm64-allmodconfig'
make: *** [Makefile:179: sub-make] Error 2

It was a simple allmodconfig build where I did:

make drivers/gpu/drm/hisilicon/

Please fix and resend. I did not look further.

	Sam
