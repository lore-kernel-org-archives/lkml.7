Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EB9C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA15D2089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILVqBg5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfGaMZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:25:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38522 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfGaMZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:25:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id s15so38284093wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 05:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=R7XjVu1Q+2t2OCDbFe6JERwCgU5GBze4iS/iecgn0V8=;
        b=ILVqBg5GPvAXj+lG/yEYdWeBKdGfPf7klH1okvhPhvnvb56wHJqAaW0GTzAQ43hwpt
         UxwLHzao3BquJGq/4xOCWUk71gXgNoo+/p+ol0oMYVO5IW4jw5hKTjtOBAN6Fntkw7PE
         uGMwYlJQ1Co/C40XS43b+Q8gf7vJk6FB8Yaw7GUM2YBJC7VdSg+KDY9SZFU44ZE2bGPk
         apKjXkVv7Iem1UUgP5gBQQvUPrUX9UGQ9NGF0qfrAGM1TiuOjBpSNPVigkiwmXYl6JeQ
         wYlTMMqesR7sW9CB2Ci3cX0dkE5HFlAVPnepRNx0yXNI2Awp2K7EFrZeRDaxOSGX6+ZE
         ENlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=R7XjVu1Q+2t2OCDbFe6JERwCgU5GBze4iS/iecgn0V8=;
        b=m/pMMxHx7PUZJPshtqZOZVU973QyBG88DyhTq98lLlvzdXnLdKGCBDxPDYSq6BN+Ol
         H7UryIIz4MmT+yP+1SafzduqKQV3apt9pgBQHOdJAUJ+2XIGwuizKouf2PRQ6NiuEY+q
         8G5ZpMPQbH2PseeY0SoEjMDJudwMD+/4TS7YMtVR16PPG5EcR5A7/Nwk7JEjzGbe9xSv
         a7EQXjRe3D8Pe4nKWtSVowLLGXQFAwtaLQ+gPp35eUQ4PnfE3xppj9YXWOG+jJHECyWI
         Z2ssvp5oZFzuq0PP8x/vbaWUWtxIP0tz4BkjqJnsnOKko8Az876EJy4STyynf68hWD/2
         iobg==
X-Gm-Message-State: APjAAAU7FqY9nfG1AthXaX61eJcbXp1UeLHEeOPjxyDOynl7toh0mX3h
        aGwJAVvEKc3e8RcK+vuhD9CviutrY0ciLyb8Rtk=
X-Google-Smtp-Source: APXvYqxVxxud91q/SIqbQpYtC/q0uxNH7WkuOed0ZaYA+0PM53Kfn+D5yFaPrxj3KUv3RfPJ5OTpAibDIA5CSzzdAX4=
X-Received: by 2002:a05:600c:225a:: with SMTP id a26mr116610265wmm.81.1564575928122;
 Wed, 31 Jul 2019 05:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <51a4155c5bc2ca847a9cbe85c1c11918bb193141.1564086017.git.jpoimboe@redhat.com>
 <alpine.DEB.2.21.1907252355150.1791@nanos.tec.linutronix.de>
 <156416793450.30723.5556760526480191131@skylake-alporthouse-com>
 <alpine.DEB.2.21.1907262116530.1791@nanos.tec.linutronix.de> <156416944205.21451.12269136304831943624@skylake-alporthouse-com>
In-Reply-To: <156416944205.21451.12269136304831943624@skylake-alporthouse-com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 31 Jul 2019 14:25:16 +0200
Message-ID: <CA+icZUXwBFS-6e+Qp4e3PhnRzEHvwdzWtS6OfVsgy85R5YNGOg@mail.gmail.com>
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

On Fri, Jul 26, 2019 at 9:30 PM Chris Wilson <chris@chris-wilson.co.uk> wrote:
>
> Quoting Thomas Gleixner (2019-07-26 20:18:32)
> > On Fri, 26 Jul 2019, Chris Wilson wrote:
> > > Quoting Thomas Gleixner (2019-07-25 22:55:45)
> > > > On Thu, 25 Jul 2019, Josh Poimboeuf wrote:
> > > >
> > > > > Objtool reports:
> > > > >
> > > > >   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x36: redundant UACCESS disable
> > > > >
> > > > > __copy_from_user() already does both STAC and CLAC, so the
> > > > > user_access_end() in its error path adds an extra unnecessary CLAC.
> > > > >
> > > > > Fixes: 0b2c8f8b6b0c ("i915: fix missing user_access_end() in page fault exception case")
> > > > > Reported-by: Thomas Gleixner <tglx@linutronix.de>
> > > > > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > > Link: https://github.com/ClangBuiltLinux/linux/issues/617
> > > > > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > >
> > > > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > >
> > > Which tree do you plan to apply it to? I can put in drm-intel, and with
> > > the fixes tag it will percolate through to 5.3 and beyond, but if you
> > > want to apply it directly to squash the build warnings, feel free.
> >
> > It would be nice to get it into 5.3. I can route it linuxwards if you give
> > an Acked-by, but I'm happy to hand it to you :)
>
> Acked-by: Chris Wilson <chris@chris-wilson.co.uk>

Thomas did you take this through tip tree after Chris' ACK?

- Sedat -
