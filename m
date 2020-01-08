Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7654C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AD420692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbgAHIzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:55:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48877 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgAHIzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:55:46 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ip77k-0001qD-45; Wed, 08 Jan 2020 09:55:32 +0100
Date:   Wed, 8 Jan 2020 09:55:32 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+f2ca20d4aa1408b0385a@syzkaller.appspotmail.com>,
        alexander.deucher@amd.com, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, nicholas.kazlauskas@amd.com,
        Rik van Riel <riel@surriel.com>, sunpeng.li@amd.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>, zhan.liu@amd.com
Subject: Re: WARNING in switch_fpu_return
Message-ID: <20200108085532.37ycr24gryqhkkto@linutronix.de>
References: <000000000000f04e43059b1ee697@google.com>
 <20200107205302.45yb2rkekz3nat6v@linutronix.de>
 <CACT4Y+ax6URhDKBREy6XLx=nKFLGSmt87Z-oU3E1D8SAJwBcrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+ax6URhDKBREy6XLx=nKFLGSmt87Z-oU3E1D8SAJwBcrg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 2020-01-08 05:28:31 [+0100], Dmitry Vyukov wrote:
> > > userspace arch: i386
> >
> > So I tried to reproduce this. syz-prog2c made .c out of the above link.
> > It starts with:
> > |int main(void)
> > | {
> > |   syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 3ul, 0x32ul, -1, 0);
> 
> Hi Sebastian,
> 
> If you want to generate a C repro for 386 arch, you need to add
> -arch=386 flag to syz-prog2c (then it hopefully should use mmap2).

Ah okay. I've been looking at
	https://github.com/google/syzkaller/blob/master/docs/syzbot.md#crash-does-not-reproduce

and it says
|Note: if the report contains userspace arch: i386, then the program
|needs to be built with -m32 flag.

and with the argument you mentioned it the compiled C code uses mmap2.
Thanks.
Now the 32bit testcase reboots, too :)

> But FWIW syzbot wasn't able to reproduce it with a C program,
> otherwise it would have been provided it. But that may be for various
> reasons.

Yeah, my memory was also that a C-testcase is provided. But there was this
	https://syzkaller.appspot.com/x/repro.syz?x=10cc8971e00000

link so I assumed I should use it myself and I missed the update that
something changed.
So what should I do with the file above? Feed it to `syz-execprog' or is
it a rough idea what the test case should have done?

Sebastian
