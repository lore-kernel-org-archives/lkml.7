Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73701C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EBB22CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fhxwaF26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfH1Wds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:33:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34580 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfH1Wdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:33:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id b24so702819pfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 15:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=66PbkMb43wbFePH3agbP8gVcp9PdE3fuoyONvv239XQ=;
        b=fhxwaF26Wm3uShV8EW5J5fXTEdJvGmHs8vWkWAdYOkIH1kDl6rpTUHKsB97Cf0VnyC
         zgt4tRBx/+Sk78gKLTUpjLsj+QwOOc/W+bEYxFumrwPjI38Qk7qLljoVCMOGa54MXKmW
         JK3orfdUI4DRBu2ljL/QPVrQwLSEws7pXJVboyHfDsFk0cuqoGsakjx9lguvNeHxdcJu
         xtm0Rhy8KQKuux76x4KfCfv2NvspJ5Gzwbj6s5AwlZWiSV/wfOADWCa7yrkZMw+A2cUT
         r3RTY7ps6c947DLJUiZ0pCIptAH+an3QZeJ7BcsPRnZ/uDOeA9k1ccjBth22lgQ13IvT
         B/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=66PbkMb43wbFePH3agbP8gVcp9PdE3fuoyONvv239XQ=;
        b=L1oWR3r0sEKCrSyiOeNJhRhuAZZwxn5HlOd3MNFOKieS6G5Tvs49AL1tFmn0dbb715
         GuQIiE/8rt71KCuenlhtFSv4y+DLzCUdwtwnSd6J2MVaX3st1bjkcQUmgB/vKqktWaiE
         chbV9GPefEGiOeVZjazonOpGIEQJb/1RhMtMGabcLedXrRSkt82gBePUJf/ang2J1eqT
         8pBWDqCzGDHTvy39n/uDicqpkEFgorkOmWKolRD5aNT7Jf6unhK7+7sECzbYIHU+XV2r
         tLpQKJZ6okpmed3ZooWbvTD2qUhueGBYpNRXLRlsNbADrKDqHvhCHRhHyoko7Gf2vCSe
         emjA==
X-Gm-Message-State: APjAAAXCnu1O1O9m1/3FQB8aqKxVDR+jmRfOC4CWPYzzN6C9TqGH7SSn
        1eqKRlOYbI9ApTFIwF+RR6rLEw==
X-Google-Smtp-Source: APXvYqxTOiRNDO+k+BbIpv0/8yRNCFnmkuiNEmxI3IEa1o8dk3cZhV09PVMFEK8qrPHTNbD21MdJpg==
X-Received: by 2002:aa7:991a:: with SMTP id z26mr7426934pff.43.1567031627382;
        Wed, 28 Aug 2019 15:33:47 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id p5sm397972pfg.184.2019.08.28.15.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 15:33:46 -0700 (PDT)
Date:   Wed, 28 Aug 2019 15:33:46 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Anup Patel <anup@brainfault.org>
cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] RISC-V: Fix FIXMAP area corruption on RV32 systems
In-Reply-To: <CAAhSdy0XALGpc-bCuO7njiBT3p-YvLqhMnRTRu4Hd4gMKeQMTw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1908281526410.13811@viisi.sifive.com>
References: <20190819051345.81097-1-anup.patel@wdc.com> <alpine.DEB.2.21.9999.1908261704500.10109@viisi.sifive.com> <CAAhSdy0XALGpc-bCuO7njiBT3p-YvLqhMnRTRu4Hd4gMKeQMTw@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019, Anup Patel wrote:

> On Tue, Aug 27, 2019 at 5:43 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> >
> > On Mon, 19 Aug 2019, Anup Patel wrote:
> >
> > > Currently, various virtual memory areas of Linux RISC-V are organized
> > > in increasing order of their virtual addresses is as follows:
> > > 1. User space area (This is lowest area and starts at 0x0)
> > > 2. FIXMAP area
> > > 3. VMALLOC area
> > > 4. Kernel area (This is highest area and starts at PAGE_OFFSET)
> > >
> > > The maximum size of user space aread is represented by TASK_SIZE.
> > >
> > > On RV32 systems, TASK_SIZE is defined as VMALLOC_START which causes the
> > > user space area to overlap the FIXMAP area. This allows user space apps
> > > to potentially corrupt the FIXMAP area and kernel OF APIs will crash
> > > whenever they access corrupted FDT in the FIXMAP area.
> > >
> > > On RV64 systems, TASK_SIZE is set to fixed 256GB and no other areas
> > > happen to overlap so we don't see any FIXMAP area corruptions.
> > >
> > > This patch fixes FIXMAP area corruption on RV32 systems by setting
> > > TASK_SIZE to FIXADDR_START.
> >
> > This part -- the TASK_SIZE change -- makes sense to me.
> >
> > However, the patch also changes FIXADDR_SIZE to be defined in terms of
> > page table-related constants.  Previously, FIXADDR_SIZE was based on
> > __end_of_fixed_addresses, as it is for most other architectures. The part
> > of the patch that changes FIXADDR_SIZE seems unrelated to the actual fix.
> >
> > If that's indeed the case -- that the change to FIXADDR_SIZE is unrelated
> > from the fix -- could you please split that into a separate patch, with a
> > description of the rationale?  I think I understand why you're proposing
> > it, but it seems odd to explicitly connect it to page table-related
> > constants, rather than the contents of "enum fixed_addresses", and I'm
> > reluctant to merge that part of this patch without a bit more discussion.
> 
> The FIXADDR_SIZE change is related to the TASK_SIZE requirement and
> it is not a separate change because:
> 
> 1. TASK_SIZE must be evenly divisible by PGDIR_SIZE. The FIXADDR_START
> is defined as (FIXADDR_TOP - FIXADDR_SIZE). The original FIXADDR_SIZE
> defined in-terms of __end_of_fixed_addresses is not a multiple of PGDIR_SIZE
> hence it makes sense to make FIXADDR_SIZE as PGDIR_SIZE.
> 
> 2. Let say we ignore point1 above then still we cannot continue to express
> FIXADDR_SIZE in-terms of __end_of_fixed_addresses because of cyclic
> header dependency where asm/fixmap.h includes asm/pgtable.h and
> __end_of_fixed_addresses is defined in asm/fixmap.h. We certainly need
> to move FIXADDR_TOP, FIXADDR_START, and FIXADDR_SIZE to
> asm/pgtable.h so that we can express TASK_SIZE as FIXADDR_START
> for RV32. If we don't simplify FIXADDR_SIZE then it will result in compile
> errors.


It would be better if we could stick to the same approach used by other 
Linux architectures.  That keeps things consistent across architectures.  
However, in the short term, as you note, the header file changes to get to 
that point are likely to be too intense for the late -rc series that we're 
in.

So, queued for v5.3-rc7.  Thanks very much for the speedy fix,


- Paul
