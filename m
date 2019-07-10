Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B74C74A23
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF112087F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562768582;
	bh=zm9gaKNfM1jd2enG3JtUv2YXrFn3mAp2+8Rx9nYS4iw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=aB5sRTWgRk82fVbou2eg3Pgo0QnLG3WbH0k3W/hwzA42u+kvlZl4eRpDHU4gkPmNi
	 Umne93vNmabE3VFAekL4SnR7cDmZWYTvhiZN/kNHhTkgt9ygKJ+Yp3L8TSA/LNwpqI
	 fLFcJYz0ibDNtRZkA/Qd2wb7rK5xDjlCVl5SjIG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfGJOXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 10:23:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfGJOXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:23:00 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F8EF20651;
        Wed, 10 Jul 2019 14:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562768580;
        bh=zm9gaKNfM1jd2enG3JtUv2YXrFn3mAp2+8Rx9nYS4iw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Cw086sGLJLrxkNuX+uKPF1rI1tx+svUUnHmCE09VyMcCyQ1LE1RaIq6QIab2ENzII
         UEaW/UVEWgpCxwPNfQrfVXnFu9rvhAkR6SL+Ikb+8nbNSIikF7HLwQF2S8CVkbLdro
         tuYKX2HKMTbsJK+rmHz/XeFZL4BbrFPq9pWczRS8=
Date:   Wed, 10 Jul 2019 16:22:51 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Xi Ruoyao <xry111@mengyan1223.wang>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Nadav Amit <namit@vmware.com>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
In-Reply-To: <20190710134433.GN3402@hirez.programming.kicks-ass.net>
Message-ID: <nycvar.YFH.7.76.1907101621050.5899@cbobk.fhfr.pm>
References: <CAHk-=wh7NChJP+WkaDd3qCz847Fq4NdQ6z6m-VFpbr3py_EknQ@mail.gmail.com> <alpine.DEB.2.21.1907100023020.1758@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907100039540.1758@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907100115220.1758@nanos.tec.linutronix.de>
 <201907091727.91CC6C72D8@keescook> <1ad2de95e694a29909801d022fe2d556df9a4bd5.camel@mengyan1223.wang> <cb6d381ed7cd0bf732ae9d8f30c806b849b0f94b.camel@mengyan1223.wang> <alpine.DEB.2.21.1907101404570.1758@nanos.tec.linutronix.de> <nycvar.YFH.7.76.1907101425290.5899@cbobk.fhfr.pm>
 <768463eb26a2feb0fcc374fd7f9cc28b96976917.camel@mengyan1223.wang> <20190710134433.GN3402@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jul 2019, Peter Zijlstra wrote:

> If we mark the key as RO after init, and then try and modify the key to
> link module usage sites, things might go bang as described.
> 
> Thanks!
> 
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 27d7864e7252..5bf7a8354da2 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -366,7 +366,7 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
>  	cr4_clear_bits(X86_CR4_UMIP);
>  }
>  
> -DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
> +DEFINE_STATIC_KEY_FALSE(cr_pinning);

Good catch, I guess that is going to fix it.

At the same time though, it sort of destroys the original intent of Kees' 
patch, right? The exploits will just have to call static_key_disable() 
prior to calling native_write_cr4() again, and the protection is gone.

-- 
Jiri Kosina
SUSE Labs

