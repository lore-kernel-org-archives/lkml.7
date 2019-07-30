Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07304C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8125206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jdYJmR8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbfG3QX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:23:59 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36610 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfG3QX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:23:59 -0400
Received: by mail-io1-f66.google.com with SMTP id o9so25890287iom.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 09:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0TLRZIQCR9Pw2vbyso675k3pFlhhJXqTc19qTvv4hf0=;
        b=jdYJmR8m0xX0zlcc3PoPTUK+s2NqbszXxm3DLd39YC9QiPycf8ZUeNGjIQcOp2loa1
         jR39WTMryx8VEMCZawpYXd9he7GV+NEWkclF4zpRnRGE2dtTJjdn/2QBDeTqYIcKwiCS
         ycuL8cUw+W/VuU2IAXi0gtFiZmx44cUc2mn8tX6n4OV40PGfKAiyuuvEGpAp+eZYdnyq
         igkHYUUwODjs/aMwvomePV++HILV1vuGCtcxQ68//cev0yjbTjQIalzAgFmch/yhLldc
         kruq7vpHEIxgQdWBjsHCmZDa+egneG05AEo1+QHlOJ9y/rUaKgDhrA/34D3k5QdxJp1e
         XC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0TLRZIQCR9Pw2vbyso675k3pFlhhJXqTc19qTvv4hf0=;
        b=rfm5VDHqoNelt7aZ9VMK8A3XM8ZbGn6yQTFyTA/hu/n1B2QqdG+Yy+E1zQ/Njpai7y
         QTnLmu0cQ9HV5zFyO0rHW7X10HMdHtYcqCdE4p5Ir3nrWkDfodduf+SMg2mxjCkhcq/9
         wvXnuUeUfR8Ado1DkLFSIx2wLKiyAyvGZafhRVP7UWW8h6nyPT4JYXzF8MBAYoODyg/h
         wegM2SYfeTttkUKFEAmnE8X0VvBv+j7DfOluO6UjamHiKUOd5lTDepP3s4Dvtwg3Ll+P
         TzUwp3tuSoF9bCd62B4uUtTjxgW+cvZx7xUxJ+F/Z7YfieHlJu4ukVKqJRf0TJPVvoas
         kK7Q==
X-Gm-Message-State: APjAAAXgSKHJsBISm8ou6AEp8FE4fjLHYt79vjX1jtodGh3Tbspc+Ran
        q5RKXUrS/yLFnh1ATCcZ2FONuHWr5R0iFjgzij1oCQ==
X-Google-Smtp-Source: APXvYqx/OWIOYbbaJV8KsbFLHHL5h59tqc9ASGLCt3k07z7nzOjRHsH+LbIoPAaodF8vMOPJKXfqNvjHSYB5bJ8KTjg=
X-Received: by 2002:a6b:4101:: with SMTP id n1mr82094401ioa.138.1564503837528;
 Tue, 30 Jul 2019 09:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190730154027.101525-1-drinkcat@chromium.org> <20190730154204.GC15386@arrakis.emea.arm.com>
In-Reply-To: <20190730154204.GC15386@arrakis.emea.arm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 30 Jul 2019 18:23:44 +0200
Message-ID: <CACT4Y+ZRoSeBw=NUxvnLR+GAHweDgyV+3YkzeZiW3f85STqMpQ@mail.gmail.com>
Subject: Re: [PATCH] kmemleak: Increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE default
 to 16K
To:     Catalin Marinas <catalin.marinas@arm.com>
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
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 5:42 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Jul 30, 2019 at 11:40:27PM +0800, Nicolas Boichat wrote:
> > The current default value (400) is too low on many systems (e.g.
> > some ARM64 platform takes up 1000+ entries).
> >
> > syzbot uses 16000 as default value, and has proved to be enough
> > on beefy configurations, so let's pick that value.
> >
> > This consumes more RAM on boot (each entry is 160 bytes, so
> > in total ~2.5MB of RAM), but the memory would later be freed
> > (early_log is __initdata).
> >
> > Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Dmitry Vyukov <dvyukov@google.com>
