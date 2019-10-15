Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DDDECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFD120663
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571166059;
	bh=+KBu6VtRO9T+h8wxDzVRwoY7u1gdvlKtdXVYL7jQ/go=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TBi/bFa3S9JILI0pY42HNLOoL8HHacM86F5i05IicDjq/Ty4Z3wodSyMsrR/aLpqe
	 tuJbaKSVEidHApPmmyEvmLXzki+oM+YRckXt5I7tFaaxxTWEzFkGYr23rzKHiLOlr9
	 B2Sy/QRnCL4Ppd2nRC9NraHP25RgLu7Z6o4Y/ixc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389114AbfJOTA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:00:58 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39714 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731776AbfJOTA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:00:56 -0400
Received: by mail-lj1-f195.google.com with SMTP id y3so21399963ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MMAvaim9+S74+cLKGfKpPV0jt0ePKq4pl+dUnol7U2k=;
        b=DhI3jZcx/uyOLfu8ny5Lt1siVQgFVsCm5kmsY6i2FCqBbzb8QH9PPyTN8DCmdhDr5S
         A4G11LYL3O44P/4Ql7Jt/VeZd1nO1dKf4kVncZj73MdbJR4Dzd9pa/QE5Xu42b6DB/NB
         KjEixpuat22YXDmNzVBhKNDv8Olnc7lfHEeOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MMAvaim9+S74+cLKGfKpPV0jt0ePKq4pl+dUnol7U2k=;
        b=Sfko3OgbfQEuj2WTydBmbcoqqDFIgtBiqn/WCkZ/9CqPL61X8kKzlt7eB7qbRZdtk4
         gLzRg4x07V9Trb80NFmFup5WDD3VD2pR78TIn5IzgW4CjwarrjTWV+uUnuvrLJ0c/C0o
         +LTf+kUAY0Dn5V8ZyWRUeY+s/aDGsrsNAWnC/GVBy5soNVziMts/qATR7JMmoqiDahTa
         dyIb4QXK+lzjDceIrvgyLLS4eF1ofb5frX9LLFj03rvSwaj0h2vJ+2h/dEqF17co77GB
         h2gEJcrirzxLUFCvRyYvHkFn8C4JWAIPhsyBlugBDg3CCaBMBZEgZBeWvm6Qmc4xnMIe
         qQ4w==
X-Gm-Message-State: APjAAAV2mx5DtVR3Zo4NnX43ExylvvZIYAtFtmcl4IpXRDP4GXUGjnPT
        EcpFZ5sUgdax8icwSN8c5KBaZj9WyYE=
X-Google-Smtp-Source: APXvYqwuNKpndHMm/WcYWQnwqf/9yylOM1AkYGZEhThHBwINp2fi9u/Hx9IZVTdg3hI1PR6SHlA8VQ==
X-Received: by 2002:a2e:858f:: with SMTP id b15mr23421358lji.68.1571166053091;
        Tue, 15 Oct 2019 12:00:53 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id m27sm430987lfp.60.2019.10.15.12.00.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 12:00:51 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id m7so21393820lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 12:00:51 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr1159643ljf.133.1571166050946;
 Tue, 15 Oct 2019 12:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgOWxqwqCFuP_Bw=Hxxf9njeHJs0OLNGNc63peNd=kRqw@mail.gmail.com>
 <20191010195504.GI26530@ZenIV.linux.org.uk> <CAHk-=wgWRQo0m7TUCK4T_J-3Vqte+p-FWzvT3CB1jJHgX-KctA@mail.gmail.com>
 <20191011001104.GJ26530@ZenIV.linux.org.uk> <CAHk-=wgg3jzkk-jObm1FLVYGS8JCTiKppEnA00_QX7Wsm5ieLQ@mail.gmail.com>
 <20191013181333.GK26530@ZenIV.linux.org.uk> <CAHk-=wgrWGyACBM8N8KP7Pu_2VopuzM4A12yQz6Eo=X2Jpwzcw@mail.gmail.com>
 <20191013191050.GL26530@ZenIV.linux.org.uk> <CAHk-=wjJNE9hOKuatqh6SFf4nd65LG4ZR3gQSgg+rjSpVxe89w@mail.gmail.com>
 <20191013195949.GM26530@ZenIV.linux.org.uk> <20191015180846.GA31707@ZenIV.linux.org.uk>
In-Reply-To: <20191015180846.GA31707@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Oct 2019 12:00:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjyiiYhAbzVDUW1F3j9CAcu8+ugSvGYwUivdBfKoeU6yA@mail.gmail.com>
Message-ID: <CAHk-=wjyiiYhAbzVDUW1F3j9CAcu8+ugSvGYwUivdBfKoeU6yA@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 11:08 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Another question: right now we have
>         if (!access_ok(uaddr, sizeof(u32)))
>                 return -EFAULT;
>
>         ret = arch_futex_atomic_op_inuser(op, oparg, &oldval, uaddr);
>         if (ret)
>                 return ret;
> in kernel/futex.c.  Would there be any objections to moving access_ok()
> inside the instances and moving pagefault_disable()/pagefault_enable() outside?

I think we should remove all the "atomic" versions, and just make the
rule be that if you want atomic, you surround it with
pagefault_disable()/pagefault_enable().

That covers not just the futex ops (where "atomic" is actually
somewhat ambiguous - the ops themselves are atomic too, so the naming
might stay, although arguably the "futex" part makes that pointless
too), but also copy_to_user_inatomic() and the powerpc version of
__get_user_inatomic().

So we'd aim to get rid of all the "inatomic" ones entirely.

Same ultimately probably goes for the NMI versions. We should just
make it be a rule that we can use all of the user access functions
with pagefault_{dis,en}able() around them, and they'll be "safe" to
use in atomic context.

One issue with the NMI versions is that they actually want to avoid
the current value of set_fs().  So copy_from_user_nmi() (at least on
x86) is special in that it does

        if (__range_not_ok(from, n, TASK_SIZE))
                return n;

instead of access_ok() because of that issue.

NMI also has some other issues (nmi_uaccess_okay() on x86, at least),
but those *probably* could be handled at page fault time instead.

Anyway, NMI is so special that I'd suggest leaving it for later, but
the non-NMI atomic accesses I would suggest you clean up at the same
time.

I think the *only* reason we have the "inatomic()" versions is that
the regular ones do that "might_fault()" testing unconditionally, and
might_fault() _used_ to be just a might_sleep() - so it's not about
functionality per se, it's about "we have this sanity check that we
need to undo".

We've already made "might_fault()" look at pagefault_disabled(), so I
think a lot of the reasons for inatomic are entirely historical.

                Linus
