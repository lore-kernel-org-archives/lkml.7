Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2A1C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE13321906
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574250038;
	bh=wG3Ciu5bgsmyAvPFvl08x8P6WxfLqAa1C62DIomEmak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UXQR+K5ZE+Oyr5XLULtXSTfCBHFA8Rdlb1IUEKcvcbHur4MRQcSydckQpAOGgZwAu
	 1qpQsKTYWntI+cDVdl1+uCRpz3J+T8vF2EUkcJ63LbapiQBa2oux9Yb1lSsXJgnhWW
	 GZEdhfx9Y8MV4yjqfLSiOAHZXnbkUzV1gFx26v9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbfKTLkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:40:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42368 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbfKTLkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:40:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id a15so27746454wrf.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 03:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=69RZrXkuGAApUnr4iO+YhE+hxS3D9Hh/3GfnGeQJbmc=;
        b=EKkBQD69Gr4Z6m+PltZcvf2lyKMN28VnVBoTIsxuMo6oNvu54mMflXP5btNhxLkS6K
         QIJtg9f/WtVbHCy3ez5vviEOQSYed/yMcdaCaPXiso9d2ZXC7XweMCCbf+Bz6DgYV1SJ
         6Wiz0SfeYU3htABZha+ZUZQJRg5Q7HkfORy9Fwuuzsvd19VTQXdoETPgJZ3Jbm70MpKk
         lzwuJiPnfPRYNLezUmLx0Ae0Rqa+iKsfg8qtZ95WtV4j+CFUSaFcCDSy/VaQPV0IMU4T
         hp5fJGuKKOOR9xy99nLo15+PvCPV8OqBeSlUZll8N/ihBIoxqAZMJxSgdq1M806MytiT
         u8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=69RZrXkuGAApUnr4iO+YhE+hxS3D9Hh/3GfnGeQJbmc=;
        b=S8pZPbSWf0Kk8g2PcfxREcDLgTDx1Hvh+9WMGbTHfcAIqhwKVzkA/zMCom2bIehyJa
         Km7jY7y9ZfmS34m3ViaR3CgavwI//72GrLYgEpZMHhrQDxIK7+E+Kx1xiAWTi04zOxw7
         3D2W4IzEWI9M11bnf/4BSweEY8X3mAJtfDy7GfGPR38pczCx6Fv8kXjMFJm2BdIy5y08
         R4sMyl937hbB4sM/lIdfDSHQ2EIwmKRRE533TmFBqml1bpONq0y3ealvs+jbf+4ALe/S
         NlY8C/zNiNx4yocKJa3Anngvj0XRs0E51lqKDY2OrTS7TsQE4DLIA8pC6R+EVP79Rf7k
         GaKQ==
X-Gm-Message-State: APjAAAVmJJsRuWZNioKYkBUWut6NGOzo6LZURLeOK6gM7INmx8Kj+Zn6
        OQvQWqfDJmBEEjjPawPXJug=
X-Google-Smtp-Source: APXvYqxTXqiNRTyBoZo27pWW4ARai/hloRxCrn3CqnCkF8MPGCanO2Plxq9PCXCmpF+2R5eXizwIuA==
X-Received: by 2002:a5d:66cf:: with SMTP id k15mr2692723wrw.38.1574250034732;
        Wed, 20 Nov 2019 03:40:34 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id s11sm30289635wrr.43.2019.11.20.03.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 03:40:34 -0800 (PST)
Date:   Wed, 20 Nov 2019 12:40:31 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 2/3] x86/traps: Print non-canonical address on #GP
Message-ID: <20191120114031.GA83574@gmail.com>
References: <20191115191728.87338-1-jannh@google.com>
 <20191115191728.87338-2-jannh@google.com>
 <20191118142144.GC6363@zn.tnic>
 <CACT4Y+bCOr=du1QEg8TtiZ-X6U+8ZPR4N07rJOeSCsd5h+zO3w@mail.gmail.com>
 <CAG48ez1AWW7FkvU31ahy=0ZiaAreSMz=FFA0u8-XkXT9hNdWKA@mail.gmail.com>
 <CACT4Y+bfF86YY_zEGWO1sK0NwuYgr8Cx0wFewRDq0WL_GBgO0Q@mail.gmail.com>
 <20191118164407.GH6363@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118164407.GH6363@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Mon, Nov 18, 2019 at 05:29:42PM +0100, Dmitry Vyukov wrote:
> > > And of not having a standard way to signal "this line starts something
> > > that should be reported as a bug"? Maybe as a longer-term idea, it'd
> > > help to have some sort of extra prefix byte that the kernel can print
> > > to say "here comes a bug report, first line should be the subject", or
> > > something like that, similar to how we have loglevels...
> > 
> > This would be great.
> > Also a way to denote crash end.
> > However we have lots of special logic for subjects, not sure if kernel
> > could provide good subject:
> > https://github.com/google/syzkaller/blob/1daed50ac33511e1a107228a9c3b80e5c4aebb5c/pkg/report/linux.go#L537-L1588
> > Probably it could, but it won't be completely trivial. E.g. if there
> > is a stall inside of a timer function, it should give the name of the
> > actual timer callback as identity ("stall in timer_subsystem_foo"). Or
> > for syscalls we use more disambiguation b/c "in sys_ioclt" is not much
> > different than saying "there is a bug in kernel" :)
> 
> While external tools are fine and cool, they can't really block kernel
> development and printk strings format is not an ABI. And yeah, we have
> this discussion each time someone proposes changes to those "magic"
> strings but I guess it is about time to fix this in a way that any
> future changes don't break tools.
> 
> And so I like the idea of marking *only* the first splat with some small
> prefix char as that first splat is the special and very important one.
> I.e., the one where die_counter is 0.
> 
> So I could very well imagine something like:
> 
> ...
> [    2.523708] Write protecting the kernel read-only data: 16384k
> [    2.524729] Freeing unused kernel image (text/rodata gap) memory: 2040K
> [    2.525594] Freeing unused kernel image (rodata/data gap) memory: 368K
> [    2.541414] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> 
> <--- important first splat starts here:
> 
> [    2.542218] [*] general protection fault while derefing a non-canonical address 0xdfff000000000001: 0000 [#1] PREEMPT SMP
> [    2.543343] [*] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc8+ #8
> [    2.544138] [*] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
> [    2.545120] [*] RIP: 0010:kernel_init+0x58/0x107
> [    2.546055] [*] Code: 48 c7 c7 e0 5c e7 81 e8 eb d2 90 ff c7 05 77 d6 95 00 02 00 00 00 e8 4e 1d a2 ff e8 69 b7 91 ff 48 b8 01 00 00 00 00 00 ff df <ff> e0 48 8b 3d fe 54 d7 00 48 85 ff 74 22 e8 76 93 84 ff 85 c0 89

> <--- and ends here.
> 
> to denote that first splat. And the '*' thing is just an example - it
> can be any char - whatever's easier to grep for.

Well, this would break various pieces of tooling I'm sure.

Maybe it would be nicer to tooling to embedd the splat-counter in the 
timestamp in a way:

> [    2.542218-#1] general protection fault while derefing a non-canonical address 0xdfff000000000001: 0000 [#1] PREEMPT SMP
> [    2.543343-#1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc8+ #8
> [    2.544138-#1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
> [    2.545120-#1] RIP: 0010:kernel_init+0x58/0x107
> [    2.546055-#1] Code: 48 c7 c7 e0 5c e7 81 e8 eb d2 90 ff c7 05 77 d6 95 00 02 00 00 00 e8 4e 1d a2 ff e8 69 b7 91 ff 48 b8 01 00 00 00 00 00 ff df <ff> e0 48 8b 3d fe 54 d7 00 48 85 ff 74 22 e8 76 93 84 ff 85 c0 89

That way we'd not only know that it's the first splat, but we'd know it 
from all the *other* splats as well where they are in the splat-rank ;-)

(Also Cc:-ed Linus.)

Thanks,

	Ingo
