Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9752C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 13:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6D420B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 13:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbfFGNg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 09:36:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727606AbfFGNg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:36:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7EAF430C0DF4;
        Fri,  7 Jun 2019 13:36:25 +0000 (UTC)
Received: from treble (ovpn-124-241.rdu2.redhat.com [10.10.124.241])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 245B15C46C;
        Fri,  7 Jun 2019 13:36:05 +0000 (UTC)
Date:   Fri, 7 Jun 2019 09:36:02 -0400
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 03/15] x86/kprobes: Fix frame pointer annotations
Message-ID: <20190607133602.os7st57epo3otbc4@treble>
References: <20190605130753.327195108@infradead.org>
 <20190605131944.711054227@infradead.org>
 <20190607220210.328ed88f2f7598e757c3564f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190607220210.328ed88f2f7598e757c3564f@kernel.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 07 Jun 2019 13:36:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 10:02:10PM +0900, Masami Hiramatsu wrote:
> On Wed, 05 Jun 2019 15:07:56 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > The kprobe trampolines have a FRAME_POINTER annotation that makes no
> > sense. It marks the frame in the middle of pt_regs, at the place of
> > saving BP.
> 
> commit ee213fc72fd67 introduced this code, and this is for unwinder which
> uses frame pointer. I think current code stores the address of previous
> (original context's) frame pointer into %rbp. So with that, if unwinder
> tries to decode frame pointer, it can get the original %rbp value,
> instead of &pt_regs from current %rbp.
> 
> > 
> > Change it to mark the pt_regs frame as per the ENCODE_FRAME_POINTER
> > from the respective entry_*.S.
> > 
> 
> With this change, I think stack unwinder can not get the original %rbp
> value. Peter, could you check the above commit?

The unwinder knows how to decode the encoded frame pointer.  So it can
find regs by decoding the new rbp value, and it also knows that regs->bp
is the original rbp value.

Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
