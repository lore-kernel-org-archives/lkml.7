Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4E6C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837BB22CE9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="F9omnknw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfH3OMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 10:12:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42520 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727718AbfH3OMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 10:12:03 -0400
Received: from zn.tnic (p200300EC2F0AAA0001D832AAA778AB1D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:aa00:1d8:32aa:a778:ab1d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 46BA91EC0819;
        Fri, 30 Aug 2019 16:12:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567174321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=k4VwADrPCi5rLm3iNeYNw+tyHrRu79BZjudlrKpekYg=;
        b=F9omnknwKNcQNRrUDkeHN2K/2FZScCUieMKsW8X5Inwuq2W/fDvYXPwDsBSAdxwOstRlzC
        8U6TG6sJPO6WpQPvHdR0KYb3zwr06JuN73UjCV1R+66Fs3EI/KRXWNBr3zor+fQJmHNfqi
        d5ZALOPEaIeYtYTyEDITLpB5nK2kYlw=
Date:   Fri, 30 Aug 2019 16:11:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>,
        x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Drake <drake@endlessm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org
Subject: Re: [PATCHv2 0/4] x86/mce: protect nr_cpus from rebooting by
 broadcast mce
Message-ID: <20190830141156.GB30413@zn.tnic>
References: <1566874943-4449-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1566874943-4449-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 11:02:19AM +0800, Pingfan Liu wrote:
> v1 -> v2: fix compile warning and error on x86_32
> 
> 
> This series include two related groups:
> [1-3/4]: protect nr_cpus from rebooting by broadcast mce
> [4/4]: improve "kexec -l" robustness against broadcast mce
> 
> When I tried to fix [1], Thomas raised concern about the nr_cpus' vulnerability
> to unexpected rebooting by broadcast mce. After analysis, I think only the
> following first case suffers from the rebooting by broadcast mce. [1-3/4] aims
> to fix that issue.
> 
> *** Back ground ***
> 
> On x86 it's required to have all logical CPUs set CR4.MCE=1. Otherwise, a
> broadcast MCE observing CR4.MCE=0b on any core will shutdown the machine.
> 
> The option 'nosmt' has already complied with the above rule by Thomas's patch.
> For detail, refer to 506a66f3748 (Revert "x86/apic: Ignore secondary threads if
> nosmt=force")
> 
> But for nr_cpus option, the exposure to broadcast MCE is a little complicated,
> and can be categorized into three cases.

One thing is not clear to me: are you "fixing" a hypothetical case here
or have you *actually* experienced an MCE happening while kdumping with
nr_cpus < num_online_cpus()?

Btw, pls do not use lkml.org to refer to previous mails but

http://lkml.kernel.org/r/<Message-ID>

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
