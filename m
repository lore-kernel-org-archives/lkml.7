Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FFAC2D0C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 08:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C0F214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 08:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576053471;
	bh=L6lTmn6ZJo8jEKrZuiY/fFMRppBnU5FIObjyAg+xgL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hTKBHZhlOMfvaizRC6zp2LgRWb0LbGWhyfMQYlQW8dnPxWQE2EDLRlt/nuR4jAGz3
	 mjQlZGkJlaIBYjZBOtr9c5exU75qWU5NXnyE0T861+0Y0h5+umRh8vl4Qi8/lZXJhZ
	 6DUzIjk23wv9OYe2eF/9GimjcdmvkbMeKhTKYEYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfLKIhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 03:37:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51374 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfLKIht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 03:37:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id d73so2785565wmd.1;
        Wed, 11 Dec 2019 00:37:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RT9pTTqiwT2L0hZKyzfnOGnReyBEaT0I8SJou9/ZWtA=;
        b=WycEzKWaK87nhxlV+2EnWYZecESj4FbRNoi3hrm59tb9XC6hCqXSjM4FfXbMKeEUm3
         QHVKYM/geYUsGFQVqIUO17nCkau3cYresxD8ELPEcTlOSnpARGAhe2r7e3W8SB7Xj3tD
         9vgv8KL+ZwNoo7iBblJArA/vpx785kJUmTHKTvTfmOa2O+tTEp6HBl+KPitv5BN4tTQ7
         eaRCDrAOWWRsjq4o/BS5/SktQiwyJD9oBmZelDa590PS2o3mCZSoOYrXGc5aQl5eAUDQ
         uwMjhnbHcTeq9GqhQTb69EV5hruX/kgWR63lS1/4+U75dNRELl9j5XzPBw5C5yzyF/A0
         iEkQ==
X-Gm-Message-State: APjAAAUlYha9geLJLxhmF7pSAS0CtRxtrtToKb/trammq74ARU5gMd+g
        fMzcboodHab5MsSuBbnd96uEYOZk
X-Google-Smtp-Source: APXvYqw61QRsYL0Lq+p6xXB8wylpboyl1Ts6lCVX0L7iemSth1vHmOlbDD2iTtXwvmvWkyZL3xVJiQ==
X-Received: by 2002:a7b:cf18:: with SMTP id l24mr2029460wmg.95.1576053467280;
        Wed, 11 Dec 2019 00:37:47 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id f1sm1406269wrp.93.2019.12.11.00.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 00:37:46 -0800 (PST)
Date:   Wed, 11 Dec 2019 09:37:45 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
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
Message-ID: <20191211083745.GA14655@dhcp22.suse.cz>
References: <20191209191346.5197-1-logang@deltatee.com>
 <20191209191346.5197-6-logang@deltatee.com>
 <ce50d9da-c60e-05a1-a86b-3bb3629de502@redhat.com>
 <f34a4c52-cc95-15ed-8a72-c05ab4fd6d33@deltatee.com>
 <CAPcyv4hpXCZxV5p7WaeGgE7ceujBBa5NOz9Z8fepDHOt6zHO2A@mail.gmail.com>
 <20191210100432.GC10404@dhcp22.suse.cz>
 <6da2b279-6a6d-d89c-a34c-962ed021d91d@redhat.com>
 <20191210103452.GF10404@dhcp22.suse.cz>
 <a9d6cfe8-39fb-accf-acdc-7cce5578bf2f@redhat.com>
 <297b7cc0-c5bc-a4c6-83eb-afc008395234@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <297b7cc0-c5bc-a4c6-83eb-afc008395234@deltatee.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-12-19 16:52:31, Logan Gunthorpe wrote:
[...]
> In my opinion, having a coder and reviewer see PAGE_KERNEL and ask if
> that makes sense is a benefit. Having it hidden because we don't want
> people to think about it is worse, harder to understand and results in
> bugs that are more difficult to spot.

My experience would disagree here. We have several examples in the MM
where an overly complex and versatile APIs led to suble bugs, a lot of
copy&pasting and cargo cult programing (just look at the page allocator
as a shiny example - e.g. gfp_flags). So I am always trying to be
carefull here.

> Though, we may be overthinking this: arch_add_memory() is a low level
> non-exported API that's currently used in exactly two places.

This is a fair argument. Most users are and should be using
add_memory().

> I don't
> think there's going to be many, if any, valid new use cases coming up
> for it in the future. That's more what memremap_pages() is for.

OK, fair enough. If this is indeed the simplest way forward then I will
not stand in the way.
-- 
Michal Hocko
SUSE Labs
