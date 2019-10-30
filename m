Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE19CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F91020578
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5U/GaUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfJ3NkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 09:40:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40467 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfJ3NkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:40:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id r4so1610140pfl.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 06:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6hewunER1BJ3JHZmiLHPwNFknENQ0spNgw9Su+32lGw=;
        b=i5U/GaUzYYTNmgE0d7+egpWalDF1wGMJltWY5Kj+DsOY3SklsuL6jLLTnN5Fx2cR3x
         PR5Jp5k+DJFDsfWza66xxO/kpd3vmLsDaMep5qJs8w+TBP4+VbMRB72wJaIFypD4IZTF
         QOvwHprRWuMt027mMmukKvfhWdJxXHpT1E3JXrdhsGvFZw5ZLASziLh1gKw4odMvMy4U
         VZOIwL3lzynrY8NMzfhMouXy1iaB9kJrvsCInd2TlGl+OAoKM/TFk6GMqlx3rvn9E+9E
         G9gM7AcAE5vPIxTpLCMi79b0/0dv4t/ew8E8pGrRx/Y1vuiU0GIJxrL6UcFTf/ASYon3
         u75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6hewunER1BJ3JHZmiLHPwNFknENQ0spNgw9Su+32lGw=;
        b=B8/jtOeQJcQsWpyxq7hFmWZmNygAivXmn+tQdAq7eeAA+4PDKlpbBAJe/to3Yy4zmP
         e/KmkypIwZqE1jMjn3H479sm8yw3iy1FwYgk+O7z6BIrIt5K+bAnrYfWwHeYqNXMFFJW
         HvIvAr2gbu4gIKkr0n/nh1izZUBoBSanXxP8zKnHnymNELICWUJCRNuK8JSNEZMYVYFZ
         6PU++gNmM6y3vV7jp6dz5jrFx7d6ccdG6GBl4eVYfkCy0O5k0JHp5N2TMst1rFDv/j5E
         RflSoJthL98lBlxddEarIYha1nb42NxvYMJ4epNg+NVdvwPgtxubRi/qKumQolOMyjaz
         3LfQ==
X-Gm-Message-State: APjAAAV1VQRvuAO3KlMRoJuC6nlcL37ohjddczu3WyJzp8tBC/Zoaanx
        sTJdJAgR907/lOzUuLitSxfUawb3gimOZiJ0McQ=
X-Google-Smtp-Source: APXvYqxnhe4RY9omxQUIA+E+AAyAyt0AaSmxl6SyaVdsCbcJIOtyrJoSNMQ7bVLhT5uc/MKyT8mExRRvvw24fUf0mxo=
X-Received: by 2002:a63:5619:: with SMTP id k25mr34026206pgb.439.1572442801008;
 Wed, 30 Oct 2019 06:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <1572440776-50318-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1572440776-50318-1-git-send-email-zhongjiang@huawei.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Wed, 30 Oct 2019 22:39:49 +0900
Message-ID: <CAC5umyhRiJ9LHD1fhhSUygmWtXMe28WL4KB9=5DXv0rU6rJ0vg@mail.gmail.com>
Subject: Re: [PATCH v2] fault-inject: Use debugfs_create_ulong() instead of debugfs_create_ul()
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019=E5=B9=B410=E6=9C=8830=E6=97=A5(=E6=B0=B4) 22:10 zhong jiang <zhongjian=
g@huawei.com>:
>
> debugfs_create_ulong() has implemented the function of debugfs_create_ul(=
)
> in lib/fault-inject.c. hence we can replace it.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  lib/fault-inject.c | 43 ++++++++++++++-----------------------------
>  1 file changed, 14 insertions(+), 29 deletions(-)
>
> diff --git a/lib/fault-inject.c b/lib/fault-inject.c
> index 8186ca8..326fc1d 100644
> --- a/lib/fault-inject.c
> +++ b/lib/fault-inject.c
> @@ -151,10 +151,13 @@ bool should_fail(struct fault_attr *attr, ssize_t s=
ize)
>  EXPORT_SYMBOL_GPL(should_fail);
>
>  #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
> +#ifdef CONFIG_FAULT_INJECTION_STACKTRACE_FILTER
>
> -static int debugfs_ul_set(void *data, u64 val)
> +static int debugfs_stacktrace_depth_set(void *data, u64 val)
>  {
> -       *(unsigned long *)data =3D val;
> +       *(unsigned long *)data =3D
> +               min_t(unsigned long, val, MAX_STACK_TRACE_DEPTH);
> +
>         return 0;
>  }
>
> @@ -164,26 +167,8 @@ static int debugfs_ul_get(void *data, u64 *val)
>         return 0;
>  }
>
> -DEFINE_SIMPLE_ATTRIBUTE(fops_ul, debugfs_ul_get, debugfs_ul_set, "%llu\n=
");
> -
> -static void debugfs_create_ul(const char *name, umode_t mode,
> -                             struct dentry *parent, unsigned long *value=
)
> -{
> -       debugfs_create_file(name, mode, parent, value, &fops_ul);
> -}
> -
> -#ifdef CONFIG_FAULT_INJECTION_STACKTRACE_FILTER
> -
> -static int debugfs_stacktrace_depth_set(void *data, u64 val)
> -{
> -       *(unsigned long *)data =3D
> -               min_t(unsigned long, val, MAX_STACK_TRACE_DEPTH);
> -
> -       return 0;
> -}
> -
> -DEFINE_SIMPLE_ATTRIBUTE(fops_stacktrace_depth, debugfs_ul_get,
> -                       debugfs_stacktrace_depth_set, "%llu\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_stacktrace_depth, debugfs_ul_get,
> +                        debugfs_stacktrace_depth_set, "%llu\n");
>

The commit message doesn't describe the s/SIMPLE/DEBUGFS/ change
for fops_stacktrace_depth.

It is better to prepare another patch and I think debugfs_create_file()
in debugfs_create_stacktrace_depth() can now be replaced by
debugfs_create_file_unsafe().
