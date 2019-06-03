Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A107C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218BD263F4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="PYGUZK+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfFCM25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:28:57 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39712 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfFCM2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:28:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id a10so12755417ljf.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 05:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WvqHOC4rVKX462WwE0yHSlmBZF1YO9aROqbvN/HfH6Y=;
        b=PYGUZK+GV8eTc/sc1/LJV2/FRh6sJ3eQVXqtHpM1WdCHjxWxGcJHVX6no/5nw7UnO6
         DV0yDj/ec3TxqyDkkmaBhVAS4R0g44dxp9/lCrwxqbNfRaWzZra8qYmAc+YZXjsgn2FX
         UGutllvZNq/hEvDPh7uqahFLrpIWsFBdileHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WvqHOC4rVKX462WwE0yHSlmBZF1YO9aROqbvN/HfH6Y=;
        b=LHmaqdAIzw5mheQmw+f+72FDBRZeueXwlu1G4rZ1OWPKS8uI0jY06h6oLINu7SWekF
         eUiC2YdD4u9fMVuFrQ4UcCQ2oO7FOI4vFDlCW0SJPR0HZD0KkSE4EGaXdxZDmnb2ZQXL
         ldjLpGtD0n4nZaF7/OCMa/sM6khmCnMTNI3EaVN3yENn0jENcCknT+s0THUQqpd6aLzE
         xRqcHaMt/NZxfO55OUExeHbHqVofk4P4pDjcmdbTznT9FJGIRMqlzgbkVicIo3mlJKX/
         J4oEVl8Y3zAfM0oGsgZRgaUgylX217/euYCC20y2LA1uPR9bLSD12FA3/JHQyWiAxjRz
         Bl0w==
X-Gm-Message-State: APjAAAWI7EofWEVa8c4vbY5si67AzHEG8FWDgOAZnZOgDLXTLx0z9zA9
        J+PBxz0fUlpaJFFkXot22exEO35fjB9GqxufS2zW0Q==
X-Google-Smtp-Source: APXvYqzHzzga29JITONK+bAJt2s0MgC0PRTzbGVoOX6cnbI/p9OIDGMPiEXt3Q9ji63k1yr8CtUni9paU765sGDmFMs=
X-Received: by 2002:a2e:9742:: with SMTP id f2mr13977662ljj.184.1559564932484;
 Mon, 03 Jun 2019 05:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190601222738.6856-1-joel@joelfernandes.org> <20190601222738.6856-3-joel@joelfernandes.org>
 <20190602070014.GA543@amd> <CAEXW_YT3t4Hb6wKsjXPGng+YbA5rhNRa7OSdZwdN4AKGfVkX3g@mail.gmail.com>
 <CAEXW_YSM2wwah2Q7LKmUO1Dp7GG62ciQA1nZ7GLw3m6cyuXXTw@mail.gmail.com> <20190603064212.GA7400@amd>
In-Reply-To: <20190603064212.GA7400@amd>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 3 Jun 2019 08:28:41 -0400
Message-ID: <CAEXW_YSz8SNQCTnJj_86uJvRX3LFEQ6xJX-UV07HGwwA7oLwvg@mail.gmail.com>
Subject: Re: [RFC 2/6] ipv4: add lockdep condition to fix for_each_entry
To:     Pavel Machek <pavel@denx.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neil Brown <neilb@suse.com>, netdev <netdev@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zilstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 2:42 AM Pavel Machek <pavel@denx.de> wrote:
>
> On Sun 2019-06-02 08:24:35, Joel Fernandes wrote:
> > On Sun, Jun 2, 2019 at 8:20 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Sun, Jun 2, 2019 at 3:00 AM Pavel Machek <pavel@denx.de> wrote:
> > > >
> > > > On Sat 2019-06-01 18:27:34, Joel Fernandes (Google) wrote:
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > >
> > > > This really needs to be merged to previous patch, you can't break
> > > > compilation in middle of series...
> > > >
> > > > Or probably you need hlist_for_each_entry_rcu_lockdep() macro with
> > > > additional argument, and switch users to it.
> > >
> > > Good point. I can also just add a temporary transition macro, and then
> > > remove it in the last patch. That way no new macro is needed.
> >
> > Actually, no. There is no compilation break so I did not follow what
> > you mean. The fourth argument to the hlist_for_each_entry_rcu is
> > optional. The only thing that happens is new lockdep warnings will
> > arise which later parts of the series fix by passing in that fourth
> > argument.
>
> Sorry, I missed that subtlety. Might be worth it enabling the lockdep
> warning last in the series...

Good idea, will do! Thanks.
