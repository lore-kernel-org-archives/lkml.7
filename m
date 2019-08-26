Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF25C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 21:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EFB206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 21:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="W5Be1yQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfHZVRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 17:17:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42117 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfHZVRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 17:17:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id p3so11324846pgb.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 14:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=4iHMLHThNJBGjTESO+UXuVCPR4zQ2/5AcoKCoGrbBlQ=;
        b=W5Be1yQ3bDSisWGF6V4Q9m+ydc849sRP0naZI4+CYyzgn4o3VQnpOx3Nz4lDPmCgb9
         H9DZHtmekFPPfLQDdKNYT+tFQHK1UGzMydODz/gQUzedYRB+/n7aw5Er8mkzEG02w9FJ
         gNM594n8bZMI744xF/MrnFagyk0yg3J501l8upZ8smL5ZCT7nQWuxGR8OaK2ey9QfMfL
         ztVjwtUq8XPta3pz2KS2xBCtwCCGD8pfAWFrfa2OCMFQd3ghu6k0VRLnlXYZkBZJ7yK6
         LZkliejccx4b6agYqpa+wBaUSe7jmwEYytyF3ZHCANseop1sK8hqxxQb2OYrY8Tnac+I
         CdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=4iHMLHThNJBGjTESO+UXuVCPR4zQ2/5AcoKCoGrbBlQ=;
        b=JVWKf7crWWHlKK0UYAwoP95cpTD2gEVkepB5jjZKRpQR1NU0hskL9g+oMUm7WOAqDf
         X2FAR56SJF+cUj47PgO9is1nqHfwheFQOImKlKqU3yR5FPLfjGOWcC4ec6MlgpMuzpFC
         pPU5JRL5mD+KUgGdF2llubEbDlvOOidNz1wHKfVSy4daErYUryty29lljDFUml8Vu8KZ
         nFV1U98bvFOA7/Tkl1y2ng0M/Ag/d2bSU49Kc7WBOG1iVtOPqWK22CckF8hYp29hG3LT
         iTKj8kLR2bT2tRzX6vyrqGWQ/6GzGHA81RE894LtUzYYOwPx4wgsy9z7FGSBbSyJQVg2
         vaNw==
X-Gm-Message-State: APjAAAXGFrbH7SAdhl5SQFXsmp2wilpZihjaM+aQ2xWW0KW1QmktzHW0
        3PzEfhrjnFxpsgUrfEgu23ovbA==
X-Google-Smtp-Source: APXvYqxqVbAI/HR7BzF5tThL2lMrXkfE6uTqMaGDuM1Yy2DRHc6du5lFLc6qBNAGV07fW7NtzXWf7A==
X-Received: by 2002:a63:6206:: with SMTP id w6mr18127988pgb.428.1566854262237;
        Mon, 26 Aug 2019 14:17:42 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id m13sm12988366pgn.57.2019.08.26.14.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 14:17:41 -0700 (PDT)
Date:   Mon, 26 Aug 2019 14:17:41 -0700 (PDT)
X-Google-Original-Date: Mon, 26 Aug 2019 14:17:38 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Fix FIXMAP area corruption on RV32 systems
In-Reply-To: <CAAhSdy1arxoekV4p3so=2PtTtBCvT61sz+uDbaZ=e11p7b5DXg@mail.gmail.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-7a475a74-60cb-4e3f-bcae-6cd6299bb173@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Aug 2019 21:49:01 PDT (-0700), anup@brainfault.org wrote:
> On Sun, Aug 18, 2019 at 11:49 PM Christoph Hellwig <hch@infradead.org> wrote:
>>
>> > +#define FIXADDR_TOP      (VMALLOC_START)
>>
>> Nit: no need for the braces, the definitions below don't use it
>> either.
>
> Sure, I will update and send v2 soon.
>
>>
>> > +#ifdef CONFIG_64BIT
>> > +#define FIXADDR_SIZE     PMD_SIZE
>> > +#else
>> > +#define FIXADDR_SIZE     PGDIR_SIZE
>> > +#endif
>> > +#define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
>> > +
>> >  /*
>> > - * Task size is 0x4000000000 for RV64 or 0xb800000 for RV32.
>> > + * Task size is 0x4000000000 for RV64 or 0x9fc00000 for RV32.
>> >   * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
>> >   */
>> >  #ifdef CONFIG_64BIT
>> >  #define TASK_SIZE (PGDIR_SIZE * PTRS_PER_PGD / 2)
>> >  #else
>> > -#define TASK_SIZE VMALLOC_START
>> > +#define TASK_SIZE FIXADDR_START
>> >  #endif
>>
>> Mentioning the addresses is a little weird.  IMHO this would be
>> a much nicer place to explain the high-level memory layout, including
>> maybe a little ASCII art.  Also we could have one #ifdef CONFIG_64BIT
>> for both related values.  Last but not least instead of saying that
>> something should be dividable it would be nice to have a BUILD_BUG_ON
>> to enforce it.
>>
>> Either way we are late in the cycle, so I guess this is ok for now:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>
>> But I'd love to see this area improved a little further as it is full
>> of mine fields.
>
> I agree with you. We also have Sparsemem and KASAN patches which
> touch virtual memory layout so it's important to have virtual memory layout
> documented clearly. I can add the required documentation as separate patch.

Documentation is great, but if we document something that is broken then it's 
still broken :)

I think this needs to just be redone -- we keep running into issues here and 
fixing them, but there are probably more issues and it'll probably be faster to 
just think through the memory map than to keep fixing bugs as they crop up.  
This was one of the areas of the port I didn't rewrite as part of the upstream 
submission process, and as a result it's pretty crusty.

> I think the best place to add ASCII art would be asm/pgtable.h where all
> virtual memory related defines are placed. Suggestions??
