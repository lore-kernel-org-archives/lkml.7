Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645DCECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE962084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="dcXZ61tR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfJKMTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:19:54 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38871 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfJKMTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:19:54 -0400
Received: by mail-lj1-f196.google.com with SMTP id b20so9621131ljj.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 05:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n9TW/HRe8d6mz4MQKhjPNO1PuLOYHluTJjNubX7sfzE=;
        b=dcXZ61tRqDpeGyGapLhTvELR9pMmEjlU53H4BbUz/JaJ3WO3hx84ErbKazu7xtKoKW
         gvfMB/6EjJI8i+G890KgefdzxLr6S1o9w430ETPzkjAgdOP3l6l7ixOEThpqumgeBE79
         yFf5+SbM3GAjhnHfb/2lFglO+G1/u+qEVoh+6kFuwnvZMHgvU9mHqq45wrT4hVF2CZ/V
         nOEak8d7761PnYr0dhcs16wc/cnH3Dsw+uB2anDBfGq2iKT2kjiQ3OI2EAOBkr7y0GrI
         Zjo4zkuTZyH8+5GZzq4yNm64xgg5q+9qrdsHcivByH0oX+mhqy2KnAzFo6Brv2OiVRvb
         8aWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n9TW/HRe8d6mz4MQKhjPNO1PuLOYHluTJjNubX7sfzE=;
        b=Jl0FLJOgFNCIAb4HzDjAaTTsTEdupe1Mv/Ef9erihIHD7FAq9kAbBQEDmIYW+Li3dP
         xePAI8DQTb8ZON51Nrx5e6y8pYy6nSo6K2mnwlaGA01usAZcmZgmcVMs4BBaqWTW3H+5
         YaX1DMe6gH4gLTpbe43qdG8r5arX58I2bf8I/B6MrCPC+q/r0h/EYvdAOrchgOPuv5bY
         TvCSIZiAaa6u6OByKTLw97d4ux5pYewOwsKvVd5VMXnYBTPfnsv4R2utp42nicdXis7F
         9iZ9x5KfriD2O8rnQ/Mys+3H5Hf6Q45JMsJymWf9UEJW5isceoSmGVnPO9O+CT0a4aNU
         D9Hw==
X-Gm-Message-State: APjAAAWNvH2NSHuTagoWqDBCacgD1tzWY0OXIpf7kuN8TMVUbDKPRXyC
        I5jtjfpwevECHkceHJTsnNmFQg==
X-Google-Smtp-Source: APXvYqwZoc4fM1naaPJ7w+PtjiadfJ4JzznLHAw4a73DhoKiP8rjYFSUvqrrjtzyxw6vnYfFdWEnyA==
X-Received: by 2002:a2e:9913:: with SMTP id v19mr8829129lji.234.1570796392539;
        Fri, 11 Oct 2019 05:19:52 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v22sm1868024ljh.56.2019.10.11.05.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 05:19:51 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 93D6C102DC1; Fri, 11 Oct 2019 15:19:51 +0300 (+03)
Date:   Fri, 11 Oct 2019 15:19:51 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vineet Gupta <vineetg76@gmail.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Nick Piggin <npiggin@gmail.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-snps-arc@lists.infradead.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 0/3] eldie generated code for folded p4d/pud
Message-ID: <20191011121951.nxna6hruuskvdxod@box>
References: <20191009222658.961-1-vgupta@synopsys.com>
 <20191010085609.xgwkrbzea253wmfg@black.fi.intel.com>
 <8ba067a6-8b6a-2414-0f04-b251cd6bb47c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ba067a6-8b6a-2414-0f04-b251cd6bb47c@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 01:05:56PM -0700, Vineet Gupta wrote:
> 
> Hi Kirill,
> 
> On 10/10/19 1:56 AM, Kirill A. Shutemov wrote:
> > On Wed, Oct 09, 2019 at 10:26:55PM +0000, Vineet Gupta wrote:
> >>
> >> This series elides extraneous generate code for folded p4d/pud.
> >> This came up when trying to remove __ARCH_USE_5LEVEL_HACK from ARC port.
> >> The code saving are not a while lot, but still worthwhile IMHO.
> > 
> > Agreed.
> 
> Thx.
> 
> So given we are folding pmd too, it seemed we could do the following as well.
> 
> +#ifndef __PAGETABLE_PMD_FOLDED
>  void pmd_clear_bad(pmd_t *);
> +#else
> +#define pmd_clear_bad(pmd)        do { } while (0)
> +#endif
> 
> +#ifndef __PAGETABLE_PMD_FOLDED
>  void pmd_clear_bad(pmd_t *pmd)
>  {
>         pmd_ERROR(*pmd);
>         pmd_clear(pmd);
>  }
> +#endif
> 
> I stared at generated code and it seems a bit wrong.
> free_pgd_range() -> pgd_none_or_clear_bad() is no longer checking for unmapped pgd
> entries as pgd_none/pgd_bad are all stubs returning 0.
> 
> This whole pmd folding is a bit confusing considering I only revisit it every few
> years :-) Abstraction wise, __PAGETABLE_PMD_FOLDED only has pgd, pte but even in
> this regime bunch of pmd macros are still valid
> 
>     pmd_set(pmdp, ptep) {
>         *pmdp.pud.p4d.pgd = (unsigned long)ptep
>     }
> 
> Is there a better way to make a mental model of this code folding.

I don't have any. PMD folding predates me and have never looked at it
closely. Quick look brings more confusion than clarity. :P

> In an ideal world pmd folded would have meant pmd_* routines just vanish - poof.
> So in that sense I like your implementation under #[45]LEVEL_HACK where the level
> simply vanishes by code like #define p4d_t pgd_t. Perhaps there is lot of historic
> baggage, proliferated into arch code so hard to untangle.

In ideal world all these pgd/p4d/pud/pmd/pte should die and we have
something more flexible to begin with.

I played with this before:

https://lore.kernel.org/lkml/20180424154355.mfjgkf47kdp2by4e@black.fi.intel.com/

-- 
 Kirill A. Shutemov
