Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A941C04AA6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E0B2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556568361;
	bh=yW7qSagl221sheslSGbscpNtINSNH2wrxqa5XAnFmgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=amjlrpOx4WxYyevZlKVhmRxKtFLTn2b7Z90a9CByazdNEi2dWn42eE2VkwV3Q2adZ
	 r8XdeoCOPt23glyqcp7vk1aA5k+LM1MsWjpj2/29jkg6t36cCDK/Zq+RrzELkcUtFI
	 2P397L9U8mgWupSB43dTcK4XoQZWzAgjsgUxucgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfD2UGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 16:06:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35266 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfD2UF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:05:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so895845wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 13:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3bA1GjyiOqhiuVg99bZFV+UdtqoiitioJOxxTtpTJvM=;
        b=hSNfUmq2FWt0hwGZGwRRx6ux4gGT19Z5mAXNwVuJXSN0QwcB9VBBQjDL8/gAfaXgqB
         PRlKgIyaEV14eqq9h9L4TUyYrd5sgX0pGXQdZc909GLHZU364d3jtzd7xrRSpqa9A11b
         D+Fs7K3AvlCcHWx8JTwPW3VZzB4DCl4bQlclAVlHOg4hc1KdEatZsLbKfVe8Z7vHPT9h
         LEKz9P0XxBAI+WUUh4KOezOQ/PkWGLnMO4oHEX0ohv3qDcS7KWvjVKizM2Xlp9Zpd7OX
         DZ2dAcF/7yL9BguEcP2PmPY8/G1Uz1NPA+EmHwCRlS5y9XWA4wBAg0gvQ7b2KYHtVEgX
         L0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3bA1GjyiOqhiuVg99bZFV+UdtqoiitioJOxxTtpTJvM=;
        b=tfRgEE5BMJ8Y5SyMhVnKdELspD2h2PM8PsDuXifD0Bo3HCLETGHSaKAjGKsO3w4h0x
         hpV/vZf+gfnXDga9XaLIfidMb4yIjZFNlDrCrpPlyeyZ3XbrXmdlXleTcZNPjqDGzAQA
         IrJfX+Qz7a3n3HCVAhYjBKQUtrvnlM+EYOK/ew0vUfqf+PNtiZpBl+Nwi7eOm3D0dxC7
         kxNsSFZxPMNrdSJkGOVqxiMrH+UtyIc6JQgkupiKDQMnkqGDaA7jlpUAWxLzvXH6Chxh
         hYqyjkIrlR3z/qFVIDRXMQLtDdfUgptqcglLwmxWScue7OmRAp1iPC28nVO0XgcnXbFp
         s5qg==
X-Gm-Message-State: APjAAAUnuLfMhTJZmeWu8X99ak7IllJtLQKrwy6+D4+WVAqdtX+5NNYt
        0k+mZUUyTO+28alOexO2yFI=
X-Google-Smtp-Source: APXvYqxGiHSnnNJ1a/9EZhUrXaRjPVCn9qMn/skaREokKLrBVmvLfqx2RSYt4Z2utXm9gg1l+N3zKw==
X-Received: by 2002:a1c:d7:: with SMTP id 206mr567213wma.69.1556568358168;
        Mon, 29 Apr 2019 13:05:58 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c63sm762243wma.29.2019.04.29.13.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 13:05:57 -0700 (PDT)
Date:   Mon, 29 Apr 2019 22:05:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Borislav Petkov <bp@alien8.de>,
        Changbin Du <changbin.du@intel.com>,
        Gary Guo <gary@garyguo.net>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/3] x86: Move DEBUG_TLBFLUSH option.
Message-ID: <20190429200554.GA102486@gmail.com>
References: <20190429195759.18330-1-atish.patra@wdc.com>
 <20190429195759.18330-2-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429195759.18330-2-atish.patra@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Atish Patra <atish.patra@wdc.com> wrote:

> CONFIG_DEBUG_TLBFLUSH was added in 'commit 3df3212f9722 ("x86/tlb: add
> tlb_flushall_shift knob into debugfs")' to support tlb_flushall_shift
> knob. The knob was removed in 'commit e9f4e0a9fe27 ("x86/mm: Rip out
> complicated, out-of-date, buggy TLB flushing")'.  However, the debug
> option was never removed from Kconfig. It was reused in commit
> '9824cf9753ec ("mm: vmstats: tlb flush counters")' but the commit text
> was never updated accordingly.

Please, when you mention several commits, put them into new lines to make 
it readable, i.e.:

  3df3212f9722 ("x86/tlb: add tlb_flushall_shift knob into debugfs")

etc.

> Update the Kconfig option description as per its current usage.
> 
> Take this opprtunity to make this kconfig option a common option as it
> touches the common vmstat code. Introduce another arch specific config
> HAVE_ARCH_DEBUG_TLBFLUSH that can be selected to enable this config.

"opprtunity"?

> +config HAVE_ARCH_DEBUG_TLBFLUSH
> +	bool
> +	depends on DEBUG_KERNEL
> +
> +config DEBUG_TLBFLUSH
> +	bool "Save tlb flush statstics to vmstat"
> +	depends on HAVE_ARCH_DEBUG_TLBFLUSH
> +	help
> +
> +	Add tlbflush statstics to vmstat. It is really helpful understand tlbflush
> +	performance and behavior. It should be enabled only for debugging purpose
> +	by individual architectures explicitly by selecting HAVE_ARCH_DEBUG_TLBFLUSH.

"statstics"??

Please put a spell checker into your workflow or read what you are 
writing ...

Thanks,

	Ingo
