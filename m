Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B79CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A4A20C01
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZTyzChf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbfHETaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 15:30:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51981 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHETaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 15:30:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so75851826wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 12:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=4TR1ROvSxrSW2jGMt/9xUpK6NJiArbHQHezkRC5T3No=;
        b=rZTyzChfgcWwwgTvCD/CVNOqEZQsoKiuqoj6vu6VFXxDpBxWbk6/3on5trmksfOnUM
         X70HVqGO+45T01EKlSpcM/e498+YYNoj1r+r3ZfwxrA3DLrvx8JZZN5/2dBeOMh3DYoR
         YTgGq08SWRokl8/7az8va7hPyfo9h17732xhpydMZ9QkZDZTChlAvwvkAhzzUQuICJa1
         mtjvYaSwTv+/VuNuFmSLV4upxvAZVJdFv7aS6dU5vG/50Qvylr5mRb8UQCK0F12Gqbnn
         WtD66meo/gDN8udvs2t6HhYX0P3+EuKF48/xi5ibJVGT/4jAC1H29FMQ7esFHiaUncLz
         G8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=4TR1ROvSxrSW2jGMt/9xUpK6NJiArbHQHezkRC5T3No=;
        b=qdV1OSVW3Q6J6fUbQp4REGmp+PH5qzGCBPZmCxSQinjSz9mc2ZwGx4zGowmI890B9u
         IQiz3dIzZpS1YiZKVuGPLA5lkHbR3cubj7soBPkANcwcl0PARL9QzalIb8xVG9U0KQX9
         kmlpxuLyaE+pe6Mx66iAO68zkZTA42AogOmXGgJ4KY0YqnF87DN0S15JU32rF0eMOFee
         fGqcFsIb+4hfdcrMXyveH8hS8Ou+9aT7pg8dBF1YOCEXSAO0YMxlipeAoSjtMkxa9xAe
         kV2Nwju4GElZrVpbb2m5/2x6ljp7/qU/zm1iu1h9dN4pRzxDTqrKC3icld42UGn2kM8b
         k1QQ==
X-Gm-Message-State: APjAAAW6YO9/D4EDooHYhe6cOIM8xMaO5+meU1j0pMrNgfl0hyFbtfs7
        p4MuU3eqK3Lt0AK8YHkNM6lj1K/5VO1f58kUVR8=
X-Google-Smtp-Source: APXvYqyGSzwDfUb1BiB433k508Z+fmaGZSrxRSK52vSJD6e/xnBmIqpLNGWQq/QRx1YQtmC7gqxrqWy42fyxNAsztfw=
X-Received: by 2002:a05:600c:225a:: with SMTP id a26mr20957306wmm.81.1565033405310;
 Mon, 05 Aug 2019 12:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <51a4155c5bc2ca847a9cbe85c1c11918bb193141.1564086017.git.jpoimboe@redhat.com>
 <alpine.DEB.2.21.1907252355150.1791@nanos.tec.linutronix.de>
 <156416793450.30723.5556760526480191131@skylake-alporthouse-com>
 <alpine.DEB.2.21.1907262116530.1791@nanos.tec.linutronix.de>
 <156416944205.21451.12269136304831943624@skylake-alporthouse-com> <CA+icZUXwBFS-6e+Qp4e3PhnRzEHvwdzWtS6OfVsgy85R5YNGOg@mail.gmail.com>
In-Reply-To: <CA+icZUXwBFS-6e+Qp4e3PhnRzEHvwdzWtS6OfVsgy85R5YNGOg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 5 Aug 2019 21:29:53 +0200
Message-ID: <CA+icZUWA6e0Zsio6sthRUC=Ehb2-mw_9U76UnvwGc_tOnOqt7w@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: Remove redundant user_access_end() from
 __copy_from_user() error path
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 2:25 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Jul 26, 2019 at 9:30 PM Chris Wilson <chris@chris-wilson.co.uk> wrote:
> >
> > Quoting Thomas Gleixner (2019-07-26 20:18:32)
> > > On Fri, 26 Jul 2019, Chris Wilson wrote:
> > > > Quoting Thomas Gleixner (2019-07-25 22:55:45)
> > > > > On Thu, 25 Jul 2019, Josh Poimboeuf wrote:
> > > > >
> > > > > > Objtool reports:
> > > > > >
> > > > > >   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x36: redundant UACCESS disable
> > > > > >
> > > > > > __copy_from_user() already does both STAC and CLAC, so the
> > > > > > user_access_end() in its error path adds an extra unnecessary CLAC.
> > > > > >
> > > > > > Fixes: 0b2c8f8b6b0c ("i915: fix missing user_access_end() in page fault exception case")
> > > > > > Reported-by: Thomas Gleixner <tglx@linutronix.de>
> > > > > > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > > > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > > > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > > > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > > > Link: https://github.com/ClangBuiltLinux/linux/issues/617
> > > > > > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > > >
> > > > > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > > >
> > > > Which tree do you plan to apply it to? I can put in drm-intel, and with
> > > > the fixes tag it will percolate through to 5.3 and beyond, but if you
> > > > want to apply it directly to squash the build warnings, feel free.
> > >
> > > It would be nice to get it into 5.3. I can route it linuxwards if you give
> > > an Acked-by, but I'm happy to hand it to you :)
> >
> > Acked-by: Chris Wilson <chris@chris-wilson.co.uk>
>
> Thomas did you take this through tip tree after Chris' ACK?
>

Hi,

Gentle ping...
Thomas and Chris: Will someone of you pick this up?
As "objtool: Improve UACCESS coverage" [1] went trough tip tree I
highly appreciate to do so with this one.

Thanks.

Regards,
- Sedat -

[1] https://git.kernel.org/linus/882a0db9d143e5e8dac54b96e83135bccd1f68d1
[2] https://github.com/ClangBuiltLinux/linux/issues/617
