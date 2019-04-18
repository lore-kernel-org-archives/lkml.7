Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD70EC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3DE21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="XzUCp5Ie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388210AbfDRHkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 03:40:11 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:56021 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRHkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 03:40:11 -0400
Received: by mail-it1-f194.google.com with SMTP id y134so1896598itc.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 00:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tu9CIqkID/XUZbh4ORTwGHccETfN4KwCG0wTfULZxv8=;
        b=XzUCp5IeogMbiiTvN6sx8DH/HJzRGJQC40yE3dYSwOXYQKIxqWucWI4FfNgcemcXtB
         I4uAYRPcIqbz4QdJINwFP748rZnfgISMk6KJt9fD6X35GKjOKQ1sng8S0uqWHN5meMQs
         rQCJNapHRanY6Ugjt54gEprR8bMFc43NlJXe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tu9CIqkID/XUZbh4ORTwGHccETfN4KwCG0wTfULZxv8=;
        b=f/jhc1+pMtgJcnUGjdo/B/mOdxbvwpo4Di7/Wy8khbqFUmOHDNdBU3TEMCl05Y8L84
         Jvrfp8CoO4DVHtGhCLlEpVzn2VIl4NoVwPIGrJ0v6ljk86AhLH7vvUyQkPj6OWB4TJsO
         HHxqC9JkzuobWxLZvsMWTbcmJvGOJA2KiWOzuL9HYqxKy7m4T/yHaxUlHR2PvykLBJS9
         JZZRHN8Vb202I4CnWZkU/Ml5b3a6A7/eoFcNzG7SwuRov+sR9/CF5fUgwp9Q0EoCVmbv
         +a+LL/23PxmyW5S7XiuLntVemF0RrGbntu1v2j4xFihjhHCN9/IZvWYWoaCbfKSk2Dfe
         rZDA==
X-Gm-Message-State: APjAAAVc6Ff+WDp1mIIjHyHqnk0ValzwfBsr6ljv8O69jmDTcgF/urhH
        t5F0xpIsfdNmkInkfo35C85XVKDw8wqbHu+T4a+0BQ==
X-Google-Smtp-Source: APXvYqxHUEMNTVo084VJmAK+Ukta241XS9J2z70o60HEtHH6Sl5UBdciIzqdlDn+JH9kkixj8M+gjcU1uSnzXa2RGA4=
X-Received: by 2002:a02:c4cf:: with SMTP id h15mr938861jaj.96.1555573210559;
 Thu, 18 Apr 2019 00:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190418074658.541fcfd7@canb.auug.org.au>
In-Reply-To: <20190418074658.541fcfd7@canb.auug.org.au>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 18 Apr 2019 09:39:59 +0200
Message-ID: <CAKMK7uHiZLLcnotJyb1jK2tJ0iKqk4cQpvpy_x+AHih34_QCSw@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the drm-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Wed, Apr 17, 2019 at 11:47 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   453393369dc9 ("drm/ttm: fix incrementing the page pointer for huge pages")
>
> Fixes tag
>
>   Fixes: e16858a7e6e7 drm/ttm: fix start page for huge page check in ttm_put_pages()
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
> Did you mean
>
> Fixes: ac1e516d5a4c ("drm/ttm: fix start page for huge page check in ttm_put_pages()")

Uh, our tooling should have caught this, and more:

dim: WARNING: Issues in pull request detected, but continuing dry-run
dim: b575f10dbd6f ("drm/amdgpu: shadow in shadow_list without
tbo.mem.start cause page fault in sriov TDR"): author Signed-off-by
missing.

^^ Wentao Lou should fix their git author, it looks a bit more like a
login id than a proper name

dim: 453393369dc9 ("drm/ttm: fix incrementing the page pointer for
huge pages"): SHA1 in fixes line not found:
dim:     e16858a7e6e7 drm/ttm: fix start page for huge page check in
ttm_put_pages()

^^ There we are.

dim: WARNING: issues in commits detected, but continuing dry-run

Dave, maybe drop the default dim -f you probably have in your history
somewhere :-)
Alex, another excuse to at lest copypaste the checks from dim? Or push
your tree using dim first, for these checks (you can still do all the
internal tree dancing for whatever reasons).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
