Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CF9C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FC420850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfDLOxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:53:46 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33049 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfDLOxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:53:46 -0400
Received: by mail-qt1-f195.google.com with SMTP id k14so11578795qtb.0;
        Fri, 12 Apr 2019 07:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pqa9WIDm+xCZ7iSwdL0saLx/fB+hfOu5in5ySTxJXgk=;
        b=lTdNDCt7+hc3gQvc54ygpO5Ssq+M9plKP4VKxsyo6cSWXUPK59zghD36Wk63JCzift
         xwRtUx/k4ERf5Fd6QXn2t473jzz5ah7qI2r1l8N9anqZ8fGQo2ez7+S6+Jd2kU8vdqiQ
         z6BN8LLKEhZ9Na0nB+dAcURdnAHwtY/aUmCUyLLrvbtQrjCVPGKKEpNenmPFXZq5eD0i
         fHFLbNHehjfOozN17hDuiSfUCSHv5LDyuUfK1dQH+Mue4TUdIH4kKDOAXiMltNW7+4pA
         1y9CIK93Yj3wa05mC6RZYs5skiP/J9CZqU/XjLAFIL7q9CDC9wEUt+h255WWzXmQcSrs
         V7mw==
X-Gm-Message-State: APjAAAVy9uWhXLCFchkL7aMdEtHnlos7rTG5oSccF3IGhp8KwbS8PIkk
        /cJEgLC4zlXpHrjjSE/NjVynpm1K84DYZ/66LhE=
X-Google-Smtp-Source: APXvYqyCT3CF04C0hC+uwusxKl/kHl7ffI4HJpeWsXbnVJNllEPB9Sa+jsDSYSMc2gfnXGdiRMvlLd5MFMJ2ShoHZ6k=
X-Received: by 2002:a0c:93f2:: with SMTP id g47mr45229333qvg.22.1555080825045;
 Fri, 12 Apr 2019 07:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190412143538.11780-1-hch@lst.de>
In-Reply-To: <20190412143538.11780-1-hch@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Apr 2019 16:53:28 +0200
Message-ID: <CAK8P3a2bg9YkbNpAb9uZkXLFZ3juCmmbF7cRw+Dm9ZiLFno2OQ@mail.gmail.com>
Subject: Re: [PATCH, RFC] byteorder: sanity check toolchain vs kernel endianess
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>, mick@ics.forth.gr,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 4:36 PM Christoph Hellwig <hch@lst.de> wrote:
>
> When removing some dead big endian checks in the RISC-V code Nick
> suggested that we should have some generic sanity checks.  I don't think
> we should have thos inside the RISC-V code, but maybe it might make
> sense to have these in the generic byteorder headers.  Note that these
> are UAPI headers and some compilers might not actually define
> __BYTE_ORDER__, so we first check that it actually exists.
>
> Suggested-by: Nick Kossifidis <mick@ics.forth.gr>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Extra checking like this is good in general, but I'm not sure I see
exactly what kind of issue one might expect to prevent with this:

All architecture asm/byteorder.h headers either include the only
possible option, or they check the compiler defined macros:

arch/arc/include/uapi/asm/byteorder.h:#ifdef __BIG_ENDIAN__
arch/arm/include/uapi/asm/byteorder.h:#ifdef __ARMEB__
arch/arm64/include/uapi/asm/byteorder.h:#ifdef __AARCH64EB__
arch/c6x/include/uapi/asm/byteorder.h:#ifdef _BIG_ENDIAN
arch/microblaze/include/uapi/asm/byteorder.h:#ifdef __MICROBLAZEEL__
arch/mips/include/uapi/asm/byteorder.h:#if defined(__MIPSEB__)
arch/nds32/include/uapi/asm/byteorder.h:#ifdef __NDS32_EB__
arch/powerpc/include/uapi/asm/byteorder.h:#ifdef __LITTLE_ENDIAN__
arch/sh/include/uapi/asm/byteorder.h:#ifdef __LITTLE_ENDIAN__
arch/xtensa/include/uapi/asm/byteorder.h:#ifdef __XTENSA_EL__

Are you worried about toolchains that define those differently
from what these headers expect? Did you encounter such a case?

      Arnd
