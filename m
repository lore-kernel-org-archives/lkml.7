Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9804C3A5AA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 23:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD29A2168B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 23:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="herM5rmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfIDXnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 19:43:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37301 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729919AbfIDXnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 19:43:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id y9so455200pfl.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 16:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=20yt+YNZ1L9RG1o4wcjzf4KRuf7yK7zvoTIvG7LJ5dY=;
        b=herM5rmY9dTySIiWkNtCKws+S32Q+KNr9KnA+p+QMqgbvsrsie5gRriffPC8sA/dvK
         C++NJPm6cH/IV68xM7a5W3/bTfJlMUFX7BletVHvCCULvYeZu48DdlxbAwoy94COPeAO
         BGcpaMHSHj2EEV0RFEg9nPnaQpxL9D/QuBcIcCpiVGxTDNkmNzGk6ekHCJIXmsrYr3oQ
         YJGXuZA5OUqyclRL9oYjNGwSjgNYxHO4R881eXHiHVeOEN8PHtpeAaICunkMrmOE2uSY
         wPBwMv1qHNKI62tT1HPe5QAamvEIjeMaPx6S3IT+eKQr1aYnFZDUzwx++38b90NXxpXS
         paJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=20yt+YNZ1L9RG1o4wcjzf4KRuf7yK7zvoTIvG7LJ5dY=;
        b=U/SthBk7tnmbu68mD5GF4zK+y/egf6T+q+TYr1asHPuR+E/5JWo3Vs5GhI0bmXOLJX
         mdqRj6wUYgOUFxoq/DMJxVLj48Vkos9XRDN0KSDsoXAovLwYrYn5Y8ODCNPc6bhHxqjt
         OimsiLfe9SR60sodaxMboQKaP/EO1HKI5XoKe0Bwie1qZQ0W841O5jT/3g0ZJtQ2QWGZ
         7UDcopYJs9d1eRpktZvefNVHFkit42e9p+vVoJsb15VJ//pAUR6XoDHfB91+eXN9p7uW
         UA0aY76+aYKT8hNZ737qqS5HIiFmfBFxez91Ee2oOb/inL2loinXffOdT1dqirR/omSj
         k3HA==
X-Gm-Message-State: APjAAAXrQvksw1HDgVU5kuw2yWgGj3Q37QzXLZM0pEM5VNQDEorgwBES
        42RI2TD8aDpc224kCWDT2q5RY6hj4GWxZgCScBpfcA==
X-Google-Smtp-Source: APXvYqwb6a9JvgIsY537fvx0QmcGGFZpP9NmS0y0s0rFiAJs9NR6meGRExFTHKlaBQgpKv098lpoKduJkhchy366fA4=
X-Received: by 2002:a65:690b:: with SMTP id s11mr596069pgq.10.1567640625488;
 Wed, 04 Sep 2019 16:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190904164622.57f69595@canb.auug.org.au>
In-Reply-To: <20190904164622.57f69595@canb.auug.org.au>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 4 Sep 2019 16:43:34 -0700
Message-ID: <CAKwvOdkxgNJ_KW3M4DW-VnMk9_Vst8yPTheELTrMDK14bb+L+w@mail.gmail.com>
Subject: Re: linux-next: manual merge of the drm tree with the kbuild tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 11:46 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the drm tree got conflicts in:
>
>   drivers/gpu/drm/amd/display/dc/calcs/Makefile
>   drivers/gpu/drm/amd/display/dc/dml/Makefile
>   drivers/gpu/drm/amd/display/dc/dsc/Makefile
>
> between commit:
>
>   30851871d5ab ("kbuild: change *FLAGS_<basetarget>.o to take the path relative to $(obj)")
>
> from the kbuild tree and commit:
>
>   0f0727d971f6 ("drm/amd/display: readd -msse2 to prevent Clang from emitting libcalls to undefined SW FP routines")
>
> from the drm tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

My changes LGTM, thanks!

>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc drivers/gpu/drm/amd/display/dc/calcs/Makefile
> index d930df63772c,16614d73a5fc..000000000000
> --- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> @@@ -32,9 -32,13 +32,13 @@@ endi
>
>   calcs_ccflags := -mhard-float -msse $(cc_stack_align)
>
> + ifdef CONFIG_CC_IS_CLANG
> + calcs_ccflags += -msse2
> + endif
> +
>  -CFLAGS_dcn_calcs.o := $(calcs_ccflags)
>  -CFLAGS_dcn_calc_auto.o := $(calcs_ccflags)
>  -CFLAGS_dcn_calc_math.o := $(calcs_ccflags) -Wno-tautological-compare
>  +CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calcs.o := $(calcs_ccflags)
>  +CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calc_auto.o := $(calcs_ccflags)
>  +CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calc_math.o := $(calcs_ccflags) -Wno-tautological-compare
>
>   BW_CALCS = dce_calcs.o bw_fixed.o custom_float.o
>
> diff --cc drivers/gpu/drm/amd/display/dc/dml/Makefile
> index 83792e2c0f0e,95fd2beca80c..000000000000
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@@ -32,16 -32,25 +32,20 @@@ endi
>
>   dml_ccflags := -mhard-float -msse $(cc_stack_align)
>
> + ifdef CONFIG_CC_IS_CLANG
> + dml_ccflags += -msse2
> + endif
> +
>  -CFLAGS_display_mode_lib.o := $(dml_ccflags)
>  +CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
>
>   ifdef CONFIG_DRM_AMD_DC_DCN2_0
>  -CFLAGS_display_mode_vba.o := $(dml_ccflags)
>  -CFLAGS_display_mode_vba_20.o := $(dml_ccflags)
>  -CFLAGS_display_rq_dlg_calc_20.o := $(dml_ccflags)
>  -CFLAGS_display_mode_vba_20v2.o := $(dml_ccflags)
>  -CFLAGS_display_rq_dlg_calc_20v2.o := $(dml_ccflags)
>  +CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_ccflags)
>  +CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_ccflags)
>  +CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_ccflags)
>   endif
>  -ifdef CONFIG_DRM_AMD_DCN3AG
>  -CFLAGS_display_mode_vba_3ag.o := $(dml_ccflags)
>  -endif
>  -CFLAGS_dml1_display_rq_dlg_calc.o := $(dml_ccflags)
>  -CFLAGS_display_rq_dlg_helpers.o := $(dml_ccflags)
>  -CFLAGS_dml_common_defs.o := $(dml_ccflags)
>  +CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_ccflags)
>  +CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_ccflags)
>  +CFLAGS_$(AMDDALPATH)/dc/dml/dml_common_defs.o := $(dml_ccflags)
>
>   DML = display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_dlg_calc.o \
>         dml_common_defs.o
> diff --cc drivers/gpu/drm/amd/display/dc/dsc/Makefile
> index c3922d6e7696,17db603f2d1f..000000000000
> --- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> @@@ -9,9 -9,14 +9,13 @@@ endi
>
>   dsc_ccflags := -mhard-float -msse $(cc_stack_align)
>
> + ifdef CONFIG_CC_IS_CLANG
> + dsc_ccflags += -msse2
> + endif
> +
>  -CFLAGS_rc_calc.o := $(dsc_ccflags)
>  -CFLAGS_rc_calc_dpi.o := $(dsc_ccflags)
>  -CFLAGS_codec_main_amd.o := $(dsc_ccflags)
>  -CFLAGS_dc_dsc.o := $(dsc_ccflags)
>  +CFLAGS_$(AMDDALPATH)/dc/dsc/rc_calc.o := $(dsc_ccflags)
>  +CFLAGS_$(AMDDALPATH)/dc/dsc/rc_calc_dpi.o := $(dsc_ccflags)
>  +CFLAGS_$(AMDDALPATH)/dc/dsc/dc_dsc.o := $(dsc_ccflags)
>
>   DSC = dc_dsc.o rc_calc.o rc_calc_dpi.o
>


-- 
Thanks,
~Nick Desaulniers
