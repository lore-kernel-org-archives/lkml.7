Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A42C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600792175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjMvfUJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfDXLH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:07:29 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38340 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbfDXLH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:07:27 -0400
Received: by mail-vs1-f65.google.com with SMTP id s2so10130348vsi.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 04:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9pWZS7yFlm3jCGx8ZoRRFTXnaq8fMPphdAp4nx9YpaA=;
        b=AjMvfUJLtaiaBpFtR/KeeVTGqisiknyTNgIl7V1GbX6JW7/ewugs9HTuCnDeZJg0rn
         tu4VmWCxmVi5sruUhlNCwaWPpcDDHiWHf+AFsFD5tEpY0YmpFw+TuvXwjXDcGFGRz72r
         br/8CdrV7X6QmgVMJGWvRcHuorOAncVooE8pchMemS3y7gB/XkZVUmtlgrD35hBmZ4Yn
         E4ZX7Ix/asEIRKJuvAhXmWzL3CRiulXTWdCMTwDrf2gNV+cAJnxbte/Me0yL2SOASlUT
         f4ZOJDWzYF6oS3flMHzkw+lRJu3cZst99COVoKIsU4zQj/qMhHwuLdJwdYmBBTkZUTE7
         /pbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9pWZS7yFlm3jCGx8ZoRRFTXnaq8fMPphdAp4nx9YpaA=;
        b=fkJoX6leJrraqaYGAQoDHO2Qlp4tkzkqm4cAzBGaSCw1FDDT1pBH9tqs5zULRtgelR
         ag7qcOZCNC4O48QvPLfRQV4pMdtZCllTw026k8oMTRVl36ZzuP3PXUswVs0CoY2zdhdD
         wSJgb5Oo3vEg7PvpXmXosqU8azHGIFgQAHiSoUfjwSfedqGey1miXLUW/ZTSuyBVwWbm
         8Z6WEB8rGLqd3qQ5kMyqbNIMH3LmMyCsUOoHOdUv2/ILf7FoSbM4gYw9pHlR1LPAIQaw
         0qgfXRr4p206YGAOb/tgCroipGcox0ik4e0MS3ENqOkbHaCjNSASuvo9gNMckrLXhEo9
         ocYg==
X-Gm-Message-State: APjAAAVNmJ0bU46qIHIWYdjRfwJmkOmkkMfty0lucAZq5iXI7pQm1wMw
        4mZo5TUgemQBh6usK5rtS6Wijxs78PhHsDNEc7E=
X-Google-Smtp-Source: APXvYqzfFTlpHJ/EswLEPq6ugdb8nQnQtGfB4kHMpFb7LJTm63ukM0kOpdEuIt5Tz/gkzXAjpEbza9rEEMyAuGsOwzc=
X-Received: by 2002:a67:8210:: with SMTP id e16mr16126262vsd.85.1556104045869;
 Wed, 24 Apr 2019 04:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190424055108.19390-1-james.qian.wang@arm.com>
In-Reply-To: <20190424055108.19390-1-james.qian.wang@arm.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Wed, 24 Apr 2019 12:06:55 +0100
Message-ID: <CACvgo50zWO61bbY7Mwxhp0YSxaPT02aTEfG6pzUZ8bpPkzyo=g@mail.gmail.com>
Subject: Re: [PATCH] drm/komeda: Mark the local functions as static
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>, nd <nd@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019 at 06:51, james qian wang (Arm Technology China)
<james.qian.wang@arm.com> wrote:
>
> Fix the kbuild test rebot reported warnings:
> - symbol was not declared. Should it be static?
> - missing braces around initializer
>
> Depends on:
> - https://patchwork.freedesktop.org/series/58976/
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
> ---
>  .../gpu/drm/arm/display/komeda/d71/d71_component.c    |  9 +++++----
>  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c      |  4 ++--
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c       |  4 +++-
>  drivers/gpu/drm/arm/display/komeda/komeda_drv.c       |  2 +-
>  drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c  |  2 +-
>  .../drm/arm/display/komeda/komeda_pipeline_state.c    | 11 ++++++-----
>  drivers/gpu/drm/arm/display/komeda/komeda_plane.c     | 10 ++++++----
>  7 files changed, 24 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index c56cfc2de147..031e5f305a3c 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -391,7 +391,7 @@ static void d71_compiz_dump(struct komeda_component *c, struct seq_file *sf)
>         seq_printf(sf, "CU_USER_HIGH:\t\t0x%X\n", v[1]);
>  }
>
> -struct komeda_component_funcs d71_compiz_funcs = {
> +static struct komeda_component_funcs d71_compiz_funcs = {

Side note: Practically any piece of komeda_component_funcs and
komeda_pipeline_funcs could (and should) be constified.

-Emil
