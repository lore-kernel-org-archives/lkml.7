Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAE8C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BDB214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YdLjxYgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388890AbfIPVG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:06:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34419 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730662AbfIPVG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:06:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id b128so691107pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 14:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iS/KS7K2dpElo8VkeXq0MZCaa3SuE0K1o3j4psLcFA8=;
        b=YdLjxYgRbkoi06bMhkQnbta7mRwdXc5iGkj16WLjvWHccLbl1IEoEQgQNK9cuSyldW
         mnG6FyS+PTWXYUivgSnH4ar0Jz0Bnce/CsdKs9TZhWuClo9vkix9oeoonQEOa2uZcDCc
         VwBR4oL1DF5bCfjUsZKsnNxhGxKXrY7zSIA14puGVdFeaO39XPeEtBC3r3MkEXp1dcHv
         2ZyUHyoSYB1Z0yuR0gki0YDurp2BTja5VXeKRKLBTAHnqJrgbpYkAJnnt+kaFhh5rh0U
         r9NF7VHvDToPuWN663YyucmZrI2bEzZAW+9yvVVYSiCbrFJjmCcxYnGDaBUB/bip6C+m
         EiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iS/KS7K2dpElo8VkeXq0MZCaa3SuE0K1o3j4psLcFA8=;
        b=JNb6IpmMc/kUL/tlTWq+cGhfiTrWhsqQIXVwtnnT38V79xoY8PWCJGUyHQGUXZykgk
         iooEmzYRxdXebSWZ16/sGEVg/zMPI5ZFMLU2dK4XU6dW8aYAYBMH3hTwov1Nsl0lzb3l
         XGsOabgoSPonwQn71ZUuni+Kzfjtj6PjxThnPP1wvSY6vtUJrIDKjUocop5O0YGZ+PUZ
         LD4gd17HhZNUScdTYkNxkIAiathwyd41a1j67YfvImc1DdgPe7koSPxgLs19iLSt4pIG
         Hjf9/D5qQd3XoYugWg4SN2U13xSaXG+EyRAa2+mWdKKLNWd/Tht3pIVc5ElWCGx/7hBk
         minw==
X-Gm-Message-State: APjAAAXRtU8iDNBGGkcrV8oz43PJWwD1RtUFu9yssZIAgZ7xiNJD/jqY
        GFl+0gJFcFWFZ3SNjtiwI6Z5UhTJxhau3NeWpCP0xg==
X-Google-Smtp-Source: APXvYqxZco9RmXoG2vVXf/2rxlM8ja+bWzzGh23VEs5YPWBvIGKwLERa7drgEvqHT1ZmjmG63H9hom+fnxJ5QfbcVic=
X-Received: by 2002:a62:5fc1:: with SMTP id t184mr414733pfb.84.1568668017409;
 Mon, 16 Sep 2019 14:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190915214748.GJ4352@sirena.co.uk>
In-Reply-To: <20190915214748.GJ4352@sirena.co.uk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 16 Sep 2019 14:06:46 -0700
Message-ID: <CAKwvOdkZ9_qp9V=H6tjpLyscct+g-aPqn-dPj8R+CGF4Rt_-Rw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the drm tree with the kbuild tree
To:     Mark Brown <broonie@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Roman Li <Roman.Li@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Jun Lei <Jun.Lei@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xinpeng Liu <danielliu861@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2019 at 2:47 PM Mark Brown <broonie@kernel.org> wrote:
>
> Hi all,
>
> Today's linux-next merge of the drm tree got a conflict in:
>
>   drivers/gpu/drm/amd/display/dc/dml/Makefile
>
> between commit:
>
>   54b8ae66ae1a345 ("kbuild: change *FLAGS_<basetarget>.o to take the path relative to $(obj)")
>
> from the kbuild tree and commits:
>
>   0f0727d971f6fdf ("drm/amd/display: readd -msse2 to prevent Clang from emitting libcalls to undefined SW FP routines")

^ this patch is now broken due to the SHA above it.

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index 2b399cfa72e6..ddb8d5649e79 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -19,7 +19,7 @@ endif
 CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o := -mhard-float -msse
$(cc_stack_align)

 ifdef CONFIG_CC_IS_CLANG
-CFLAGS_dcn20_resource.o += -msse2
+CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o += -msse2
 endif

 AMD_DAL_DCN20 = $(addprefix $(AMDDALPATH)/dc/dcn20/,$(DCN20))


>   542816ff168d8a3 ("drm/amd/display: Add DCN2.1 changes to DML")
>   b04641a3f4c54b0 ("drm/amd/display: Add Renoir DML")
>   057fc695e934a77 ("drm/amd/display: support "dummy pstate"")
>
> from the drm tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> diff --cc drivers/gpu/drm/amd/display/dc/dml/Makefile
> index 83792e2c0f0e4,af2a864a6da05..0000000000000
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@@ -32,16 -32,29 +32,25 @@@ endi
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
>  -endif
>  +CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_ccflags)
>  +CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_ccflags)
>  +CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_ccflags)
> ++CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_ccflags)
> ++CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20v2.o := $(dml_ccflags)
> + ifdef CONFIG_DRM_AMD_DC_DCN2_1
>  -CFLAGS_display_mode_vba_21.o := $(dml_ccflags)
>  -CFLAGS_display_rq_dlg_calc_21.o := $(dml_ccflags)
>  -endif

^ this endif should not be removed.


>  -ifdef CONFIG_DRM_AMD_DCN3AG
>  -CFLAGS_display_mode_vba_3ag.o := $(dml_ccflags)
> ++CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_mode_vba_21.o := $(dml_ccflags)
> ++CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_rq_dlg_calc_21.o := $(dml_ccflags)
>   endif
>  -CFLAGS_dml1_display_rq_dlg_calc.o := $(dml_ccflags)
>  -CFLAGS_display_rq_dlg_helpers.o := $(dml_ccflags)
>  -CFLAGS_dml_common_defs.o := $(dml_ccflags)
>  +CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_ccflags)
>  +CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_ccflags)
>  +CFLAGS_$(AMDDALPATH)/dc/dml/dml_common_defs.o := $(dml_ccflags)
>
>   DML = display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_dlg_calc.o \
>         dml_common_defs.o



--
Thanks,
~Nick Desaulniers
