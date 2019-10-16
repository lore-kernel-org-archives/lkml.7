Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8C9ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A037206A4
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395351AbfJPX6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 19:58:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40959 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729897AbfJPX57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:57:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id x127so390816pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 16:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=BbWa1nPh5B2BNvDIpIRryQ0D+zzK6Rg7d2TtU75aidY=;
        b=W+LN6y5HD1QJcYr65rnXLASVhLny9cMvSf4DdHMgz2tM83K93RR5ISJsAloUGSOMvY
         RWdd2+oaEsokHHusS+7qi0LXACPMuHcJJYspZxxLxCN+XhhZi9wQEHH58UKb0M0ex/pz
         T+TSOJgh6iAexrXjoOHnd+pyq33qFCkJoUL/I1Z0AO1H1ZwdhkvJ/IcN89d8Ak7zfyCV
         hBT5asC6e9UrZh+NI59hUzyGIl09p4R3yHh8qpRLQeta5vOVGkVEdpJUwh4HfgWJF+zx
         JVtQJAYh5NkdW9HZiiOtbAhiNPC07op/yLkSst/kIvOizFwfNYGTGspuXHsjjvJybETY
         kcAQ==
X-Gm-Message-State: APjAAAWJAj4qWxvyzj081cGqVol7B3TUW4dFwTfCu4j4qUJ/AXv9f+Gu
        xzp5pXG60Ycb4ie+b3b8jw5oGQ==
X-Google-Smtp-Source: APXvYqwl65+99OK7Bf88H7LPwct/aXEPYDcgVzbnKOsnZjQvmNx9j9uhHomqsd69I+SqXbGAmvjrzw==
X-Received: by 2002:a63:575a:: with SMTP id h26mr869322pgm.178.1571270277072;
        Wed, 16 Oct 2019 16:57:57 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id m9sm304519pjf.11.2019.10.16.16.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 16:57:56 -0700 (PDT)
Date:   Wed, 16 Oct 2019 16:57:56 -0700 (PDT)
X-Google-Original-Date: Wed, 16 Oct 2019 16:57:54 PDT (-0700)
Subject:     Re: [PATCH v2] PCI/MSI: Enable PCI_MSI_IRQ_DOMAIN support for Microblaze
In-Reply-To: <fe37e872-09c7-7b60-cd3e-33228c740afc@xilinx.com>
CC:     helgaas@kernel.org, Christoph Hellwig <hch@infradead.org>,
        michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, git@xilinx.com, kuldeep.dave@xilinx.com,
        aou@eecs.berkeley.edu, bharat.kumar.gogada@xilinx.com,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, yamada.masahiro@socionext.com,
        firoz.khan@linaro.org, Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, will@kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>, michal.simek@xilinx.com
Message-ID: <mhng-5d9bcb53-225e-441f-86cc-b335624b3e7c@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2019 22:59:07 PDT (-0700), michal.simek@xilinx.com wrote:
> Hi Bjorn,
>
> On 15. 10. 19 1:23, Bjorn Helgaas wrote:
>> On Tue, Oct 08, 2019 at 08:46:52AM -0700, Christoph Hellwig wrote:
>>>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>>>> index a304f5ea11b9..9d259372fbfd 100644
>>>> --- a/drivers/pci/Kconfig
>>>> +++ b/drivers/pci/Kconfig
>>>> @@ -52,7 +52,7 @@ config PCI_MSI
>>>>  	   If you don't know what to do here, say Y.
>>>>
>>>>  config PCI_MSI_IRQ_DOMAIN
>>>> -	def_bool ARC || ARM || ARM64 || X86 || RISCV
>>>> +	def_bool ARC || ARM || ARM64 || X86 || RISCV || MICROBLAZE
>>>
>>> Can you find out what the actual dependency is so that we can
>>> automatically enabled this instead of the weird arch list?
>>
>> Hi Michal, I'll wait for your response on whether it's feasible to do
>> something smarter than listing every arch here.  Please ping here or
>> post a v3; since I marked this patch "Changed Requested" in patchwork,
>> it's fallen off my to-do list.
>
> I was waiting more for you to comment this. I was expecting that the
> same question came last time when RISCV was added.
> I am happy to investigate more about it but definitely some your input
> would help.

Sorry: we usually try to do things the right way but it looks like this got 
lost in the shuffle.  It really doesn't look like there's any 
architecture-specific code implementation on our end:

    commit 251a44888183003b0380df184835a2c00bfa39d7
    Author: Wesley Terpstra <wesley@sifive.com>
    Date:   Mon May 20 10:29:26 2019 -0700
    
        riscv: include generic support for MSI irqdomains
    
        Some RISC-V systems include PCIe host controllers that support PCIe
        message-signaled interrupts.  For this to work on Linux, we need to
        enable PCI_MSI_IRQ_DOMAIN and define struct msi_alloc_info.  Support
        for the latter is enabled by including the architecture-generic msi.h
        include.
    
        Signed-off-by: Wesley Terpstra <wesley@sifive.com>
        [paul.walmsley@sifive.com: split initial patch into one arch/riscv
         patch and one drivers/pci patch]
        Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
    
    diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
    index 1efaeddf1e4b..16970f246860 100644
    --- a/arch/riscv/include/asm/Kbuild
    +++ b/arch/riscv/include/asm/Kbuild
    @@ -22,6 +22,7 @@ generic-y += kvm_para.h
     generic-y += local.h
     generic-y += local64.h
     generic-y += mm-arch-hooks.h
    +generic-y += msi.h
     generic-y += percpu.h
     generic-y += preempt.h
     generic-y += sections.h

I bet that dropping the architectures and adding msi.h everywhere it's not 
listed will at least get this building.  I'll give

    diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
    index a304f5ea11b9..77c1428cd945 100644
    --- a/drivers/pci/Kconfig
    +++ b/drivers/pci/Kconfig
    @@ -52,7 +52,7 @@ config PCI_MSI
               If you don't know what to do here, say Y.
    
     config PCI_MSI_IRQ_DOMAIN
    -       def_bool ARC || ARM || ARM64 || X86 || RISCV
    +       def_bool y
            depends on PCI_MSI
            select GENERIC_MSI_IRQ_DOMAIN
    
a build everywhere to see what falls out.
