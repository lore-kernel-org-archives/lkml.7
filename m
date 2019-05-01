Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AC4C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F3B2053B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556739217;
	bh=BNe8Z3wFeWB5CKjbFI6Cj/w/lrCFZr0sTHpfLA4jSpo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=uyGh71z4C3Q/nT8HwNBAigpNaKuCatEYsAUOoMI7hRfAodZYcvfzJLk5PSIgsb2S5
	 8/Kq8LDJgIKyj9rQcXRCzo84Y6nUVd2vzAcrEZG+iCyG6wcf1GIoINT43MxASzPw4y
	 y7UOrKk8pioZpbV0Ss3HvMNUMwHxNJlTcWNOxY4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfEATdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 15:33:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfEATdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 15:33:36 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F258B20866;
        Wed,  1 May 2019 19:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556739215;
        bh=BNe8Z3wFeWB5CKjbFI6Cj/w/lrCFZr0sTHpfLA4jSpo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=mT2RvnVM5A7+Dhk0OVEHuwbrtVXLMyKKKGUohSRtB1363e9b1sk729M/eOl57Ho8L
         vYC9pTXAUkTl1A0yV91lcV2cE5QHb3kQ714RzZDf9tfE5QScVcHLv9l4QuNyX6GY7W
         h7MtGN4uCKEEOg7HEDtDMY8NoD3I/kdFAQvZbibw=
Date:   Wed, 1 May 2019 21:33:28 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joerg Roedel <jroedel@suse.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC][PATCH] ftrace/x86: Emulate call function while updating
 in breakpoint handler
In-Reply-To: <20190501151330.023cc620@gandalf.local.home>
Message-ID: <nycvar.YFH.7.76.1905012132100.9803@cbobk.fhfr.pm>
References: <CAHk-=whay7eN6+2gZjY-ybRbkbcqAmgrLwwszzHx8ws3c=S-MA@mail.gmail.com> <CALCETrXzVU0Q7u1q=QFPaDr=aojjF5cjbOi9CxxXnp5GqTqsWA@mail.gmail.com> <CAHk-=wg1QPz0m+7jnVcjQgkySUQLzAXE8_PZARV-vWYK27LB=w@mail.gmail.com> <20190430135602.GD2589@hirez.programming.kicks-ass.net>
 <CAHk-=wg7vUGMRHyBsLig6qiPK0i4_BK3bRrTN+HHHziUGg1P_A@mail.gmail.com> <CALCETrXujRWxwkgAwB+8xja3N9H22t52AYBYM_mbrjKKZ624Eg@mail.gmail.com> <20190430130359.330e895b@gandalf.local.home> <20190430132024.0f03f5b8@gandalf.local.home> <20190430134913.4e29ce72@gandalf.local.home>
 <CAHk-=wjJ8D74+FDcXGL65Q9aB0cc7B4vr2s2rS6V4d4a3hU-1Q@mail.gmail.com> <20190501131117.GW2623@hirez.programming.kicks-ass.net> <CAHk-=wjCoycqdVjvWkkFnVRQS9fHEzdmiAG4uUV8B04xv7ZVwA@mail.gmail.com> <20190501151330.023cc620@gandalf.local.home>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 May 2019, Steven Rostedt wrote:

> I never tested the 32 bit version of this. And we could just not
> implement it (I don't think there's live kernel patching for it
> either).

That's correct, there is no livepatching on x86_32 (and no plans for 
it). CONFIG_LIVEPATCH is not available for 32bit builds at all.

-- 
Jiri Kosina
SUSE Labs

