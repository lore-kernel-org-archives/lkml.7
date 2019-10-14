Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A0DC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 23:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501E72133F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 23:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IB2aUdkb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfJNXvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 19:51:38 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44586 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfJNXvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 19:51:38 -0400
Received: by mail-io1-f68.google.com with SMTP id w12so41693940iol.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 16:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k4LG9A60e0AWB6+HxDiNUTXT9+nVfxCFWPyoyVSEVA0=;
        b=IB2aUdkbO4uaayL9lm/pGvtaPMct+pJEOEo+QZUCZ2M5Ui9SlTD0C+j3+Zmd6dHTN4
         qgVmLoHycRpD0utCSuz/9a3EpAUk6f+3ot7NYRegMNOA6YcNltTEJh/Mc0RacU4MOobj
         OtKE1oH/ITR4/GVnSEpkxGKLK0JFYaNpdbAHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k4LG9A60e0AWB6+HxDiNUTXT9+nVfxCFWPyoyVSEVA0=;
        b=P+VGiiskH+S51yegbK3sVecHEF51Wr00V5l0BxGdi8bDXvh7dw8xpHa+omGQpTxB1P
         DS5q1nlVxbP+Sjd9ctCX0mGLQEWK4r0mq+QgdCbUt0WuCz1Yw2yM4UiPwxerVmby65na
         JtGCqQNFMNDoUicnR8fobEi2tntpVRS3kCj/7Q5uXJHaEniiLN8qgNwUwtfX/EVkuUhG
         NWct1xlgh0BxXaz07Ph2xLTw88J1Ct5pCH8YJvy7GCvfqMTf/rRXLaxqtYxlqmi1wNFt
         WdYnc26qnl7tugVcwt0T9BMz2sK01h4m0tF6/E660GMczqN08HM7uyy7MlOcMEAl+8Er
         S3sw==
X-Gm-Message-State: APjAAAUyb9CpoAlNvAvI2XKKzDtjva4Ps/FrNgYJ2nfMnG3Vzy2UsbaF
        g20T0MsWU7vh4cWbAHlHyENgKhL9uy0=
X-Google-Smtp-Source: APXvYqzCj7iX5FatI6iAuFbHZ7g3MfGJGfydgLtMnDZKzw/zHrCFWYtOK0aDp4qpaNr7EUq4SUJauw==
X-Received: by 2002:a92:1011:: with SMTP id y17mr3229081ill.234.1571097097017;
        Mon, 14 Oct 2019 16:51:37 -0700 (PDT)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id h4sm13812471iom.17.2019.10.14.16.51.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 16:51:36 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id v2so41742419iob.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 16:51:36 -0700 (PDT)
X-Received: by 2002:a92:819c:: with SMTP id q28mr3325441ilk.269.1571097095829;
 Mon, 14 Oct 2019 16:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <201910110030.gUpQOCmR%lkp@intel.com> <20191014162847.kshvdwcahyjbtweo@holly.lan>
In-Reply-To: <20191014162847.kshvdwcahyjbtweo@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 14 Oct 2019 16:51:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WL_2zDoqdB96NK5tLwmqsL4Zt+wUbhKrGq7dz+sUAdYw@mail.gmail.com>
Message-ID: <CAD=FV=WL_2zDoqdB96NK5tLwmqsL4Zt+wUbhKrGq7dz+sUAdYw@mail.gmail.com>
Subject: Re: [danielt-linux:kgdb/for-next 4/4] kernel/debug/debug_core.c:452:17:
 warning: array subscript is outside array bounds
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 14, 2019 at 9:28 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Hi Doug
>
> On Fri, Oct 11, 2019 at 12:41:31AM +0800, kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git kgdb/for-next
> > head:   2277b492582d5525244519f60da6f9daea5ef41a
> > commit: 2277b492582d5525244519f60da6f9daea5ef41a [4/4] kdb: Fix stack crawling on 'running' CPUs that aren't the master
> > config: sh-allyesconfig (attached as .config)
> > compiler: sh4-linux-gcc (GCC) 7.4.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout 2277b492582d5525244519f60da6f9daea5ef41a
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.4.0 make.cross ARCH=sh
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> > Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
> >
> > All warnings (new ones prefixed by >>):
> >
> >    kernel/debug/debug_core.c: In function 'kdb_dump_stack_on_cpu':
> > >> kernel/debug/debug_core.c:452:17: warning: array subscript is outside array bounds [-Warray-bounds]
> >      if (!(kgdb_info[cpu].exception_state & DCPU_IS_SLAVE)) {
> >            ~~~~~~~~~^~~~~
> >    kernel/debug/debug_core.c:469:33: warning: array subscript is outside array bounds [-Warray-bounds]
> >      kgdb_info[cpu].exception_state |= DCPU_WANT_BT;
> >    kernel/debug/debug_core.c:470:18: warning: array subscript is outside array bounds [-Warray-bounds]
> >      while (kgdb_info[cpu].exception_state & DCPU_WANT_BT)
> >             ~~~~~~~~~^~~~~
>
> Thoughts on the following?
>
> From 9e0114bc9ae504c3a7e837c977d64f84b2010d8e Mon Sep 17 00:00:00 2001
> From: Daniel Thompson <daniel.thompson@linaro.org>
> Date: Fri, 11 Oct 2019 08:49:29 +0100
> Subject: [PATCH] kdb: Avoid array subscript warnings on non-SMP builds
>
> Recent versions of gcc (reported on gcc-7.4) issue array subscript
> warnings for builds where SMP is not enabled.
>
> There is no bug here but there is scope to improve the code
> generation for non-SMP systems (whilst also silencing the warning).
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: 2277b492582d ("kdb: Fix stack crawling on 'running' CPUs that aren't the master")
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/debug_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 70e86b4b4932..eccb7298a0b5 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -449,7 +449,8 @@ void kdb_dump_stack_on_cpu(int cpu)
>                 return;
>         }
>
> -       if (!(kgdb_info[cpu].exception_state & DCPU_IS_SLAVE)) {
> +       if (!IS_ENABLED(CONFIG_SMP) ||
> +           !(kgdb_info[cpu].exception_state & DCPU_IS_SLAVE)) {

Thanks for sending this!  I saw the alert but I was on vacation last
Friday and today has been a trainwreck.

I guess my first thought is that this fix is slightly confusing to
read.  Reading it makes you think that if we don't have SMP that we'll
print:

  ERROR: Task on cpu %d didn't stop in the debugger

It took me a second to realize that of course this would never print
because if we're ot on SMP then the first "if" test would trip and
we'd return.  Which makes me wonder why we couldn't instead change
that "if" test to:

 if (!IS_ENABLED(CONFIG_SMP) || cpu == raw_smp_processor_id()) {

...and be done with it.

---

As far as the "there is no bug here", I actually wonder.  We are
always called with a cpu that we got from "kdb_process_cpu(p)", right?
 That function sets cpu to 0 if "cpu > num_possible_cpus()".  ...but
shouldn't it be >=?  I guess task_cpu() probably returned something
sane anyway...

I also find it a little odd that kdb_process_cpu() returns a signed
int even though task_cpu() returns an unsigned one, but I guess we
don't need to worry about the case where the number of CPUs can't fit
into a signed int?

---

Hopefully that's all correct.  I'm just about outta time and I wanted
to send something off.  If something looks wrong it probably is...

-Doug
