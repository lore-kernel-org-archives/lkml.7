Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B7CC28D18
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0C020684
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Dvb5lvHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfFENE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:04:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42437 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbfFENE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:04:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id t28so11928670lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 06:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NRvNKqXzZztvQh3qtkPJBNz3Y41PCmY2mwresCdihvw=;
        b=Dvb5lvHNFy/YlX9VOpbVuAXgLc/Bkqb9FHL1QfulyPL3Nfu7LNFUDi2bdtRN38UIDB
         kpsq1w0ZNYuzjO5QiRB/VNBh4B2zYpwznNXZ2BcTi+m6xeubmV2GNyYxBYFe52W8b6at
         WcDyZ7BR4dByy2KBn+q2kg8uW24xdyRPcakrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NRvNKqXzZztvQh3qtkPJBNz3Y41PCmY2mwresCdihvw=;
        b=bOqjeRKNZFsuZYC4NuAWow1epMA9RObSIlDkYwMZ4e+Yo4/uIqJT3sJhFg0Mi2Kuzt
         X9bJQeOB+NCJGuren/iMDO1XaFlAjxUmTqECtAlcqx2gLExw4qeow6boeZ96lMqgTpYl
         Df8y1yq3oJkAY5FVU0bicdmfMhFEjV1vzZXskhyHg3tU1QRhFQYtnRmQraQqcpvEyiVe
         tuXBnWbp0jpsbXxEocDA6FG8b0jv9a3iTqEwWcRMBpEIqtt5eAb7A0cAaOto60el0gbt
         uRyW0iDAiPcwrntIHzB3u6dv01TO2JT7JwTX0oIR1nwke6tTW7O+4JsvXrq07VjP25AP
         S5UQ==
X-Gm-Message-State: APjAAAWPFdsLsVcFQEasmvaYsCTKNdjuhHbbp06KtKnU4gzDGAlNEhzI
        k5+P7Qr/Eo+t2xkUM16bQdxI5R83J7X+CiIM558O+g==
X-Google-Smtp-Source: APXvYqyt7OLKBZ4DAerRqhiAeTPqPshOGmAnuk0KkZaQmyvMV/dwuVHzpUT44mnRI2A50tJlbF4XhdP85jTinsVz67M=
X-Received: by 2002:a05:651c:87:: with SMTP id 7mr3383290ljq.184.1559739895494;
 Wed, 05 Jun 2019 06:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190601222738.6856-1-joel@joelfernandes.org> <20190601222738.6856-5-joel@joelfernandes.org>
 <20190605012429.wmlvlgn4mb4jkvua@ca-dmjordan1.us.oracle.com>
In-Reply-To: <20190605012429.wmlvlgn4mb4jkvua@ca-dmjordan1.us.oracle.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 5 Jun 2019 09:04:44 -0400
Message-ID: <CAEXW_YTsT5BY5Qbc6Jju2XmbHSQFELrGM9UaPPXY-ETmJaBrsA@mail.gmail.com>
Subject: Re: [RFC 4/6] workqueue: Convert for_each_wq to use built-in list check
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
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
        Pavel Machek <pavel@ucw.cz>,
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

On Tue, Jun 4, 2019 at 9:25 PM Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
>
> On Sat, Jun 01, 2019 at 06:27:36PM -0400, Joel Fernandes (Google) wrote:
> > list_for_each_entry_rcu now has support to check for RCU reader sections
> > as well as lock. Just use the support in it, instead of explictly
> > checking in the caller.
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/workqueue.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index 9657315405de..91ed7aca16e5 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -424,9 +424,8 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
> >   * ignored.
> >   */
> >  #define for_each_pwq(pwq, wq)                                                \
> > -     list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node)          \
> > -             if (({ assert_rcu_or_wq_mutex(wq); false; })) { }       \
> > -             else
> > +     list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node,          \
> > +                              lock_is_held(&(wq->mutex).dep_map))
> >
>
> I think the definition of assert_rcu_or_wq_mutex can also be deleted.

Sure, will do. Thank you.
