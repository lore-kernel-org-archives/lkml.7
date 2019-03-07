Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4A9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A5220675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfCGVX2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:23:28 -0500
Received: from linux-libre.fsfla.org ([209.51.188.54]:38636 "EHLO
        linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfCGVX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:23:28 -0500
Received: from free.home (home.lxoliva.fsfla.org [172.31.160.164])
        by linux-libre.fsfla.org (8.15.2/8.15.2/Debian-3) with ESMTP id x27LMrbu028749;
        Thu, 7 Mar 2019 21:22:56 GMT
Received: from livre (livre.home [172.31.160.2])
        by free.home (8.15.2/8.15.2) with ESMTP id x27LME4J377376;
        Thu, 7 Mar 2019 18:22:14 -0300
From:   Alexandre Oliva <lxoliva@fsfla.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Tom Li <tomli@tomli.me>, James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] On the Current Troubles of Mainlining Loongson Platform Drivers
Organization: Free thinker, not speaking for FSF Latin America
References: <20190208083038.GA1433@localhost.localdomain>
        <orbm3i5xrn.fsf@lxoliva.fsfla.org>
        <20190211125506.GA21280@localhost.localdomain>
        <orimxq3q9j.fsf@lxoliva.fsfla.org>
        <20190211230614.GB22242@darkstar.musicnaut.iki.fi>
        <orva1jj9ht.fsf@lxoliva.fsfla.org>
        <20190217235951.GA20700@darkstar.musicnaut.iki.fi>
        <orpnrpj2rk.fsf@lxoliva.fsfla.org>
        <alpine.LFD.2.21.1902180227090.15915@eddie.linux-mips.org>
        <orlg1ryyo2.fsf@lxoliva.fsfla.org>
        <20190307202156.GB30189@darkstar.musicnaut.iki.fi>
Date:   Thu, 07 Mar 2019 18:22:14 -0300
In-Reply-To: <20190307202156.GB30189@darkstar.musicnaut.iki.fi> (Aaro
        Koskinen's message of "Thu, 7 Mar 2019 22:21:56 +0200")
Message-ID: <or1s3ixtvd.fsf@lxoliva.fsfla.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.84
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar  7, 2019, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:

> Hi,
> On Thu, Mar 07, 2019 at 03:41:01AM -0300, Alexandre Oliva wrote:
>> On Feb 17, 2019, "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
>> 
>> >  Is there an MMIO completion barrier missing there somewhere by any chance 
>> > causing an IRQ that has been handled already to be redelivered because an 
>> > MMIO write meant to clear the IRQ at its origin at handler's completion 
>> > has not reached its destination before interrupts have been reenabled in 
>> > the issuing CPU?  Just a thought.
>> 
>> I've finally got a chance to bisect the IRQ14 (nobody cared) regression
>> on my yeeloong.  It took me to MIPS: Enforce strong ordering for MMIO
>> accessors (commit 3d474dacae72ac0f28228b328cfa953b05484b7f).

> This is interesting, thanks for the research, but I'm afraid it doesn't seem
> to be the root cause.

Oh, I didn't mean to offer anything definitive, just to report the
findings of my investigation so far, since I had no clue when I'd find
another significant time slot to get back onto it.

> Could you check your /proc/interrupts counters after the boot with
> your change?

16k to 18k interrupts after booting up into multi-user mode, including
some idle time (and possibly anacron jobs) in the case that got more
interrupts.  That's not unlike what I get with 4.19.26-gnu.

-- 
Alexandre Oliva, freedom fighter   https://FSFLA.org/blogs/lxo
Be the change, be Free!         FSF Latin America board member
GNU Toolchain Engineer                Free Software Evangelist
Hay que enGNUrecerse, pero sin perder la terGNUra jamás-GNUChe
