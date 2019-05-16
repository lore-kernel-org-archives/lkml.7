Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C732C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF12205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hQ5iBqKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfEPIrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:47:22 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39268 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfEPIrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:47:22 -0400
Received: by mail-io1-f68.google.com with SMTP id m7so1935812ioa.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 01:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T67sSBYpxyMnMx5QAXMMq1F3JuIWuxSCHLtvQoMOPC8=;
        b=hQ5iBqKw8w+CnbtvBQNCHowRf/7eqLIDLeSjRYUgZYVdCs2VYDfzQO0NredRP/+iaH
         bmxXDx1ZZpxja1lFZ+aCKXXm97qhsynO6b9QLoSYyzVNHePnrXaM+euM7iqPRN3JnCu6
         +JdUXHk6GQZAPqdrg/c/n9AF+WPWl6PK31LhJRhOwJY12J9yL7XXpwwmy8URwaATKMCS
         ChSHszr09O/y8aJKwsccl4yQzWSDbhdXXRz8JNu+9Qjhup6JWnAGVmGo0J8dOJqjHO66
         9pR+YuKZTZzI9tGG8jg45Fe2qhDVXzO9RoLbfNKCLB20kt8xuNKVsI1johJCKqKZj/2G
         YqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T67sSBYpxyMnMx5QAXMMq1F3JuIWuxSCHLtvQoMOPC8=;
        b=ZsnBAfNYereIHmye9rCmY1/ChzQ8yzdQgEzACuBS6mWCQnarALi8wGCr3IBeWbLMUe
         DrXfq8scJugixq1AXV75kMbZxxeJg/c+hHNfh9xxgkpxf1O3bdZQxtLVAchujyhlX/Up
         /XFVLrtkWClNyM5x7eSFwFIouFpygTfIeq6wiNGGssp/5EIUQxNM62rzfH/i0DmRrmZR
         nohc51zojRCjqNPxhyxc/rHy9Z4W9OLj1vpEQBL+YlnEQ1/XPGQRljhvFf7BYXQKo37L
         b8RJmSYlfe+PE/jNnG6tMTg87G8zwIGkfTBB+SROYrSU1y7/u2W3Z+G3U3oxDOabQzfD
         9yZQ==
X-Gm-Message-State: APjAAAWba1x1ZCVz3bD7HyLO0gkKidxNBTTPFuExVwYBa+AdhPMkAtpz
        aVmzS5WNEbbyPCjCUIxAB82HlBO/lvU3PW2eVvBQ6Q==
X-Google-Smtp-Source: APXvYqzRWW5Vw8J/39xYKpC2Df9BAh9uNAvhSdajD9qOYt+HUvst57L/1O1ngpkWEYP6UmG2ye5WhE1hcP1xsks5uNY=
X-Received: by 2002:a5d:93da:: with SMTP id j26mr26609941ioo.170.1557996441199;
 Thu, 16 May 2019 01:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190510090025.4680-1-chris.packham@alliedtelesis.co.nz> <CAD=FV=UN8rm_40eVz4YVVJ57d_BWkzxs1E4nYhX_mKWe2pwX0Q@mail.gmail.com>
In-Reply-To: <CAD=FV=UN8rm_40eVz4YVVJ57d_BWkzxs1E4nYhX_mKWe2pwX0Q@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 16 May 2019 10:47:08 +0200
Message-ID: <CAKv+Gu98jQA7XARghVNXq8qEBm4DG77q3K0j-zw-WX_w-4_Q-Q@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: arm_ssp_per_task_plugin: Fix for older GCC < 6
To:     Doug Anderson <dianders@chromium.org>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 May 2019 at 00:42, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> > Use gen_rtx_set instead of gen_rtx_SET. The former is a wrapper macro
> > that handles the difference between GCC versions implementing
> > the latter.
> >
> > This fixes the following error on my system with g++ 5.4.0 as the host
> > compiler
> >
> >    HOSTCXX -fPIC scripts/gcc-plugins/arm_ssp_per_task_plugin.o
> >  scripts/gcc-plugins/arm_ssp_per_task_plugin.c:42:14: error: macro "gen=
_rtx_SET" requires 3 arguments, but only 2 given
> >           mask)),
> >                ^
> >  scripts/gcc-plugins/arm_ssp_per_task_plugin.c: In function =E2=80=98un=
signed int arm_pertask_ssp_rtl_execute()=E2=80=99:
> >  scripts/gcc-plugins/arm_ssp_per_task_plugin.c:39:20: error: =E2=80=98g=
en_rtx_SET=E2=80=99 was not declared in this scope
> >     emit_insn_before(gen_rtx_SET
> >
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > ---
> >  scripts/gcc-plugins/arm_ssp_per_task_plugin.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I can confirm that I was getting compile errors before this patch and
> applying it allowed me to compile and boot.  Thanks!  :-)
>
> Tested-by: Douglas Anderson <dianders@chromium.org>
>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
