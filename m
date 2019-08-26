Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05336C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B20217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732086AbfHZNso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 09:48:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40178 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfHZNsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 09:48:43 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i2FML-0004bC-7H; Mon, 26 Aug 2019 15:48:37 +0200
Date:   Mon, 26 Aug 2019 15:48:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@amacapital.net>
cc:     Sebastian Mayr <me@sam.st>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] uprobes/x86: fix detection of 32-bit user mode
In-Reply-To: <alpine.DEB.2.21.1908240218460.1939@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1908261548070.1939@nanos.tec.linutronix.de>
References: <20190728152617.7308-1-me@sam.st> <alpine.DEB.2.21.1908232343470.1939@nanos.tec.linutronix.de> <alpine.DEB.2.21.1908240142000.1939@nanos.tec.linutronix.de> <32D5D6B1-B29E-426E-90B6-48565A3B8F3B@amacapital.net> <alpine.DEB.2.21.1908240200070.1939@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1908240202220.1939@nanos.tec.linutronix.de> <DE4AECCC-AFBE-4DA7-A229-B6B870E06B1D@amacapital.net> <alpine.DEB.2.21.1908240218460.1939@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-25970487-1566827317=:1939"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-25970487-1566827317=:1939
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Sat, 24 Aug 2019, Thomas Gleixner wrote:
> On Fri, 23 Aug 2019, Andy Lutomirski wrote:
> > > On Aug 23, 2019, at 5:03 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > > 
> > >> On Sat, 24 Aug 2019, Thomas Gleixner wrote:
> > >> On Fri, 23 Aug 2019, Andy Lutomirski wrote:
> > >>>> On Aug 23, 2019, at 4:44 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > >>>> 
> > >>>>>> On Sat, 24 Aug 2019, Thomas Gleixner wrote:
> > >>>>>> On Sun, 28 Jul 2019, Sebastian Mayr wrote:
> > >>>>>> 
> > >>>>>> -static inline int sizeof_long(void)
> > >>>>>> +static inline int sizeof_long(struct pt_regs *regs)
> > >>>>>> {
> > >>>>>> -    return in_ia32_syscall() ? 4 : 8;
> > >>>>> 
> > >>>>> This wants a comment.
> > >>>>> 
> > >>>>>> +    return user_64bit_mode(regs) ? 8 : 4;
> > >>>> 
> > >>>> The more simpler one liner is to check
> > >>>> 
> > >>>>   test_thread_flag(TIF_IA32)
> > >>> 
> > >>> I still want to finish killing TIF_IA32 some day.  Let’s please not add new users.
> > >> 
> > >> Well, yes and no. This needs to be backported ....
> > > 
> > > And TBH the magic in user_64bit_mode() is not pretty either.
> > > 
> > It’s only magic on Xen. I should probably stick a
> > cpu_feature_enabled(X86_FEATURE_XENPV) in there instead.
> 
> For backporting sake I really prefer the TIF version. One usage site more
> is not the end of the world. We can add the user_64bit_mode() variant from
> Sebastian on top as a cleanup right away so mainline is clean.

Bah, scratch it. I take the proper one right away.

--8323329-25970487-1566827317=:1939--
