Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33327C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099932133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfCRVvN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:51:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52433 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbfCRVvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 17:51:13 -0400
Received: from [IPv6:2607:fb90:8435:e408:e1a9:1fde:6fc9:a6d9] ([IPv6:2607:fb90:8435:e408:e1a9:1fde:6fc9:a6d9])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x2ILol0d3146907
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 18 Mar 2019 14:50:48 -0700
Date:   Mon, 18 Mar 2019 14:50:44 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20190318213113.GI112750@google.com>
References: <CAG5bF+S6OvBnsaR6UpMCqjDR9_hMo6qRMHGiW+iCaRYQW4C3YA@mail.gmail.com> <20190318213113.GI112750@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] lib: Add shared copy of __lshrti3 from libgcc
To:     Matthias Kaehlcke <mka@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
CC:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        clang-built-linux@googlegroups.com
From:   hpa@zytor.com
Message-ID: <25133BBA-9121-4B3A-865B-085BFC5F154C@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 18, 2019 2:31:13 PM PDT, Matthias Kaehlcke <mka@chromium.org> wrote:
>On Fri, Mar 15, 2019 at 01:54:50PM -0700, Matthias Kaehlcke wrote:
>> The compiler may emit calls to __lshrti3 from the compiler runtime
>> library, which results in undefined references:
>> 
>> arch/x86/kvm/x86.o: In function `mul_u64_u64_shr':
>>   include/linux/math64.h:186: undefined reference to `__lshrti3'
>> 
>> Add a copy of the __lshrti3 libgcc routine (from gcc v4.9.2).
>> 
>> Include the function for x86 builds with clang, which is the
>> environment where the above error was observed.
>> 
>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>
>With "Revert "kbuild: use -Oz instead of -Os when using clang"
>(https://lore.kernel.org/patchwork/patch/1051932/) the above
>error is fixed, a few comments inline for if the patch is
>resurrected in the future because __lshrti3 is emitted in a
>different context.
>
>> diff --git a/include/linux/libgcc.h b/include/linux/libgcc.h
>> index 32e1e0f4b2d0..a71036471838 100644
>> --- a/include/linux/libgcc.h
>> +++ b/include/linux/libgcc.h
>> @@ -22,15 +22,26 @@
>>  #include <asm/byteorder.h>
>> 
>>  typedef int word_type __attribute__ ((mode (__word__)));
>> +typedef int TItype __attribute__ ((mode (TI)));
>
>Consider using __int128 instead. Definition and use need a
>'defined(__SIZEOF_INT128__)' guard  (similar for mode (TI)), since
>these 128 bit types aren't supported on all platforms.
>
>>  #ifdef __BIG_ENDIAN
>>  struct DWstruct {
>>  	int high, low;
>>  };
>> +
>> +struct DWstruct128 {
>> +	long long high, low;
>> +};
>
>This struct isn't needed, struct DWstruct can be used.
>
>> diff --git a/lib/lshrti3.c b/lib/lshrti3.c
>> new file mode 100644
>> index 000000000000..2d2123bb3030
>> --- /dev/null
>> +++ b/lib/lshrti3.c
>> @@ -0,0 +1,31 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/export.h>
>> +#include <linux/libgcc.h>
>> +
>> +long long __lshrti3(long long u, word_type b)
>
>use TItype for input/output, which is what gcc does, though the above
>matches the interface in the documentation.
>
>> +{
>> +	DWunion128 uu, w;
>> +	word_type bm;
>> +
>> +	if (b == 0)
>> +		return u;
>> +
>> +	uu.ll = u;
>> +	bm = 64 - b;
>> +
>> +	if (bm <= 0) {
>> +		w.s.high = 0;
>> +		w.s.low = (unsigned long long) uu.s.high >> -bm;
>
>include <linux/types.h> and use u64 instead of unsigned long long.

Ok, now I'm really puzzled.

How could we need a 128-bit shift when the prototype only has 64 bits of input?!

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
