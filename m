Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C4EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E752184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbfC2UcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:32:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:32924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729996AbfC2UcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:32:11 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99A97218AC;
        Fri, 29 Mar 2019 20:32:09 +0000 (UTC)
Date:   Fri, 29 Mar 2019 16:32:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Will Drewry <wad@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@redhat.com>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv: fix syscall_get_arguments() and
 syscall_set_arguments()
Message-ID: <20190329163208.73f6d9fa@gandalf.local.home>
In-Reply-To: <20190329181109.GA32651@altlinux.org>
References: <20190329171221.GA32456@altlinux.org>
        <20190329131514.3e4ec93e@gandalf.local.home>
        <CAEn-LTpY6Tto1N9irXJeOb4iB=qSYhb=jM0E=Z9ppumbPX6GSw@mail.gmail.com>
        <20190329135635.7e136350@gandalf.local.home>
        <20190329181109.GA32651@altlinux.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2019 21:11:09 +0300
"Dmitry V. Levin" <ldv@altlinux.org> wrote:

> On Fri, Mar 29, 2019 at 01:56:35PM -0400, Steven Rostedt wrote:
> > On Fri, 29 Mar 2019 18:52:18 +0100
> > David Abdurachmanov <david.abdurachmanov@gmail.com> wrote:
> >   
> > > I have alternative version posted in December part of SECCOMP
> > > patchset which is based on arm64 implementation.
> > > 
> > > http://lists.infradead.org/pipermail/linux-riscv/2018-December/002450.html
> > > 
> > > I noticed that SECCOMP wasn't working properly if filters were
> > > checking syscall arguments, because populated arguments were wrong.
> > > 
> > > Btw, I plan to send v2 of SECCOMP patchset soonish.  
> > 
> > Please do. I want to get my patch series out, which will require these
> > changes.  
> 
> Sorry, I haven't seen the alternative patch posted by David before.
> Apparently, besides fixing the bug it also introduces new sanity checks
> of "i" and "n" arguments in syscall_get_arguments() and
> syscall_set_arguments().
> 
> Given that your patchset removes these arguments completely,
> I see little sense in adding new checks that are going to be removed
> by the subsequent commit in the series.

I agree. I'm going to pull in Dmitry's patches as my patches are going
to rewrite most the code anyway, and no need for the extra churn of the
sanity checks that are going to become irrelevant immediately afterward.

-- Steve
