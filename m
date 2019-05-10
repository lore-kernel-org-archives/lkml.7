Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54006C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4E0217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="N9kTZopR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfEJH7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 03:59:23 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:45881 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbfEJH7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 03:59:23 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x4A7x9Dw010247
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 16:59:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x4A7x9Dw010247
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557475150;
        bh=+bD1W2W15drvCLRFZeUTvXsYCA2Xi5m+SSwd/mVTuT0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N9kTZopRmsb9NQlMokW1vT7Mz0rnD34Xtn/wJhGOocIAp4hHexgzuZhQlMx0B8kEv
         f/9wdvrcfjuU/HRgypBK0QHWyrk6CgxNZl3TkcNLLJOofUWybBp1iEborXTWZov43c
         +egxYt4SsJ0S+bPfUIPhfSV3K3JqeKodoMrb8N1zcAw1FR2tAlDntpfn328zzVV6yN
         7MofcP7QTOa4CZkkPOfV8pF1cO7hT8w7t72NHYyVInXL0bAWcX+d2ybbSG/woekN20
         KJolCumAkTmpf0AAIGQGpfki4plOG6CzSCNZBpOVCo3GufI5dw031bvn5I3nuAEUW6
         HyaOsypf9L26w==
X-Nifty-SrcIP: [209.85.160.178]
Received: by mail-qt1-f178.google.com with SMTP id y42so5574642qtk.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 00:59:09 -0700 (PDT)
X-Gm-Message-State: APjAAAXImR2qr8/mDcfcI8HXdZl91FbIgdOXUhPDM83fQUuJMBDv9O3d
        ycE6dnkXb0xzEqMDgb/I3oWVvIKrUoDDmWFWmoc=
X-Google-Smtp-Source: APXvYqxR/y9mdwfjln5IazpTwuayxFQpmKQ4y2FElg9yLLj7BoKzH1SffHp1m4IpRnDZmUOa0fzOSx2NcUPZOPzb2Wo=
X-Received: by 2002:ac8:1003:: with SMTP id z3mr8233628qti.261.1557475148599;
 Fri, 10 May 2019 00:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190507175912.GA11709@kroah.com> <CAHk-=wh=Uscp=yO1p===JjH3x9NS-ez+wrk64Z0pw7EGfWvVTA@mail.gmail.com>
 <20190510023659.GA219679@google.com>
In-Reply-To: <20190510023659.GA219679@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 10 May 2019 16:58:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNATXXH++opsHGYc0Q-J_D7TxzDD4Y0vrEEss++m8HTi5dg@mail.gmail.com>
Message-ID: <CAK7LNATXXH++opsHGYc0Q-J_D7TxzDD4Y0vrEEss++m8HTi5dg@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core patches for 5.2-rc1
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On Fri, May 10, 2019 at 11:38 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Thu, May 09, 2019 at 01:47:54PM -0700, Linus Torvalds wrote:
> > [ Ok, this may look irrelevant to people, but I actually notice this
> > because I do quick rebuilds *all* the time, so the 30s vs 41s
> > difference is actually something I reacted to and then tried to figure
> > out... ]
> >
> > On Tue, May 7, 2019 at 10:59 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > Joel Fernandes (Google) (2):
> > >       Provide in-kernel headers to make extending kernel easier
> >
> > Joel and Masahiro,
> >  this commit does annoying things. It's a small thing, but it ends up
> > grating on my kernel rebuild times, so I hope somebody can take a look
> > at it..
> >
> > Try building a kernel with no changes, and it shouldn't re-link.
> >
> > HOWEVER.
> >
> > If you re-make the config in between, the kernel/kheaders_data.tar.xz
> > is re-generated too. I think it checks timestamps despite having that
> > "CHK" phase that should verify just contents.
> >
> > I think the kernel/config_data.gz rules do the same thing, judging by
> > the output.
> >
> > I use "make allmodconfig" to re-generate the same kernel config, which
> > triggers this. The difference between "nothing changed" and "rerun
> > 'make allmodconfig' and nothing _still_ should have changed" is quite
> > stark:
> [snip]
> > No, this isn't the end of the world, but if somebody sees a simple
> > solution to avoid that extra ten seconds, I'd appreciate it.
>
> Hi Linus,
> The following patch should fix the issue. The patch depends on [1] though. So
> that will have to be pulled first (which I believe Greg is going to pull soon
> since it is in his pipeline, and Steven Rostedt already Acked it)
> [1] https://lore.kernel.org/patchwork/patch/1070199/
>
> For the below patch which fixes this issue, I have tested it and it fixes the
> allmodconfig issue. Could you try it out as well? As mentioned above, the
> patch at [1] should be applied first. Thanks a lot and let me know how it goes.
>
> (I am going to be on a long haul flight shortly so I may not be available for
> next 24-48 hours but will be there after, thanks).
> ---8<-----------------------
>
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: [PATCH] gen_kheaders: Do not regenerate archive if config is not
>  changed
>
> Linus reported that allmodconfig config was causing the kheaders archive
> to be regenerated even though the config is the same. This is due to the
> fact that the generated config header files are rewritten even if they
> were the same from a previous run.


I will fix the root cause in Kconfig anyway.


This patch is still useful in case
"one of Kconfig files is changed,
but the resulted configuration is still the same"

$ touch Kconfig
$ make -j8


But, you should simplify the code.


> To fix the issue, we ignore changes to these files and use md5sum on
> auto.conf to determine if the config really changed. And regenerate the
> header archive if it has.


Nope. This is really unnecessary.

When CONFIG_FOO_BAR is changed, include/config/foo/bar.h
should have already been touched by Kconfig,
so the change of the kernel configuration
is correctly detected.

If you want to know the this Kbuild magic,
read the comment block of scripts/basic/fixdep.c


Please remove config_md5 and correct the commit log.

Thanks.




> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/gen_kheaders.sh | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
> index 581b83534587..f621242037f4 100755
> --- a/kernel/gen_kheaders.sh
> +++ b/kernel/gen_kheaders.sh
> @@ -33,7 +33,7 @@ arch/$SRCARCH/include/
>  # Uncomment it for debugging.
>  # iter=1
>  # if [ ! -f /tmp/iter ]; then echo 1 > /tmp/iter;
> -# else;        iter=$(($(cat /tmp/iter) + 1)); fi
> +# else         iter=$(($(cat /tmp/iter) + 1)); fi
>  # find $src_file_list -type f | xargs ls -lR > /tmp/src-ls-$iter
>  # find $obj_file_list -type f | xargs ls -lR > /tmp/obj-ls-$iter
>
> @@ -43,16 +43,27 @@ arch/$SRCARCH/include/
>  pushd $kroot > /dev/null
>  src_files_md5="$(find $src_file_list -type f                       |
>                 grep -v "include/generated/compile.h"              |
> +               grep -v "include/generated/autoconf.h"             |
> +               grep -v "include/config/auto.conf"                 |
> +               grep -v "include/config/auto.conf.cmd"             |
> +               grep -v "include/config/tristate.conf"             |
>                 xargs ls -lR | md5sum | cut -d ' ' -f1)"
>  popd > /dev/null
>  obj_files_md5="$(find $obj_file_list -type f                       |
>                 grep -v "include/generated/compile.h"              |
> +               grep -v "include/generated/autoconf.h"             |
> +               grep -v "include/config/auto.conf"                 |
> +               grep -v "include/config/auto.conf.cmd"             |
> +               grep -v "include/config/tristate.conf"             |
>                 xargs ls -lR | md5sum | cut -d ' ' -f1)"
>
> +config_md5="$(md5sum include/config/auto.conf | cut -d ' ' -f1)"
> +
>  if [ -f $tarfile ]; then tarfile_md5="$(md5sum $tarfile | cut -d ' ' -f1)"; fi
>  if [ -f kernel/kheaders.md5 ] &&
>         [ "$(cat kernel/kheaders.md5|head -1)" == "$src_files_md5" ] &&
>         [ "$(cat kernel/kheaders.md5|head -2|tail -1)" == "$obj_files_md5" ] &&
> +       [ "$(cat kernel/kheaders.md5|head -3|tail -1)" == "$config_md5" ] &&
>         [ "$(cat kernel/kheaders.md5|tail -1)" == "$tarfile_md5" ]; then
>                 exit
>  fi
> @@ -82,8 +93,9 @@ find $cpio_dir -type f -print0 |
>
>  tar -Jcf $tarfile -C $cpio_dir/ . > /dev/null
>
> -echo "$src_files_md5" > kernel/kheaders.md5
> +echo "$src_files_md5" >  kernel/kheaders.md5
>  echo "$obj_files_md5" >> kernel/kheaders.md5
> +echo "$config_md5"    >> kernel/kheaders.md5
>  echo "$(md5sum $tarfile | cut -d ' ' -f1)" >> kernel/kheaders.md5
>
>  rm -rf $cpio_dir
> --
> 2.21.0.1020.gf2820cf01a-goog
>


--
Best Regards
Masahiro Yamada
