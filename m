Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,TRACKER_ID autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E8CC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83A720811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Ckcx3dby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbfDXVug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:50:36 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39188 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730998AbfDXVug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:50:36 -0400
Received: by mail-lj1-f194.google.com with SMTP id l7so18339028ljg.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 14:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2r7FC6aYEqQpIsQhrjVyCdVrM9R04TFaGoYME2LBME4=;
        b=Ckcx3dbyKCmtnAntgbeX+20jlI5/NrF3yB+EmQObtbjOAWaEMCyCcJeASwyuhHbOjg
         jf9pZtJIuo8dpRsM63RqgRVgt7p4jHFJX1PPo9wfJq9cuwRmkYSG9PIe/5Nh9Xzfiw8i
         xyQBqK7/l0/GEJIHpGzfQMqXVpKGu1budfp08KSJWjvL7MlbuUPtgZHIfJZmN06+xMNd
         mF+kNRKvcwLsCl5/Syt6kNDNclXZShLbWKVlNx5ENriPl7kgET0s/4gUB7pjwx+JLxw+
         UczwXebYduuYtTqsFfz/5ovU+o+A4NJ8nWc53uv7nGds3Xs+8EzBvjwhTZk/OjruIaR/
         /kIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2r7FC6aYEqQpIsQhrjVyCdVrM9R04TFaGoYME2LBME4=;
        b=NU9SocwPfCjPCMGdKW5uThT7P6w4WUXS6x0kWSD7BwFAKySFpvCzxSIwzVDx6Ucf/Q
         DQAOvHzMQyjPBPvhIL/+Y4bLbZmuZJDfI39NcBLhTacEKj3f9g93wPbj0u5XJvH7ttuw
         o5Xkp7idxvryWIOnHDgkM7NdUrPWG7o2Pa1YKJYRXUEXWxixaoRl/po91S9VTWQSC353
         N0yW2miJNSsUAI1xgK57uiw8Q03ylqj0XGjdVn7P3ZzvRhgSOwBV7mcf9v0C/mMeJzlj
         i8NxIo7AlgrSklCwSWBkYL58MlShAnUjgv/YC8WYX783Vu7PIQ5OM5veeGIZewWBgOWj
         dJwQ==
X-Gm-Message-State: APjAAAU3thRzzOXXIctaQ7b7Gb/PIfetCXDrg4Y0SKNG6P4NPjxq3F4I
        ki0cgTmFUG6AkItPScs7bfrEkuEvLU3cMI1BQMkWLw==
X-Google-Smtp-Source: APXvYqyXkcxfJcSJ5mtMT0WY76YW4Hvw/iG2k0yXpY8M+XikMTgRxPXvy48w8e3dDF1Tz8+hLeLgxcezrg2UlBTpByo=
X-Received: by 2002:a2e:7114:: with SMTP id m20mr18995897ljc.120.1556142633904;
 Wed, 24 Apr 2019 14:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190424170923.452349382@linuxfoundation.org> <20190424170924.385228692@linuxfoundation.org>
In-Reply-To: <20190424170924.385228692@linuxfoundation.org>
From:   Christian Brauner <christian@brauner.io>
Date:   Wed, 24 Apr 2019 23:50:22 +0200
Message-ID: <CAHrFyr6w3c-hJTYPUP8uxcrg4d_2PzxRP4HAh_-zdcF5igfGWg@mail.gmail.com>
Subject: Re: [PATCH 4.4 014/168] sysctl: handle overflow for file-max
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 7:16 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> [ Upstream commit 32a5ad9c22852e6bd9e74bdec5934ef9d1480bc5 ]
>
> Currently, when writing
>
>   echo 18446744073709551616 > /proc/sys/fs/file-max
>
> /proc/sys/fs/file-max will overflow and be set to 0.  That quickly
> crashes the system.
>
> This commit sets the max and min value for file-max.  The max value is
> set to long int.  Any higher value cannot currently be used as the
> percpu counters are long ints and not unsigned integers.
>
> Note that the file-max value is ultimately parsed via
> __do_proc_doulongvec_minmax().  This function does not report error when
> min or max are exceeded.  Which means if a value largen that long int is
> written userspace will not receive an error instead the old value will be
> kept.  There is an argument to be made that this should be changed and
> __do_proc_doulongvec_minmax() should return an error when a dedicated min
> or max value are exceeded.  However this has the potential to break
> userspace so let's defer this to an RFC patch.
>
> Link: http://lkml.kernel.org/r/20190107222700.15954-3-christian@brauner.io
> Signed-off-by: Christian Brauner <christian@brauner.io>
> Acked-by: Kees Cook <keescook@chromium.org>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Joe Lawrence <joe.lawrence@redhat.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> [christian@brauner.io: v4]
>   Link: http://lkml.kernel.org/r/20190210203943.8227-3-christian@brauner.io
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Hey Greg,

Just an heads-up. This patch triggered a KASAN warning and Will has
sent a fix for that
which is already in master.
So if you backport this patch you likely also want to backport

9002b21465fa4d829edfc94a5a441005cffaa972

(See  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9002b21465fa4d829edfc94a5a441005cffaa972
)

Seems we missed a Cc: for stable in there. Sorry about that.
Thanks!
Christian

> ---
>  kernel/sysctl.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index beadcf83ceba..2f98b11477b8 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -126,6 +126,7 @@ static int __maybe_unused one = 1;
>  static int __maybe_unused two = 2;
>  static int __maybe_unused four = 4;
>  static unsigned long one_ul = 1;
> +static unsigned long long_max = LONG_MAX;
>  static int one_hundred = 100;
>  #ifdef CONFIG_PRINTK
>  static int ten_thousand = 10000;
> @@ -1603,6 +1604,8 @@ static struct ctl_table fs_table[] = {
>                 .maxlen         = sizeof(files_stat.max_files),
>                 .mode           = 0644,
>                 .proc_handler   = proc_doulongvec_minmax,
> +               .extra1         = &zero,
> +               .extra2         = &long_max,
>         },
>         {
>                 .procname       = "nr_open",
> --
> 2.19.1
>
>
>
