Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1375C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B000C2070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbfCZQKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:10:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48716 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfCZQKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:10:09 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8oe0-0000hx-LX; Tue, 26 Mar 2019 17:09:44 +0100
Date:   Tue, 26 Mar 2019 17:09:44 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Oleg Nesterov <oleg@redhat.com>
cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2] x86/syscalls: Mark expected switch fall-throughs
In-Reply-To: <20190326151244.GC16837@redhat.com>
Message-ID: <alpine.DEB.2.21.1903261706230.1789@nanos.tec.linutronix.de>
References: <20190228192746.GA13021@embeddedor> <alpine.DEB.2.21.1903231457590.1798@nanos.tec.linutronix.de> <20190326151244.GC16837@redhat.com>
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

On Tue, 26 Mar 2019, Oleg Nesterov wrote:
> On 03/23, Thomas Gleixner wrote:
> >
> > On Thu, 28 Feb 2019, Gustavo A. R. Silva wrote:
> > 
> > >  arch/x86/include/asm/syscall.h | 28 ++++++++++++++++++++++++++++
> > >  1 file changed, 28 insertions(+)
> > 
> > Second thoughts. So this adds 28 /* fall through */ comments. Now I
> > appreciate the effort, but can we pretty please look at the code in
> > question and figure out whether the implementation makes sense in the first
> > place before adding falltrough comments blindly?
> > 
> > The whole exercise can be simplified. Untested patch below.
> > 
> > Looking at that stuff makes me wonder about two things:
> > 
> >  1) The third argument of get/set(), i.e. the argument offset, is 0 on all
> >     call sites. Do we need it at all?
> 
> Probably "maxargs" can be removed too, Steven sent the patches a long ago, see
> https://lore.kernel.org/lkml/20161107212634.529267342@goodmis.org/

Indeed. We should resurrect them.

> >  2) syscall_set_arguments() has been introduced in 2008 and we still have
> >     no caller. Instead of polishing it, can it be removed completely or are
> >     there plans to actually use it?
> 
> I think it can die.

Good. Removed code is the least buggy code :)

Gustavo, it would be really appreciated if you could take care of that,
unless Steven wants to polish his old set up himself. If you have no
cycles, please let us know.

Thanks,

	tglx

