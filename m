Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C60C04AB1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 02:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6B4217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 02:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dmPGCWGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfEJChD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 22:37:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45318 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfEJChD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 22:37:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id s11so2331448pfm.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 19:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xa+bl84gw9smkws/TLg+dk8AvFIIZOITTUI3B97GnE4=;
        b=dmPGCWGZUUDwP2bfQEtACrGkI7XkjjkiI7uJg7cgNKZIv3oZU5o47sY/yez23le1Z6
         faKqpMk6OSXHqoNoi87xnzHHpNu7LawAIUZpwfdULSemfEJILbf7jVB2s3eZkbqqXOrb
         7TxZ36mwxymRt9STPtZdi/X/6wr00cdlTedNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xa+bl84gw9smkws/TLg+dk8AvFIIZOITTUI3B97GnE4=;
        b=lKzLIlWu+jMDEda50L6B0Iw1QIVKAHyIg3qTyVO3yAe82EIiThw3fdPbYTyI+olgBs
         vgS7dSk4wzdZ9Azq8Nco0uB+2+dKdMK/Z2Ip1zzOfsoW1s1VHx7/RoyrWqHj5Hk0tvx5
         I2Nw7YoOSTELIBCk2NvNqffWNLcKdu+0+8JIwWhZbaSoXV83iGndVtiHVp/5sb0AHOSq
         pUN4EB+mGqPYJx94Aca6yazd+vrJCGtAzbc0ZAEj4gTl5SebJhFvhxt/Xrz54fIemBWh
         fCuTmMUXgNzgy21E4lFrpPqHCH2IrlQavcAigNia8Fac+7eOX3tTRJU2G+Bzi8js4apW
         xfpg==
X-Gm-Message-State: APjAAAXw3bcHiO59euQ0jl1n++5irsFhE9os4RZf0eBHLeRZrB2LGtAa
        3d/UDs1/iYQTRnnoUXzzQXWMi6tcYFQ=
X-Google-Smtp-Source: APXvYqx8uq/kq4lRoD3MkkL3e2wtsNw7YcJ2yPsZVI9GyzRdwJm+qHddvYOX8gMkDPsZhC/9o/BU8Q==
X-Received: by 2002:a62:e303:: with SMTP id g3mr10341647pfh.220.1557455822024;
        Thu, 09 May 2019 19:37:02 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h189sm4995747pfc.125.2019.05.09.19.37.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 19:37:01 -0700 (PDT)
Date:   Thu, 9 May 2019 22:36:59 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel-team@android.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Driver core patches for 5.2-rc1
Message-ID: <20190510023659.GA219679@google.com>
References: <20190507175912.GA11709@kroah.com>
 <CAHk-=wh=Uscp=yO1p===JjH3x9NS-ez+wrk64Z0pw7EGfWvVTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh=Uscp=yO1p===JjH3x9NS-ez+wrk64Z0pw7EGfWvVTA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 01:47:54PM -0700, Linus Torvalds wrote:
> [ Ok, this may look irrelevant to people, but I actually notice this
> because I do quick rebuilds *all* the time, so the 30s vs 41s
> difference is actually something I reacted to and then tried to figure
> out... ]
> 
> On Tue, May 7, 2019 at 10:59 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Joel Fernandes (Google) (2):
> >       Provide in-kernel headers to make extending kernel easier
> 
> Joel and Masahiro,
>  this commit does annoying things. It's a small thing, but it ends up
> grating on my kernel rebuild times, so I hope somebody can take a look
> at it..
> 
> Try building a kernel with no changes, and it shouldn't re-link.
> 
> HOWEVER.
> 
> If you re-make the config in between, the kernel/kheaders_data.tar.xz
> is re-generated too. I think it checks timestamps despite having that
> "CHK" phase that should verify just contents.
> 
> I think the kernel/config_data.gz rules do the same thing, judging by
> the output.
> 
> I use "make allmodconfig" to re-generate the same kernel config, which
> triggers this. The difference between "nothing changed" and "rerun
> 'make allmodconfig' and nothing _still_ should have changed" is quite
> stark:
[snip]
> No, this isn't the end of the world, but if somebody sees a simple
> solution to avoid that extra ten seconds, I'd appreciate it.

Hi Linus,
The following patch should fix the issue. The patch depends on [1] though. So
that will have to be pulled first (which I believe Greg is going to pull soon
since it is in his pipeline, and Steven Rostedt already Acked it)
[1] https://lore.kernel.org/patchwork/patch/1070199/

For the below patch which fixes this issue, I have tested it and it fixes the
allmodconfig issue. Could you try it out as well? As mentioned above, the
patch at [1] should be applied first. Thanks a lot and let me know how it goes.

(I am going to be on a long haul flight shortly so I may not be available for
next 24-48 hours but will be there after, thanks).
---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH] gen_kheaders: Do not regenerate archive if config is not
 changed

Linus reported that allmodconfig config was causing the kheaders archive
to be regenerated even though the config is the same. This is due to the
fact that the generated config header files are rewritten even if they
were the same from a previous run.

To fix the issue, we ignore changes to these files and use md5sum on
auto.conf to determine if the config really changed. And regenerate the
header archive if it has.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/gen_kheaders.sh | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index 581b83534587..f621242037f4 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -33,7 +33,7 @@ arch/$SRCARCH/include/
 # Uncomment it for debugging.
 # iter=1
 # if [ ! -f /tmp/iter ]; then echo 1 > /tmp/iter;
-# else; 	iter=$(($(cat /tmp/iter) + 1)); fi
+# else 	iter=$(($(cat /tmp/iter) + 1)); fi
 # find $src_file_list -type f | xargs ls -lR > /tmp/src-ls-$iter
 # find $obj_file_list -type f | xargs ls -lR > /tmp/obj-ls-$iter
 
@@ -43,16 +43,27 @@ arch/$SRCARCH/include/
 pushd $kroot > /dev/null
 src_files_md5="$(find $src_file_list -type f                       |
 		grep -v "include/generated/compile.h"		   |
+		grep -v "include/generated/autoconf.h"		   |
+		grep -v "include/config/auto.conf"		   |
+		grep -v "include/config/auto.conf.cmd"		   |
+		grep -v "include/config/tristate.conf"		   |
 		xargs ls -lR | md5sum | cut -d ' ' -f1)"
 popd > /dev/null
 obj_files_md5="$(find $obj_file_list -type f                       |
 		grep -v "include/generated/compile.h"		   |
+		grep -v "include/generated/autoconf.h"		   |
+		grep -v "include/config/auto.conf"                 |
+		grep -v "include/config/auto.conf.cmd"		   |
+		grep -v "include/config/tristate.conf"		   |
 		xargs ls -lR | md5sum | cut -d ' ' -f1)"
 
+config_md5="$(md5sum include/config/auto.conf | cut -d ' ' -f1)"
+
 if [ -f $tarfile ]; then tarfile_md5="$(md5sum $tarfile | cut -d ' ' -f1)"; fi
 if [ -f kernel/kheaders.md5 ] &&
 	[ "$(cat kernel/kheaders.md5|head -1)" == "$src_files_md5" ] &&
 	[ "$(cat kernel/kheaders.md5|head -2|tail -1)" == "$obj_files_md5" ] &&
+	[ "$(cat kernel/kheaders.md5|head -3|tail -1)" == "$config_md5" ] &&
 	[ "$(cat kernel/kheaders.md5|tail -1)" == "$tarfile_md5" ]; then
 		exit
 fi
@@ -82,8 +93,9 @@ find $cpio_dir -type f -print0 |
 
 tar -Jcf $tarfile -C $cpio_dir/ . > /dev/null
 
-echo "$src_files_md5" > kernel/kheaders.md5
+echo "$src_files_md5" >  kernel/kheaders.md5
 echo "$obj_files_md5" >> kernel/kheaders.md5
+echo "$config_md5"    >> kernel/kheaders.md5
 echo "$(md5sum $tarfile | cut -d ' ' -f1)" >> kernel/kheaders.md5
 
 rm -rf $cpio_dir
-- 
2.21.0.1020.gf2820cf01a-goog

