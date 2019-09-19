Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BDAC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BEC620665
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yqn2hP5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404005AbfISPSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:18:50 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42109 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389171AbfISPSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:18:50 -0400
Received: by mail-ed1-f66.google.com with SMTP id y91so3533663ede.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eJ0UWMRY33TSZcE2wFwrgcT5zmWwOXQ+xlDh/x5Rbok=;
        b=Yqn2hP5/7LoUE96rW6LgXvDeRFDoEgSIYLWO331yu/t8KvfcDLYs0svMMqhPl0nEKU
         3028G05kj86vZEYdH0BT8B4Snvw/8TzsFj/6z3cDmgcLrYqAf9CTKaxFxWz6TetvRVWD
         JaOhJxFoN6Lysw3uc3I7TCd+bGbTAYEQdtrh530GBo5Aqg2kjpsReLMDlMYPva23+thK
         3paKUHNXhfjBIBDEcc9d7OpRoL4M9YEswI1G3XEqU9hMkBTILBRZAfv3lk1GyAApc7kF
         uBVf89FvXfuH3jiXShL1/vpa79fW+aGEKUGlC597SIRD1tjHojMUhcUCeA7TA1Um/ffs
         UzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eJ0UWMRY33TSZcE2wFwrgcT5zmWwOXQ+xlDh/x5Rbok=;
        b=JTiSXK0YDQ6PJ0UzAuUCZ7IORqNVCH7gQ3DAKf87Cj/evHlUVBRcEk5ITxBBZGLJCN
         nOqOxY921OhqLO170S9NdmbvokoHEAIz7OeuG0vAz2Yeg801NsVaWmQAZ00Ah/DkzqVs
         EyfjTOgY+K2gJptiTOT7gaUSZiE6NVhSOhN5pbh8lj48usC31+iCY4n4rEP8EC9BSZda
         3UistVnimseXcvpHR4yrYVB/bpP+pv8lg84hwTHcjAkjFDhvQPuiI54n8Ky5WpDffbIw
         z6csO2RuurpokXws5yaMn4XEhdJAHqmYgUpz7FL+5o318siIbLoZbJWGMmVMlL2qRJKx
         qGaA==
X-Gm-Message-State: APjAAAUjFk5FNyJZklyBVPr2/8NG0O1mcgNcFQViQLeh03VSE/v5l/qo
        Ha5HhBYZcPQP60R5X+7YefdH6Q==
X-Google-Smtp-Source: APXvYqyjE5Z/ExpKjAFeUwQaYOlsDCBhURZQ6GgY1ZAERUi1xVf6/dGQvcGXJsfycKEfjO1ON7WJpA==
X-Received: by 2002:a17:906:6a92:: with SMTP id p18mr14982887ejr.253.1568906327557;
        Thu, 19 Sep 2019 08:18:47 -0700 (PDT)
Received: from lophozonia ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id x4sm763681eds.87.2019.09.19.08.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 08:18:46 -0700 (PDT)
Date:   Thu, 19 Sep 2019 17:18:44 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>, christoffer.dall@arm.com,
        Atish Patra <Atish.Patra@wdc.com>,
        Julien Grall <julien.grall@arm.com>, gary@garyguo.net,
        linux-riscv@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        Mike Rapoport <rppt@linux.ibm.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, suzuki.poulose@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-arm-kernel@lists.infradead.org,
        Anup Patel <anup.Patel@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, james.morse@arm.com
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
Message-ID: <20190919151844.GG1013538@lophozonia>
References: <CAJF2gTTmFq3yYa9UrdZRAFwJgC=KmKTe2_NFy_UZBUQovqQJPg@mail.gmail.com>
 <20190619123939.GF7767@fuggles.cambridge.arm.com>
 <CAJF2gTSiiiewTLwVAXvPLO7rTSUw1rg8VtFLzANdP2S2EEbTjg@mail.gmail.com>
 <20190624104006.lvm32nahemaqklxc@willie-the-truck>
 <CAJF2gTSC1sGgmiTCgzKUTdPyUZ3LG4H7N8YbMyWr-E+eifGuYg@mail.gmail.com>
 <20190912140256.fwbutgmadpjbjnab@willie-the-truck>
 <CAJF2gTT2c45HRfATF+=zs-HNToFAKgq1inKRmJMV3uPYBo4iVg@mail.gmail.com>
 <CAJF2gTTsHCsSpf1ncVb=ZJS2d=r+AdDi2=5z-REVS=uUg9138A@mail.gmail.com>
 <057a0af3-93f7-271c-170e-4b31e6894c3c@linaro.org>
 <CAJF2gTRbyfrUqAULPqJTXdxx8YOscPqAEuMsoJ+dTNobNrUV1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTRbyfrUqAULPqJTXdxx8YOscPqAEuMsoJ+dTNobNrUV1g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 09:07:15PM +0800, Guo Ren wrote:
> > The solution I had to this problem is pinning the ASID [1] used by the
> > IOMMU, to prevent the CPU from recycling the ASID on rollover. This way
> > the CPU doesn't have to wait for IOMMU invalidations to complete, when
> > scheduling a task that might not even have anything to do with the IOMMU.
> >
> 
> > In the Arm SMMU, ASID and IOASID (PASID) are separate identifiers. IOASID
> > indexes an entry in the context descriptor table, which contains the ASID.
> > So with unpinned shared ASID you don't need to invalidate the ATC on
> > rollover, since the IOASID doesn't change, but you do need to modify the
> > context descriptor and invalidate cached versions of it.
> The terminology confused me a lot. I perfer use PASID for IOMMU and
> ASID is for CPU.
> Arm's entry of the context descriptor table contains a "IOASID"

The terminology I've been using so far is different:
* IOASID is PASID
* The entry in the context descriptor table contains an ASID, which
  is either "shared" with CPUs or "private" to the SMMU (the SMMU spec
  says "shared" or "non-shared").
* So the CPU and SMMU TLBs use ASIDs, and the PCI ATC uses IOASID

> IOASID != ASID for CPU_TLB and IOMMU_TLB.
> 
> When you say "since the IOASID doesn't change",Is it PASID or my IOASID ? -_*!

I was talking about PASID. Maybe we can drop "IOASID" and talk only
about ASID and PASID :)

> PASID in PCI-sig was used to determine transfer address space.
> For intel, the entry which is indexed by PASID also contain S1/S2.PGD
> and DID(VMID).
> For arm, the entry which is indexed by PASID only contain S1.PGD and
> IOASID. Compare to Intel Vt-d Scalable mode, arm's design can't
> support PCI Virtual Function.

The SMMU does support PCI Virtual Function - an hypervisor can assign a
VF to a guest, and let that guest partition the VF into smaller contexts
by using PASID.  What it can't support is assigning partitions of a PCI
function (VF or PF) to multiple Virtual Machines, since there is a
single S2 PGD per function (in the Stream Table Entry), rather than one
S2 PGD per PASID context.

Thanks,
Jean

> > Once you have pinned ASIDs, you could also declare that IOASID = ASID. I
> > don't remember finding an argument to strictly forbid it, even though ASID
> > and IOASID have different sizes on Arm (respectively 8/16 and 20 bits).
> ASID and IOASID are hard to keep the same between CPU system and IOMMU
> system. So I introduce S1/S2.PGD.PPN as a bridge between CPUs and
> IOMMUs.
> See my proposal [1]
> 
> 1: https://lore.kernel.org/linux-csky/1568896556-28769-1-git-send-email-guoren@kernel.org/T/#u
> -- 
> Best Regards
>  Guo Ren
> 
> ML: https://lore.kernel.org/linux-csky/
