Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F3CC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 00:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1633A21920
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 00:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568938075;
	bh=KAhGCSVOVtUtAdEEuBhsqNfJhp1wcq6UJPR1rEams+Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KgvoEuhl9MlsgTD35o1JgxhW0XmJxj2nny83aZyyqxhfNItxQrtq+UeCBV0m5QYlq
	 7ROMgxwBTqBN3yn2YarwBkNZWRZRrDqCJ8CmGCmZSHtMGVMaM16IFpBFucvpWf2zuM
	 jSIGTj3sB5Lv4v9rnpydmca3itS2aVpH75+eqMQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392076AbfITAHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 20:07:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388604AbfITAHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 20:07:53 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9CBD21920
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 00:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568938073;
        bh=KAhGCSVOVtUtAdEEuBhsqNfJhp1wcq6UJPR1rEams+Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=v5PB0HhvLmN/6ZaebrnHpnUH8NPDVNrrZqFQJxlbGHGW5BjN98ufBDZu0YRL8ANiQ
         BHqOCR3wlr8v5DE9t9rfG9yqZ1DCDNMv6n2DSES9zAB5DSHPlgCTPmZGM6nLPW8pkH
         s3npw8z3tv+lCr63gyPA3pj9qac4w4UP86/GKnD8=
Received: by mail-wr1-f52.google.com with SMTP id l11so4927218wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 17:07:52 -0700 (PDT)
X-Gm-Message-State: APjAAAWLSo5V/YeMBuHHBlrQdQsKiFrtKfbj3enTUyaLWOXqLsRN9lX+
        OvmzS1HWrC/jkceKSfUc6aU1DYktKm8DSZM7xhQ=
X-Google-Smtp-Source: APXvYqzYKnFXikeBrYgOpER2Qjc+5Diq7t0DgzMJf2ATPzJa1qK18MTpVnoNyg+SDqozE2cOBqwBEvImB62CtwuT4PI=
X-Received: by 2002:adf:fe0f:: with SMTP id n15mr9371291wrr.343.1568938071266;
 Thu, 19 Sep 2019 17:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAJF2gTTmFq3yYa9UrdZRAFwJgC=KmKTe2_NFy_UZBUQovqQJPg@mail.gmail.com>
 <20190619123939.GF7767@fuggles.cambridge.arm.com> <CAJF2gTSiiiewTLwVAXvPLO7rTSUw1rg8VtFLzANdP2S2EEbTjg@mail.gmail.com>
 <20190624104006.lvm32nahemaqklxc@willie-the-truck> <CAJF2gTSC1sGgmiTCgzKUTdPyUZ3LG4H7N8YbMyWr-E+eifGuYg@mail.gmail.com>
 <20190912140256.fwbutgmadpjbjnab@willie-the-truck> <CAJF2gTT2c45HRfATF+=zs-HNToFAKgq1inKRmJMV3uPYBo4iVg@mail.gmail.com>
 <CAJF2gTTsHCsSpf1ncVb=ZJS2d=r+AdDi2=5z-REVS=uUg9138A@mail.gmail.com>
 <057a0af3-93f7-271c-170e-4b31e6894c3c@linaro.org> <CAJF2gTRbyfrUqAULPqJTXdxx8YOscPqAEuMsoJ+dTNobNrUV1g@mail.gmail.com>
 <20190919151844.GG1013538@lophozonia>
In-Reply-To: <20190919151844.GG1013538@lophozonia>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 20 Sep 2019 08:07:38 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQtk7VhBgUan6WOZgc3UaQzHL8SxMi=yiHG-8eC207BbQ@mail.gmail.com>
Message-ID: <CAJF2gTQtk7VhBgUan6WOZgc3UaQzHL8SxMi=yiHG-8eC207BbQ@mail.gmail.com>
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 11:18 PM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:

>
> The SMMU does support PCI Virtual Function - an hypervisor can assign a
> VF to a guest, and let that guest partition the VF into smaller contexts
> by using PASID.  What it can't support is assigning partitions of a PCI
> function (VF or PF) to multiple Virtual Machines, since there is a
> single S2 PGD per function (in the Stream Table Entry), rather than one
> S2 PGD per PASID context.
>
In my concept, the two sentences "The SMMU does support PCI Virtual
Functio" v.s. "What it can't support is assigning partitions of a PCI
function (VF or PF) to multiple Virtual Machines" are conflict and I
don't want to play naming game :)

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
