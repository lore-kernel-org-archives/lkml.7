Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E4BC31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2AB2238C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="k9yBV2lk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfFQIay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 04:30:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47544 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfFQIax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:30:53 -0400
Received: from zn.tnic (p200300EC2F0613003807E25F1A502EA7.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:1300:3807:e25f:1a50:2ea7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DB9311EC0249;
        Mon, 17 Jun 2019 10:30:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560760252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aJdX6aisVO6H6FX3DU14pzHYLHpJbMPF2yQU35n6wlI=;
        b=k9yBV2lkDqaBHEX+629qfc0frCfOzwCqJUoHm0ZRuvYobLUcH6Mj/BmzQsRRAMNhLgCZVq
        qDh0NaEdfqcyKOG5oZJ8rGyB1A6eUzER4n2KtHSzuKkOla8LfZESBKdWehA5wMpO2gEJrm
        k5x/vYFze7YwIqwQ9jjuCpV7pqRGVuc=
Date:   Mon, 17 Jun 2019 10:30:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/3] x86/resctrl: Get max rmid and occupancy scale
 directly from CPUID instead of cpuinfo_x86
Message-ID: <20190617083048.GE27127@zn.tnic>
References: <1560705250-211820-1-git-send-email-fenghua.yu@intel.com>
 <1560705250-211820-2-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1906162141301.1760@nanos.tec.linutronix.de>
 <20190617031808.GA214090@romley-ivt3.sc.intel.com>
 <20190617075214.GB27127@zn.tnic>
 <20190617080909.GC214090@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190617080909.GC214090@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 01:09:09AM -0700, Fenghua Yu wrote:
> I just keep the code a bit uniform around the calling area where
> a few functions are called. So get_cqm_info() makes the code a bit more
> readable.
> 
>         init_scattered_cpuid_features(c);
>         init_speculation_control(c);
> +       get_cqm_info(c);
> 
>         /*
>          * Clear/Set all flags overridden by options, after probe.
>          * This needs to happen each time we re-probe, which may happen
>          * several times during CPU initialization.
>          */
>         apply_forced_caps(c);
> }
> 
> Maybe not? If the function is not good, I can directly put the code here?

If you want to have it cleaner, make that a separate patch and say so in
the commit message. Patches should do one logical thing and not mix up
different changes which makes review harder.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
