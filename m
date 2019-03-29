Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D810DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACEC2218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbfC2Rkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:40:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729842AbfC2Rkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 13:40:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36DB521871;
        Fri, 29 Mar 2019 17:40:47 +0000 (UTC)
Date:   Fri, 29 Mar 2019 13:40:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Roland McGrath <roland@hack.frob.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [RFC][PATCH 0/4 v2] sycalls: Remove args i and n from
 syscall_get_arguments()
Message-ID: <20190329134045.3fb2e69f@gandalf.local.home>
In-Reply-To: <CAHk-=whtDB2HiEgyKcJPN7m8c83GrY=hQ=p-m-um1N6eSqxczg@mail.gmail.com>
References: <20190328230512.486297455@goodmis.org>
        <CAHk-=whtDB2HiEgyKcJPN7m8c83GrY=hQ=p-m-um1N6eSqxczg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2019 10:24:58 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> The whole series looks fine to me.

Great! I may just send a pull request to you, after some fixes (see
below).

> 
> I still suspect that we should just remove the syscall_set_arguments()
> thing entirely, but even without that, the cleanup of the calling
> convention is at least an improvement.

I'll keep it around for now, but this should go as a warning to Dmitry,
to get something using it soon, or they may be dropped.

Also, Dmitry found a few bugs with the current
syscall_set/get_arguments() on some of the archs (riscv and csky). Which
I'll add at the front of this series and update my changes to keep the
same logic.

Then I'll post a non RFC version.

-- Steve
