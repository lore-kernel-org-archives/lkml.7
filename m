Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4D4C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FE520872
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="V6fllti1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfIZKZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 06:25:58 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45596 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfIZKZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 06:25:58 -0400
Received: by mail-ed1-f65.google.com with SMTP id h33so1453754edh.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 03:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sZySFJLySHqAg+L9VV4WCP/n21XzxDuSfHpOa9dXZmk=;
        b=V6fllti1rZHNM40XpXtG1W2Ot4VDBW2UHagEWW0u0MoI0rDFExg7qiEEC4Kx0BkJUO
         N39Zd2scOCpcawHLCt9EgBnxj3aafD0HolLGIy87seuTK4yUMVbDI6o0IMeV8c8kl2q3
         Wf5SnYx+eKbP+/RCIcXsFXduLye95DPO+JQHh/WCLvCUGlPh8nGmH+sogm+pvP4xBNfx
         h4JNIqEgrzXC8r7pu68KwoXWKMGCd2MHljTYxWD05iLCWWxyObBk3ZBW/VCrlMrvtx7F
         z59l19lWm8GhC67PPTck26crrkv0RUiagsUS97uZ2h069vyeKg0ny5eU8/EERwCbbDGs
         R3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sZySFJLySHqAg+L9VV4WCP/n21XzxDuSfHpOa9dXZmk=;
        b=qDL/Fdy195slp9EXpu5A7wlDuDwzLHlwZbw3XoDdrf0Ys84q1WwhNlXBUbLerPiwmx
         LM3EZy8x5iy515wOS4TCEdkHerVERtCEHr8etPhfZrKKvK5LGPGmV61sY+OFdFlonO9u
         x041ElIOo/KKYjqxFuE78YzcxkV3u8dfbLVpkiU6/sGsfUhOiN73GsPthE+wZZfL4wRH
         635FhEO4Vsc0K0+qTs+2BN98pqtV4G3v4r3+dTRPgXhqeog1DSVN0t37fsngnTiZJAoa
         XGfp0sRjSHWoazpDqmnGsbCeSekz77RwGW43KZnotHSy4u3TWupyst5BhbVjV4THy/x0
         8jDA==
X-Gm-Message-State: APjAAAVvW0rAjplx8k2ldGJ431GP8K8SoGwXGmCMkdw61ukqpkD6wGuv
        DMayzXVHXMYCzZhnRAGHJBRKSw==
X-Google-Smtp-Source: APXvYqys0ai/BvbbRaO+GKiiNYldqfE2MTNlpzGoSrB2YWZd0rbFIaSycO3c42IMKl9185PoXnzMPg==
X-Received: by 2002:a50:cfc7:: with SMTP id i7mr2606367edk.89.1569493556435;
        Thu, 26 Sep 2019 03:25:56 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id ng5sm187555ejb.9.2019.09.26.03.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 03:25:55 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7FBCC1004E0; Thu, 26 Sep 2019 13:25:58 +0300 (+03)
Date:   Thu, 26 Sep 2019 13:25:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Jia He <justin.he@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>, nd@arm.com
Subject: Re: [PATCH v9 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Message-ID: <20190926102558.jlessqelf5k3havb@box>
References: <20190925025922.176362-1-justin.he@arm.com>
 <20190925025922.176362-4-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925025922.176362-4-justin.he@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 10:59:22AM +0800, Jia He wrote:
> When we tested pmdk unit test [1] vmmalloc_fork TEST1 in arm64 guest, there
> will be a double page fault in __copy_from_user_inatomic of cow_user_page.
> 
> Below call trace is from arm64 do_page_fault for debugging purpose
> [  110.016195] Call trace:
> [  110.016826]  do_page_fault+0x5a4/0x690
> [  110.017812]  do_mem_abort+0x50/0xb0
> [  110.018726]  el1_da+0x20/0xc4
> [  110.019492]  __arch_copy_from_user+0x180/0x280
> [  110.020646]  do_wp_page+0xb0/0x860
> [  110.021517]  __handle_mm_fault+0x994/0x1338
> [  110.022606]  handle_mm_fault+0xe8/0x180
> [  110.023584]  do_page_fault+0x240/0x690
> [  110.024535]  do_mem_abort+0x50/0xb0
> [  110.025423]  el0_da+0x20/0x24
> 
> The pte info before __copy_from_user_inatomic is (PTE_AF is cleared):
> [ffff9b007000] pgd=000000023d4f8003, pud=000000023da9b003, pmd=000000023d4b3003, pte=360000298607bd3
> 
> As told by Catalin: "On arm64 without hardware Access Flag, copying from
> user will fail because the pte is old and cannot be marked young. So we
> always end up with zeroed page after fork() + CoW for pfn mappings. we
> don't always have a hardware-managed access flag on arm64."
> 
> This patch fix it by calling pte_mkyoung. Also, the parameter is
> changed because vmf should be passed to cow_user_page()
> 
> Add a WARN_ON_ONCE when __copy_from_user_inatomic() returns error
> in case there can be some obscure use-case.(by Kirill)
> 
> [1] https://github.com/pmem/pmdk/tree/master/src/test/vmmalloc_fork
> 
> Signed-off-by: Jia He <justin.he@arm.com>
> Reported-by: Yibo Cai <Yibo.Cai@arm.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
