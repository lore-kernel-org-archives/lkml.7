Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31955C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F110E2173C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ixL2l2Vf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfDEVR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:17:29 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37486 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfDEVR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 17:17:29 -0400
Received: by mail-qt1-f195.google.com with SMTP id z16so9119878qtn.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 14:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=i1e4wK7Wp/95BF47ls3i/xUTVnvFhsWDCLNPMoB/w6I=;
        b=ixL2l2VfaumUHMV8DKvjljQXGinkk4t//a60hFA8P9qeQurcO/nNRbapEWSRhk5qGm
         t6/Gu++IXEGPSncAeLvXDX8ODSfsL7z8ci24Yld8/N6JQFJIo4sPsoEBmfWodb9K35hl
         TKGMi+71VqJ/PjUF2x+qqHzqPlAvtPIjnSx37ChtA1hgXb8QSgwZycLUyBSf/FLkp+FC
         FUsIBkBdhipUtJs9Dr8gn6c6BXSPntg8GZfEuvU8vhS2hh7IIL9SGzqcc8B31fvaZ7Ob
         ImS7IPMnHN3XjJjRt7roSAV/0EgkzT8dssQ46Zao4pqrhfHE9WLt6ISBoQbcA/Nz2i57
         6bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=i1e4wK7Wp/95BF47ls3i/xUTVnvFhsWDCLNPMoB/w6I=;
        b=ThvjBCf4HDHio2FMwD+pLh12Sat7jVadotlzC0GflyC/6vBFhe0d1XCHGS4rTKTWWk
         KCCxEOM+a/+Tezu+HmzN+tJdDiuyQMLZ6xX3S3zRXoEzDPeWr3/4T6pYHWgpLUGB5010
         wHZVAVhJJcfz07RDNtAMJGByw49Rd2IhO90x/nXVBM6SWXCEmUZ5XWOCjz8sEXiPx5Pp
         PyK22OnyYkeJGy3370sVSLwg3zgESpHjbiI0+Ho1lJ6r/dq8KeIqU8wWLv9I8JVL5YOk
         3zg7vFrSXaBaHDn85kCOGIcThsmt09zdpvD0zSGIvW0gpxLhiR2oxyuc8NZaII1H4VbM
         qKrA==
X-Gm-Message-State: APjAAAXco/es0j7kPNyNJxg76vf+HR93YgjyOqGQgstNngo+3lCFmCQa
        r3OS+j0E5UaDEDtKLf9r/FK+CqBTckUvNw==
X-Google-Smtp-Source: APXvYqyZF9VJqS+i3Kd0Boli1jbCdp7vkSNuAywV8rNAZKej8AKs5tHkV7ZHIaz5r2tUUgXFJavNpA==
X-Received: by 2002:ac8:65c3:: with SMTP id t3mr13074389qto.12.1554499048388;
        Fri, 05 Apr 2019 14:17:28 -0700 (PDT)
Received: from localhost ([199.255.44.128])
        by smtp.gmail.com with ESMTPSA id o136sm12487543qke.48.2019.04.05.14.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 14:17:27 -0700 (PDT)
Date:   Fri, 05 Apr 2019 14:17:27 -0700 (PDT)
X-Google-Original-Date: Fri, 05 Apr 2019 11:20:51 PDT (-0700)
Subject:     Re: [PATCH v3] RISC-V: Fix Maximum Physical Memory 2GiB option for 64bit systems
In-Reply-To: <CAAhSdy0k0gSipzne1=agZzTWa0URoq3OH7vefJsr2=SEMyJ1tg@mail.gmail.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        Anup Patel <Anup.Patel@wdc.com>, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, rppt@linux.ibm.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-6bd91073-ecae-4da5-8332-0e6c9f8aaac1@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Apr 2019 23:01:11 PDT (-0700), anup@brainfault.org wrote:
> On Fri, Apr 5, 2019 at 11:24 AM Christoph Hellwig <hch@infradead.org> wrote:
>>
>> On Fri, Apr 05, 2019 at 05:49:34AM +0000, Anup Patel wrote:
>> > The Maximum Physical Memory 2GiB option for 64bit systems is currently
>> > broken because kernel hangs at boot-time when this option is enabled
>> > and the underlying system has more than 2GiB memory.
>> >
>> > This issue can be easily reproduced on SiFive Unleashed board where
>> > we have 8GiB of memory.
>> >
>> > This patch fixes above issue by removing unusable memory region in
>> > setup_bootmem().
>> >
>> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
>> > Reviewed-by: Christoph Hellwig <hch@lst.de>
>>
>> Btw, what is the rationale behind even offering the 2GiB option and
>> the medlow model on 64-bit?  Do we reall have use cases where the
>> slightly more effient generated code matters so much to keep up
>> the support burden of this mostly unused and unusual configuration?

I'd be OK dropping medlow on rv64.  The performance impact of medany is pretty minor 
these days, and even back when we added the option it was mostly paranoia about 
the linker being correct.  medany has been solid on rv64 for a while, but we 
did recently find a pretty major toolchain bug in medany/rv32 so if we were to 
drop that we'd need to enforce a pretty recent binutils version (the latest 
release is OK, I'd have to check on the previous one).  I'd prefer to avoid 
that, and since medany doesn't really buy us anything on rv32 it seems fine to 
leave it that way.

Given how many issues we've found here recently I doubt anyone is flipping this 
option away from the default for their base ISA.

> Yes, if we want to use medlow with 64bit then max physical memory
> can be 2GiB. Otherwise, I don't any practical use of restricting max
> physical memory to 2GiB on 64bit systems.
>
> BTW, as-per latest revision of RISC-V priviledge spece the MMU SV32
> mode will be able to access 34bit physical memory (i.e. 16GiB) so
> max physical memory 2GiB will also be required for 32bit system for
> medlow.

It's a bit more complicated that than.  The 34-bit physical addresses have been 
in the spec for a long time, but we've never bothered supporting them in Linux.  
Right now we assume we can map all physical memory into a contiguous region, 
which is why we tie PAGE_OFFSET to the maximum physical memory.  It's 
impossible to map all physical memory with 34-bit physical addresses on a 
32-bit system, so we'll need to break that assumption to move forward with 
34-bit physical addresses anyway.

Additionally: medlow can map everything on 32-bit systems anyway, so moving to 
medany doesn't buy you anything.
