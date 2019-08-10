Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647D8C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 05:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A582217F4
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 05:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfHJF7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 01:59:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57993 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfHJF7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 01:59:13 -0400
Received: from p200300ddd71876237e7a91fffec98e25.dip0.t-ipconnect.de ([2003:dd:d718:7623:7e7a:91ff:fec9:8e25])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hwKPD-0001rk-4j; Sat, 10 Aug 2019 07:59:07 +0200
Date:   Sat, 10 Aug 2019 07:59:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sedat Dilek <sedat.dilek@gmail.com>
cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] drm/i915: Remove redundant user_access_end() from
 __copy_from_user() error path
In-Reply-To: <CA+icZUWgE5NTEa9Q0jof0Hv52tZM8-869Daww7dueaaMMXt+7A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908100754560.7324@nanos.tec.linutronix.de>
References: <51a4155c5bc2ca847a9cbe85c1c11918bb193141.1564086017.git.jpoimboe@redhat.com> <alpine.DEB.2.21.1907252355150.1791@nanos.tec.linutronix.de> <156416793450.30723.5556760526480191131@skylake-alporthouse-com> <alpine.DEB.2.21.1907262116530.1791@nanos.tec.linutronix.de>
 <156416944205.21451.12269136304831943624@skylake-alporthouse-com> <CA+icZUXwBFS-6e+Qp4e3PhnRzEHvwdzWtS6OfVsgy85R5YNGOg@mail.gmail.com> <CA+icZUWA6e0Zsio6sthRUC=Ehb2-mw_9U76UnvwGc_tOnOqt7w@mail.gmail.com> <20190806125931.oqeqateyzqikusku@treble>
 <CAKwvOd=wa-XPCpoLQoQJH8Me7S=fXLfog0XsiKyFZKu8ojW_UQ@mail.gmail.com> <alpine.DEB.2.21.1908082221150.2882@nanos.tec.linutronix.de> <CAKwvOdkTD-0inuEKLTsH_tKXzXjvzwnUDwYZ++-hOUrC_FU=sw@mail.gmail.com>
 <CA+icZUWgE5NTEa9Q0jof0Hv52tZM8-869Daww7dueaaMMXt+7A@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Aug 2019, Sedat Dilek wrote:
> On Fri, Aug 9, 2019 at 1:03 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Thu, Aug 8, 2019 at 1:22 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > tglx just picked up 2 other patches of mine, bumping just in case he's
> > > > not picking up patches while on vacation. ;)
> > >
> > > I'm only half on vacation :)
> > >
> > > So I can pick it up.
> >
> > Thanks, will send half margaritas.
> >
> 
> Sends some Turkish Cay.

One day, I'm going to collect all the things people promised to send or buy
me in the past 15 years. That's going to be a really huge party :)
