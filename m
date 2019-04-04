Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFA4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F2D20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfDDO07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:26:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbfDDO05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:26:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95E882171F;
        Thu,  4 Apr 2019 14:26:54 +0000 (UTC)
Date:   Thu, 4 Apr 2019 10:26:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Roland McGrath <roland@hack.frob.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Drewry <wad@chromium.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 3/6 v3] riscv: Fix syscall_get_arguments() and
 syscall_set_arguments()
Message-ID: <20190404102653.705456df@gandalf.local.home>
In-Reply-To: <20190404140210.GC4962@altlinux.org>
References: <20190401134104.676620247@goodmis.org>
        <20190401134420.958530155@goodmis.org>
        <20190404140210.GC4962@altlinux.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2019 17:02:10 +0300
"Dmitry V. Levin" <ldv@altlinux.org> wrote:

> On Mon, Apr 01, 2019 at 09:41:07AM -0400, Steven Rostedt wrote:
> > From: "Dmitry V. Levin" <ldv@altlinux.org>
> > 
> > RISC-V syscall arguments are located in orig_a0,a1..a5 fields
> > of struct pt_regs.
> > 
> > Due to an off-by-one bug and a bug in pointer arithmetic
> > syscall_get_arguments() was reading s3..s7 fields instead of a1..a5.
> > Likewise, syscall_set_arguments() was writing s3..s7 fields
> > instead of a1..a5.
> > 
> > Link: http://lkml.kernel.org/r/20190329171221.GA32456@altlinux.org
> > 
> > Fixes: e2c0cdfba7f69 ("RISC-V: User-facing API")
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Andy Lutomirski <luto@amacapital.net>
> > Cc: Will Drewry <wad@chromium.org>
> > Cc: Palmer Dabbelt <palmer@sifive.com>
> > Cc: Albert Ou <aou@eecs.berkeley.edu>
> > Cc: linux-riscv@lists.infradead.org
> > Cc: stable@vger.kernel.org # v4.15+
> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>  
> 
> According to
> https://lore.kernel.org/lkml/mhng-8e9b547b-7fe3-43d2-9dea-b217de923605@palmer-si-x1c4/
> the following tag could be added to this patch:
>  
> Acked-by: Palmer Dabbelt <palmer@sifive.com>

That link isn't actually an ack. Palmer, you OK if I add it?

-- Steve

