Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89587CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2BC20659
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jsx5MQBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409922AbfJXQvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:51:31 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37558 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730622AbfJXQvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:51:31 -0400
Received: by mail-il1-f196.google.com with SMTP id v2so2605597ilq.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 09:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=sFSyUVxBP37pgjvJlZsU/w0N+fGBkJlyXhysmzgiRpo=;
        b=jsx5MQBLTE/ixg4HSEH80bow8kXSPu0/ZvHVz75WFDvo4+cfMriHzGKD/W1YN7Ogvn
         5bgfLGRs+45/922cfbl6SzF51OSbFqPFB4aXc1djIT0ImEXcLJ6yySbeCdyVyGeM6Qc6
         XxYPN4NgHjeOShoryC+hXNoO064Nzqt9RZ9bVrOShHsCQSgnbrOC1EuMa4E5GoMF97pi
         C9ueRcm8KVwNy2L98a0QrueeGLLuXH336k7v/AWTdrPSK7lwOKByHvSvXuTqMpmCWalJ
         3AF93MvmlKQqomUEjciFRjTPLyLRj4nyoMlXJTY1VMjj/Y6usmwkx4C4AfkM3hYApVue
         YRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=sFSyUVxBP37pgjvJlZsU/w0N+fGBkJlyXhysmzgiRpo=;
        b=Kgol/k9+Ga4NbvKgZSl7GTsGN/yKANz0W+/wNw7EEDEs3gGo0DtUuLmTGApjJnLQLX
         N6D7fVzC2R1Q/JVZuMqbXoE9hqUl4bVlmdmJ57xpMxH1J4LsSWcTnGWiiaIryPll8JQx
         TBQ42Bqa5v1olB/wpfYGKo4nD7taLOC7jn5sKT/5TCnsI5Ec/09coIjTzcIooe7rcsyq
         HMF+slWEcSJRSe9lFWBeX5Teo6zsfEzTIV0Z3p66MzSknVXafG80Nyj6x3QspQrvr8te
         1xE76R/kWsTyvGs2QjKBKrF35ZUKyyP3Xib+Anjttp1FxE8oz/o6rmUmuFrLXyvtQHRu
         9FSQ==
X-Gm-Message-State: APjAAAX1GXsEC8V6hC6Jrbq4YMPg1jQKJIAKjqhMME0V0wodwwJynubu
        ymOrL7VwyM+iGCExw358l5Kf9w==
X-Google-Smtp-Source: APXvYqwlgWwLvHpNCxZVDp1ya5Nk4eSqkY3nvyjRJZW6GGBcNGxrzX/5p972P71H9/AqqqDSnK2B8Q==
X-Received: by 2002:a92:9f1c:: with SMTP id u28mr17517108ili.97.1571935888436;
        Thu, 24 Oct 2019 09:51:28 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id h13sm8830059ili.6.2019.10.24.09.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 09:51:27 -0700 (PDT)
Date:   Thu, 24 Oct 2019 09:51:25 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Logan Gunthorpe <logang@deltatee.com>
cc:     Yash Shah <yash.shah@sifive.com>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@g.sifive.com>,
        "Palmer Dabbelt ( Sifive)" <palmer@g.sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sorear2@gmail.com" <sorear2@gmail.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "alex@ghiti.fr" <alex@ghiti.fr>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "Anup.Patel@wdc.com" <Anup.Patel@wdc.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Greentime Hu <greentime.hu@g.sifive.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "will@kernel.org" <will@kernel.org>,
        "allison@lohutok.net" <allison@lohutok.net>
Subject: Re: [PATCH] RISC-V: Add PCIe I/O BAR memory mapping
In-Reply-To: <c4817ec1-4e50-5646-68f0-caeb0ab6f0bf@deltatee.com>
Message-ID: <alpine.DEB.2.21.9999.1910240937350.20010@viisi.sifive.com>
References: <1571908438-4802-1-git-send-email-yash.shah@sifive.com> <c4817ec1-4e50-5646-68f0-caeb0ab6f0bf@deltatee.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2019, Logan Gunthorpe wrote:

> On 2019-10-24 3:14 a.m., Yash Shah wrote:
> > For I/O BARs to work correctly on RISC-V Linux, we need to establish a
> > reserved memory region for them, so that drivers that wish to use I/O BARs
> > can issue reads and writes against a memory region that is mapped to the
> > host PCIe controller's I/O BAR MMIO mapping.
> 
> I don't think other arches do this. 

$ git grep 'define PCI_IOBASE' arch/ 
arch/arm/include/asm/io.h:#define PCI_IOBASE            ((void __iomem *)PCI_IO_VIRT_BASE)
arch/arm64/include/asm/io.h:#define PCI_IOBASE          ((void __iomem *)PCI_IO_START)
arch/m68k/include/asm/io_no.h:#define PCI_IOBASE        ((void __iomem *) PCI_IO_PA)
arch/microblaze/include/asm/io.h:#define PCI_IOBASE     ((void __iomem *)_IO_BASE)
arch/unicore32/include/asm/io.h:#define PCI_IOBASE      PKUNITY_PCILIO_BASE
arch/xtensa/include/asm/io.h:#define PCI_IOBASE         ((void __iomem *)XCHAL_KIO_BYPASS_VADDR)
$

This is for the old x86-style, non-memory mapped I/O address space the 
legacy PCI stuff that one would use in{b,w,l}()/out{b,w,l}() for.

Yash, you might consider updating your patch description to note that this 
is for "legacy I/O BARs (i.e., non-MMIO BARs)" or something similar.  That 
might make things clearer.

> ioremap() typically just uses virtual address space in the VMALLOC 
> region, PCI doesn't need it's own range. As far as I know the ioremap() 
> implementation in riscv already does this.
> 
> In any case, 16MB for PCI bar space seems woefully inadequate.

The modern MMIO PCI resources wind up in jost controller apertures, which 
as you note, are usually much larger.  They don't go in this legacy space.

Regarding sizing - I haven't seen any PCIe cards with more than 64KiB of 
legacy I/O resources.  (16MiB / 64KiB) = 256, so 16MiB sounds reasonable 
from that point of view?  ARM64 is using that.


- Paul
