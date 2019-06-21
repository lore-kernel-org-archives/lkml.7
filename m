Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A26C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 03:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6899B20675
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 03:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxTpHm7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfFUDy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 23:54:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37392 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFUDyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 23:54:25 -0400
Received: by mail-lf1-f68.google.com with SMTP id d11so3964539lfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 20:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jn4tGYSJ/BVRJYqeuzvrUB2edC/jmbjSeSFuekjFpaE=;
        b=UxTpHm7rCec53OY9ETHDHt6KAq5k39cMuHcI1a3Dq2f4pSc24mnlCaxM8Zu3KLgdlI
         0kwzLI57XCfc0WJXMNoUBdpKRmxtLFPe6GPEpU71c+/qJqTsrwBMZeAuDPfet9m8GUOY
         cWemjN1l3qpgFLF9pf9vgDOmMF4H3AvHhMwqjW67QrZaayQzNnAcVPbzEGneGj6rZ7DT
         5akLJVVYypyCw16BN8iDRRF1OfbWkILZ2LSW+WofQ+jxCakLJtUYcZQOMRqJHLrXdsu+
         G1cvDYTIFEkuebULB54Wq1dRtuhcy3Apj5QEfZtT7v4JzzQFs/tEt95bXb12GdmL7Hb8
         XkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jn4tGYSJ/BVRJYqeuzvrUB2edC/jmbjSeSFuekjFpaE=;
        b=eJbglV3Zu/UNkqHqvqviNgA1hQoY1/DWVI/9m1d/g8XbFCH9AtgprajVQC5VwCRYpc
         EpjxUlTVqEl6EA20WZ4Ryi9CbDpPthrO3wZhmpEoF3jBqfO+FsMBHY1e+Gn2973JYoBs
         VdsRUtuEdGABGWbKVJuGXYDdzy5x4/bJvSrQtOrhETniYNFouROEd95IAUBUUs+pvoyx
         OX7I92ZV8YzhVT1luoR0X+S4xey3F65JKw22bBLPdxbMtPHhOFkJModNaB4xJONtPLOU
         H2V2RWoXz6tYQzOBXWuDf+AVVtRrehRocpsbqcxQgJmeWMOrDo0mcxrXIDMADWwmbNvT
         MCjg==
X-Gm-Message-State: APjAAAWY4dvaSoPgoxk3PnOsJEDBqCUKQcWegrqPHuX2NINoOaByzST5
        Sjmk3UarS2D1Np/1GxerkgltRVg3Mz/9C1w7wMITRPjL
X-Google-Smtp-Source: APXvYqydGQ8QmBF8bQXC1fWB9VKUlQL5NiQCwNMkAVUQ2cHe1Ocf30WnEs2/LJdXgTkrhRaTar6elZXPSfIFRpZW+qQ=
X-Received: by 2002:a19:ccc6:: with SMTP id c189mr35078913lfg.160.1561089262697;
 Thu, 20 Jun 2019 20:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190620103524.GF17204@e110455-lin.cambridge.arm.com>
In-Reply-To: <20190620103524.GF17204@e110455-lin.cambridge.arm.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 21 Jun 2019 13:54:11 +1000
Message-ID: <CAPM=9tx9n7eAiHakdp+A8twco1GbKs5sy3=kJL6tH_SoYsLG1g@mail.gmail.com>
Subject: Re: [GIT PULL] mali-dp and komeda patches for drm-next
To:     Liviu Dudau <Liviu.Dudau@arm.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        MaliDP Maintainers <malidp@foss.arm.com>,
        DRI devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Lowry Li (Arm Technology China)" <lowry.li@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2019 at 20:35, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
>
> Hi DRM maintainers,
>
> Picking up pace on the upstreaming of Komeda driver, with quite a lot
> of new features added this time. On top of that we have the small
> cleanups and improved usage of the debugfs functions. Please pull!

It looks like you rebased this at the last moment, please don't do
that, don't rebase just because you can.

The reason I noticed is because
dim: 344f00e4d7d6 ("drm/komeda: Make Komeda interrupts shareable"):
author Signed-off-by missing.
dim: 1885a6d946f5 ("drm/komeda: fix 32-bit
komeda_crtc_update_clock_ratio"): SHA1 in fixes line not found:
dim:     a962091227ed ("drm/komeda: Add engine clock requirement check
for the downscaling")
dim: ERROR: issues in commits detected, aborting

so clearly rebasing the fixed commit broke stuff, you should probably
squash fixes if you are rebasing.

Please resend with above fixed, and refrain from misc rebases in future.

Dave.

>
> Best regards,
> Liviu
>
>
> The following changes since commit 52d2d44eee8091e740d0d275df1311fb8373c9=
a9:
>
>   Merge v5.2-rc5 into drm-next (2019-06-19 12:07:29 +0200)
>
> are available in the Git repository at:
>
>   git://linux-arm.org/linux-ld.git for-upstream/mali-dp
>
> for you to fetch changes up to 344f00e4d7d6538c1862505b25b662b47c9e0bb0:
>
>   drm/komeda: Make Komeda interrupts shareable (2019-06-19 17:04:21 +0100=
)
>
> ----------------------------------------------------------------
> Arnd Bergmann (1):
>       drm/komeda: fix 32-bit komeda_crtc_update_clock_ratio
>
> Ayan Halder (1):
>       drm/komeda: Make Komeda interrupts shareable
>
> Greg Kroah-Hartman (2):
>       komeda: no need to check return value of debugfs_create functions
>       malidp: no need to check return value of debugfs_create functions
>
> Liviu Dudau (1):
>       arm/komeda: Convert dp_wait_cond() to return an error code.
>
> Lowry Li (Arm Technology China) (10):
>       drm/komeda: Creates plane alpha and blend mode properties
>       drm/komeda: Clear enable bit in CU_INPUTx_CONTROL
>       drm/komeda: Add rotation support on Komeda driver
>       drm/komeda: Adds limitation check for AFBC wide block not support R=
ot90
>       drm/komeda: Update HW up-sampling on D71
>       drm/komeda: Enable color-encoding (YUV format) support
>       drm/komeda: Adds SMMU support
>       dt/bindings: drm/komeda: Adds SMMU support for D71 devicetree
>       drm/komeda: Adds zorder support
>       drm/komeda: Add slave pipeline support
>
> james qian wang (Arm Technology China) (21):
>       drm/komeda: Add writeback support
>       drm/komeda: Added AFBC support for komeda driver
>       drm/komeda: Attach scaler to drm as private object
>       drm/komeda: Add the initial scaler support for CORE
>       drm/komeda: Implement D71 scaler support
>       drm/komeda: Add writeback scaling support
>       drm/komeda: Add engine clock requirement check for the downscaling
>       drm/komeda: Add image enhancement support
>       drm/komeda: Add komeda_fb_check_src_coords
>       drm/komeda: Add format support for Y0L2, P010, YUV420_8/10BIT
>       drm/komeda: Unify mclk/pclk/pipeline->aclk to one MCLK
>       drm/komeda: Rename main engine clk name "mclk" to "aclk"
>       dt/bindings: drm/komeda: Unify mclk/pclk/pipeline->aclk to one ACLK
>       drm/komeda: Add component komeda_merger
>       drm/komeda: Add split support for scaler
>       drm/komeda: Add layer split support
>       drm/komeda: Refine function to_d71_input_id
>       drm/komeda: Accept null writeback configurations for writeback
>       drm/komeda: Add new component komeda_splitter
>       drm/komeda: Enable writeback split support
>       drm/komeda: Correct printk format specifier for "size_t"
>
>  .../devicetree/bindings/display/arm,komeda.txt     |  23 +-
>  drivers/gpu/drm/arm/display/include/malidp_io.h    |   7 +
>  drivers/gpu/drm/arm/display/include/malidp_utils.h |   5 +-
>  drivers/gpu/drm/arm/display/komeda/Makefile        |   2 +
>  .../gpu/drm/arm/display/komeda/d71/d71_component.c | 582 +++++++++++++++=
++-
>  drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c   | 142 +++--
>  drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h   |   2 +
>  .../gpu/drm/arm/display/komeda/komeda_color_mgmt.c |  67 ++
>  .../gpu/drm/arm/display/komeda/komeda_color_mgmt.h |  17 +
>  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   | 154 ++++-
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c    |  59 +-
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.h    |  13 +-
>  .../drm/arm/display/komeda/komeda_format_caps.c    |  58 ++
>  .../drm/arm/display/komeda/komeda_format_caps.h    |  24 +-
>  .../drm/arm/display/komeda/komeda_framebuffer.c    | 175 +++++-
>  .../drm/arm/display/komeda/komeda_framebuffer.h    |  13 +-
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.c    | 130 +++-
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.h    |  71 ++-
>  .../gpu/drm/arm/display/komeda/komeda_pipeline.c   |  66 +-
>  .../gpu/drm/arm/display/komeda/komeda_pipeline.h   | 111 +++-
>  .../drm/arm/display/komeda/komeda_pipeline_state.c | 679 +++++++++++++++=
+++++-
>  drivers/gpu/drm/arm/display/komeda/komeda_plane.c  | 191 +++++-
>  .../drm/arm/display/komeda/komeda_private_obj.c    | 154 +++++
>  .../drm/arm/display/komeda/komeda_wb_connector.c   | 199 ++++++
>  drivers/gpu/drm/arm/malidp_drv.c                   |  11 +-
>  25 files changed, 2728 insertions(+), 227 deletions(-)
>  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.=
c
>  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.=
h
>  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_wb_connecto=
r.c
>
>
> --
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     =C2=AF\_(=E3=83=84)_/=C2=AF
