Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC35C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA412089E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556739756;
	bh=18P3VDsac7ephJ0O6xUfbsPNFCrO/cTvK/Pjp054eDY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iGnrMqDWgzQZa2DDFq/qdRnpkFU9T+9jJrPtLQBa2U//T7DOGwt95Q67Ohx4TcF95
	 a3Q85Oe2C0vltpT3XmjrOsF0mHSB3aEHO6s7simC4J25W1mBBL4gZtkWIlJwhAE7L3
	 qG6e8ZlBPSIzxyKLE7pRM18XXkyvwIdUaBzjulME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfEATmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 15:42:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36818 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfEATme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 15:42:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id y8so92979ljd.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 12:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1aWTopvtcpE1sMBLog+svv/V7Oyc8azAzAFUDC8QSPA=;
        b=g5Olcm90ZhHiM7hLghWqEsHCmJOQJKveCq93FgS32/SOMLiESIU19RmapyE9Ee9EYf
         ViBeexnj6bwofQ4qsmRyD1ujInNeMtVrrzEmNmw9ZRifskM7p87DSr1orgBEPN8GpwJA
         AtMCjbwPS+2qzsxmpJz+Cd9TiwHXhMCbJ9VGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1aWTopvtcpE1sMBLog+svv/V7Oyc8azAzAFUDC8QSPA=;
        b=g3ciL8KCJoHJ4kryt9gYxYG59QyIMtGqm7p1yunVUx5Txkns1wAjYeJRAmy3heljJj
         v2nRV/2fqj+hm1ArJRsG1b378nqP2+9YLQEVJ+M0DC3EfpT7ubLq5KZO7aRo4a8Gbc+0
         WOLecYgIUZ3UZjn5KDKEZR4pN/0Byad2UtqtxSRzuj0MMXA6UhysXF2Oz080c6S2mBgZ
         syaXOvWQqAzsxNNAR39eab47u+TqZut0mLqlOccYs/B5tKo+mNPMgkm/hv2PsVYbOECj
         yMu8qGlKfcUP0ePJO6L39bDx4Axi25t9jFpgIOH6A8JDywFuAwHpuGgwF2nSkWJfeedb
         7hTg==
X-Gm-Message-State: APjAAAVggbkq/aaBQEdfSaKB+VWnSs7UNtl/76guqP0umcXsPxD87d4e
        lvr8zhHQQUn15H4UGFK0Q+TpXru77zg=
X-Google-Smtp-Source: APXvYqw1f3Kq+k6kBpt5s8DgRzzl3a46s3nP5FryPj3GBx5K9tdoHn7Au3vrYgtzcczQay1Sqt+QUA==
X-Received: by 2002:a2e:2b16:: with SMTP id q22mr40574625lje.20.1556739752634;
        Wed, 01 May 2019 12:42:32 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id v11sm8963811lfb.68.2019.05.01.12.42.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 12:42:32 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id e18so84015lja.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 12:42:32 -0700 (PDT)
X-Received: by 2002:a05:651c:8f:: with SMTP id 15mr4971551ljq.118.1556739386764;
 Wed, 01 May 2019 12:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190501113238.0ab3f9dd@gandalf.local.home> <CAHk-=wjvQxY4DvPrJ6haPgAa6b906h=MwZXO6G8OtiTGe=N7_w@mail.gmail.com>
 <20190501145200.6c095d7f@oasis.local.home> <CAHk-=wgMZJeMCW5MA25WFJZeYYWCOWr0nGaHhJ7kg+zsu5FY_A@mail.gmail.com>
 <20190501191716.GV7905@worktop.programming.kicks-ass.net>
In-Reply-To: <20190501191716.GV7905@worktop.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 May 2019 12:36:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whWOStbe8nAxuaovrmqsq_YW-rDFu1AkpgisaWMqdMibg@mail.gmail.com>
Message-ID: <CAHk-=whWOStbe8nAxuaovrmqsq_YW-rDFu1AkpgisaWMqdMibg@mail.gmail.com>
Subject: Re: [RFC][PATCH v3] ftrace/x86_64: Emulate call function while
 updating in breakpoint handler
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 1, 2019 at 12:17 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Something like so then?

Yes, that looks correct.

We have those X86_EFLAGS_VM tests pretty randomly scattered around,
and I wish there was some cleaner model for this, but I also guess
that there's no point in worrying about the 32-bit code much.

                Linus
