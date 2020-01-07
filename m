Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AADAC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC0C206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PHyPQo+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgAGT52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:57:28 -0500
Received: from mail-pf1-f169.google.com ([209.85.210.169]:45475 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbgAGT51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 14:57:27 -0500
Received: by mail-pf1-f169.google.com with SMTP id 2so366225pfg.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 11:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Yxkh8StDu3vfVeGtFseg/gks40WP5yhSnsk2dLl/57E=;
        b=PHyPQo+yCzPgAyKjg4UI6suHI+/ilkeRBuy3mWhSA7DVXVKUcuiIVjWuDG0hXVodbp
         mcEUZ8yoRDIY3DPtWAuhFQ88QZR7soYmQyLQTqZEszF+yPWu2wMSk1CpA4LR0pAbrVDd
         q4LBK2ljorr++qqoPelhCd8t1EggBBdeX0WFOtKW4VJUvq6lJa/RNpWb1Q+6eNYfCjNr
         T9NWKpNAY1pnkoHSYx9wgQ+JL6d2py3WTMFS5HkJExIw+lWTzuUQDmzDKTyKEcA43Sv9
         oa3NoHBG3bOurQC3DwKeSF7NSDYXgga0LPUAg3n7pfsZ+UJCxf0vDwgnCF7ayUcKrSKK
         GNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Yxkh8StDu3vfVeGtFseg/gks40WP5yhSnsk2dLl/57E=;
        b=tFgzXW4TSn0zttr0wm91/E9hpaCOsYt/J6JZEkkNLIGI7sP1vj1aMKNkCpqTCF9gwd
         UllXJXp3ijoYO9kqyH8OJ2RpAmjaSPNjHA56NxBE8SiojDW2EmDTKco2aytXmHobzml7
         07Z4ahFJOEgMA3sZEfkG/tbmgkVRXG+1Bd/uBnZZ3VuChlloTBI0n9j5tMB/8pZc4Q8A
         wymUJMqZDiLY0nzigSbBdW5Tzm2thlnZDeCt+zy+qwPwvZDwoEHSZvutLOXBT47JIFN5
         ktXKO2nT00fuIQ8Ly712zFJs3J3WhEo2fSivKEElC4R3pI9lonG92jpmsL05kVTd15JU
         kR+A==
X-Gm-Message-State: APjAAAXMHazPm8ns29RORg2rx+PS7KvfpX13145drROJmg1rUwveFTy6
        uFzeGhL6ach1VFm6mN8JYFO0/A==
X-Google-Smtp-Source: APXvYqxGdQcWNlWl+zmmQVooo+EnW/Y+CbADoGAw4kD88ujWmMJ3/b6XJYMmHmJAn2JPkQWEtaw04g==
X-Received: by 2002:a65:538b:: with SMTP id x11mr1139153pgq.395.1578427045338;
        Tue, 07 Jan 2020 11:57:25 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 2sm373729pjh.19.2020.01.07.11.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 11:57:24 -0800 (PST)
Date:   Tue, 7 Jan 2020 11:57:24 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Robin Murphy <robin.murphy@arm.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, baekhw@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [rfc] dma-mapping: preallocate unencrypted DMA atomic pool
In-Reply-To: <20200107105458.GA3139@lst.de>
Message-ID: <alpine.DEB.2.21.2001071152020.183706@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com> <3213a6ac-5aad-62bc-bf95-fae8ba088b9e@arm.com> <20200107105458.GA3139@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2020, Christoph Hellwig wrote:

> > On 01/01/2020 1:54 am, David Rientjes via iommu wrote:
> >> Christoph, Thomas, is something like this (without the diagnosic
> >> information included in this patch) acceptable for these allocations?
> >> Adding expansion support when the pool is half depleted wouldn't be *that*
> >> hard.
> >>
> >> Or are there alternatives we should consider?  Thanks!
> >
> > Are there any platforms which require both non-cacheable remapping *and* 
> > unencrypted remapping for distinct subsets of devices?
> >
> > If not (and I'm assuming there aren't, because otherwise this patch is 
> > incomplete in covering only 2 of the 3 possible combinations), then 
> > couldn't we keep things simpler by just attributing both properties to the 
> > single "atomic pool" on the basis that one or the other will always be a 
> > no-op? In other words, basically just tweaking the existing "!coherent" 
> > tests to "!coherent || force_dma_unencrypted()" and doing 
> > set_dma_unencrypted() unconditionally in atomic_pool_init().
> 
> I think that would make most sense.
> 

I'll rely on Thomas to chime in if this doesn't make sense for the SEV 
usecase.

I think the sizing of the single atomic pool needs to be determined.  Our 
peak usage that we have measured from NVMe is ~1.4MB and atomic_pool is 
currently sized to 256KB by default.  I'm unsure at this time if we need 
to be able to dynamically expand this pool with a kworker.

Maybe when CONFIG_AMD_MEM_ENCRYPT is enabled this atomic pool should be 
sized to 2MB or so and then when it reaches half capacity we schedule some 
background work to dynamically increase it?  That wouldn't be hard unless 
the pool can be rapidly depleted.

Do we want to increase the atomic pool size by default and then do 
background dynamic expansion?
