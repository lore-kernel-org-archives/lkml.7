Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184DAC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 23:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D821F2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 23:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VDlEGmqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404697AbfHHXDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 19:03:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46946 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404633AbfHHXDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 19:03:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id c3so21793136pfa.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 16:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w4PN33Lkfcqftf0QvPt6llyr/NqrBtuKXP5AjG4sS2I=;
        b=VDlEGmqQayUasSCsFFl/kgJP0QooO8SApmQBdfy+BJLl5TJEwpbGtwtJq7T+qOSyqP
         4pr+f9f/cobDjVxMHFw9yEWd6ystcw7NzJfLo/UBCyxRAllppqjZECKri1MBeMdHWnt5
         lPecE59M+Yu4biklKc21qNhg6dGcDqL4iSekPE3+nzudK3ae0ckmJXABQK2P4yao4Ms+
         gpT9Ha7D9di8pymw27zH6y5sFYK8o/fxUS9DMABoCbNg29v2kJf90UAAw9+HndEWWJpZ
         6NSHmgdEp3UZTKKAQsBoYJDcv2cdrc4vbuU/x3uvPWGh/z4COVpgRk2oEyTytwH+OcvW
         YyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w4PN33Lkfcqftf0QvPt6llyr/NqrBtuKXP5AjG4sS2I=;
        b=R830DyQ7CrN+T2ih5gkdQuHRJ/0ezFAl0uAfmWwHkgUrsHssEykPd/KNteNC6mvIx3
         EalfKWA5hJalCQYDmkNQmoHeBLqFpcXwK1zXqxZ+qK74luIcleV9BDD7BDBgY/wozxox
         k1H1QPHuuv3Q+RKFj48PwQrRrk+zuv++EAnRzLazENcYRZs5Xq4M7vAO05WiEG58fd3R
         KiB+UQFstzEeHv99wK9gi0wmIqOtqnuqQBQC1KT5+c1GL75K9V+UCCMVpYflvbDOnQqa
         bBH7krnz8VQrPhbOhiOhGU9zoB/Im+I9xqtRVlzlyvE/1/lr+CEZy9oxQCYpHVVYpy2n
         xLFQ==
X-Gm-Message-State: APjAAAUrL5ThtykwluW62JxwZorHDG9+yv+swtBuYe+73kYojPL1vLBp
        vJy5+bjcnIZt21zhf0XKnUsZu5rULmZj0OJkYrDusg==
X-Google-Smtp-Source: APXvYqzH449xBvCrlqjQwzF5xj2tRIVmQKanSHXknIuOYx+GTnQuSh1A8LBUrt41WSJC5l3ogvCmflURVarkffJBOuU=
X-Received: by 2002:a17:90a:c20f:: with SMTP id e15mr358266pjt.123.1565305385027;
 Thu, 08 Aug 2019 16:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <51a4155c5bc2ca847a9cbe85c1c11918bb193141.1564086017.git.jpoimboe@redhat.com>
 <alpine.DEB.2.21.1907252355150.1791@nanos.tec.linutronix.de>
 <156416793450.30723.5556760526480191131@skylake-alporthouse-com>
 <alpine.DEB.2.21.1907262116530.1791@nanos.tec.linutronix.de>
 <156416944205.21451.12269136304831943624@skylake-alporthouse-com>
 <CA+icZUXwBFS-6e+Qp4e3PhnRzEHvwdzWtS6OfVsgy85R5YNGOg@mail.gmail.com>
 <CA+icZUWA6e0Zsio6sthRUC=Ehb2-mw_9U76UnvwGc_tOnOqt7w@mail.gmail.com>
 <20190806125931.oqeqateyzqikusku@treble> <CAKwvOd=wa-XPCpoLQoQJH8Me7S=fXLfog0XsiKyFZKu8ojW_UQ@mail.gmail.com>
 <alpine.DEB.2.21.1908082221150.2882@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908082221150.2882@nanos.tec.linutronix.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 8 Aug 2019 16:02:53 -0700
Message-ID: <CAKwvOdkTD-0inuEKLTsH_tKXzXjvzwnUDwYZ++-hOUrC_FU=sw@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: Remove redundant user_access_end() from
 __copy_from_user() error path
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 1:22 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > tglx just picked up 2 other patches of mine, bumping just in case he's
> > not picking up patches while on vacation. ;)
>
> I'm only half on vacation :)
>
> So I can pick it up.

Thanks, will send half margaritas.

-- 
Thanks,
~Nick Desaulniers
