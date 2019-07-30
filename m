Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A55BC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC9C206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S3vv2HDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732268AbfG3PWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:22:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38623 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbfG3PWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:22:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id n11so63400689qtl.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 08:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0/VikeT/40/94mlzafqQ+br06jiibogiKOd39iZFxVU=;
        b=S3vv2HDTN4GlOLWRrQu3XWT4f7svDBLxxP3BZ+0r+2d9QzUmW4mbQN09LYmtyL1+p+
         HD0LZROqt+yxspDRIhYZIywaOnDd7tAyFU81sKIzQMxVoR22sbVFXRz0CkULNmEjq8PU
         FeZsgGbmbAg/rUHJZCIixw7umVesNt7VUdF+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0/VikeT/40/94mlzafqQ+br06jiibogiKOd39iZFxVU=;
        b=ILeEZYXxC/Fpqqt8nckJfSbkgPpQLCBu/gDmgKPtlxyHz7Nr3bAFXSiIIu6pj/aOUe
         u+PNgXf2Ar7YQ3DlaLn+s7pIblulIlFRwchbTYSe2rzoGE2kjK5ur4kz7Rn3Oqp2WlGU
         lKuCd0SG+pfPRXFE2TysFNMSPqVZoEmwyCYTuokAKkG4d8vDS4EDqZo7hj19IcwDBp6L
         vSL0Xdnkx67pJl9Fn5sGE6GpskqWZSnt2VT3D8WmsYprfTtzmUNp7qf4TkcpPveqL2Kb
         6yYN0z0sjv1L1pEX0w/frCMU0++CzgA+RnACU+w7puBgRjtkk32UYV5yiVfAnOtsoeZ8
         t8HQ==
X-Gm-Message-State: APjAAAUOPR7UkwMXV1dWzbgChXmRX5cTiXn7i64UDbvGRj4D1/2qgWk6
        YRV2Ok+8ZGmcFguL17WMnz6o6j7zlKZo/AWb7xcQbA==
X-Google-Smtp-Source: APXvYqxiF9XqXsJgYZY66tLmHlKA6YyZSyll6VNgtMH212HpnhK5C6yShyQYlQFVlW6Wd6QG22HtLlKUmTWvPqbkc58=
X-Received: by 2002:ac8:6619:: with SMTP id c25mr44624329qtp.221.1564500152521;
 Tue, 30 Jul 2019 08:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190723072605.103456-1-drinkcat@chromium.org>
 <CACT4Y+bi5KkZ8igSeYVxjwtr8t0Vjz55gzWfAu_c8VMAqw0zPA@mail.gmail.com>
 <CANMq1KB8ECeRqNhSWyUf3amAkF7qvAmS3aU6rGNnZ=kUV3LC5Q@mail.gmail.com> <095e2bc3-9284-e72d-8ed8-e2c6ec3f7c23@virtuozzo.com>
In-Reply-To: <095e2bc3-9284-e72d-8ed8-e2c6ec3f7c23@virtuozzo.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 30 Jul 2019 08:22:21 -0700
Message-ID: <CANMq1KDrPDjHB=hsVBrW4WCiTBBAm6T2TS0yo3icU8Zt0krNog@mail.gmail.com>
Subject: Re: [PATCH] kmemleak: Increase maximum early log entries to 1000000
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 2:01 AM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>
>
>
> On 7/23/19 11:13 AM, Nicolas Boichat wrote:
> > On Tue, Jul 23, 2019 at 3:46 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >>
> >> On Tue, Jul 23, 2019 at 9:26 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
> >>>
> >>> When KASan is enabled, a lot of memory is allocated early on,
> >>> and kmemleak complains (this is on a 4GB RAM system):
> >>> kmemleak: Early log buffer exceeded (129846), please increase
> >>>   DEBUG_KMEMLEAK_EARLY_LOG_SIZE
> >>>
> >>> Let's increase the upper limit to 1M entry. That would take up
> >>> 160MB of RAM at init (each early_log entry is 160 bytes), but
> >>> the memory would later be freed (early_log is __initdata).
> >>
> >> Interesting. Is it on an arm64 system?
> >
> > Yes arm64. And this is chromiumos-4.19 tree. I didn't try to track
> > down where these allocations come from...
> >
>
> Is this still a problem in upstream tree? 4.19 doesn't have fed84c785270 ("mm/memblock.c: skip kmemleak for kasan_init()")

Sorry for the delay, and thanks for the hint, indeed, not a problem
with that patch backported to our 4.19 tree: the number of allocations
shrinks from 100K+ to 1K+.

However, I think Dmitry is still right that the default (400) is too
low, I will send a patch for that.
