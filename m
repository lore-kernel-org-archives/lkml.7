Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF70C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF6F217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fFWIepym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfGXHKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 03:10:34 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35027 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfGXHKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 03:10:34 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so87430080ioo.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 00:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8YismThz5V4muUnYY1qClW5cinII46QirkdsyCteNKI=;
        b=fFWIepymAOxZ/7wsNjuQYgFw7/AFh4OeZs9PLI6q7actDNgju38LCDscCD+3xLy1ML
         hhaYzpx3Ov81IZbLeVAiNP9q6Eo7Zw+0MX2zcFfVE6WF+K4AsHQN9eDj/kb4mebdtPiS
         2OubBKh97eKYSeevJonbzZ657KizutJMzx1ktgHbQFGQ9/GOSVmyntIIwqUx0+lfN28G
         RovqyEUT/yFHTgEHHuCU1yc/SsgZfiGFcfeyFctev9LyjkDiIjuEzu2w0Vg8DH3ONND4
         4lWDyBhPG33PgQQcXfj1N4aYzMcloWMOkoNV/r2z03xIiGLEZQzkoKzoVcTZ/XbZzvje
         sl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8YismThz5V4muUnYY1qClW5cinII46QirkdsyCteNKI=;
        b=HOECnL3CzMTB/V3u/U3FvCRakR//gExTy1S7iF/x8lNHELjjJkLZT1MrLjjP1Dk/mA
         ikrq8Z8ouKuIKtTIKFhBBRxE+uHMQtzhvgsmcuM4/+rW348IQCj5kekpv4n1UQBV71Tu
         CvBgHwAnbMkoNQlC9S9mtPc5crWmQkX2VMRSU4WNdtlhq7BvNbuUKoFpPdV8I2AJRWpd
         sBc1sTcA/j9kGaQk83C0ejbVIGaRNZkG+7Fd1SHQuzIr/q58Z0/P3IWyL7wjCxnwNO0+
         NL3Te5tXI83PzILqoDzXAUvp63uUE1OJ4j8FNcG5xTBxfk5NCp+wdElyH79ybfmn50IP
         ZOaw==
X-Gm-Message-State: APjAAAWwxm/t/9VWQl6xYKvWDYs6P+ti58dECC/ySqY40D51vLyWlNna
        X6zRcMuSAs6p1gIpoUkhIipRP6+DNplzbhWVP19G5g==
X-Google-Smtp-Source: APXvYqxHdpFMRacX1s10/jFEl/RqUhU/RvbDgwRNkcYPJYPsoUjzZxCmFjC3DO2XATDtqVvUKMxTnJS1q0b6hTimPeo=
X-Received: by 2002:a5e:c241:: with SMTP id w1mr70546096iop.58.1563952233103;
 Wed, 24 Jul 2019 00:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190723072605.103456-1-drinkcat@chromium.org>
 <CACT4Y+bi5KkZ8igSeYVxjwtr8t0Vjz55gzWfAu_c8VMAqw0zPA@mail.gmail.com>
 <CANMq1KB8ECeRqNhSWyUf3amAkF7qvAmS3aU6rGNnZ=kUV3LC5Q@mail.gmail.com>
 <CACT4Y+YkjCpEdH0rvgp8b1hqAWfo66FY76qhn1xj_yNAER-XoQ@mail.gmail.com> <CAD=FV=Wse7tGi-RP5Rq1314AdLqMS3JNy6a-gFbmVZuroSWozw@mail.gmail.com>
In-Reply-To: <CAD=FV=Wse7tGi-RP5Rq1314AdLqMS3JNy6a-gFbmVZuroSWozw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 24 Jul 2019 09:10:20 +0200
Message-ID: <CACT4Y+a2REA5quUgOLr50LV7KGCvwBQMy77kk2aVPAPr4R+Y7w@mail.gmail.com>
Subject: Re: [PATCH] kmemleak: Increase maximum early log entries to 1000000
To:     Doug Anderson <dianders@chromium.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 12:17 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Jul 23, 2019 at 1:21 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Tue, Jul 23, 2019 at 10:13 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
> > >
> > > On Tue, Jul 23, 2019 at 3:46 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > >
> > > > On Tue, Jul 23, 2019 at 9:26 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
> > > > >
> > > > > When KASan is enabled, a lot of memory is allocated early on,
> > > > > and kmemleak complains (this is on a 4GB RAM system):
> > > > > kmemleak: Early log buffer exceeded (129846), please increase
> > > > >   DEBUG_KMEMLEAK_EARLY_LOG_SIZE
> > > > >
> > > > > Let's increase the upper limit to 1M entry. That would take up
> > > > > 160MB of RAM at init (each early_log entry is 160 bytes), but
> > > > > the memory would later be freed (early_log is __initdata).
> > > >
> > > > Interesting. Is it on an arm64 system?
> > >
> > > Yes arm64. And this is chromiumos-4.19 tree. I didn't try to track
> > > down where these allocations come from...
> >
> > So perhaps it's due to arm64, or you have even more configs, or maybe
> > running on real hardware. But I guess it's fine as is, just wondered
> > why such a radical difference. Thanks.
>
> If I had to guess I'd guess gcc vs. clang.  I think we've noticed a
> few places where clang+kasan produces much bloatier code than
> gcc+kasan.  Oh look, I just invented a new word: bloatier.  :-P
>
> ...could you try building with gcc and see if that explains the problems?

Just in case, there is no problem per se. There is just a difference :)
Whom have you asked? We use gcc with KEMEMLEAK atm. But compiler
should not affect number of kernel heap allocations.
