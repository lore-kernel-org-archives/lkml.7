Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481E7C04A6B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 01:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154FF206BF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 01:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557193308;
	bh=9D/5jhhY/r7hbe/Nd5GrK0RWuyDt4WTTNPwLtCd3DiU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LxcE4SuQN8EO3Qm4cNOs6xvJWYe9pZkWsBeCIrfWf03r6ELb0J3AbRBlgrZ8/MCJK
	 r1eKs9YaGiHMx5JIv3iHgwCNRM9tEFHR/SX3Nf/FzofMeyTogbHrxu2dltKle+Y+d/
	 gl96yy9fDnV08WtcYDayBMfpDEvDglxfEmwr/zFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfEGBlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 21:41:46 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45067 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGBlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 21:41:46 -0400
Received: by mail-lf1-f65.google.com with SMTP id n22so3006044lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 18:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6H70OYCWqWNzJ1zGHNlYsHEsCgxXv8c0o/4c1a8H4TM=;
        b=dpFgNSCaKcwRzOTxc2CRA45EB/B/5baFN6H/ywJJjn2iC4DVw0z3j37EPur3kF2BcM
         gR5dH5TJcCt0L08AcgiCY39z5fIt5og+cl6z+Q6Orik7/B2A+FvQSQtx6uaVPo9r5nWT
         BpDf9SS2XWqZ2zgNFN0ahQyv31mOBnC8Onm0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6H70OYCWqWNzJ1zGHNlYsHEsCgxXv8c0o/4c1a8H4TM=;
        b=Bx0TeM1O007mDlnOZU6ybzIZqIl2NVIk7TzlqDpEFH68/kbU7KnV2cblXPlZBDm0ZV
         gT+b3Fe7jwC6PP+4QXHhikpbuPEbfuTZ0/JBQD8U5aUe4+G85H1YcpTu1/p12faPwPGl
         VkoaEtm2GaUUwXH4q/vxJfLT0E1oDjrzVcQF3MBRc0YxIUaUFYoCbdFyjY54LjRGucVo
         NtRYL0Tlc6sISXYvhQF9mBT5In+VB05AJL+/GshJFloeskka3qb+U0PX8bXJrNILFtuh
         gN0DlhGIN9hvpVjNbF5UZYYRbYiXGp4ztqetD4d+a1+EgAQQW0GF8qpVuBjT2WLh7tN2
         ifKQ==
X-Gm-Message-State: APjAAAX9I2A8PmOpPcECyBb6DQjTdJtwJ3eero4ErIOFD7lfUnaQmoqZ
        2v4idOp50KFTMF5pUP6aon3pcxI2esY=
X-Google-Smtp-Source: APXvYqx0j6cT0FfjvePJ9DnIx9dKW3IP2T//lW6PmYrVypQbAGyhkccCAnpiddOIt+OBpv74l6X6iw==
X-Received: by 2002:a19:97c8:: with SMTP id z191mr14340744lfd.167.1557193304273;
        Mon, 06 May 2019 18:41:44 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id p18sm3199628ljc.54.2019.05.06.18.41.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 18:41:44 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id n134so8716011lfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 18:41:43 -0700 (PDT)
X-Received: by 2002:a19:2952:: with SMTP id p79mr5995097lfp.166.1557192915891;
 Mon, 06 May 2019 18:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190502181811.GY2623@hirez.programming.kicks-ass.net>
 <20190502195052.0af473cf@gandalf.local.home> <20190503092959.GB2623@hirez.programming.kicks-ass.net>
 <20190503092247.20cc1ff0@gandalf.local.home> <2045370D-38D8-406C-9E94-C1D483E232C9@amacapital.net>
 <CAHk-=wjrOLqBG1qe9C3T=fLN0m=78FgNOGOEL22gU=+Pw6Mu9Q@mail.gmail.com>
 <20190506081951.GJ2606@hirez.programming.kicks-ass.net> <20190506095631.6f71ad7c@gandalf.local.home>
 <CAHk-=wgw_Jmn1iJWanoSFb1QZn3mbTD_JEoMsWcWj5QPeyHZHA@mail.gmail.com>
 <20190506130643.62c35eeb@gandalf.local.home> <CAHk-=whesas+GDtHZks62wqXWXe4d_g3XJ359GX81qj=Fgs6qQ@mail.gmail.com>
 <20190506145745.17c59596@gandalf.local.home> <CAHk-=witfFBW2O5v6g--FmqnAFsMkKNLosTFfWyaoJ7euQF8kQ@mail.gmail.com>
 <20190506162915.380993f9@gandalf.local.home> <CAHk-=wi5KBWUOvM94aTOPnoJ5L_aQG=vgLQ4SxxZDeQD0pF2tQ@mail.gmail.com>
 <20190506174511.2f8b696b@gandalf.local.home> <CAHk-=wj3R_s0RTJOmTBNaUPhu4fz2shNBUr4M6Ej65UYSNCs-g@mail.gmail.com>
 <20190506210416.2489a659@oasis.local.home>
In-Reply-To: <20190506210416.2489a659@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 18:34:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZwqzbu-=1r_j_cXfd=ta1q7RFCuneqBZfQQhS_P-BmQ@mail.gmail.com>
Message-ID: <CAHk-=whZwqzbu-=1r_j_cXfd=ta1q7RFCuneqBZfQQhS_P-BmQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] x86: Allow breakpoints to emulate call functions
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, stable <stable@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 6:04 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> That iterator does something special for each individual record. All
> 40,000 of them.

.. yes, but the 'int3' only happens for *one* of them at a time.

Why would it bother with the other 39,999 calls?

You could easily just look up the record at the int3 time, and just
use the record. Exactly the same way you use the one-at-a-time ones.

Instead, you emulate a fake call to a function that *wouldn't* get
called, which now does the lookup there. That's the part I don't get.
Why are you emulating something else than what you'd be rewriting?

             Linus
