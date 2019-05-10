Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAC7C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B59217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DxEJkpaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfEJTE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 15:04:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40155 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbfEJTE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 15:04:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id u17so3700436pfn.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 12:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yhyji4q7jVHUJp3jCGtjdjzSNJfPTB5wSHOst6Gztjc=;
        b=DxEJkpaJfIDI1HMaQE1XKtofdxopzmdpXqzGnkIoCDyfEHOpv7U9gWv7ogPQibJ1Bc
         DB6kQE4Yv7mRQE3NDvKesy3ZLrK9jgpbbQZQKtIngoke6hv+w9CfsxRj/Cbm4taVS7Oj
         DcSQ4XJiKBYeKvPuxhbFjrPB11Mb3w6o/Owrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yhyji4q7jVHUJp3jCGtjdjzSNJfPTB5wSHOst6Gztjc=;
        b=hi1AjGMxD+PW2Vw8OzoWsa6pCPoRozv419Tcjv8puzICnnV0Ah9VxoY0bAk6MhK3IG
         YkS9KCnFCDPpBt/ZIxQEDnzkhZcZgiR+j+GS7yg1ZEHGlqegU7k3WNb+LSH3+YstNHw8
         MuuRY27UqHoCaP+HTq3cQBZJRyjXJRanxbqRU7Ds6uNa60ceatfc484L7R+D1shZmJbg
         Jm1AQJRXSLhTvViiCCSJRXLu+6XalCQBdNt4/nhZftwz+HMScU+H51wUSNn9NO4BbfSb
         gSo8MTdONvpNbAwEypoqoygoA8csXGz3rCdHwD4dWJDhyJ623aga2Dbe+UwgkYATMB8y
         q30A==
X-Gm-Message-State: APjAAAVRFYggiqMUfhXcWUg5Umb3svD4je/3jKlC8JYxoLTZo34shtm7
        LfCZrirETmW9rnOPY+Dj7rsC8A==
X-Google-Smtp-Source: APXvYqy7gBWWnSrphKrwXg2qSiSNwetLaFrC8QXo75ei7xl0yUMfIEl6yNJIaMkd1A/ZLh1k3mLD1A==
X-Received: by 2002:a63:ee10:: with SMTP id e16mr9745579pgi.207.1557515065398;
        Fri, 10 May 2019 12:04:25 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y4sm6479947pgj.34.2019.05.10.12.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 12:04:23 -0700 (PDT)
Date:   Fri, 10 May 2019 15:04:22 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Driver core patches for 5.2-rc1
Message-ID: <20190510190422.GB219679@google.com>
References: <20190507175912.GA11709@kroah.com>
 <CAHk-=wh=Uscp=yO1p===JjH3x9NS-ez+wrk64Z0pw7EGfWvVTA@mail.gmail.com>
 <20190510023659.GA219679@google.com>
 <CAK7LNATXXH++opsHGYc0Q-J_D7TxzDD4Y0vrEEss++m8HTi5dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATXXH++opsHGYc0Q-J_D7TxzDD4Y0vrEEss++m8HTi5dg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 04:58:32PM +0900, Masahiro Yamada wrote:
> Hi Joel,
> 
> On Fri, May 10, 2019 at 11:38 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Thu, May 09, 2019 at 01:47:54PM -0700, Linus Torvalds wrote:
> > > [ Ok, this may look irrelevant to people, but I actually notice this
> > > because I do quick rebuilds *all* the time, so the 30s vs 41s
> > > difference is actually something I reacted to and then tried to figure
> > > out... ]
> > >
> > > On Tue, May 7, 2019 at 10:59 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > Joel Fernandes (Google) (2):
> > > >       Provide in-kernel headers to make extending kernel easier
> > >
> > > Joel and Masahiro,
> > >  this commit does annoying things. It's a small thing, but it ends up
> > > grating on my kernel rebuild times, so I hope somebody can take a look
> > > at it..
> > >
> > > Try building a kernel with no changes, and it shouldn't re-link.
> > >
> > > HOWEVER.
> > >
> > > If you re-make the config in between, the kernel/kheaders_data.tar.xz
> > > is re-generated too. I think it checks timestamps despite having that
> > > "CHK" phase that should verify just contents.
> > >
> > > I think the kernel/config_data.gz rules do the same thing, judging by
> > > the output.
> > >
> > > I use "make allmodconfig" to re-generate the same kernel config, which
> > > triggers this. The difference between "nothing changed" and "rerun
> > > 'make allmodconfig' and nothing _still_ should have changed" is quite
> > > stark:
> > [snip]
> > > No, this isn't the end of the world, but if somebody sees a simple
> > > solution to avoid that extra ten seconds, I'd appreciate it.
> >
> > Hi Linus,
> > The following patch should fix the issue. The patch depends on [1] though. So
> > that will have to be pulled first (which I believe Greg is going to pull soon
> > since it is in his pipeline, and Steven Rostedt already Acked it)
> > [1] https://lore.kernel.org/patchwork/patch/1070199/
> >
> > For the below patch which fixes this issue, I have tested it and it fixes the
> > allmodconfig issue. Could you try it out as well? As mentioned above, the
> > patch at [1] should be applied first. Thanks a lot and let me know how it goes.
> >
> > (I am going to be on a long haul flight shortly so I may not be available for
> > next 24-48 hours but will be there after, thanks).
> > ---8<-----------------------
> >
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > Subject: [PATCH] gen_kheaders: Do not regenerate archive if config is not
> >  changed
> >
> > Linus reported that allmodconfig config was causing the kheaders archive
> > to be regenerated even though the config is the same. This is due to the
> > fact that the generated config header files are rewritten even if they
> > were the same from a previous run.
> 
> 
> I will fix the root cause in Kconfig anyway.
> 
> 
> This patch is still useful in case
> "one of Kconfig files is changed,
> but the resulted configuration is still the same"
> 
> $ touch Kconfig
> $ make -j8
> 
> 
> But, you should simplify the code.
> 
> 
> > To fix the issue, we ignore changes to these files and use md5sum on
> > auto.conf to determine if the config really changed. And regenerate the
> > header archive if it has.
> 
> 
> Nope. This is really unnecessary.
> 
> When CONFIG_FOO_BAR is changed, include/config/foo/bar.h
> should have already been touched by Kconfig,
> so the change of the kernel configuration
> is correctly detected.
> 
> If you want to know the this Kbuild magic,
> read the comment block of scripts/basic/fixdep.c
> 
> 
> Please remove config_md5 and correct the commit log.

Agreed! Will remove the md5 check and keep the rest of the patch the same
(except the commit log).

thanks!

 - Joel


> 
> Thanks.
> 
> 
> 
> 
> > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/gen_kheaders.sh | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
> > index 581b83534587..f621242037f4 100755
> > --- a/kernel/gen_kheaders.sh
> > +++ b/kernel/gen_kheaders.sh
> > @@ -33,7 +33,7 @@ arch/$SRCARCH/include/
> >  # Uncomment it for debugging.
> >  # iter=1
> >  # if [ ! -f /tmp/iter ]; then echo 1 > /tmp/iter;
> > -# else;        iter=$(($(cat /tmp/iter) + 1)); fi
> > +# else         iter=$(($(cat /tmp/iter) + 1)); fi
> >  # find $src_file_list -type f | xargs ls -lR > /tmp/src-ls-$iter
> >  # find $obj_file_list -type f | xargs ls -lR > /tmp/obj-ls-$iter
> >
> > @@ -43,16 +43,27 @@ arch/$SRCARCH/include/
> >  pushd $kroot > /dev/null
> >  src_files_md5="$(find $src_file_list -type f                       |
> >                 grep -v "include/generated/compile.h"              |
> > +               grep -v "include/generated/autoconf.h"             |
> > +               grep -v "include/config/auto.conf"                 |
> > +               grep -v "include/config/auto.conf.cmd"             |
> > +               grep -v "include/config/tristate.conf"             |
> >                 xargs ls -lR | md5sum | cut -d ' ' -f1)"
> >  popd > /dev/null
> >  obj_files_md5="$(find $obj_file_list -type f                       |
> >                 grep -v "include/generated/compile.h"              |
> > +               grep -v "include/generated/autoconf.h"             |
> > +               grep -v "include/config/auto.conf"                 |
> > +               grep -v "include/config/auto.conf.cmd"             |
> > +               grep -v "include/config/tristate.conf"             |
> >                 xargs ls -lR | md5sum | cut -d ' ' -f1)"
> >
> > +config_md5="$(md5sum include/config/auto.conf | cut -d ' ' -f1)"
> > +
> >  if [ -f $tarfile ]; then tarfile_md5="$(md5sum $tarfile | cut -d ' ' -f1)"; fi
> >  if [ -f kernel/kheaders.md5 ] &&
> >         [ "$(cat kernel/kheaders.md5|head -1)" == "$src_files_md5" ] &&
> >         [ "$(cat kernel/kheaders.md5|head -2|tail -1)" == "$obj_files_md5" ] &&
> > +       [ "$(cat kernel/kheaders.md5|head -3|tail -1)" == "$config_md5" ] &&
> >         [ "$(cat kernel/kheaders.md5|tail -1)" == "$tarfile_md5" ]; then
> >                 exit
> >  fi
> > @@ -82,8 +93,9 @@ find $cpio_dir -type f -print0 |
> >
> >  tar -Jcf $tarfile -C $cpio_dir/ . > /dev/null
> >
> > -echo "$src_files_md5" > kernel/kheaders.md5
> > +echo "$src_files_md5" >  kernel/kheaders.md5
> >  echo "$obj_files_md5" >> kernel/kheaders.md5
> > +echo "$config_md5"    >> kernel/kheaders.md5
> >  echo "$(md5sum $tarfile | cut -d ' ' -f1)" >> kernel/kheaders.md5
> >
> >  rm -rf $cpio_dir
> > --
> > 2.21.0.1020.gf2820cf01a-goog
> >
> 
> 
> --
> Best Regards
> Masahiro Yamada
