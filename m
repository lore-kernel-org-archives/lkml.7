Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C087C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B16720859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387740AbfFJQ6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 12:58:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727648AbfFJQ6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 12:58:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C12E4307D941;
        Mon, 10 Jun 2019 16:58:04 +0000 (UTC)
Received: from treble (ovpn-121-189.rdu2.redhat.com [10.10.121.189])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28A36600CD;
        Mon, 10 Jun 2019 16:57:55 +0000 (UTC)
Date:   Mon, 10 Jun 2019 11:57:52 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 08/15] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Message-ID: <20190610165752.2feozekuqbincj3d@treble>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.005681046@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190605131945.005681046@infradead.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 10 Jun 2019 16:58:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 03:08:01PM +0200, Peter Zijlstra wrote:
> In preparation for static_call support, teach text_poke_bp() to
> emulate instructions, including CALL.
> 
> The current text_poke_bp() takes a @handler argument which is used as
> a jump target when the temporary INT3 is hit by a different CPU.
> 
> When patching CALL instructions, this doesn't work because we'd miss
> the PUSH of the return address. Instead, teach poke_int3_handler() to
> emulate an instruction, typically the instruction we're patching in.
> 
> This fits almost all text_poke_bp() users, except
> arch_unoptimize_kprobe() which restores random text, and for that site
> we have to build an explicit emulate instruction.
> 
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Nadav Amit <namit@vmware.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
