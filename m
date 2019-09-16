Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D74C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 17:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B57B216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 17:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="zlmpEt5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732272AbfIPRrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 13:47:31 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:59719 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfIPRrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 13:47:31 -0400
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x8GHlOSP000933
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 02:47:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x8GHlOSP000933
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1568656045;
        bh=snSC5CbpUuN1Cw3Ri9XlO0GR3QpMdN6LNC6tbl3IFpw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zlmpEt5sTfPYRKVA5/2rQkTcbsZtkXiTvMkIlsayE1VrEhTaMhEeG8laftJvYEfR1
         3VNxQDEE8Z3FDKVGGqExRg8nMudu2nQAeutKtyU8QA1ZTI5AFebtE1Lft2BW1i5tY6
         oWv40Jg2ztT15sZUv4yN+7Kz+ZxM4tpx3CWIGrSf7Ktva3EYlHeHutFdzHpHjloCXm
         IoHT2/G/0Ly9eCrt5f4fIQhVNQnXCBHafQTK17cFb/fvJEvQHBWjWgNxszmBtKt15a
         8WBtHiRHPjrxaLN+7BbZ3nrwTc3nsY5/W96QzrFjR+5ujrTpG5F8U4bVcISnD5dorL
         syb0XIObdX5hw==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id w195so201076vsw.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 10:47:25 -0700 (PDT)
X-Gm-Message-State: APjAAAVUJ+Ti7xbDFQDNEJQRH8Q/G0A/8psTgYME3XleiyXX+NpWPNFL
        cXjegbok5c5oDMmMcY7TsDYJq90T7wCxnUt5BnI=
X-Google-Smtp-Source: APXvYqw0crawiGP3RG9x21JW4rmaeJ/jyNDfUIdTYxkF1YqpKyOnmgLelaYfXtHPmP/3VofBZVarCj+rIB0skCe86ZI=
X-Received: by 2002:a67:1e87:: with SMTP id e129mr578937vse.179.1568656044082;
 Mon, 16 Sep 2019 10:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190916044651.GA72121@LGEARND20B15>
In-Reply-To: <20190916044651.GA72121@LGEARND20B15>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 17 Sep 2019 02:46:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNARZMr5ZKGufi63GZrZ45k60faAiXr4mBB_mU9h_QifjxQ@mail.gmail.com>
Message-ID: <CAK7LNARZMr5ZKGufi63GZrZ45k60faAiXr4mBB_mU9h_QifjxQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix compile error due to 'endif' missing
To:     Austin Kim <austindh.kim@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Roman.Li@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+CC Stephen Rothwell, Mark Brown)

On Mon, Sep 16, 2019 at 1:46 PM Austin Kim <austindh.kim@gmail.com> wrote:
>
> gcc throws compile error with below message:

GNU Make throws ...


This is probably a merge mistake in linux-next.

If so, this should be directly fixed in the linux-next.

If it is not fixed in time,
please inform Linus to *not* follow the linux-next.


Thanks.



>
> HDRINST usr/include/drm/i915_drm.h
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/Makefile:70: *** missing 'endif'.  Stop.
> scripts/Makefile.modbuiltin:55: recipe for target 'drivers/gpu/drm/amd/amdgpu' failed
> make[3]: *** [drivers/gpu/drm/amd/amdgpu] Error 2
> make[3]: *** Waiting for unfinished jobs....
>   HDRINST usr/include/drm/omap_drm.h
>   HDRINST usr/include/drm/tegra_drm.h
>   HDRINST usr/include/drm/drm_sarea.h
>   HDRINST usr/include/drm/panfrost_drm.h
>   HDRINST usr/include/drm/drm.h
> scripts/Makefile.modbuiltin:55: recipe for target 'drivers/gpu/drm' failed
> make[2]: *** [drivers/gpu/drm] Error 2
> scripts/Makefile.modbuiltin:55: recipe for target 'drivers/gpu' failed
> make[1]: *** [drivers/gpu] Error 2
> make[1]: *** Waiting for unfinished jobs....
>
> Add 'endif' to Makefile to stop compile error.
>
> Signed-off-by: Austin Kim <austindh.kim@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index a2eb59e..5b2a65b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -44,6 +44,7 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_ccflags)
>  CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_ccflags)
>  CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_ccflags)
>  CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20v2.o := $(dml_ccflags)
> +endif
>  ifdef CONFIG_DRM_AMD_DC_DCN2_1
>  CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_mode_vba_21.o := $(dml_ccflags)
>  CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_rq_dlg_calc_21.o := $(dml_ccflags)
> --
> 2.6.2
>


-- 
Best Regards
Masahiro Yamada
