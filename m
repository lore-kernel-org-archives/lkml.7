Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34E9C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A804F20726
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575974097;
	bh=Q1vD2o2e4sRhhTZHSpeGMLQPqeJEHIGckRxWEDJbRUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XOwlaH4uuBI2CT/mZFeva0h6wdogKhXpIG49Vp9FOLhG3zt919SEXtHLDGm+ro38s
	 HUYG1OaDuGkDZUA4feucVirNjjepKJIg2MRHXkVT7oYAL5EV2/w7hG6UPtKa5tpSkx
	 NokTIhtdipR0dZfEHf/iEga0SijYurJgpdAqsWfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfLJKe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:34:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33595 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfLJKe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:34:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so19445257wrq.0;
        Tue, 10 Dec 2019 02:34:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uizXfprRj8fjney4P3afQoTDUjaSaVYSy+09p97UTek=;
        b=my/Q7mc4rbTpewBHvHXX8AO/p6IDNkGeuqDWd/NTX0qnvAHVR0aufADZBSnlIVFO55
         +QKUNZugk4/DmrS4YjxsayaZtsf02slLhENZEMkvqVkLP9CAhpQ4gYw63Uytui6VYI4L
         PxRFqVbZVlcg/NS6NjACYAS2USGXfFsLeg95nMuhEGlhlSRuG+VbWQ9eUx6yOPJ9T3TO
         l/UpwiODsHSwXjTehfly4Cn9nwug375aVjUXgss1SIyfCm+1pQDSr8/mGvf8VPf1F2RC
         HADAmFKsSm0Jr9cLITS0CgqlmapbhRVpU5PdJdjj+jVBS4prQbXTyfUlTfzAbSoPSJJe
         f5rw==
X-Gm-Message-State: APjAAAVyPVXeiT5NHRyN+SZGslx6geH/KTMwv4la8XI1dyF61KOMjhis
        ZVEz8CpT4OLtXoC1UV8PdCI=
X-Google-Smtp-Source: APXvYqz7NYibGMgFhBlmpiRw0nMRfb/8UeyOuRHFJOPIT/McfGwDtjqDvzf1agsTzUpbWsC0n1vSRQ==
X-Received: by 2002:adf:8297:: with SMTP id 23mr2231156wrc.379.1575974093765;
        Tue, 10 Dec 2019 02:34:53 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id t1sm2693672wma.43.2019.12.10.02.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 02:34:52 -0800 (PST)
Date:   Tue, 10 Dec 2019 11:34:52 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/6] mm, memory_hotplug: Provide argument for the
 pgprot_t in arch_add_memory()
Message-ID: <20191210103452.GF10404@dhcp22.suse.cz>
References: <20191209191346.5197-1-logang@deltatee.com>
 <20191209191346.5197-6-logang@deltatee.com>
 <ce50d9da-c60e-05a1-a86b-3bb3629de502@redhat.com>
 <f34a4c52-cc95-15ed-8a72-c05ab4fd6d33@deltatee.com>
 <CAPcyv4hpXCZxV5p7WaeGgE7ceujBBa5NOz9Z8fepDHOt6zHO2A@mail.gmail.com>
 <20191210100432.GC10404@dhcp22.suse.cz>
 <6da2b279-6a6d-d89c-a34c-962ed021d91d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6da2b279-6a6d-d89c-a34c-962ed021d91d@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-12-19 11:09:46, David Hildenbrand wrote:
> On 10.12.19 11:04, Michal Hocko wrote:
> > On Mon 09-12-19 12:43:40, Dan Williams wrote:
> >> On Mon, Dec 9, 2019 at 12:24 PM Logan Gunthorpe <logang@deltatee.com> wrote:
> >>>
> >>>
> >>>
> >>> On 2019-12-09 12:23 p.m., David Hildenbrand wrote:
> >>>> On 09.12.19 20:13, Logan Gunthorpe wrote:
> > [...]
> >>>>>  #ifdef CONFIG_MEMORY_HOTPLUG
> >>>>> -int arch_add_memory(int nid, u64 start, u64 size,
> >>>>> +int arch_add_memory(int nid, u64 start, u64 size, pgprot_t prot,
> >>>>>                      struct mhp_restrictions *restrictions)
> >>>>
> >>>> Can we fiddle that into "struct mhp_restrictions" instead?
> >>>
> >>> Yes, if that's what people want, it's pretty trivial to do. I chose not
> >>> to do it that way because it doesn't get passed down to add_pages() and
> >>> it's not really a "restriction". If I don't hear any objections, I will
> >>> do that for v2.
> >>
> >> +1 to storing this information alongside the altmap in that structure.
> >> However, I agree struct mhp_restrictions, with the MHP_MEMBLOCK_API
> >> flag now gone, has lost all of its "restrictions". How about dropping
> >> the 'flags' property and renaming the struct to 'struct
> >> mhp_modifiers'?
> > 
> > Hmm, this email somehow didn't end up in my inbox so I have missed it
> > before replying.
> > 
> > Well, mhp_modifiers makes some sense and it would reduce the API
> > proliferation but how do you expect the prot part to be handled?
> > I really do not want people to think about PAGE_KERNEL or which
> > protection to use because my experience tells that this will get copied
> > without much thinking or simply will break with some odd usecases.
> > So how exactly this would be used?
> 
> I was thinking about exactly the same "issue".
> 
> 1. default initialization via a function
> 
> memhp_modifier_default_init(&modified);
> 
> 2. a flag that unlocks the prot field (default:0). Without the flag, it
> is ignored. We can keep the current initialization then.
> 
> Other ideas?

3. a prot mask to apply on top of PAGE_KERNEL? Or would that be
insufficient/clumsy?
-- 
Michal Hocko
SUSE Labs
