Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D86C04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 02:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0799E216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 02:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfEPCMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 22:12:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8200 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbfEPCMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 22:12:09 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DF385F26E4A54189A22C;
        Thu, 16 May 2019 10:12:06 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 16 May
 2019 10:12:00 +0800
Subject: Re: [PATCH 1/1] LZ4: Port LZ4 1.9.x FAST_DEC_LOOP and enable it on
 x86 and ARM64
To:     "Mao, Chenxi" <Chenxi.Mao@sony.com>
CC:     Cyan <yann.collet.73@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Feng, Roy" <Roy.Feng@sony.com>,
        "Xu, Yuanli 2" <Yuanli.Xu@sony.com>,
        "Alm, Robert 2" <Robert.Alm@sony.com>,
        "Takahashi, Masaya A (Sony Mobile)" <Masaya.A.Takahashi@sony.com>,
        Miao Xie <miaoxie@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190515004336.66555-1-chenxi.mao@sony.com>
 <649ba9ed-223e-1e82-1513-f3c16e4c8f9a@huawei.com>
 <0c1d0d7d24ae48f68ae6acc95c0c4869@CNBJMBX12.corpusers.net>
 <CADv+DGkGa3q4FJ0TeLcj626PrUEYCDMfyKdd0yx82VmAX2i98Q@mail.gmail.com>
 <CADv+DG=Rc5gqhJXsYOAWbFQNm_5RMhCjDEm4d2V+an-6+-QTCg@mail.gmail.com>
 <d5001400-f46f-9da3-a8b2-611429acaa68@huawei.com>
 <5c735ce9-04fc-a2a4-4f0c-ba5718fe7933@sony.com>
 <1ca01dfb-c478-0752-cda0-b98f3da9f1b0@huawei.com>
 <cd5e539d-fa95-6ba3-4d95-c0658e796795@sony.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <2bd0fcc0-5bbc-2edc-9f4a-60cccd426a28@huawei.com>
Date:   Thu, 16 May 2019 10:10:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <cd5e539d-fa95-6ba3-4d95-c0658e796795@sony.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/5/16 10:07, Mao, Chenxi wrote:
> Hi Xiang:
> 
> I checked the deliver history.
> There is only below delivery related with lz4.c
> Pull request:616
> 4e3accc Fix Dict Size Test in `LZ4_compress_fast_continue()`
> 535636f Don't Attach Very Small Dictionaries
> This 2 changes seems like ONLY bug fixes for dictionary fix baesd on 1.8.3

Have you taken a glance at

https://github.com/lz4/lz4/commit/5a6d72447ae998b387794df1135023689aa89995   at least?

and issues,

https://github.com/lz4/lz4/issues/676
https://github.com/lz4/lz4/issues/681

That is what Yann said before.

Thanks,
Gao Xiang

> 
> Based on current investigation result, I think pick decompress patches is safe for v1.8.3
> 
> If there is any misunderstanding or faults, please feel free to let me know.
> 
> Chenxi
> 
> On 5/16/19 9:35 AM, Gao Xiang wrote:
>>
>>
>> On 2019/5/16 7:48, Mao, Chenxi wrote:
>>> Hi Yann and Xiang:
>>> For this FAST_DEC_LOOP change, I only pick up decompress related patches to current kernel LZ4 implementation(based on 1.8.3).
>>> Here is my cherry-pick list:
>>> 2589c44 created LZ4_FAST_DEC_LOOP build macro
>>> 605d811 enable LZ4_FAST_DEC_LOOP build macro on aarch64/GCC by default
>>> 5d7d116 decompress_generic: Limit fastpath to x86
>>> 75fb878 decompress_generic: Add fastpath for small offsets
>>> faac110 decompress_generic: Unroll loops a bit more
>>> 1fbaf84 decompress_generic: remove msan write
>>> 28b8249 decompress_generic: re-add fastpath
>>> 232f1e2 decompress_generic: drop partial copy check in fast loop
>>> 59332a3 decompress_generic: Optimize literal copies
>>> 5dfa7d4 decompress_generic: optimize match copy
>>> 28356e0 decompress_generic: Add a loop fastpath
>>> 4da3360 decompress_generic: Refactor variable length fields
>>>
>>> Only cherry-pick these changes to LZ4 1.8.3 would not be introduce risks.
>>
>> The fact is that ... LZ4_FAST_DEC_LOOP almost influences all decompression apis.
>> You should keep LZ4_decompress_generic from all known issues.
>>
>>>
>>> @Xiang:
>>> Do you prefer to upgrade kernel lz4 to 1.9.1 directly or only pick some optimization patches?
>>
>> I think you should pick all patches which are related to LZ4_decompress_generic()
>> and LZ4_FAST_DEC_LOOP since known issues of LZ4_FAST_DEC_LOOP should be fixed of course.
>>
>> Thanks,
>> Gao Xiang
>>
>>>
>>> Chenxi
>>>
>>>
>>> On 5/16/19 1:47 AM, Gao Xiang wrote:
>>>> Hi Yann,
>>>>
>>>> On 2019/5/16 1:03, Cyan wrote:
>>>>> Re-posted,
>>>>> it seems the previous message was rejected by the linux-kernel server
>>>>> due to some kind of format limitation (no html).
>>>>>
>>>>>
>>>>> Le mer. 15 mai 2019 à 09:56, Cyan <yann.collet.73@gmail.com> a écrit :
>>>>>>
>>>>>> The v1.9.0 version has a bug which makes it read a few bytes out of bound in certain cases.
>>>>>> This was fixed in v1.9.1.
>>>>>> Therefore, if you plan upgrading version, skip directly to v1.9.1.
>>>>>>
>>>>>> Note that, in v1.9.1, LZ4_decompress_fast() is now deprecated.
>>>>>> LZ4_decompress_fast() is a security liability, since it's unable to cope with malicious inputs.
>>>>>> While this is not a problem when the producer is under direct control (local production and consumption, no intermediate storage),
>>>>>> this entry point seems misused in multiple scenarios where input cannot be decently trusted.
>>>>>> The deprecation warning is meant to "scare away" such usages.
>>>>>> It's still possible to intentionally remove the warning, for users who know what they are doing.
>>>>>>
>>>>>> Note that, on top of that, the _fast() variant is now slower that LZ4_decompress_safe(), removing its most important positive differentiator.
>>>>>> That's because LZ4_decompress_fast() is "blind", it doesn't know the input size.
>>>>>> It just guesses it, from the requested output size, and by relying on end-of-block conditions.
>>>>>> This effectively limits its capability to copy up to 8 bytes at a time,
>>>>>> which proves slower than the 32-bytes at a time used in LZ4_decompress_safe().
>>>>>>
>>>>>> LZ4_decompress_fast() still has some possible usage :
>>>>>> it doesn't need the compressed size.
>>>>>> Therefore, in a scenario where decompressed size is known, but compressed size isn't,
>>>>>> it cannot be replaced by `LZ4_decompress_safe()`.
>>>>>> This is pretty rare, but can happen in some cases, erofs for example.
>>>>>> `LZ4_decompress_safe_partial()` *might* be able to replace it for such scenario,
>>>>>> but I haven't thoroughly tested it, so can't yet vouch for it.
>>>>
>>>> Yes, that is my real concern...
>>>>
>>>> In fact, we have shipped erofs with LZ4_decompress_safe_partial() of lz4-1.8.3
>>>> for our HUAWEI P30/P30 Pro and other HUAWEI EMUI 9.1 phones on the market...
>>>>
>>>> It seemd lz4-1.8.3 is rather stable since no stability report from our internal
>>>> beta test and real consumers...
>>>>
>>>> I haven't tested lz4-1.9.0 yet since I am working on the erofs paper [1]...
>>>>
>>>> But anyway, the patch looks good to me since it has obvious performance gain...
>>>>
>>>>>>
>>>>>> If it doesn't, then it will be necessary to create a new entry point.
>>>>>> The main difference is that this new entry point will need a bound for the input size, in order to guarantee it never reads beyond input buffer.
>>>>>> But as said, for the time being, such dedicated entry point doesn't exist.
>>>>
>>>> I agree, but current erofs still have to choose LZ4_decompress_fast...
>>>> I will test these 2 apis later and will report if something is wrong as well.
>>>>
>>>> [1] https://www.usenix.org/conference/atc19/presentation/gao
>>>>     https://www.usenix.org/conference/atc19/technical-sessions
>>>>
>>>> Thanks,
>>>> Gao Xiang
>>>>
>>>>
>>>>>>
>>>>>> The new FAST_DEC_LOOP setting works well on x86 and x64.
>>>>>> Recently, it has been extended to gcc+arm64 (`dev` branch).
>>>>>> The combination of clang+arm64 is less successful though (impacts vary, depending on version and exact hardware), so it's still disabled by default.
>>>>>> But anyone can test it by setting FAST_DEC_LOOP definition to 1, thus enabling the new decoder loop.
>>>>>>
>>>>>>
>>>>>> Y.
>>>>>>
>>>>>> Le mar. 14 mai 2019 à 20:28, Mao, Chenxi <Chenxi.Mao@sony.com> a écrit :
>>>>>>>
>>>>>>> Hi Xiang:
>>>>>>>
>>>>>>> Thanks for your reply, I will have a stress test on my device later.
>>>>>>> I didn't have chance to test LZ4 with clang build because of device limitation. I think I could do it later.
>>>>>>> I guess the clang performance downgrade is caused by some compiler optimization options.
>>>>>>> I will double check it later if I got the device which can build kernel with clang.
>>>>>>>
>>>>>>> BTW, the FAST_DEC_LOOP leverage LZ4_wildCopy8 instead of LZ4_wildCopy,
>>>>>>> however based on my test, original LZ4_wildCopy has the better performance.
>>>>>>> Original LZ4_wildCopy API still invoked by FAST_DEC_LOOP apis.
>>>>>>> That might be a problem for X86 devices for current patch.
>>>>>>>
>>>>>>> Chenxi
>>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Gao Xiang [mailto:gaoxiang25@huawei.com]
>>>>>>> Sent: Wednesday, May 15, 2019 10:21 AM
>>>>>>> To: Mao, Chenxi <Chenxi.Mao@sony.com>
>>>>>>> Cc: akpm@linux-foundation.org; linux-kernel@vger.kernel.org; Feng, Roy <Roy.Feng@sony.com>; Xu, Yuanli 2 <Yuanli.Xu@sony.com>; Alm, Robert 2 <Robert.Alm@sony.com>; Takahashi, Masaya A (Sony Mobile) <Masaya.A.Takahashi@sony.com>; Miao Xie <miaoxie@huawei.com>
>>>>>>> Subject: Re: [PATCH 1/1] LZ4: Port LZ4 1.9.x FAST_DEC_LOOP and enable it on x86 and ARM64
>>>>>>>
>>>>>>> Hi Chenxi,
>>>>>>>
>>>>>>> On 2019/5/15 8:43, Chenxi Mao wrote:
>>>>>>>> FAST_DEC_LOOP was introduced from LZ4 1.9.
>>>>>>>> This change would be introduce 10% on decompress operation according
>>>>>>>> to LZ4 benchmark result on X86 devices.
>>>>>>>> Meanwhile, LZ4 with FAST_DEC_LOOP could get improvements, however
>>>>>>>> clang compiler has downgrade if FAST_DEC_LOOP enabled.
>>>>>>>
>>>>>>> I noticed this optimization and lz4-1.9.0 [1] was just released month ago with this big change therefore I'm a little afraid of its current stability (especially some rare used decompression apis...)
>>>>>>>
>>>>>>> Could you Cc more people (e.g. lz4 original author Yann Collet) in order to get some more ideas about this if possible?
>>>>>>>
>>>>>>> Anyway, I like this optimization as well since FAST_DEC_LOOP improves decompression speed a lot :)
>>>>>>>
>>>>>>> [1] https://github.com/lz4/lz4/releases/tag/v1.9.0
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Gao Xiang
>>>>>>>
>>>>>>>>
>>>>>>>> So FAST_DEC_LOOP only enabled on X86/X86-64 or ARM64 with GCC build.
>>>>>>>>
>>>>>>>> Here is the test result on ARM64(cortex-A53)
>>>>>>>>
>>>>>>>> Benchmark via ZRAM:
>>>>>>>>
>>>>>>>> Test case:
>>>>>>>> fio --bs=32k --randrepeat=1 --randseed=100 --refill_buffers \
>>>>>>>> --buffer_compress_percentage=75 \
>>>>>>>> --scramble_buffers=1 --direct=1 --loops=100 --numjobs=8 \
>>>>>>>> --filename=/dev/block/zram0 --name=seq-write --rw=write --stonewall \
>>>>>>>> --name=seq-read --rw=read --stonewall --name=seq-readwrite \ --rw=rw
>>>>>>>> --stonewall --name=rand-readwrite --rw=randrw --stonewall
>>>>>>>>
>>>>>>>> Patched:
>>>>>>>>    READ: bw=7077MiB/s (7421MB/s)
>>>>>>>> Vanilla:
>>>>>>>>    READ: bw=5134MiB/s (5384MB/s)
>>>>>>>>
>>>>>>>> Reference:
>>>>>>>> 1. https://github.com/lz4/lz4/pull/645
>>>>>>>> 2. https://github.com/lz4/lz4/pull/707
>>>>>>>>
>>>>>>>> Signed-off-by: chenxi.mao <chenxi.mao@sony.com>
>>>>>>>> ---
>>>>>>>>  lib/lz4/lz4_decompress.c | 425
>>>>>>>> +++++++++++++++++++++++++++++++++------
>>>>>>>>  1 file changed, 361 insertions(+), 64 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/lib/lz4/lz4_decompress.c b/lib/lz4/lz4_decompress.c index
>>>>>>>> 0c9d3ad17e0f..a4c87e32b3c0 100644
>>>>>>>> --- a/lib/lz4/lz4_decompress.c
>>>>>>>> +++ b/lib/lz4/lz4_decompress.c
>>>>>>>> @@ -50,6 +50,131 @@
>>>>>>>>  #define assert(condition) ((void)0)
>>>>>>>>  #endif
>>>>>>>>
>>>>>>>> +#ifndef LZ4_FAST_DEC_LOOP
>>>>>>>> +#if defined(__i386__) || defined(__x86_64__) #define
>>>>>>>> +LZ4_FAST_DEC_LOOP 1 #elif defined(__aarch64__) && !defined(__clang__)
>>>>>>>> +     /* On aarch64, we disable this optimization for clang because on certain
>>>>>>>> +      * mobile chipsets and clang, it reduces performance. For more information
>>>>>>>> +      * refer to https://github.com/lz4/lz4/pull/707. */ #define
>>>>>>>> +LZ4_FAST_DEC_LOOP 1 #else #define LZ4_FAST_DEC_LOOP 0 #endif #endif
>>>>>>>> +
>>>>>>>> +static const unsigned inc32table[8] = { 0, 1, 2, 1, 0, 4, 4, 4 };
>>>>>>>> +static const int dec64table[8] = { 0, 0, 0, -1, -4, 1, 2, 3 };
>>>>>>>> +
>>>>>>>> +#if LZ4_FAST_DEC_LOOP
>>>>>>>> +#define FASTLOOP_SAFE_DISTANCE 64
>>>>>>>> +FORCE_INLINE void
>>>>>>>> +LZ4_memcpy_using_offset_base(BYTE * dstPtr, const BYTE * srcPtr, BYTE * dstEnd,
>>>>>>>> +                          const size_t offset)
>>>>>>>> +{
>>>>>>>> +     if (offset < 8) {
>>>>>>>> +             dstPtr[0] = srcPtr[0];
>>>>>>>> +
>>>>>>>> +             dstPtr[1] = srcPtr[1];
>>>>>>>> +             dstPtr[2] = srcPtr[2];
>>>>>>>> +             dstPtr[3] = srcPtr[3];
>>>>>>>> +             srcPtr += inc32table[offset];
>>>>>>>> +             memcpy(dstPtr + 4, srcPtr, 4);
>>>>>>>> +             srcPtr -= dec64table[offset];
>>>>>>>> +             dstPtr += 8;
>>>>>>>> +     } else {
>>>>>>>> +             memcpy(dstPtr, srcPtr, 8);
>>>>>>>> +             dstPtr += 8;
>>>>>>>> +             srcPtr += 8;
>>>>>>>> +     }
>>>>>>>> +
>>>>>>>> +     LZ4_wildCopy(dstPtr, srcPtr, dstEnd); }
>>>>>>>> +
>>>>>>>> +/* customized variant of memcpy, which can overwrite up to 32 bytes
>>>>>>>> +beyond dstEnd
>>>>>>>> + * this version copies two times 16 bytes (instead of one time 32
>>>>>>>> +bytes)
>>>>>>>> + * because it must be compatible with offsets >= 16. */ FORCE_INLINE
>>>>>>>> +void LZ4_wildCopy32(void *dstPtr, const void *srcPtr, void *dstEnd) {
>>>>>>>> +     BYTE *d = (BYTE *) dstPtr;
>>>>>>>> +     const BYTE *s = (const BYTE *)srcPtr;
>>>>>>>> +     BYTE *const e = (BYTE *) dstEnd;
>>>>>>>> +
>>>>>>>> +     do {
>>>>>>>> +             memcpy(d, s, 16);
>>>>>>>> +             memcpy(d + 16, s + 16, 16);
>>>>>>>> +             d += 32;
>>>>>>>> +             s += 32;
>>>>>>>> +     } while (d < e);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +FORCE_INLINE void
>>>>>>>> +LZ4_memcpy_using_offset(BYTE *dstPtr, const BYTE *srcPtr, BYTE *dstEnd,
>>>>>>>> +                     const size_t offset)
>>>>>>>> +{
>>>>>>>> +     BYTE v[8];
>>>>>>>> +     switch (offset) {
>>>>>>>> +
>>>>>>>> +     case 1:
>>>>>>>> +             memset(v, *srcPtr, 8);
>>>>>>>> +             goto copy_loop;
>>>>>>>> +     case 2:
>>>>>>>> +             memcpy(v, srcPtr, 2);
>>>>>>>> +             memcpy(&v[2], srcPtr, 2);
>>>>>>>> +             memcpy(&v[4], &v[0], 4);
>>>>>>>> +             goto copy_loop;
>>>>>>>> +     case 4:
>>>>>>>> +             memcpy(v, srcPtr, 4);
>>>>>>>> +             memcpy(&v[4], srcPtr, 4);
>>>>>>>> +             goto copy_loop;
>>>>>>>> +     default:
>>>>>>>> +             LZ4_memcpy_using_offset_base(dstPtr, srcPtr, dstEnd, offset);
>>>>>>>> +             return;
>>>>>>>> +     }
>>>>>>>> +
>>>>>>>> +      copy_loop:
>>>>>>>> +     memcpy(dstPtr, v, 8);
>>>>>>>> +     dstPtr += 8;
>>>>>>>> +     while (dstPtr < dstEnd) {
>>>>>>>> +             memcpy(dstPtr, v, 8);
>>>>>>>> +             dstPtr += 8;
>>>>>>>> +     }
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +/* Read the variable-length literal or match length.
>>>>>>>> + *
>>>>>>>> + * ip - pointer to use as input.
>>>>>>>> + * lencheck - end ip.  Return an error if ip advances >= lencheck.
>>>>>>>> + * loop_check - check ip >= lencheck in body of loop.  Returns loop_error if so.
>>>>>>>> + * initial_check - check ip >= lencheck before start of loop.  Returns initial_error if so.
>>>>>>>> + * error (output) - error code.  Should be set to 0 before call.
>>>>>>>> + */
>>>>>>>> +typedef enum { loop_error = -2, initial_error = -1, ok = 0}
>>>>>>>> +variable_length_error; FORCE_INLINE unsigned read_variable_length(const BYTE **ip,
>>>>>>>> +                                        const BYTE *lencheck,
>>>>>>>> +                                        int loop_check, int initial_check,
>>>>>>>> +                                        variable_length_error *error) {
>>>>>>>> +     unsigned length = 0;
>>>>>>>> +     unsigned s;
>>>>>>>> +     if (initial_check && unlikely((*ip) >= lencheck)) {     /* overflow detection */
>>>>>>>> +             *error = initial_error;
>>>>>>>> +             return length;
>>>>>>>> +     }
>>>>>>>> +     do {
>>>>>>>> +             s = **ip;
>>>>>>>> +             (*ip)++;
>>>>>>>> +             length += s;
>>>>>>>> +             if (loop_check && unlikely((*ip) >= lencheck)) {        /* overflow detection */
>>>>>>>> +                     *error = loop_error;
>>>>>>>> +                     return length;
>>>>>>>> +             }
>>>>>>>> +     } while (s == 255);
>>>>>>>> +
>>>>>>>> +     return length;
>>>>>>>> +}
>>>>>>>> +#endif
>>>>>>>> +
>>>>>>>>  /*
>>>>>>>>   * LZ4_decompress_generic() :
>>>>>>>>   * This generic decompression function covers all use cases.
>>>>>>>> @@ -80,25 +205,28 @@ static FORCE_INLINE int LZ4_decompress_generic(
>>>>>>>>        const size_t dictSize
>>>>>>>>        )
>>>>>>>>  {
>>>>>>>> -     const BYTE *ip = (const BYTE *) src;
>>>>>>>> -     const BYTE * const iend = ip + srcSize;
>>>>>>>> +     const BYTE *ip = (const BYTE *)src;
>>>>>>>> +     const BYTE *const iend = ip + srcSize;
>>>>>>>>
>>>>>>>>       BYTE *op = (BYTE *) dst;
>>>>>>>> -     BYTE * const oend = op + outputSize;
>>>>>>>> +     BYTE *const oend = op + outputSize;
>>>>>>>>       BYTE *cpy;
>>>>>>>>
>>>>>>>> -     const BYTE * const dictEnd = (const BYTE *)dictStart + dictSize;
>>>>>>>> -     static const unsigned int inc32table[8] = {0, 1, 2, 1, 0, 4, 4, 4};
>>>>>>>> -     static const int dec64table[8] = {0, 0, 0, -1, -4, 1, 2, 3};
>>>>>>>> +     const BYTE *const dictEnd = (const BYTE *)dictStart + dictSize;
>>>>>>>>
>>>>>>>>       const int safeDecode = (endOnInput == endOnInputSize);
>>>>>>>>       const int checkOffset = ((safeDecode) && (dictSize < (int)(64 *
>>>>>>>> KB)));
>>>>>>>>
>>>>>>>>       /* Set up the "end" pointers for the shortcut. */
>>>>>>>>       const BYTE *const shortiend = iend -
>>>>>>>> -             (endOnInput ? 14 : 8) /*maxLL*/ - 2 /*offset*/;
>>>>>>>> +         (endOnInput ? 14 : 8) /*maxLL*/ - 2 /*offset*/;
>>>>>>>>       const BYTE *const shortoend = oend -
>>>>>>>> -             (endOnInput ? 14 : 8) /*maxLL*/ - 18 /*maxML*/;
>>>>>>>> +         (endOnInput ? 14 : 8) /*maxLL*/ - 18 /*maxML*/;
>>>>>>>> +
>>>>>>>> +     const BYTE *match;
>>>>>>>> +     size_t offset;
>>>>>>>> +     unsigned int token;
>>>>>>>> +     size_t length;
>>>>>>>>
>>>>>>>>       DEBUGLOG(5, "%s (srcSize:%i, dstSize:%i)", __func__,
>>>>>>>>                srcSize, outputSize);
>>>>>>>> @@ -117,15 +245,194 @@ static FORCE_INLINE int LZ4_decompress_generic(
>>>>>>>>       if ((endOnInput) && unlikely(srcSize == 0))
>>>>>>>>               return -1;
>>>>>>>>
>>>>>>>> -     /* Main Loop : decode sequences */
>>>>>>>> +#if LZ4_FAST_DEC_LOOP
>>>>>>>> +     if ((oend - op) < FASTLOOP_SAFE_DISTANCE) {
>>>>>>>> +             DEBUGLOG(6, "skip fast decode loop");
>>>>>>>> +             goto safe_decode;
>>>>>>>> +     }
>>>>>>>> +
>>>>>>>> +     /* Fast loop : decode sequences as long as output <
>>>>>>>> +iend-FASTLOOP_SAFE_DISTANCE */
>>>>>>>>       while (1) {
>>>>>>>> -             size_t length;
>>>>>>>> -             const BYTE *match;
>>>>>>>> -             size_t offset;
>>>>>>>> +             /* Main fastloop assertion: We can always wildcopy FASTLOOP_SAFE_DISTANCE */
>>>>>>>> +             assert(oend - op >= FASTLOOP_SAFE_DISTANCE);
>>>>>>>> +             if (endOnInput) {
>>>>>>>> +                     assert(ip < iend);
>>>>>>>> +             }
>>>>>>>> +             token = *ip++;
>>>>>>>> +             length = token >> ML_BITS;      /* literal length */
>>>>>>>> +
>>>>>>>> +             assert(!endOnInput || ip <= iend);      /* ip < iend before the increment */
>>>>>>>> +
>>>>>>>> +             /* decode literal length */
>>>>>>>> +             if (length == RUN_MASK) {
>>>>>>>> +                     variable_length_error error = ok;
>>>>>>>> +                     length +=
>>>>>>>> +                         read_variable_length(&ip, iend - RUN_MASK,
>>>>>>>> +                                              endOnInput, endOnInput,
>>>>>>>> +                                              &error);
>>>>>>>> +                     if (error == initial_error) {
>>>>>>>> +                             goto _output_error;
>>>>>>>> +                     }
>>>>>>>> +                     if ((safeDecode)
>>>>>>>> +                         && unlikely((uptrval) (op) + length <
>>>>>>>> +                                     (uptrval) (op))) {
>>>>>>>> +                             goto _output_error;
>>>>>>>> +                     }       /* overflow detection */
>>>>>>>> +                     if ((safeDecode)
>>>>>>>> +                         && unlikely((uptrval) (ip) + length <
>>>>>>>> +                                     (uptrval) (ip))) {
>>>>>>>> +                             goto _output_error;
>>>>>>>> +                     }
>>>>>>>> +
>>>>>>>> +                     /* overflow detection */
>>>>>>>> +                     /* copy literals */
>>>>>>>> +                     cpy = op + length;
>>>>>>>> +                     LZ4_STATIC_ASSERT(MFLIMIT >= WILDCOPYLENGTH);
>>>>>>>> +                     if (endOnInput) {       /* LZ4_decompress_safe() */
>>>>>>>> +                             if ((cpy > oend - 32)
>>>>>>>> +                                 || (ip + length > iend - 32)) {
>>>>>>>> +                                     goto safe_literal_copy;
>>>>>>>> +                             }
>>>>>>>> +                             LZ4_wildCopy32(op, ip, cpy);
>>>>>>>> +                     } else {        /* LZ4_decompress_fast() */
>>>>>>>> +                             if (cpy > oend - 8) {
>>>>>>>> +                                     goto safe_literal_copy;
>>>>>>>> +                             }
>>>>>>>> +                             LZ4_wildCopy(op, ip, cpy);
>>>>>>>> +                             /* LZ4_decompress_fast() cannot copy more than 8 bytes at a time */
>>>>>>>> +                             /* it doesn't know input length, and only relies on end-of-block */
>>>>>>>> +                             /* properties */
>>>>>>>> +                     }
>>>>>>>> +                     ip += length;
>>>>>>>> +                     op = cpy;
>>>>>>>> +             } else {
>>>>>>>> +                     cpy = op + length;
>>>>>>>> +                     if (endOnInput) {       /* LZ4_decompress_safe() */
>>>>>>>> +                             DEBUGLOG(7,
>>>>>>>> +                                      "copy %u bytes in a 16-bytes stripe",
>>>>>>>> +                                      (unsigned)length);
>>>>>>>> +                             /* We don't need to check oend */
>>>>>>>> +                             /* since we check it once for each loop below */
>>>>>>>> +                             if (ip > iend - (16 + 1)) {     /*max lit + offset + nextToken */
>>>>>>>> +                                     goto safe_literal_copy;
>>>>>>>> +                             }
>>>>>>>> +                             /* Literals can only be 14, but hope compilers optimize */
>>>>>>>> +                             /*if we copy by a register size */
>>>>>>>> +                             memcpy(op, ip, 16);
>>>>>>>> +                     } else {
>>>>>>>> +                             /* LZ4_decompress_fast() cannot copy more than 8 bytes at a time */
>>>>>>>> +                             /* it doesn't know input length, and relies on end-of-block */
>>>>>>>> +                             /* properties */
>>>>>>>> +                             memcpy(op, ip, 8);
>>>>>>>> +                             if (length > 8) {
>>>>>>>> +                                     memcpy(op + 8, ip + 8, 8);
>>>>>>>> +                             }
>>>>>>>> +                     }
>>>>>>>> +                     ip += length;
>>>>>>>> +                     op = cpy;
>>>>>>>> +             }
>>>>>>>> +
>>>>>>>> +             /* get offset */
>>>>>>>> +             offset = LZ4_readLE16(ip);
>>>>>>>> +             ip += 2;        /* end-of-block condition violated */
>>>>>>>> +             match = op - offset;
>>>>>>>> +
>>>>>>>> +             /* get matchlength */
>>>>>>>> +             length = token & ML_MASK;
>>>>>>>>
>>>>>>>> -             /* get literal length */
>>>>>>>> -             unsigned int const token = *ip++;
>>>>>>>> -             length = token>>ML_BITS;
>>>>>>>> +             if ((checkOffset) && (unlikely(match + dictSize < lowPrefix))) {
>>>>>>>> +                     goto _output_error;
>>>>>>>> +             }
>>>>>>>> +             /* Error : offset outside buffers */
>>>>>>>> +             if (length == ML_MASK) {
>>>>>>>> +                     variable_length_error error = ok;
>>>>>>>> +                     length +=
>>>>>>>> +                         read_variable_length(&ip, iend - LASTLITERALS + 1,
>>>>>>>> +                                              endOnInput, 0, &error);
>>>>>>>> +                     if (error != ok) {
>>>>>>>> +                             goto _output_error;
>>>>>>>> +                     }
>>>>>>>> +                     if ((safeDecode)
>>>>>>>> +                         && unlikely((uptrval) (op) + length < (uptrval) op)) {
>>>>>>>> +                             goto _output_error;
>>>>>>>> +                     }       /* overflow detection */
>>>>>>>> +                     length += MINMATCH;
>>>>>>>> +                     if (op + length >= oend - FASTLOOP_SAFE_DISTANCE) {
>>>>>>>> +                             goto safe_match_copy;
>>>>>>>> +                     }
>>>>>>>> +             } else {
>>>>>>>> +                     length += MINMATCH;
>>>>>>>> +                     if (op + length >= oend - FASTLOOP_SAFE_DISTANCE) {
>>>>>>>> +                             goto safe_match_copy;
>>>>>>>> +                     }
>>>>>>>> +
>>>>>>>> +                     /* Fastpath check: Avoids a branch in LZ4_wildCopy32 if true */
>>>>>>>> +                     if (!(dict == usingExtDict) || (match >= lowPrefix)) {
>>>>>>>> +                             if (offset >= 8) {
>>>>>>>> +                                     memcpy(op, match, 8);
>>>>>>>> +                                     memcpy(op + 8, match + 8, 8);
>>>>>>>> +                                     memcpy(op + 16, match + 16, 2);
>>>>>>>> +                                     op += length;
>>>>>>>> +                                     continue;
>>>>>>>> +                             }
>>>>>>>> +                     }
>>>>>>>> +             }
>>>>>>>> +
>>>>>>>> +             /* match starting within external dictionary */
>>>>>>>> +             if ((dict == usingExtDict) && (match < lowPrefix)) {
>>>>>>>> +                     if (unlikely(op + length > oend - LASTLITERALS)) {
>>>>>>>> +                             if (partialDecoding) {
>>>>>>>> +                                     /* reach end of buffer */
>>>>>>>> +                                     length =
>>>>>>>> +                                         min(length, (size_t) (oend - op));
>>>>>>>> +                             } else {
>>>>>>>> +                                     /* end-of-block condition violated */
>>>>>>>> +                                     goto _output_error;
>>>>>>>> +                             }
>>>>>>>> +                     }
>>>>>>>> +
>>>>>>>> +                     if (length <= (size_t) (lowPrefix - match)) {
>>>>>>>> +                             /* match fits entirely within external dictionary : just copy */
>>>>>>>> +                             memmove(op, dictEnd - (lowPrefix - match), length);
>>>>>>>> +                             op += length;
>>>>>>>> +                     } else {
>>>>>>>> +                             /* match stretches into both external dict and current block */
>>>>>>>> +                             size_t const copySize =
>>>>>>>> +                                 (size_t) (lowPrefix - match);
>>>>>>>> +                             size_t const restSize = length - copySize;
>>>>>>>> +                             memcpy(op, dictEnd - copySize, copySize);
>>>>>>>> +                             op += copySize;
>>>>>>>> +                             if (restSize > (size_t) (op - lowPrefix)) {     /* overlap copy */
>>>>>>>> +                                     BYTE *const endOfMatch = op + restSize;
>>>>>>>> +                                     const BYTE *copyFrom = lowPrefix;
>>>>>>>> +                                     while (op < endOfMatch) {
>>>>>>>> +                                             *op++ = *copyFrom++;
>>>>>>>> +                                     }
>>>>>>>> +                             } else {
>>>>>>>> +                                     memcpy(op, lowPrefix, restSize);
>>>>>>>> +                                     op += restSize;
>>>>>>>> +                             }
>>>>>>>> +                     }
>>>>>>>> +                     continue;
>>>>>>>> +             }
>>>>>>>> +
>>>>>>>> +             /* copy match within block */
>>>>>>>> +             cpy = op + length;
>>>>>>>> +
>>>>>>>> +             assert((op <= oend) && (oend - op >= 32));
>>>>>>>> +             if (unlikely(offset < 16)) {
>>>>>>>> +                     LZ4_memcpy_using_offset(op, match, cpy, offset);
>>>>>>>> +             } else {
>>>>>>>> +                     LZ4_wildCopy32(op, match, cpy);
>>>>>>>> +             }
>>>>>>>> +
>>>>>>>> +             op = cpy;       /* wildcopy correction */
>>>>>>>> +     }
>>>>>>>> +      safe_decode:
>>>>>>>> +#endif
>>>>>>>> +     /* Main Loop : decode sequences */
>>>>>>>> +     while (1) {
>>>>>>>> +             length = token >> ML_BITS;
>>>>>>>>
>>>>>>>>               /* ip < iend before the increment */
>>>>>>>>               assert(!endOnInput || ip <= iend);
>>>>>>>> @@ -143,26 +450,27 @@ static FORCE_INLINE int LZ4_decompress_generic(
>>>>>>>>                * combined check for both stages).
>>>>>>>>                */
>>>>>>>>               if ((endOnInput ? length != RUN_MASK : length <= 8)
>>>>>>>> -                /*
>>>>>>>> -                 * strictly "less than" on input, to re-enter
>>>>>>>> -                 * the loop with at least one byte
>>>>>>>> -                 */
>>>>>>>> -                && likely((endOnInput ? ip < shortiend : 1) &
>>>>>>>> -                          (op <= shortoend))) {
>>>>>>>> +                 /*
>>>>>>>> +                  * strictly "less than" on input, to re-enter
>>>>>>>> +                  * the loop with at least one byte
>>>>>>>> +                  */
>>>>>>>> +                 && likely((endOnInput ? ip < shortiend : 1) &
>>>>>>>> +                           (op <= shortoend))) {
>>>>>>>>                       /* Copy the literals */
>>>>>>>>                       memcpy(op, ip, endOnInput ? 16 : 8);
>>>>>>>> -                     op += length; ip += length;
>>>>>>>> +                     op += length;
>>>>>>>> +                     ip += length;
>>>>>>>>
>>>>>>>>                       /*
>>>>>>>>                        * The second stage:
>>>>>>>>                        * prepare for match copying, decode full info.
>>>>>>>>                        * If it doesn't work out, the info won't be wasted.
>>>>>>>>                        */
>>>>>>>> -                     length = token & ML_MASK; /* match length */
>>>>>>>> +                     length = token & ML_MASK;       /* match length */
>>>>>>>>                       offset = LZ4_readLE16(ip);
>>>>>>>>                       ip += 2;
>>>>>>>>                       match = op - offset;
>>>>>>>> -                     assert(match <= op); /* check overflow */
>>>>>>>> +                     assert(match <= op);    /* check overflow */
>>>>>>>>
>>>>>>>>                       /* Do not deal with overlapping matches. */
>>>>>>>>                       if ((length != ML_MASK) &&
>>>>>>>> @@ -187,28 +495,24 @@ static FORCE_INLINE int LZ4_decompress_generic(
>>>>>>>>
>>>>>>>>               /* decode literal length */
>>>>>>>>               if (length == RUN_MASK) {
>>>>>>>> -                     unsigned int s;
>>>>>>>>
>>>>>>>> -                     if (unlikely(endOnInput ? ip >= iend - RUN_MASK : 0)) {
>>>>>>>> -                             /* overflow detection */
>>>>>>>> +                     variable_length_error error = ok;
>>>>>>>> +                     length +=
>>>>>>>> +                         read_variable_length(&ip, iend - RUN_MASK,
>>>>>>>> +                                              endOnInput, endOnInput,
>>>>>>>> +                                              &error);
>>>>>>>> +                     if (error == initial_error)
>>>>>>>>                               goto _output_error;
>>>>>>>> -                     }
>>>>>>>> -                     do {
>>>>>>>> -                             s = *ip++;
>>>>>>>> -                             length += s;
>>>>>>>> -                     } while (likely(endOnInput
>>>>>>>> -                             ? ip < iend - RUN_MASK
>>>>>>>> -                             : 1) & (s == 255));
>>>>>>>>
>>>>>>>>                       if ((safeDecode)
>>>>>>>> -                         && unlikely((uptrval)(op) +
>>>>>>>> -                                     length < (uptrval)(op))) {
>>>>>>>> +                         && unlikely((uptrval) (op) +
>>>>>>>> +                                     length < (uptrval) (op))) {
>>>>>>>>                               /* overflow detection */
>>>>>>>>                               goto _output_error;
>>>>>>>>                       }
>>>>>>>>                       if ((safeDecode)
>>>>>>>> -                         && unlikely((uptrval)(ip) +
>>>>>>>> -                                     length < (uptrval)(ip))) {
>>>>>>>> +                         && unlikely((uptrval) (ip) +
>>>>>>>> +                                     length < (uptrval) (ip))) {
>>>>>>>>                               /* overflow detection */
>>>>>>>>                               goto _output_error;
>>>>>>>>                       }
>>>>>>>> @@ -216,11 +520,15 @@ static FORCE_INLINE int LZ4_decompress_generic(
>>>>>>>>
>>>>>>>>               /* copy literals */
>>>>>>>>               cpy = op + length;
>>>>>>>> +#if LZ4_FAST_DEC_LOOP
>>>>>>>> +           safe_literal_copy:
>>>>>>>> +#endif
>>>>>>>>               LZ4_STATIC_ASSERT(MFLIMIT >= WILDCOPYLENGTH);
>>>>>>>>
>>>>>>>>               if (((endOnInput) && ((cpy > oend - MFLIMIT)
>>>>>>>> -                     || (ip + length > iend - (2 + 1 + LASTLITERALS))))
>>>>>>>> -                     || ((!endOnInput) && (cpy > oend - WILDCOPYLENGTH))) {
>>>>>>>> +                                   || (ip + length >
>>>>>>>> +                                       iend - (2 + 1 + LASTLITERALS))))
>>>>>>>> +                 || ((!endOnInput) && (cpy > oend - WILDCOPYLENGTH))) {
>>>>>>>>                       if (partialDecoding) {
>>>>>>>>                               if (cpy > oend) {
>>>>>>>>                                       /*
>>>>>>>> @@ -231,7 +539,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
>>>>>>>>                                       length = oend - op;
>>>>>>>>                               }
>>>>>>>>                               if ((endOnInput)
>>>>>>>> -                                     && (ip + length > iend)) {
>>>>>>>> +                                 && (ip + length > iend)) {
>>>>>>>>                                       /*
>>>>>>>>                                        * Error :
>>>>>>>>                                        * read attempt beyond
>>>>>>>> @@ -241,7 +549,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
>>>>>>>>                               }
>>>>>>>>                       } else {
>>>>>>>>                               if ((!endOnInput)
>>>>>>>> -                                     && (cpy != oend)) {
>>>>>>>> +                                 && (cpy != oend)) {
>>>>>>>>                                       /*
>>>>>>>>                                        * Error :
>>>>>>>>                                        * block decoding must
>>>>>>>> @@ -250,7 +558,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
>>>>>>>>                                       goto _output_error;
>>>>>>>>                               }
>>>>>>>>                               if ((endOnInput)
>>>>>>>> -                                     && ((ip + length != iend)
>>>>>>>> +                                 && ((ip + length != iend)
>>>>>>>>                                       || (cpy > oend))) {
>>>>>>>>                                       /*
>>>>>>>>                                        * Error :
>>>>>>>> @@ -288,29 +596,14 @@ static FORCE_INLINE int LZ4_decompress_generic(
>>>>>>>>                       goto _output_error;
>>>>>>>>               }
>>>>>>>>
>>>>>>>> -             /* costs ~1%; silence an msan warning when offset == 0 */
>>>>>>>> -             /*
>>>>>>>> -              * note : when partialDecoding, there is no guarantee that
>>>>>>>> -              * at least 4 bytes remain available in output buffer
>>>>>>>> -              */
>>>>>>>> -             if (!partialDecoding) {
>>>>>>>> -                     assert(oend > op);
>>>>>>>> -                     assert(oend - op >= 4);
>>>>>>>> -
>>>>>>>> -                     LZ4_write32(op, (U32)offset);
>>>>>>>> -             }
>>>>>>>> -
>>>>>>>>               if (length == ML_MASK) {
>>>>>>>> -                     unsigned int s;
>>>>>>>> -
>>>>>>>> -                     do {
>>>>>>>> -                             s = *ip++;
>>>>>>>> -
>>>>>>>> -                             if ((endOnInput) && (ip > iend - LASTLITERALS))
>>>>>>>> -                                     goto _output_error;
>>>>>>>>
>>>>>>>> -                             length += s;
>>>>>>>> -                     } while (s == 255);
>>>>>>>> +                     variable_length_error error = ok;
>>>>>>>> +                     length +=
>>>>>>>> +                         read_variable_length(&ip, iend - LASTLITERALS + 1,
>>>>>>>> +                                              endOnInput, 0, &error);
>>>>>>>> +                     if (error != ok)
>>>>>>>> +                             goto _output_error;
>>>>>>>>
>>>>>>>>                       if ((safeDecode)
>>>>>>>>                               && unlikely(
>>>>>>>> @@ -322,6 +615,10 @@ static FORCE_INLINE int LZ4_decompress_generic(
>>>>>>>>
>>>>>>>>               length += MINMATCH;
>>>>>>>>
>>>>>>>> +#if LZ4_FAST_DEC_LOOP
>>>>>>>> +safe_match_copy:
>>>>>>>> +#endif
>>>>>>>> +
>>>>>>>>               /* match starting within external dictionary */
>>>>>>>>               if ((dict == usingExtDict) && (match < lowPrefix)) {
>>>>>>>>                       if (unlikely(op + length > oend - LASTLITERALS)) {
>>>>>>>>
