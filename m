Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C377C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460682146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfLQThH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:37:07 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:40697 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfLQThG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:37:06 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MK3BO-1iPCk31Wr0-00LRpU for <linux-kernel@vger.kernel.org>; Tue, 17 Dec
 2019 20:37:05 +0100
Received: by mail-qk1-f172.google.com with SMTP id 21so6535432qky.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 11:37:05 -0800 (PST)
X-Gm-Message-State: APjAAAWPIa6Dv5UqSyon5UD6HjgEpWZxRvcLWfOaA15mXYjH7dtO4gzh
        y4GA8LMUBwUJX9b4FjG6nVuhrNguLPkPH/tmo6c=
X-Google-Smtp-Source: APXvYqw3+s7qQFhMroHKJHTpeeeEQA+c8IYEivQguj0Uwpw8ohqZYzlz6cX2TpJ8GKdmMRgkE8Tdeq4RIFKKZ0HWTrM=
X-Received: by 2002:a37:84a:: with SMTP id 71mr6731872qki.138.1576611424271;
 Tue, 17 Dec 2019 11:37:04 -0800 (PST)
MIME-Version: 1.0
References: <20191217172455.186395-1-Jason@zx2c4.com>
In-Reply-To: <20191217172455.186395-1-Jason@zx2c4.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 17 Dec 2019 20:36:48 +0100
X-Gmail-Original-Message-ID: <CAK8P3a00O6_XjUd33_4esaEXu4fEf4+3fvrttXMzx=-1ruFaAQ@mail.gmail.com>
Message-ID: <CAK8P3a00O6_XjUd33_4esaEXu4fEf4+3fvrttXMzx=-1ruFaAQ@mail.gmail.com>
Subject: Re: [PATCH] random: don't forget compat_ioctl on unrandom
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:z2nFtk5MYl031enViuErDcm83x+3F3aklgD455tvmyajHdbJO0S
 LkCvfM1yyFlMY4xs8N7fxcc1ElC+E6mW81umRGVQub3Sd9K5iCFKzqVNxyUl0jyO4J5jn2y
 Ffi0XjytXVQ+KXpYsMfzQDCAIC8rvmsrU7/H5sVbrB6OXXlXz1QCEueoTKLTNqgKW2t/qZo
 5nuEaTuqSGQmkz8DjE61w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XPrvu9UMPuA=:+t9u7yMeTfOmfAQIuD+ZNZ
 WqOsUTzDJc3iqlWX54pd6oMo+pvXaPOtiMJpe0Bd2rwChi1/6tTBtBnHB12VQxYrTBGSmXmPM
 m9zj6aSlFqOxDerimuzEmtOLTAyd78TDwuVJfJ/GrqIUzNOYOxMB/j9AHJ7HqYOrmZviByrxm
 hzxCtEXqseGe+tZjX52wolAxm3pPAhynPHjmQV7Y8wpZmWMnJi1wIRbcUumE79YXhAKCJbMuM
 E5ldR8dsMPa8kLRwUezFFPyfdxvZe0yjwkukGcCp23jqCo6t+Nkhau8gabUpn/wdCBdXB0w/Q
 wFkC269K9Fv2Z6GM1J5HutlpYYB9T7cdu5I27DHfYwv/qwUSzLaLn3vNcfEPTLOqGxYXxDa9E
 GUjd0O6A/Hc1UPKypXOFOJRFFrpATUkzB6jw9xVr/BhAthTHXaUMPndZqn4BbLMke+ueFPZVQ
 cRmrlrZYKRM7KlF5jSpUWTtMjYRlLR2Ga7DI1T6Z+xb+iUXPGKq4/hX2q8evLvzCc6/N8FXsA
 MYy+uMtWnAPFnXsbkzxDZcr57S9tVqU0KKxMugb1vWoqgPFhge3swhQUg4oe/U1EZtmqRMSbv
 9lK05pov2BFqb/78fGNj8430b+hz97Pm1g3yQSWrouFhnekErrsJe4E0VcRpA8agTlhJsTw6B
 J6+/MWFGRDCnu9Hxa0KYkQWHrIpwSjk2iEXewuxRjXE3Sw5rH1IuDCuZ8bvN1S3DsY9405R1S
 9GOLYWraV7kt2Xr/rm4LISr5RBJvpoVnxtB4TCmBoBzJ6Uuk931f3hyZ5kD8B5t8ajghmESlg
 LgWhsg6Hr+bdIb4rxt+MwJCF1TdyhVQSncg7lqFCFPtYEUXzWOoGRMUwQxnl2rbtubtAALsBx
 dlLJF4w3tZEftZqdRtGw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 6:25 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Recently, there's been some compat ioctl cleanup, in which large
> hardcoded lists were replaced with compat_ptr_ioctl. One of these
> changes involved removing the random.c hardcoded list entries and adding
> a compat ioctl function pointer to the random.c fops. In the process,
> urandom was forgotten about, so this commit fixes that oversight.
>
> Fixes: 507e4e2b430b ("compat_ioctl: remove /dev/random commands")
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Thanks for debugging this. I had already sent the same
patch a few days ago after the first report:

https://lore.kernel.org/lkml/20191207185837.4030699-1-arnd@arndb.de/

Greg, can you please apply one of these and send it to Linus for 5.5-rc3?

     Arnd

> ---
>  drivers/char/random.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 909e0c3d82ea..cda12933a17d 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -2175,6 +2175,7 @@ const struct file_operations urandom_fops = {
>         .read  = urandom_read,
>         .write = random_write,
>         .unlocked_ioctl = random_ioctl,
> +       .compat_ioctl = compat_ptr_ioctl,
>         .fasync = random_fasync,
>         .llseek = noop_llseek,
>  };
> --
> 2.24.1
>
