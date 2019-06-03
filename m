Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B5EC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 21:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FACB247A7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 21:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scIwGBKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfFCVln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 17:41:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34499 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfFCVln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 17:41:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id c26so18724437edt.1;
        Mon, 03 Jun 2019 14:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yhLYhpx5r94UcNbu2SZQmZBVQeUmPq6PVimIkeEn7pk=;
        b=scIwGBKI357lkVXW52kw03XCI4+Ae6ho42noCT0DWTtPRkLPw37gVYJBmgatjte/fr
         txxL6xswgG2bwv4dcBi9ilccueJ2EbcEKZtiqgVr0w/zR7p00TQxQ68X081DlJksiVJp
         bQq/Q6WuN9RqstqJonmfHCKtiFMA7q9w/UyTa+NDl7ayqnpxpJkR/MsE/cnrEjpN5UnF
         pDmYt0I6nf0M8NtJy0pn3MNogc07CPwCXpJcmFU/YcoTOESdyv+YzC8Zd1MT32D8/vBb
         qcdBZinoMMfM8+8dbAMFVV623Db3nfb+VmQu9rZFXZf1rykogdgYpXDWtPbozhqhF8So
         ROsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yhLYhpx5r94UcNbu2SZQmZBVQeUmPq6PVimIkeEn7pk=;
        b=MCmId1Zl9qj25uQBhO7pU+QGGm+BalZm3MMtSR0MyE2UQwVeo7EVnJheXrdAdW7ReD
         9kINWPVKyoR4V9KG0Wsz+SDo9y1crj1LVDJHp/Y0ViasgdINNDpsU08mvyv9SnwM96Aw
         ZmkJKft6FQPMpPjHonkDQoDGzHtjBoeyvC9glRGKd04zt0U5Re7DmVKeJm1oO8GZFws0
         cTFrrIxohqkxgGbf105j4gvB2d5aioqoPaA1JVZZDiJS2pZVpdUgx7IC+N4/7ctx9vZ7
         n7eBsokzz/Pg0lXbTC/IaBxkhpABUokwbTDiRYKkd6MYEfJPMPFXAktX90yde7TswSFN
         gmQA==
X-Gm-Message-State: APjAAAV6roatVNc05VRAgbj8aaNJJz7LKbX75DAe+UWpfWwbwwlIe9NI
        kAo1nxv85NEXGlaYZKqe1BU=
X-Google-Smtp-Source: APXvYqwCMUWcithGJqx45+EgRmxCCI6sjYqisr91FRxovWqn6/a/0IS0IDUQUvDAHCpQkkCQxu0u/A==
X-Received: by 2002:a17:907:20d0:: with SMTP id qq16mr14587748ejb.244.1559598100632;
        Mon, 03 Jun 2019 14:41:40 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id e45sm4208929edb.12.2019.06.03.14.41.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 14:41:39 -0700 (PDT)
Date:   Mon, 3 Jun 2019 21:41:39 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v3 04/11] arm64/mm: Add temporary arch_remove_memory()
 implementation
Message-ID: <20190603214139.mercn5hol2yyfl2s@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190527111152.16324-1-david@redhat.com>
 <20190527111152.16324-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527111152.16324-5-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 01:11:45PM +0200, David Hildenbrand wrote:
>A proper arch_remove_memory() implementation is on its way, which also
>cleanly removes page tables in arch_add_memory() in case something goes
>wrong.

Would this be better to understand?

    removes page tables created in arch_add_memory

>
>As we want to use arch_remove_memory() in case something goes wrong
>during memory hotplug after arch_add_memory() finished, let's add
>a temporary hack that is sufficient enough until we get a proper
>implementation that cleans up page table entries.
>
>We will remove CONFIG_MEMORY_HOTREMOVE around this code in follow up
>patches.
>
>Cc: Catalin Marinas <catalin.marinas@arm.com>
>Cc: Will Deacon <will.deacon@arm.com>
>Cc: Mark Rutland <mark.rutland@arm.com>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>Cc: Chintan Pandya <cpandya@codeaurora.org>
>Cc: Mike Rapoport <rppt@linux.ibm.com>
>Cc: Jun Yao <yaojun8558363@gmail.com>
>Cc: Yu Zhao <yuzhao@google.com>
>Cc: Robin Murphy <robin.murphy@arm.com>
>Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>
>---
> arch/arm64/mm/mmu.c | 19 +++++++++++++++++++
> 1 file changed, 19 insertions(+)
>
>diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>index a1bfc4413982..e569a543c384 100644
>--- a/arch/arm64/mm/mmu.c
>+++ b/arch/arm64/mm/mmu.c
>@@ -1084,4 +1084,23 @@ int arch_add_memory(int nid, u64 start, u64 size,
> 	return __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
> 			   restrictions);
> }
>+#ifdef CONFIG_MEMORY_HOTREMOVE
>+void arch_remove_memory(int nid, u64 start, u64 size,
>+			struct vmem_altmap *altmap)
>+{
>+	unsigned long start_pfn = start >> PAGE_SHIFT;
>+	unsigned long nr_pages = size >> PAGE_SHIFT;
>+	struct zone *zone;
>+
>+	/*
>+	 * FIXME: Cleanup page tables (also in arch_add_memory() in case
>+	 * adding fails). Until then, this function should only be used
>+	 * during memory hotplug (adding memory), not for memory
>+	 * unplug. ARCH_ENABLE_MEMORY_HOTREMOVE must not be
>+	 * unlocked yet.
>+	 */
>+	zone = page_zone(pfn_to_page(start_pfn));

Compared with arch_remove_memory in x86. If altmap is not NULL, zone will be
retrieved from page related to altmap. Not sure why this is not the same?

>+	__remove_pages(zone, start_pfn, nr_pages, altmap);
>+}
>+#endif
> #endif
>-- 
>2.20.1

-- 
Wei Yang
Help you, Help me
