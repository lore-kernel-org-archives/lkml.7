Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD7DC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 12:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A162077C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 12:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555934698;
	bh=BNF+SRkYol4eKqZgNOPfHYOcDyBpfiTRbH24CqO+wxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m8ypWX/y7YdrsTTbomKUO68lh3xSErURhKZvF/jFGLXxcDIgOl2bBy8jC93de/61E
	 0sGhz8xRpA2By9eoCp1JP7El5BLTy2ZhIzAtdd0gB6I8VWm9bYKewGXPCeCv/Y0iXE
	 DmEHUZrgX+klnbublGPQSlCRSEhbCtNNB/gIGszo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfDVME4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 08:04:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52828 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfDVME4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 08:04:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id a184so14167821wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 05:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KfsgS0aKujUjHCSpYunCjaFm4azzJUqoJogHKqdCd4Q=;
        b=KSpORV2BXpOT3Fe+IpHNbN5EN4qKT3+Z+UCxq2qoz7NPvEMV+7DNBF8mE6MOuqgs1t
         QoBuLOeXeKR1r9ZgCscL1PfW4Hp2GjE4MhYaCQLrt4aKYfPWBT5u2h7SUD5497nX1ouM
         a11RuIiHQYbA9rT/ualzi5EzO69JZGQOAfo0Q/1DFUjEWDlGTUeM9mdmumb/CnsOtzRA
         BjqYPE51ubDIe/a+aUW5YlQtmOry7nANHqn1KGO8An5wD3JGfM+uFJhE+5So/yGKtZ1R
         G75B+T0PHBIMUMrIBTe5wvbdPw1yz9k0jdkNgeVCNlZKWCn9nUGoW3UXVvOBS6ZVSw1C
         uouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KfsgS0aKujUjHCSpYunCjaFm4azzJUqoJogHKqdCd4Q=;
        b=kaO058/NZ9Yz+mFas8HGC3F457rxnIGmN622XtFCFJyCiAm1zOsz43N6A5xTMWx4VS
         1n7tGCHDLzQZ7olQB2bjiysM/+dq9lEY3ucNKU3C3WPx6+sMuGqLMskIj0S2Br87vjpx
         VL5s1YLQK8MQoOLUMCmtIklJW+WvYANQMMZ/8FU99FvSa8QqM1n75pVM3akMhMc0b9we
         xwkjY+C/19cEAJN3VaCKINL6zGuhUrNOUS8fmmejFyRaFYTgYDfCiVMGgbv+rkF6mK3I
         3WkCjlgEm5D7uhX/S9KMPHF4pVlEsWxjZfzffrKj7MuUBO2JBfdbvZp4d9SeVO+k+IvL
         CMbQ==
X-Gm-Message-State: APjAAAW07Mne6KuDls/Tjtn/oMqsTZBSan5Gh+F60IrCda760DhPI2pe
        fKkBZdTENHRF8sVovqhtluLhUhA3
X-Google-Smtp-Source: APXvYqzahH5LgSesWLZjfoUf4mCLHpr4BcrvNYUDCA3TCzNvzHIjvvuBo+7JgwPYIUUUwyfkxbjZyQ==
X-Received: by 2002:a1c:e1c5:: with SMTP id y188mr12009981wmg.39.1555934694771;
        Mon, 22 Apr 2019 05:04:54 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i17sm13204266wrs.44.2019.04.22.05.04.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 05:04:53 -0700 (PDT)
Date:   Mon, 22 Apr 2019 14:04:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Daniel Drake <drake@endlessm.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, len.brown@intel.com,
        rafael.j.wysocki@intel.com, linux@endlessm.com
Subject: Re: [PATCH 2/2] x86/tsc: set LAPIC timer frequency to crystal clock
 frequency
Message-ID: <20190422120451.GA9499@gmail.com>
References: <20190422101526.28415-1-drake@endlessm.com>
 <20190422101526.28415-2-drake@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422101526.28415-2-drake@endlessm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Drake <drake@endlessm.com> wrote:

> +#ifdef CONFIG_X86_LOCAL_APIC
> +	/*
> +	 * The local APIC appears to be fed by the core crystal clock
> +	 * (which sounds entirely sensible). We can set the global
> +	 * lapic_timer_frequency here to avoid having to calibrate the APIC
> +	 * timer later.
> +	 */
> +	lapic_timer_frequency = (crystal_khz * 1000) / HZ;
> +#endif

Minor style nit: the parentheses are unnecessary, integer expressions 
like this are evaluated left to right and multiplication and division has 
the same precedence.

But it might also make sense to actually store crystal_mhz instead of 
crystal_khz, because both CPUID 15H and 16H provides MHz values.

That way the above expression would simplify to:

	lapic_timer_frequency = crystal_mhz / HZ;

Thanks,

	Ingo
