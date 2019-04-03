Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5FBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0ED20700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ATCjHw1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfDCRlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:41:53 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40203 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDCRlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:41:53 -0400
Received: by mail-vs1-f67.google.com with SMTP id f22so10491195vso.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 10:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y8CF+OJt6vJCiWGA55M98hTDR4Pj8zfzvZjsAL1jpAc=;
        b=ATCjHw1D5zHPEozfJWOwPuFkb9O/ZQmNa6bhJ2+wDZ5gz+RXJO6ja50fnf219kx/a8
         rpBCYS6KQ54sc8ID7DfKkG6vgnkn4Hq6I35/d8Tz8iWcb4obCyvscbRuh6knWwmR78Mu
         4fQlQczOZ18Jk/XHnWFumC3CG9KxIEbda3bWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y8CF+OJt6vJCiWGA55M98hTDR4Pj8zfzvZjsAL1jpAc=;
        b=bTecBF9joQYckuZN/QTsIEui9Ufrb0qnJ4LTlaN36L6dz81hdwAfpfJ8gGx4b0p+CE
         dIMjtN9cnJOTHyFz3ijNX3vFP4jXtkpqz//ht11ChzufB0jcY3hLjJtruR/rFZkIytyt
         LqcEd9am7a+Xa1qJbIWSrDf7qIgarQN1p6xFwl02wNigmOByc0qJduckG6L5+VxShtvy
         8RKmLqT1oY7bjOfyPPfCStYkq66LeN2cw9S2uFY83IowgeX/ap5sZ7dJJiIxoYvJJiXD
         TNaE6ZbRdr8MMsF9BODPGz5FpQt8L3WT/nDX3KHX6h52V8OzKsqhVFcDn4LjnIbMF31U
         RLNg==
X-Gm-Message-State: APjAAAW45goLxlRk+gqshYCz8g2kRyBHH33W1MP/WHe3CX2Q9uUwfVE9
        DSQFKF+4Q5xVQu4zvwoXHBdPXlUHx60=
X-Google-Smtp-Source: APXvYqx4ZyBxix0/UmVVSf9ZEfChBWhYuvmPpf9OPC9qkXiJdUmlYZj87lP+Flc/n9T5mpQoh3anUA==
X-Received: by 2002:a67:8546:: with SMTP id h67mr1116199vsd.11.1554313311283;
        Wed, 03 Apr 2019 10:41:51 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id l193sm12519957vka.19.2019.04.03.10.41.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 10:41:50 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id d8so9466347vsp.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 10:41:50 -0700 (PDT)
X-Received: by 2002:a67:7816:: with SMTP id t22mr1099376vsc.115.1554313309569;
 Wed, 03 Apr 2019 10:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190328130306.25384-1-mcroce@redhat.com>
In-Reply-To: <20190328130306.25384-1-mcroce@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 3 Apr 2019 10:41:38 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLnu3-Gxb-4Gv8vtA9B3o582tX0GiOfug_wRZ78RDaW=g@mail.gmail.com>
Message-ID: <CAGXu5jLnu3-Gxb-4Gv8vtA9B3o582tX0GiOfug_wRZ78RDaW=g@mail.gmail.com>
Subject: Re: [PATCH] kernel/sysctl.c: fix out of bounds access in fs.file-max
To:     Matteo Croce <mcroce@redhat.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 6:03 AM Matteo Croce <mcroce@redhat.com> wrote:
>
> fs.file-max sysctl uses proc_doulongvec_minmax() as proc handler, which
> accesses *extra1 and *extra2 as unsigned long, but commit 32a5ad9c2285
> ("sysctl: handle overflow for file-max") assigns &zero, which is an int,
> to extra1, generating the following KASAN report.
> Fix this by changing 'zero' to long, which does not need to be duplicated
> like 'one' and 'one_ul' for two data types.
>
> ==================================================================
> BUG: KASAN: global-out-of-bounds in __do_proc_doulongvec_minmax+0x2f9/0x600
> Read of size 8 at addr ffffffff8233dc20 by task systemd/1
>
> CPU: 0 PID: 1 Comm: systemd Not tainted 5.1.0-rc2-kvm+ #22
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS ?-20180724_192412-buildhw-07.phx2.fedoraproject.org-1.fc29 04/01/2014
> Call Trace:
>  print_address_description+0x67/0x23d
>  kasan_report.cold.3+0x1c/0x36
>  __do_proc_doulongvec_minmax+0x2f9/0x600
>  proc_doulongvec_minmax+0x3a/0x50
>  proc_sys_call_handler+0x11d/0x170
>  vfs_write+0xd7/0x200
>  ksys_write+0x93/0x110
>  do_syscall_64+0x57/0x140
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f67d33e8804
> Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 48 8d 05 f9 5e 0d 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 49 89 d4 55 48 89 f5 53
> RSP: 002b:00007fffd9992ed8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f67d33e8804
> RDX: 0000000000000015 RSI: 00005586ce2607b0 RDI: 0000000000000004
> RBP: 00007fffd9992f30 R08: 000000000000c0c0 R09: ffffffffffff0000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
> R13: 0000000000000015 R14: 00005586ce2607c4 R15: 00007fffd9992f70
>
> The buggy address belongs to the variable:
>  0xffffffff8233dc20
>
> Memory state around the buggy address:
>  ffffffff8233db00: 00 00 00 00 00 00 00 00 fa fa fa fa 04 fa fa fa
>  ffffffff8233db80: fa fa fa fa 04 fa fa fa fa fa fa fa 04 fa fa fa
> >ffffffff8233dc00: fa fa fa fa 04 fa fa fa fa fa fa fa 00 00 00 00
>                                ^
>  ffffffff8233dc80: fa fa fa fa fa fa fa fa 00 00 00 00 00 00 00 00
>  ffffffff8233dd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================
>
> Fixes: 32a5ad9c2285 ("sysctl: handle overflow for file-max")
> Signed-off-by: Matteo Croce <mcroce@redhat.com>
> ---
>  kernel/sysctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index e5da394d1ca3..3e959d67d619 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -124,7 +124,7 @@ static int sixty = 60;
>
>  static int __maybe_unused neg_one = -1;
>
> -static int zero;
> +static long zero;
>  static int __maybe_unused one = 1;
>  static int __maybe_unused two = 2;
>  static int __maybe_unused four = 4;

This seems okay to me; thanks for the fix! (I think it's fine to keep
this merged instead of a distinct long_zero, as long as we're not
seeing type warnings during the build.)

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
