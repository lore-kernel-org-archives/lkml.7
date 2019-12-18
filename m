Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4557C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 10:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEED227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 10:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfLRKf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 05:35:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:36810 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfLRKf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 05:35:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5FF2BAD05;
        Wed, 18 Dec 2019 10:35:27 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Kees Cook <keescook@chromium.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bin Meng <bmeng.cn@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: reject invalid syscalls below -1
References: <20191218084757.904971-1-david.abdurachmanov@sifive.com>
        <mvmo8w63r1d.fsf@suse.de>
        <CAEn-LTojXuAbY31nReCsbE=7Q9PkuKexAttTc+35ZFn7SLG-_w@mail.gmail.com>
X-Yow:  I was in EXCRUCIATING PAIN until I started reading JACK AND JILL
 Magazine!!
Date:   Wed, 18 Dec 2019 11:35:26 +0100
In-Reply-To: <CAEn-LTojXuAbY31nReCsbE=7Q9PkuKexAttTc+35ZFn7SLG-_w@mail.gmail.com>
        (David Abdurachmanov's message of "Wed, 18 Dec 2019 12:06:57 +0200")
Message-ID: <mvmk16t53bl.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dez 18 2019, David Abdurachmanov wrote:

> On Wed, Dec 18, 2019 at 11:46 AM Andreas Schwab <schwab@suse.de> wrote:
>>
>> On Dez 18 2019, David Abdurachmanov wrote:
>>
>> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>> > index a1349ca64669..e163b7b64c86 100644
>> > --- a/arch/riscv/kernel/entry.S
>> > +++ b/arch/riscv/kernel/entry.S
>> > @@ -246,6 +246,7 @@ check_syscall_nr:
>> >        */
>> >       li t1, -1
>> >       beq a7, t1, ret_from_syscall_rejected
>> > +     blt a7, t1, 1f
>>
>> How about using bgeu instead in the preceding check?
>
> The syscall number could be -1 if tracer rejected it.

So check for -1 first, then for out-of-range?

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
