Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6B9C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A402073F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfDLQGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:06:08 -0400
Received: from mailgate-2.ics.forth.gr ([139.91.1.5]:50614 "EHLO
        mailgate-2.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfDLQGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:06:07 -0400
Received: from av1.ics.forth.gr (av3in [139.91.1.77])
        by mailgate-2.ics.forth.gr (8.14.4/ICS-FORTH/V10-1.8-GATE) with ESMTP id x3CG5YEm010704;
        Fri, 12 Apr 2019 16:05:36 GMT
X-AuditID: 8b5b9d4d-8f5ff7000000235c-c8-5cb0b74e4e43
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.1.35])
        by av1.ics.forth.gr (SMTP Outbound / FORTH / ICS) with SMTP id F1.CA.09052.E47B0BC5; Fri, 12 Apr 2019 19:05:34 +0300 (EEST)
Received: from webmail.ics.forth.gr (localhost [127.0.0.1])
        by enigma.ics.forth.gr (8.15.1//ICS-FORTH/V10.5.0C-EXTNULL-SSL-SASL) with ESMTP id x3CG5X9s021703;
        Fri, 12 Apr 2019 19:05:34 +0300
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 12 Apr 2019 19:05:33 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>, mick@ics.forth.gr,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH, RFC] byteorder: sanity check toolchain vs kernel
 endianess
Organization: FORTH
In-Reply-To: <CAK8P3a2bg9YkbNpAb9uZkXLFZ3juCmmbF7cRw+Dm9ZiLFno2OQ@mail.gmail.com>
References: <20190412143538.11780-1-hch@lst.de>
 <CAK8P3a2bg9YkbNpAb9uZkXLFZ3juCmmbF7cRw+Dm9ZiLFno2OQ@mail.gmail.com>
Message-ID: <fd59e6e22594f740eaf86abad76ee04d@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.1.2
X-Greylist: inspected by milter-greylist-4.6.2 (mailgate-2.ics.forth.gr [139.91.1.5]); Fri, 12 Apr 2019 16:05:36 +0000 (GMT) for IP:'139.91.1.77' DOMAIN:'av3in' HELO:'av1.ics.forth.gr' FROM:'mick@ics.forth.gr' RCPT:''
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mailgate-2.ics.forth.gr [139.91.1.5]); Fri, 12 Apr 2019 16:05:36 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2019-04-12 17:53, Arnd Bergmann έγραψε:
> On Fri, Apr 12, 2019 at 4:36 PM Christoph Hellwig <hch@lst.de> wrote:
>> 
>> When removing some dead big endian checks in the RISC-V code Nick
>> suggested that we should have some generic sanity checks.  I don't 
>> think
>> we should have thos inside the RISC-V code, but maybe it might make
>> sense to have these in the generic byteorder headers.  Note that these
>> are UAPI headers and some compilers might not actually define
>> __BYTE_ORDER__, so we first check that it actually exists.
>> 
>> Suggested-by: Nick Kossifidis <mick@ics.forth.gr>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Extra checking like this is good in general, but I'm not sure I see
> exactly what kind of issue one might expect to prevent with this:
> 
> All architecture asm/byteorder.h headers either include the only
> possible option, or they check the compiler defined macros:
> 
> arch/arc/include/uapi/asm/byteorder.h:#ifdef __BIG_ENDIAN__
> arch/arm/include/uapi/asm/byteorder.h:#ifdef __ARMEB__
> arch/arm64/include/uapi/asm/byteorder.h:#ifdef __AARCH64EB__
> arch/c6x/include/uapi/asm/byteorder.h:#ifdef _BIG_ENDIAN
> arch/microblaze/include/uapi/asm/byteorder.h:#ifdef __MICROBLAZEEL__
> arch/mips/include/uapi/asm/byteorder.h:#if defined(__MIPSEB__)
> arch/nds32/include/uapi/asm/byteorder.h:#ifdef __NDS32_EB__
> arch/powerpc/include/uapi/asm/byteorder.h:#ifdef __LITTLE_ENDIAN__
> arch/sh/include/uapi/asm/byteorder.h:#ifdef __LITTLE_ENDIAN__
> arch/xtensa/include/uapi/asm/byteorder.h:#ifdef __XTENSA_EL__
> 
> Are you worried about toolchains that define those differently
> from what these headers expect? Did you encounter such a case?
> 
>       Arnd

The following architectures just include the header file without
checking for any compiler macro:

alpha: little_endian.h
csky: little_endian.h
h8300: big_endian.h
hexagon: little_endian.h
ia64: little_endian.h
m68k: big_endian.h
nios2: little_endian.h
openrisc: big_endian.h
parisc: big_endian.h
riscv: little_endian.h
s390: big_endian.h
sparc: big_endian.h
unicore32: little_endian.h
x86: little_endian.h

Of those who do check for a compiler macro, they don't use the
generic macros (__ORDER_*_ENDIAN__) but arch-specific ones.

Only two architectures (mips and xtensa) that support both big
and little endian return an error in case the endianess can't be
determined, the rest will move on without including any
of *_endian.h files.

I think it's good to have a sanity check in-place for consistency.

Regards,
Nick
