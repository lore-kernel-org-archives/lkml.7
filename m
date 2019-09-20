Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63139C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB622086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PxlvuUd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394979AbfITHS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 03:18:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33404 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390680AbfITHS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 03:18:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id c4so5444864edl.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 00:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BUHblpDIooIrZQuKvaVSkR4gzneP4UJ1DcsQqZl+esY=;
        b=PxlvuUd0/XaEgntK4rFzZoabSaLZYdKu65/CtEXGWfgiVeEBvKri54p1YtHbV54Vso
         sabWrBBBMhYzdp7d9KnVvJ/FiP9nwjBPydyvYFnlc7zKZcYqw5CKdFoVfJbkKzEkyW8J
         CbOHOI8iEMOPf8+cqLKWOimzXm8Ft2DbTDipqB28PvufFkFwN/HwQpvHtkb5hPqIHcos
         at6f3Y25OcKlt53k4/1F7Xocn9shMsVcmKDZVF/Qf1zQR0/4p7zv4zjgJkoeiz/cOxq8
         Bsk9EtGiHn+FXXRvu8plA2+/ymlFBMGxhfBebvI67y9BIVOMgwSqDpoC7Orus1cUkvNB
         UyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BUHblpDIooIrZQuKvaVSkR4gzneP4UJ1DcsQqZl+esY=;
        b=B84YfZg6+eDbtpgJGIXcYzO90NmIJsSmMZLNJhDhIjwXMu7Alrn9HLW260LfLzictE
         G9qfcZFRSeY3+P9G6nszrhLjDwAPPpkdtVQEeYH+DK06nZYPtD5l2tuPU931vbWKwK9k
         D+HpjKS+4KZONGpLaiwhNgn/OVeYZGBQCvGEAKjdU3cm4B7XgvEgs0foqsVhiJlz4VyG
         l/8YNzsipbwZNFpWMcG/I2+q+tPGQy7ikG9kwRKINaSdiW9sN0UBv2TKeBDLgPYzFdPQ
         tTcetaPhxSJchgpo5MVsxwa+ajAzoQXd1yz2nrxuCxv6T0AZa6PCazlUbc2r2k/613fR
         JKGA==
X-Gm-Message-State: APjAAAX+KnbFkA6TldbThT1x0FzI4IL13njN0B1bGiDIR+FYIX5Ruvjj
        pOXNoMtPw5hPkrs9TQHlW/wlYg==
X-Google-Smtp-Source: APXvYqzlWVFt2wqR2XV+/SkmRXHJ3VguPiEFC4D4xWO75dtqYKoxP+71EoOFdi2jld8XfBiJJ9aMHA==
X-Received: by 2002:a05:6402:17eb:: with SMTP id t11mr19808894edy.97.1568963904689;
        Fri, 20 Sep 2019 00:18:24 -0700 (PDT)
Received: from lophozonia ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id e13sm55819eje.52.2019.09.20.00.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 00:18:24 -0700 (PDT)
Date:   Fri, 20 Sep 2019 09:18:21 +0200
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
Message-ID: <20190920071821.GA1229556@lophozonia>
References: <CAJF2gTSiiiewTLwVAXvPLO7rTSUw1rg8VtFLzANdP2S2EEbTjg@mail.gmail.com>
 <20190624104006.lvm32nahemaqklxc@willie-the-truck>
 <CAJF2gTSC1sGgmiTCgzKUTdPyUZ3LG4H7N8YbMyWr-E+eifGuYg@mail.gmail.com>
 <20190912140256.fwbutgmadpjbjnab@willie-the-truck>
 <CAJF2gTT2c45HRfATF+=zs-HNToFAKgq1inKRmJMV3uPYBo4iVg@mail.gmail.com>
 <CAJF2gTTsHCsSpf1ncVb=ZJS2d=r+AdDi2=5z-REVS=uUg9138A@mail.gmail.com>
 <057a0af3-93f7-271c-170e-4b31e6894c3c@linaro.org>
 <CAJF2gTRbyfrUqAULPqJTXdxx8YOscPqAEuMsoJ+dTNobNrUV1g@mail.gmail.com>
 <20190919151844.GG1013538@lophozonia>
 <CAJF2gTQtk7VhBgUan6WOZgc3UaQzHL8SxMi=yiHG-8eC207BbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTQtk7VhBgUan6WOZgc3UaQzHL8SxMi=yiHG-8eC207BbQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 08:07:38AM +0800, Guo Ren wrote:
> On Thu, Sep 19, 2019 at 11:18 PM Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> 
> >
> > The SMMU does support PCI Virtual Function - an hypervisor can assign a
> > VF to a guest, and let that guest partition the VF into smaller contexts
> > by using PASID.  What it can't support is assigning partitions of a PCI
> > function (VF or PF) to multiple Virtual Machines, since there is a
> > single S2 PGD per function (in the Stream Table Entry), rather than one
> > S2 PGD per PASID context.
> >
> In my concept, the two sentences "The SMMU does support PCI Virtual
> Functio" v.s. "What it can't support is assigning partitions of a PCI
> function (VF or PF) to multiple Virtual Machines" are conflict and I
> don't want to play naming game :)

That's fine. But to prevent the spread of misinformation: Arm SMMU
supports PCI Virtual Functions.

Thanks,
Jean
