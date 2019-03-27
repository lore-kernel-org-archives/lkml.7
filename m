Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3423C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C224B2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbfC0XPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfC0XPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:15:08 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66FB12075C;
        Wed, 27 Mar 2019 23:15:06 +0000 (UTC)
Date:   Wed, 27 Mar 2019 19:15:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2] x86/syscalls: Mark expected switch fall-throughs
Message-ID: <20190327191504.673d1a6a@gandalf.local.home>
In-Reply-To: <20190327231215.GA815@altlinux.org>
References: <20190228192746.GA13021@embeddedor>
        <alpine.DEB.2.21.1903231457590.1798@nanos.tec.linutronix.de>
        <20190326151244.GC16837@redhat.com>
        <20190327012606.GA16532@altlinux.org>
        <alpine.DEB.2.21.1903271527110.1789@nanos.tec.linutronix.de>
        <20190327222014.GA32540@altlinux.org>
        <alpine.DEB.2.21.1903272351110.1789@nanos.tec.linutronix.de>
        <20190327231215.GA815@altlinux.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019 02:12:15 +0300
"Dmitry V. Levin" <ldv@altlinux.org> wrote:

> > Seriously. If we keep it can we at least remove all the unused arguments
> > which we have on both functions to simplify the whole mess?  
> 
> In case of syscall_set_arguments() I think we can safely remove
> "i" and "n" arguments assuming i == 0 and n == 6.
> 
> All I can say about syscall_get_arguments() is that
> - all current users invoke it with i == 0,
> - all current users that invoke it with n != 6 are in kernel/trace/trace_syscalls.c
> so it may actually be invoked with n < 6.

Yes, that's what my old (and current) patches address. I removed the
i,n parameters and make it 0,6 hardcoded in the routines.

Patches will be out soon.

-- Steve
