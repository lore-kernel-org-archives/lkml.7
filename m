Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02DDC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831EB2184B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aYpuS5OT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392522AbfGWWZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 18:25:09 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36249 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbfGWWZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 18:25:07 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so85382986iom.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 15:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cwfou+bwYvh+NgeiS9WMeMU0g5CDhL3xxSGMHlwshUw=;
        b=aYpuS5OTuXHnpMldiw3wqJiOvQAhmm3oc5rZGWUiRn9QhULPccYSGlqFNQInmVVeT9
         hji/G16nV9YMdPg5Hq2vpl3tEYwV9pb0CUNRoJfxup+s5HcUtJtOGXp12/GWht5aGMxc
         mSRRN0m+wMh9vfPIVQO8R93K+k5alY9suQ6P4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cwfou+bwYvh+NgeiS9WMeMU0g5CDhL3xxSGMHlwshUw=;
        b=TgAEWlb6xPvx387Zp3EooY14ozpdI4y8vNlXz4PstNbDCHWo6ypNdQJWjvmDbvR/KO
         uR3YvUzZGc8XmnAAbypwke/rUbVHbe46IubYdfHB9k6xgkj+Zd7S7M4OvHZeJNm7dWCM
         TPRh7AFFzJkxxljTCcssfN9Sxqy4q9d9FMuHpkpdZhb1MJOY83pfBycWnqn7J/WzFFqu
         YQ3VhpfnH09o2SO21QFAUGKYcWE314bh7+Srh9iYMToZqvvv3CiDCZC/SABhGzca29j3
         FJO3Zhmg3sg92kRrjSEYft0w1F+oK2pQRUFaoFHsyz0n4rkapKOivWn8aRtoFLkqk5Uw
         vQ3Q==
X-Gm-Message-State: APjAAAX6xB/DCg46YxiuATXdlnkwAhEms/yjKZ4XfMq9VuGVCtgKTDaJ
        jFMOBlp9CE29+AXF71JmHyRuLCfVdNM=
X-Google-Smtp-Source: APXvYqyfAWoTouZN1l2vtyGcX2QKXktFuWHAfJdc4THSLG2MA7Tv9Bmaj8FzqMLhkbb46ZcoJK7XFA==
X-Received: by 2002:a02:8663:: with SMTP id e90mr80872192jai.98.1563920705980;
        Tue, 23 Jul 2019 15:25:05 -0700 (PDT)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id z17sm62115573iol.73.2019.07.23.15.25.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 15:25:05 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id k20so85264970ios.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 15:25:05 -0700 (PDT)
X-Received: by 2002:a5d:96d8:: with SMTP id r24mr10971823iol.269.1563920265159;
 Tue, 23 Jul 2019 15:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190723072605.103456-1-drinkcat@chromium.org>
 <CACT4Y+bi5KkZ8igSeYVxjwtr8t0Vjz55gzWfAu_c8VMAqw0zPA@mail.gmail.com>
 <CANMq1KB8ECeRqNhSWyUf3amAkF7qvAmS3aU6rGNnZ=kUV3LC5Q@mail.gmail.com> <CACT4Y+YkjCpEdH0rvgp8b1hqAWfo66FY76qhn1xj_yNAER-XoQ@mail.gmail.com>
In-Reply-To: <CACT4Y+YkjCpEdH0rvgp8b1hqAWfo66FY76qhn1xj_yNAER-XoQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 23 Jul 2019 15:17:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wse7tGi-RP5Rq1314AdLqMS3JNy6a-gFbmVZuroSWozw@mail.gmail.com>
Message-ID: <CAD=FV=Wse7tGi-RP5Rq1314AdLqMS3JNy6a-gFbmVZuroSWozw@mail.gmail.com>
Subject: Re: [PATCH] kmemleak: Increase maximum early log entries to 1000000
To:     Dmitry Vyukov <dvyukov@google.com>
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

Hi,

On Tue, Jul 23, 2019 at 1:21 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, Jul 23, 2019 at 10:13 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
> >
> > On Tue, Jul 23, 2019 at 3:46 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Tue, Jul 23, 2019 at 9:26 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
> > > >
> > > > When KASan is enabled, a lot of memory is allocated early on,
> > > > and kmemleak complains (this is on a 4GB RAM system):
> > > > kmemleak: Early log buffer exceeded (129846), please increase
> > > >   DEBUG_KMEMLEAK_EARLY_LOG_SIZE
> > > >
> > > > Let's increase the upper limit to 1M entry. That would take up
> > > > 160MB of RAM at init (each early_log entry is 160 bytes), but
> > > > the memory would later be freed (early_log is __initdata).
> > >
> > > Interesting. Is it on an arm64 system?
> >
> > Yes arm64. And this is chromiumos-4.19 tree. I didn't try to track
> > down where these allocations come from...
>
> So perhaps it's due to arm64, or you have even more configs, or maybe
> running on real hardware. But I guess it's fine as is, just wondered
> why such a radical difference. Thanks.

If I had to guess I'd guess gcc vs. clang.  I think we've noticed a
few places where clang+kasan produces much bloatier code than
gcc+kasan.  Oh look, I just invented a new word: bloatier.  :-P

...could you try building with gcc and see if that explains the problems?

-Doug
