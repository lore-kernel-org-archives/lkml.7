Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BF2C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AF22133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OdbU6Wp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbfHNSdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:33:15 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34929 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfHNSdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:33:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id gn20so1796748plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=FHbaVzjuuoyrLYUA3STjtrTGQSVNOY2GYHCncQDOa8Y=;
        b=OdbU6Wp7L08K4yCF/qoOuv8FfCadAcE1CkMuHAmPFepXvJQ73qDAgLRgofGJiYU4DU
         eZO8o43/o8c0HnJUOLERUdM+i0tazX5bRDLdBffTC4mccjTswg/6iSFgs5Jj8EaD6Kgv
         mCo5Pm8rtnyfDBqBdqplQHp5POGVHh0HlPu1+pg5MFAGjzuH7nwScdgktR+nBvfvUNF/
         i+NpPaD8Tj1sFiqJRPoV8PPX8GEO7xTYZvOPpEcnucYXfePcnpate5qcxF1foiFqFVjO
         4QCayR6ih6IqE8GBvvB65b17OqT0Hv6sAOG7JKj8X8bBHW1IQztpot2Cqi380K4hrp0r
         8mnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=FHbaVzjuuoyrLYUA3STjtrTGQSVNOY2GYHCncQDOa8Y=;
        b=hvn+1Nj8KFbIK3/1JEgd07aCwRjDCY73AMPpXBU/Eyr0QcM1rVQkjV01zZ5UGxABTM
         QhlKicaOOKMuZSvnea7oM5HsxpwlQantOnAcMXGlLhjoce5hRfCvUd9ZgXb7qyywTh9C
         /biIwcP3FkifWpM2zV2qXs+k8vbJqFd8W1/5DglSAHuPWt9jAK7IrJxJV+I+4J/PTCel
         70V/G+t+nsleHWhZXi6hmCkBl6jA8O9fwBJWoq8fuJcCOD8dKIIAqMTeBi84ekb+kDmc
         wNzx5De0ooVKGpCckH1P9zw21xlgEITsj9aVV+itchJpgiTLLRqHaio1dLIoa+kGDWm2
         YyLA==
X-Gm-Message-State: APjAAAVmGY1DiLs9/S/T0jN8L510qLCaRAR0JMtB9ZFyCNaCAtiZyVz2
        BAbC44QGzLmK2SEou7dG+yl5gw==
X-Google-Smtp-Source: APXvYqxuWm/jXyZLSb4OIcBBhT0VnxfVZzx/XzeuUQ6c71yrkuHPenLi63SLvWFOGtXC6uqsSRXDJg==
X-Received: by 2002:a17:902:8f93:: with SMTP id z19mr682659plo.97.1565807594175;
        Wed, 14 Aug 2019 11:33:14 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id r4sm580533pfl.127.2019.08.14.11.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:33:13 -0700 (PDT)
Date:   Wed, 14 Aug 2019 11:33:13 -0700 (PDT)
X-Google-Original-Date: Wed, 14 Aug 2019 11:26:50 PDT (-0700)
Subject:     Re: [PATCH 1/2] riscv: Add memmove string operation.
In-Reply-To: <alpine.DEB.2.21.9999.1908131921180.19217@viisi.sifive.com>
CC:     Christoph Hellwig <hch@infradead.org>, nickhu@andestech.com,
        alankao@andestech.com, aou@eecs.berkeley.edu, green.hu@gmail.com,
        deanbo422@gmail.com, tglx@linutronix.de,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        Anup Patel <Anup.Patel@wdc.com>,
        Greg KH <gregkh@linuxfoundation.org>, alexios.zavras@intel.com,
        Atish Patra <Atish.Patra@wdc.com>, zong@andestech.com,
        kasan-dev@googlegroups.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <mhng-22db5681-9fed-4bf6-83fe-180b3599c654@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2019 19:22:15 PDT (-0700), Paul Walmsley wrote:
> On Tue, 13 Aug 2019, Palmer Dabbelt wrote:
>
>> On Mon, 12 Aug 2019 08:04:46 PDT (-0700), Christoph Hellwig wrote:
>> > On Wed, Aug 07, 2019 at 03:19:14PM +0800, Nick Hu wrote:
>> > > There are some features which need this string operation for compilation,
>> > > like KASAN. So the purpose of this porting is for the features like KASAN
>> > > which cannot be compiled without it.
>> > >
>> > > KASAN's string operations would replace the original string operations and
>> > > call for the architecture defined string operations. Since we don't have
>> > > this in current kernel, this patch provides the implementation.
>> > >
>> > > This porting refers to the 'arch/nds32/lib/memmove.S'.
>> >
>> > This looks sensible to me, although my stringop asm is rather rusty,
>> > so just an ack and not a real review-by:
>> >
>> > Acked-by: Christoph Hellwig <hch@lst.de>
>>
>> FWIW, we just write this in C everywhere else and rely on the compiler to
>> unroll the loops.  I always prefer C to assembly when possible, so I'd prefer
>> if we just adopt the string code from newlib.  We have a RISC-V-specific
>> memcpy in there, but just use the generic memmove.
>>
>> Maybe the best bet here would be to adopt the newlib memcpy/memmove as generic
>> Linux functions?  They're both in C so they should be fine, and they both look
>> faster than what's in lib/string.c.  Then everyone would benefit and we don't
>> need this tricky RISC-V assembly.  Also, from the look of it the newlib code
>> is faster because the inner loop is unrolled.
>
> There's a generic memmove implementation in the kernel already:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/string.h#n362

That ends up at __builtin_memcpy(), which ends up looking for memcpy() for 
large copies, which is in lib/string.c.  The code in there is just byte at a 
time memcpy()/memmove(), which is way slower than the newlib stuff.

>
> Nick, could you tell us more about why the generic memmove() isn't
> suitable?
>
>
> - Paul
