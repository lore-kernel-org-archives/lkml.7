Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9761C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 06:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5479A206DD
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 06:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="wCbRnxyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfDEGBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 02:01:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45443 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDEGBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 02:01:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so6417198wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 23:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8I8m7SSC/snr0cHsf2WBlkwE7bpgw/OQ5jKqCBoq9zo=;
        b=wCbRnxyNLYVi4sK6lQm7TJGYYG8lp5FUVtlVJG6aY097PpRMyg6nRbW3h2OU3mSmfe
         Z/2Dd8toqy/+d6M+wypyVE/QVDncGTa90b1UkJfwIrQdzuLnvUkdcYFDAnM9Pg4NDgvE
         xWwhtsVCZXpR94MvLQhD9J+Iuo02G1yg4J5zd+36PXDualUnZZy67CzbtmfaeQp5oJGz
         YyfQl89/SCjIQE2ijWgHUamQ5RrB53vkpNljo5f71agmlbc08SAaX7tnkF96x1DeIlag
         g//su1j0BxdcEU4uEkmNQ8DrN8Isruybr4p83MLzgLo7SeNQj6ALF8FDr7PEWHr+zgwz
         tCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8I8m7SSC/snr0cHsf2WBlkwE7bpgw/OQ5jKqCBoq9zo=;
        b=kv+AfiPJlS6fOdqcVcVcKxKrdh5K4SmqACCK1tmwDZToZ+BkhezE4UT+tfoOPh9At6
         6XIO/2hTSmgx/fyi4Pbp+gCcpVWURA1FKsGVfV2+6fyXKGqjEHj1B8U0mxwSCayVoE/Z
         sNc90yu84NGo2I966i09XLDsrlzhosuwJfXXXpPNsEOInJmIIi7I/tsz7UeJiEYjRBzW
         L/ho/HiPEG3ZZIblH6iImKBH9J3sIAz6O4FaPDqxnDjeArXkr1JaQTICkMCEowKy0I56
         o2VdMcfY1hSm67SPPpDEH1KYQVAH5+pVqMuk6krCgOWZRWrFTK1lVy1yEYkEmgOdVMVZ
         e2nQ==
X-Gm-Message-State: APjAAAWhkZpJ88p7kKkSI8D9Vamy3EXKsA5aZQYuYNRKmDOusivT+n08
        3Em7G1fSRuWTa9LhM/3D7W6xKyOZGqJJ0hxQEd8wP30WtoYokA==
X-Google-Smtp-Source: APXvYqwvVpi/LoncOYPYpBig+SQjHxP1DEaiXzYYe2cURFDrQOVHHYJ4xS0lDAEgDIJDOniOxhm435shCG4GgfH5Ksw=
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr6002760wrp.61.1554444081974;
 Thu, 04 Apr 2019 23:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190405054909.3238-1-anup.patel@wdc.com> <20190405055421.GA7087@infradead.org>
In-Reply-To: <20190405055421.GA7087@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 5 Apr 2019 11:31:11 +0530
Message-ID: <CAAhSdy0k0gSipzne1=agZzTWa0URoq3OH7vefJsr2=SEMyJ1tg@mail.gmail.com>
Subject: Re: [PATCH v3] RISC-V: Fix Maximum Physical Memory 2GiB option for
 64bit systems
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 11:24 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Apr 05, 2019 at 05:49:34AM +0000, Anup Patel wrote:
> > The Maximum Physical Memory 2GiB option for 64bit systems is currently
> > broken because kernel hangs at boot-time when this option is enabled
> > and the underlying system has more than 2GiB memory.
> >
> > This issue can be easily reproduced on SiFive Unleashed board where
> > we have 8GiB of memory.
> >
> > This patch fixes above issue by removing unusable memory region in
> > setup_bootmem().
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> Btw, what is the rationale behind even offering the 2GiB option and
> the medlow model on 64-bit?  Do we reall have use cases where the
> slightly more effient generated code matters so much to keep up
> the support burden of this mostly unused and unusual configuration?

Yes, if we want to use medlow with 64bit then max physical memory
can be 2GiB. Otherwise, I don't any practical use of restricting max
physical memory to 2GiB on 64bit systems.

BTW, as-per latest revision of RISC-V priviledge spece the MMU SV32
mode will be able to access 34bit physical memory (i.e. 16GiB) so
max physical memory 2GiB will also be required for 32bit system for
medlow.

Regards,
Anup
