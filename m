Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEAAC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2632082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mRRWRKAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfDJWSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:18:50 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39953 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDJWSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:18:48 -0400
Received: by mail-vs1-f66.google.com with SMTP id f22so2309457vso.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tPWdwl4Tm8jzYAc3nR128aIlhxTl0fGE3roAbQtw4oQ=;
        b=mRRWRKAc2PGSAovFYlgEPgX7EWVsz6TyMpP5c1Cjv/iBhpZxFL229MHvddvtGxYCBe
         /LrM9ADJ1cCN1d7a6hgQnNdQHes5pnrzKsLTskhXIr+RDv8FMh+k35L0yMcK9q9dyCQq
         5oDT0HZzka0q5yIrqNxbncujB6tVIPeXRV6eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tPWdwl4Tm8jzYAc3nR128aIlhxTl0fGE3roAbQtw4oQ=;
        b=BmRHV4oFRZppa1nW/A97X5pa7c6wiwAT/b19XC2wa6UyUPPmNk0PChgwZPiOMk0+bt
         Jq/PA2OnHPIbxCqHMBU4//NcDRgnR7X+P/oy1oAFLI3wTf1tJ5E4iR6LWwMpNE4yssh+
         nvDenJ/sx+jd467KgvPh8/e898FKoiy1bSzsK0mUmXhE+7DulT2OtQTed4bVFjEzerRd
         Lqx5S4FmJPgiQdfd+aiTao50qLcI54gom89i6bEdZmQEkFcXUI4t9oFW3et3pT7NziSH
         jR2T7NaRSFeqFidAQMni3REAsPB6VrZ85VMV4PgtQ29JXfaS2CmyNUidpxr9RCK32ZpO
         npzw==
X-Gm-Message-State: APjAAAV1GPH9do+creEVplp1/r1rroEHbRDG/28ycvhFp2iVHFECul5+
        Vf8FXWdHtsqwrXWFRcyhWvRV2iQrhN4=
X-Google-Smtp-Source: APXvYqw9oHCojF1AVbdi7NFtA61MO82KmtekNxXknroCdGmsafCpdGzJmttp5YNTBdE6eLqVS4yAjg==
X-Received: by 2002:a67:eeda:: with SMTP id o26mr26709664vsp.209.1554934726814;
        Wed, 10 Apr 2019 15:18:46 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id v22sm2025950vkd.44.2019.04.10.15.18.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 15:18:45 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id d5so1346493uan.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:18:45 -0700 (PDT)
X-Received: by 2002:ab0:4eaa:: with SMTP id l42mr19453267uah.80.1554934725230;
 Wed, 10 Apr 2019 15:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190408220925.13077-1-mcroce@redhat.com> <20190408220925.13077-2-mcroce@redhat.com>
In-Reply-To: <20190408220925.13077-2-mcroce@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 15:18:33 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJJDzty8trTPmuxu0_K9xvf+nJ9HGuUE9NF-WOgesu9sQ@mail.gmail.com>
Message-ID: <CAGXu5jJJDzty8trTPmuxu0_K9xvf+nJ9HGuUE9NF-WOgesu9sQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] proc/sysctl: add shared variables for range check
To:     Matteo Croce <mcroce@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 3:09 PM Matteo Croce <mcroce@redhat.com> wrote:
>
> In the sysctl code the proc_dointvec_minmax() function is often used to
> validate the user supplied value between an allowed range. This function
> uses the extra1 and extra2 members from struct ctl_table as minimum and
> maximum allowed value.
>
> On sysctl handler declaration, in every source file there are some readonly
> variables containing just an integer which address is assigned to the
> extra1 and extra2 members, so the sysctl range is enforced.
>
> The special values 0, 1 and INT_MAX are very often used as range boundary,
> leading duplication of variables like zero=0, one=1, int_max=INT_MAX in
> different source files:
>
>     $ git grep -E '\.extra[12].*&(zero|one|int_max)' |wc -l
>     261
>
> This patch adds three variables for the most commonly used values, so they
> can be referenced instead of creating a local one for every object file.
>
> Signed-off-by: Matteo Croce <mcroce@redhat.com>

Oh, and for this patch: Yes please; let's get everyone to use these
instead of littering the kernel with (non-const!) copies of the same
thing. :)

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  fs/proc/proc_sysctl.c  | 5 +++++
>  include/linux/sysctl.h | 4 ++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index d65390727541..e7a96169fced 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -21,6 +21,11 @@ static const struct inode_operations proc_sys_inode_operations;
>  static const struct file_operations proc_sys_dir_file_operations;
>  static const struct inode_operations proc_sys_dir_operations;
>
> +/* shared constants to be used in various sysctls */
> +const int sysctl_zero = 0;
> +const int sysctl_one = 1;
> +const int sysctl_int_max = INT_MAX;
> +
>  /* Support for permanently empty directories */
>
>  struct ctl_table sysctl_mount_point[] = {
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index b769ecfcc3bd..f3b191799747 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -37,6 +37,10 @@ struct ctl_table_root;
>  struct ctl_table_header;
>  struct ctl_dir;
>
> +extern const int sysctl_zero;
> +extern const int sysctl_one;
> +extern const int sysctl_int_max;
> +
>  typedef int proc_handler (struct ctl_table *ctl, int write,
>                           void __user *buffer, size_t *lenp, loff_t *ppos);
>
> --
> 2.21.0
>


-- 
Kees Cook
