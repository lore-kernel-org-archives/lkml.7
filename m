Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43655C04AA6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DECD21655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U1a1c0hH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbfD2V3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 17:29:45 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:27510 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729370AbfD2V3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 17:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556573384; x=1588109384;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=tylJaZ3hdwgcoleztgKHgV+VyNuRMO/FYfLLBnr0sQI=;
  b=U1a1c0hH41/qYW6ip3h4pWSorJEnWGgvY0Pznu1QP2om8RnYcm3hTdWQ
   sSmBuOEpeRJF9MPOoaF4xPx3eB3TIFxkTveLXOiCql+ViR2Pl8PBPNzmm
   WvO60NuwUJJkyKi9ZwDzI42GDGaEK6l/L8nTNK1+So5btwkkVezhkMFNt
   ZUGd5Y4FPUQ0Bk63C2oo+RZt1sRKuXpU8fATLlQl2Wv3P0b8FMF1v/t4E
   dGvURiLRjGsoCiScBIPGJAd+7U/Dl4XG4SmEHknZONyZYyI2mUJonvQH8
   1DsvhX/fQd5b/frafepbXnWYbd1Ejy7twn99AXbfcyqmdh3pVemlP0rDQ
   A==;
X-IronPort-AV: E=Sophos;i="5.60,411,1549900800"; 
   d="scan'208";a="112062337"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2019 05:29:44 +0800
IronPort-SDR: moNGso2BXe3GzkkuzU5F5AfvPyzy1Ul7eRZWgOPQWety8v3m/4zGlStQSS2hY0og1c6W5TKGVc
 9icRKPxxqqYSSnQ7mh5VJj8SjEQQ2SUx7s6yDL+OZwv9OBlRfyNNn27ojTWzjzhst5TJQXCigk
 KkOIWL2AmDYuHvbjo1e2IF+Dx9a+XNgg1gfsd0/dmdbzc3pOsOPcvFnADjZ4gbzXiRzVM9028O
 8+tLuMSRHI1aO8pdDJe9m6yljn2wju2PRL7aPCU7xTbg3B800nkLSzp6g0wNINYmRfkmOVDZuN
 zX3bdcteJ0vaMmq+F6n7rKCV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 29 Apr 2019 14:08:15 -0700
IronPort-SDR: 3DPb2PcWrl1lZn4c6cs7QX/GL1L2Mxk3qhbjtbqE5SnoEhVGLGsgYQp0Eb/dU+1MLJeRk4bK3V
 ++ljP17iEXBQXhrYVqDmr4IQi85GLF5yUyR9vBG9J79W2VBZ47HDcTonMJv8Q8Vp3og0a2fWCm
 gHe62TeuS05QO2Sgsw0CubbfQQpT6tj+1qYdgd6WTbZTEdI8miJdVoToYEPkSs41VfHPxeuTuj
 X4dDWhnvFJ9TTmKowheCJ/nsz7dfXizAcBxDYwXIRBfwu6nC4/zlIE8JC/pWnMdBoW4sCTmryI
 Mmk=
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.66.167]) ([10.111.66.167])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Apr 2019 14:29:44 -0700
Subject: Re: [PATCH v2 1/3] x86: Move DEBUG_TLBFLUSH option.
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Borislav Petkov <bp@alien8.de>,
        Changbin Du <changbin.du@intel.com>,
        Gary Guo <gary@garyguo.net>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
References: <20190429195759.18330-1-atish.patra@wdc.com>
 <20190429195759.18330-2-atish.patra@wdc.com>
 <20190429200554.GA102486@gmail.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <e80533d1-6d7c-c503-73d7-1a344a49aa37@wdc.com>
Date:   Mon, 29 Apr 2019 14:29:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429200554.GA102486@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/19 1:06 PM, Ingo Molnar wrote:
> 
> * Atish Patra <atish.patra@wdc.com> wrote:
> 
>> CONFIG_DEBUG_TLBFLUSH was added in 'commit 3df3212f9722 ("x86/tlb: add
>> tlb_flushall_shift knob into debugfs")' to support tlb_flushall_shift
>> knob. The knob was removed in 'commit e9f4e0a9fe27 ("x86/mm: Rip out
>> complicated, out-of-date, buggy TLB flushing")'.  However, the debug
>> option was never removed from Kconfig. It was reused in commit
>> '9824cf9753ec ("mm: vmstats: tlb flush counters")' but the commit text
>> was never updated accordingly.
> 
> Please, when you mention several commits, put them into new lines to make
> it readable, i.e.:
> 
>    3df3212f9722 ("x86/tlb: add tlb_flushall_shift knob into debugfs")
> 
> etc.
> 
Done.

>> Update the Kconfig option description as per its current usage.
>>
>> Take this opprtunity to make this kconfig option a common option as it
>> touches the common vmstat code. Introduce another arch specific config
>> HAVE_ARCH_DEBUG_TLBFLUSH that can be selected to enable this config.
> 
> "opprtunity"?
> 
>> +config HAVE_ARCH_DEBUG_TLBFLUSH
>> +	bool
>> +	depends on DEBUG_KERNEL
>> +
>> +config DEBUG_TLBFLUSH
>> +	bool "Save tlb flush statstics to vmstat"
>> +	depends on HAVE_ARCH_DEBUG_TLBFLUSH
>> +	help
>> +
>> +	Add tlbflush statstics to vmstat. It is really helpful understand tlbflush
>> +	performance and behavior. It should be enabled only for debugging purpose
>> +	by individual architectures explicitly by selecting HAVE_ARCH_DEBUG_TLBFLUSH.
> 
> "statstics"??
> 
> Please put a spell checker into your workflow or read what you are
> writing ...
> 

Apologies for the typos. Fixed them.

Regards,
Atish
> Thanks,
> 
> 	Ingo
> 

