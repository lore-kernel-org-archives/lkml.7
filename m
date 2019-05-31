Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFDEC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B6526F1A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559336721;
	bh=OyWxQmoLlrjhQfe/SkU8EcjxzVmOe+TJQ64dkJFwohQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=WBj+D3pjoMkAfvo4rBt76FUbXZ5dBjLQ6aLMMC5HOP+62SydW2H0+2Cotd4U09rUu
	 XmTpGOlFzgAxzSIRCv7MKCJ0iV/N9VMKuYMtBsKYWGZ3uXvUXXf0gcv1PQiZIPo68B
	 /dZO9AfMuTDKzXQm1ukPgONI2QZp26yVYOZL3gsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfEaVFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 17:05:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfEaVFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 17:05:20 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 789C626F19;
        Fri, 31 May 2019 21:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559336719;
        bh=OyWxQmoLlrjhQfe/SkU8EcjxzVmOe+TJQ64dkJFwohQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=uy0cmpr3YnluHIkHBo3T/eYDLuvYIPVSKhiS0TBXkG0koQ5q9dk+z1M7besKyVPUC
         U6//gQMMXscBrTrlCsf5NIf/pPb0Q0zxX8dxKs5mWpeR/lUC1bjWM6AM5fgGxvaKKc
         elmm/Jdub7AY3qwyP8u3HGkTgS/QVbC97xLtxJus=
Date:   Fri, 31 May 2019 23:05:15 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
In-Reply-To: <CALCETrUQzZTRnvmOS09UvRM9UCGEDvSdbJtkeeEa2foMf+hF2w@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1905312251350.1962@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm> <20190531051456.fzkvn62qlkf6wqra@treble> <nycvar.YFH.7.76.1905311045240.1962@cbobk.fhfr.pm> <5564116.e9OFvgDRbB@kreacher> <CALCETrUpseta+NrhVwzzVFTe-BkBHtDUJBO22ci3mAsVR+XOog@mail.gmail.com>
 <nycvar.YFH.7.76.1905311628330.1962@cbobk.fhfr.pm> <B7AC83ED-3F11-42B9-8506-C842A5937B50@amacapital.net> <nycvar.YFH.7.76.1905311651450.1962@cbobk.fhfr.pm> <CALCETrUQzZTRnvmOS09UvRM9UCGEDvSdbJtkeeEa2foMf+hF2w@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 May 2019, Andy Lutomirski wrote:

> The Intel SDM Vol 3 34.10 says:
> 
> If the HLT instruction is restarted, the processor will generate a
> memory access to fetch the HLT instruction (if it is
> not in the internal cache), and execute a HLT bus transaction. This
> behavior results in multiple HLT bus transactions
> for the same HLT instruction.

Which basically means that both hibernation and kexec have been broken in 
this respect for gazillions of years, and seems like noone noticed. Makes 
one wonder what the reason for that might be.

Either SDM is not precise and the refetch actually never happens for real 
(or is always in these cases satisfied from I$ perhaps?), or ... ?

So my patch basically puts things back where they have been for ages 
(while mwait is obviously much worse, as that gets woken up by the write 
to the monitored address, which inevitably does happen during resume), but 
seems like SDM is suggesting that we've been in a grey zone wrt RSM at 
least for all those ages.

So perhaps we really should ditch resume_play_dead() altogether 
eventually, and replace it with sending INIT IPI around instead (and then 
waking the CPUs properly via INIT INIT START). I'd still like to do that 
for 5.3 though, as that'd be slightly bigger surgery, and conservatively 
put things basically back to state they have been up to now for 5.2.

Thanks,

-- 
Jiri Kosina
SUSE Labs

