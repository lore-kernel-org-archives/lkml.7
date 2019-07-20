Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D37C76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 12:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B84217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 12:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563627010;
	bh=EdVU4Hw1eX974wMmWXWMUwiXMEahDa5Q3bAuMh5PE/s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DV5gQzwx0Zb8Wz4SaH25pWp8ASXJPldKiUojyDsraTaQIXzcc+4ZpP57xhvGLoyym
	 4ILfV4OPJTi9P8EQsCkYO9jmBw6YySwGcHuuH5H2kEhY9iZc8Hiq80qsykFstXC/8D
	 DjQuItDe4EAxGKjUCfzhqYdxLmAV4Kh8tdPlt0rE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfGTMuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 08:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbfGTMuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 08:50:09 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA2E62189E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2019 12:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563627007;
        bh=EdVU4Hw1eX974wMmWXWMUwiXMEahDa5Q3bAuMh5PE/s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ryf+H3YpGpwK9vtFRssVPY3YvnZ4uDTxv5pbQ7PFpJ3hc7yJ1FLY+qiMQ8igaaPTR
         IhEpkCfoeh8LW+izuRamsqm9InHY6BsqjQ1ArNab7LSqCA12djmqLbVajN60SxszDy
         KaDGRL2ffi7qM55iJegPU6G/g/Bby3g37BmVJuPg=
Received: by mail-wm1-f51.google.com with SMTP id p74so31047248wme.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2019 05:50:07 -0700 (PDT)
X-Gm-Message-State: APjAAAUDEt/8n9+LddOfw6YdX4RdcktUdi9w9AXMh8Pq3ifmQ2By62V1
        LjBwdUpBo6b0OYXHE1VHJdV2/Ch7usd4TWXvRH96Hw==
X-Google-Smtp-Source: APXvYqzatCf8SdUgPrV8GriYE189WAEs8CPd26380+NgXTBCsCNmF6BNE3bybSG/EGXz2+FS3YA8/EV7L4XpeWKaKRw=
X-Received: by 2002:a1c:a942:: with SMTP id s63mr52788532wme.76.1563627006058;
 Sat, 20 Jul 2019 05:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190711114054.406765395@infradead.org> <4c71e14d-3a32-c3bb-8e3b-6e5100853192@oracle.com>
 <97cdd0af-95cc-2583-dc19-129b20809110@oracle.com> <d82854b2-d2a4-5b83-b4a4-796db0fd401b@etsukata.com>
 <CALCETrVH_F-OVQOsJ=KRGtNLQfM5QpSzP4UNn2RbLjP4ueeq-g@mail.gmail.com> <98e20ed8-4032-09b5-e852-9f21df5c237c@etsukata.com>
In-Reply-To: <98e20ed8-4032-09b5-e852-9f21df5c237c@etsukata.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 20 Jul 2019 05:49:53 -0700
X-Gmail-Original-Message-ID: <CALCETrUkEB89jkBzWg26Y0unCwgOWYT5da+OkbatUU_Bh97T8g@mail.gmail.com>
Message-ID: <CALCETrUkEB89jkBzWg26Y0unCwgOWYT5da+OkbatUU_Bh97T8g@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Tracing vs CR2
To:     Eiichi Tsukata <devel@etsukata.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux_lkml_grp@oracle.com, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 8:59 PM Eiichi Tsukata <devel@etsukata.com> wrote:
>
>
> On 2019/07/19 5:27, Andy Lutomirski wrote:
> > Hi all-
> >
> > I suspect that a bunch of the bugs you're all finding boil down to:
> >
> >  - Nested debug exceptions could corrupt the outer exception's DR6.
> >  - Nested debug exceptions in which *both* exceptions came from the
> > kernel were probably all kinds of buggy
> >  - Data breakpoints in bad places in the kernel were bad news
> >
> > Could you give this not-quite-finished series a try?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/
> >
>
> Though I'm still trying to find out other cases(other areas which could
> be buggy if we set hw breakpoints), as far as I tested, there is
> no problem so far.
>
> If I understand correctly, the call trace and the dr6 value will be:
>
> ====
>
> debug() // dr6: 0xffff4ff0, user_mode: 1
>   TRACE_IRQS_OFF
>     arch_stack_user_walk()
>       debug()  // dr6: 0xffff4ff1 == 0xffff4ff0 | 0xffff0ff1 ... (*)
>         do_debug()
>           WARN_ON_ONCE
>   do_debug() // dr6: 0xffff0ff0(cleared in the above do_debug())

The dr6 register will indeed be cleared like this, but the dr6
variable should still be 0xffff4ff0.

>
> (*) :
> >   * The Intel SDM says:
> >   *
> >   *   Certain debug exceptions may clear bits 0-3. The remaining
> >   *   contents of the DR6 register are never cleared by the
> >   *   processor. To avoid confusion in identifying debug
> >   *   exceptions, debug handlers should clear the register before
> >   *   returning to the interrupted task.
>
> ====
>
> Note: printk() in do_debug() can cause infinite loop(printk() ->
> irq_disable() -> do_debug() -> printk() ...), so printk_deferred()
> was preferable.
>

Shouldn't that be fixed with my patches?  It should only be able to
recurse two deep: do_debug() from user mode can indeed trip
breakpoints, but the next do_debug() will clear DR7 in paranoid_entry.
