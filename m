Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22394C2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB0920663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575972278;
	bh=hnqr6Ol323TzoUsNnMfOv/ryEk5EaeQj19pkPd5hYvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IVtspTq0f72ge1yrvPuhOkW3RCGuaGVRWKTyB1WEJ3BHH2sVeNu720DI0C1IJ3xEO
	 TGDUWwgeGubOQYfBHg/ZtZst9kViqokezpokN2ffRtjHvWlQYgtlmEbAoKG1UJUZfj
	 isj2fB1dQ08WmrCHsDhY9DrKZNoPJq6Zm4O8301U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfLJKEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:04:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44929 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfLJKEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:04:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so19289976wrm.11;
        Tue, 10 Dec 2019 02:04:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QLZYchecYCyTfZUwcFTr9CQsRoFwfMan4kBgqsrapHM=;
        b=P7XAJT31rJ/rpd72WuTsVpBVnknQjn4mrzNKCrFzLg/+rxV2lSFhBDesgWPOW0Lq+e
         DCjfhklku1fZNpQGoAijZm28XM6IWcWExU2ub5SP4fyD5Hyu3ckin56DBVmIUkat5cS4
         5vz6RazQdEgvpJk5h5CRLjuNKlYrmDuURzggzOzxd4WW3o9M4LD41+hqFssVFX0AFlmE
         z+0XuS/TTm2MFj8pvj0CwFhXns4o2EuUrROldyIgw5Ce5Qg0DGGcyaElpw4MkCMEjqW/
         znICBi7gR76N6cvB5AXensky0i+Dly8MEc6Y67Qoxkg1m6lk7LwzZyetGj3PgaTj6UCW
         svWw==
X-Gm-Message-State: APjAAAUUVhqzwNLUmQDsoF4IrGww/GALDAiJJT4rLAMEMNUz9S83jSky
        d/SOQcGq2T5Fok3FPbrq45I=
X-Google-Smtp-Source: APXvYqybjX0x512h+KKDACNn2hrSkGBTVAo55jrbH0HajQVo5vL0a3cRSttPAE8CmJ6vkzdkbqPAlQ==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr2191510wrp.292.1575972274043;
        Tue, 10 Dec 2019 02:04:34 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id f5sm2430165wmh.12.2019.12.10.02.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 02:04:33 -0800 (PST)
Date:   Tue, 10 Dec 2019 11:04:32 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
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
Message-ID: <20191210100432.GC10404@dhcp22.suse.cz>
References: <20191209191346.5197-1-logang@deltatee.com>
 <20191209191346.5197-6-logang@deltatee.com>
 <ce50d9da-c60e-05a1-a86b-3bb3629de502@redhat.com>
 <f34a4c52-cc95-15ed-8a72-c05ab4fd6d33@deltatee.com>
 <CAPcyv4hpXCZxV5p7WaeGgE7ceujBBa5NOz9Z8fepDHOt6zHO2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hpXCZxV5p7WaeGgE7ceujBBa5NOz9Z8fepDHOt6zHO2A@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-12-19 12:43:40, Dan Williams wrote:
> On Mon, Dec 9, 2019 at 12:24 PM Logan Gunthorpe <logang@deltatee.com> wrote:
> >
> >
> >
> > On 2019-12-09 12:23 p.m., David Hildenbrand wrote:
> > > On 09.12.19 20:13, Logan Gunthorpe wrote:
[...]
> > >>  #ifdef CONFIG_MEMORY_HOTPLUG
> > >> -int arch_add_memory(int nid, u64 start, u64 size,
> > >> +int arch_add_memory(int nid, u64 start, u64 size, pgprot_t prot,
> > >>                      struct mhp_restrictions *restrictions)
> > >
> > > Can we fiddle that into "struct mhp_restrictions" instead?
> >
> > Yes, if that's what people want, it's pretty trivial to do. I chose not
> > to do it that way because it doesn't get passed down to add_pages() and
> > it's not really a "restriction". If I don't hear any objections, I will
> > do that for v2.
> 
> +1 to storing this information alongside the altmap in that structure.
> However, I agree struct mhp_restrictions, with the MHP_MEMBLOCK_API
> flag now gone, has lost all of its "restrictions". How about dropping
> the 'flags' property and renaming the struct to 'struct
> mhp_modifiers'?

Hmm, this email somehow didn't end up in my inbox so I have missed it
before replying.

Well, mhp_modifiers makes some sense and it would reduce the API
proliferation but how do you expect the prot part to be handled?
I really do not want people to think about PAGE_KERNEL or which
protection to use because my experience tells that this will get copied
without much thinking or simply will break with some odd usecases.
So how exactly this would be used?
-- 
Michal Hocko
SUSE Labs
