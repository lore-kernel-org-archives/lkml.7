Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D0EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0642084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfDCUxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:53:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfDCUxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:53:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6179E356F6;
        Wed,  3 Apr 2019 20:53:08 +0000 (UTC)
Received: from treble (ovpn-120-12.rdu2.redhat.com [10.10.120.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 517AC19C68;
        Wed,  3 Apr 2019 20:53:07 +0000 (UTC)
Date:   Wed, 3 Apr 2019 15:53:05 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Apr 3 (objtool)
Message-ID: <20190403205305.tqqwttjytunzgtub@treble>
References: <20190403192407.13a99513@canb.auug.org.au>
 <d37e0909-cacc-7c6c-4376-33891fa69f53@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d37e0909-cacc-7c6c-4376-33891fa69f53@infradead.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 03 Apr 2019 20:53:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 08:02:43AM -0700, Randy Dunlap wrote:
> On 4/3/19 1:24 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20190402:
> > 
> 
> on x86_64:
> 
> arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x909: unreachable instruction

Your .o file looks odd.  I can't recreate the issue when I build the
same object.

Did the issue only just now show up?  Can you bisect it?  What version
of binutils are you using?

Here's the disassembly:

------------------
     903:	e8 00 00 00 00       	callq  908 <interrupt_entry+0xc8>
			904: R_X86_64_PC32	trace_hardirqs_off_thunk-0x4
     908:	c3                   	retq   
     909:	eb 75                	jmp    980 <common_interrupt>
     90b:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
     912:	00 00 00 00 
     916:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
     91d:	00 00 00 00 
     921:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
     928:	00 00 00 00 
     92c:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
     933:	00 00 00 00 
     937:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
     93e:	00 00 00 00 
     942:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
     949:	00 00 00 00 
     94d:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
     954:	00 00 00 00 
     958:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
     95f:	00 00 00 00 
     963:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
     96a:	00 00 00 00 
     96e:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
     975:	00 00 00 00 
     979:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000000980 <common_interrupt>:
------------------

Where the heck does that "jmp 980" come from?  I don't see it in the
code:

------------------
ENTRY(interrupt_entry)
	....
	TRACE_IRQS_OFF

	ret
END(interrupt_entry)
_ASM_NOKPROBE(interrupt_entry)


/* Interrupt entry/exit. */

	/*
	 * The interrupt stubs push (~vector+0x80) onto the stack and
	 * then jump to common_interrupt.
	 */
	.p2align CONFIG_X86_L1_CACHE_SHIFT
common_interrupt:
------------------

Hopefully gas isn't inserting stray jumps for code alignments...

-- 
Josh
