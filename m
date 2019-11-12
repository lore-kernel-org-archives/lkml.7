Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C737C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 04:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E978206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 04:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="OmfMPkcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKLETv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 23:19:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55053 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKLETv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 23:19:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id z26so1536999wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 20:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F92ESdQX6UoJ61XjdWNouamb4m5JYUWzj/93fvLdDW8=;
        b=OmfMPkcUsU4z4Sge8bbBGEf7SLKlM3zhGCh0zWkASXg12E0B76dN5oZOy50OqSen1L
         1qJ58buJa6TvWFnwHI6+I4W2b/5sa2njMM/hRsRF2CzNeTvxKHHc5XODZGkOkAZNQdb+
         kmQUKgqavl1owTAsagWk5aktCyU5/kKKFMAYIECRxHFV4QYPrknpv+bLeBERhlefqQix
         zC4Ll2iHktkfcr4x9fNo18SgWbImwnGqLDv+YuvYnE+ZIUC/rbth6mhX7cL1De1ihAwf
         uwO/R75QZaq4bpRhJ1WbV1KqRcesyyM1jw7m3UJ6e35HL63OYmtydAILVbAjDmHpTosG
         YVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F92ESdQX6UoJ61XjdWNouamb4m5JYUWzj/93fvLdDW8=;
        b=gQsuu4w1t0FjYIRiDoQKVwxg4/FhKa+Kynv8wSJ/BxqWeT1b3+wISGRPeZBWpc13sb
         25D1cXpeZcENMPkzsiEZylqJLYCi8SAxLPC7QeFIvbeJ+BaW50hnsofNnCAHaog7C91w
         hq/G7oS5sAY1TwJNm/mPJXNsHdmNa1CYf9EkhRKmkMapYV6FHSWFHBMwmXqWKwh0UC3f
         Dv/BC6KAxKYsLBsl7UhMvt3adHwTN3pb60FpwvZ0uqUgFwwNk78dcSZ+jTmluMoWvQ94
         RRWExKsXCElscGZBBuyHYKISL7sOzDMqgS0YSF6aleXci37knOpkYk07Jxl3RvgFruyD
         DLZQ==
X-Gm-Message-State: APjAAAXumxYTVKlwNRCLveOscHA5yjt1YRl6mnqcMSle7me5xZckcbiq
        mtuqnGuZ0UVguDmGVMd+l01By/RKIj/q6bgXKp50Bg==
X-Google-Smtp-Source: APXvYqxfmg4gwVVmXOge9gfCiEkbE8Xe6rCqSJCbDSL9MSZe/0J4HCGkyOMrCS/FGlQu5ML00TxzFQzsi3f5hz3ZMUw=
X-Received: by 2002:a1c:9a4f:: with SMTP id c76mr1912349wme.103.1573532389104;
 Mon, 11 Nov 2019 20:19:49 -0800 (PST)
MIME-Version: 1.0
References: <20191111133421.14390-1-anup.patel@wdc.com> <alpine.DEB.2.21.999.1911111705350.30304@utopia.booyaka.com>
In-Reply-To: <alpine.DEB.2.21.999.1911111705350.30304@utopia.booyaka.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 12 Nov 2019 09:49:38 +0530
Message-ID: <CAAhSdy28n=XkhcZC2=7L8YZyxa5yJ+CUso_s7kK5FacUQM6tMA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Enable SYSCON reboot and poweroff drivers
To:     Paul Walmsley <paul@pwsan.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 10:36 PM Paul Walmsley <paul@pwsan.com> wrote:
>
> On Mon, 11 Nov 2019, Anup Patel wrote:
>
> > We can use SYSCON reboot and poweroff drivers for the
> > SiFive test device found on QEMU virt machine and SiFive
> > SOCs.
> >
> > This patch enables SYSCON reboot and poweroff drivers
> > in RV64 and RV32 defconfigs.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
>
> I'd much prefer Christoph's driver, once it's fixed up per my earlier
> comments.  This business with writing random registers based on what's in
> the DT data has always been a bad idea.

Like mentioned in other email thread, we are not writing random
date to registers. In fact, we are describing Reboot and Poweroff
mechanism in DT using SYSCON Reboot and Poweroff DT nodes.

This is not a new approach. It has been used by a variety of SOCs
in past.

Regards,
Anup
