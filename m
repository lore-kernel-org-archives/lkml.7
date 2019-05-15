Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD14C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097A220862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsY6LRHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfEORDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 13:03:31 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34181 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfEORDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 13:03:31 -0400
Received: by mail-io1-f66.google.com with SMTP id g84so190575ioa.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 10:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QQv+2cVzaSf/sR+TfoVuc+JE8shCO+QHFMVSgR01JgI=;
        b=YsY6LRHddYDf7S/JEpbknJjwcozbew/I+bQ4PJ0qvsUZbmY1B+eo0GRJZKhzuO53It
         77uvVwWNCknFxO79aEMrBt5Lfh0maByYyD8Gc4SL/Gh6GoKXkpik4FS1pQQCE8Mmri7z
         RodxaUBWyY0NnNB4TR/0D0T98Bw+qPjTl5CPFJIEgY+ztADqB/8XduYNC50lfVwv81zJ
         SMv1uge6OVmgntpAln6navE1BRlsaPxqtAmh8/6cNkR8JHJkkLWP5iOmjh+cqXQVkrhn
         jrW/AGO+t2oUnzGBpfDtqx5G1+nw70HS1FA/LnM/L+fzEguw0EiNstVHe3nFlBzQagNx
         wDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QQv+2cVzaSf/sR+TfoVuc+JE8shCO+QHFMVSgR01JgI=;
        b=WgrKiH5xcnOQR/YgGrx84mvph2LD+32+sScXv8wnxC4HZUMmTmTzA9DHHckRzXsbnJ
         KEEHViWVKzeo3LY75hul3BPIejcd/tyxEURlMhv5iGrvk/FVO5uMxlmCIGMkLw/my2yp
         wKSkzDWlFY2NpgD51PV5GpN7nQu5UJYY3hLPdT7xaWpjML7DYDt6faZ1MKvq3E8itgRm
         SI1aAneSyeDArQcwNiwfurLgocu5vGkKEHBeaTLpeE6LMcZCR1AXzIRxV7IZk0tXc48r
         fcJaFcT5yR+LMgMhRwBKpprrnkWAxBcldia3IkkBFXHDOL92kMnwBMld82lphAqBI9t2
         2u7g==
X-Gm-Message-State: APjAAAXjGeG5boLGmydxT/by9cBfxGgcWJEamVg3YxuTp4EFQzxikdYI
        +P3TnT53bH+X9EOkzSCk+bem2FUxtTjYLFSnYwU=
X-Google-Smtp-Source: APXvYqzeUx5aU2BLCpGInMs3dk/A2T1wjbdYZZ2rBZ3jICOMLmHdSFVUSMTWQEnupavrM5bsItXARaTT32woAcibym8=
X-Received: by 2002:a5d:9d07:: with SMTP id j7mr6347152ioj.39.1557939809579;
 Wed, 15 May 2019 10:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190515004336.66555-1-chenxi.mao@sony.com> <649ba9ed-223e-1e82-1513-f3c16e4c8f9a@huawei.com>
 <0c1d0d7d24ae48f68ae6acc95c0c4869@CNBJMBX12.corpusers.net> <CADv+DGkGa3q4FJ0TeLcj626PrUEYCDMfyKdd0yx82VmAX2i98Q@mail.gmail.com>
In-Reply-To: <CADv+DGkGa3q4FJ0TeLcj626PrUEYCDMfyKdd0yx82VmAX2i98Q@mail.gmail.com>
From:   Cyan <yann.collet.73@gmail.com>
Date:   Wed, 15 May 2019 10:03:18 -0700
Message-ID: <CADv+DG=Rc5gqhJXsYOAWbFQNm_5RMhCjDEm4d2V+an-6+-QTCg@mail.gmail.com>
Subject: Re: [PATCH 1/1] LZ4: Port LZ4 1.9.x FAST_DEC_LOOP and enable it on
 x86 and ARM64
To:     "Mao, Chenxi" <Chenxi.Mao@sony.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Feng, Roy" <Roy.Feng@sony.com>,
        "Xu, Yuanli 2" <Yuanli.Xu@sony.com>,
        "Alm, Robert 2" <Robert.Alm@sony.com>,
        "Takahashi, Masaya A (Sony Mobile)" <Masaya.A.Takahashi@sony.com>,
        Miao Xie <miaoxie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-posted,
it seems the previous message was rejected by the linux-kernel server
due to some kind of format limitation (no html).


Le mer. 15 mai 2019 =C3=A0 09:56, Cyan <yann.collet.73@gmail.com> a =C3=A9c=
rit :
>
> The v1.9.0 version has a bug which makes it read a few bytes out of bound=
 in certain cases.
> This was fixed in v1.9.1.
> Therefore, if you plan upgrading version, skip directly to v1.9.1.
>
> Note that, in v1.9.1, LZ4_decompress_fast() is now deprecated.
> LZ4_decompress_fast() is a security liability, since it's unable to cope =
with malicious inputs.
> While this is not a problem when the producer is under direct control (lo=
cal production and consumption, no intermediate storage),
> this entry point seems misused in multiple scenarios where input cannot b=
e decently trusted.
> The deprecation warning is meant to "scare away" such usages.
> It's still possible to intentionally remove the warning, for users who kn=
ow what they are doing.
>
> Note that, on top of that, the _fast() variant is now slower that LZ4_dec=
ompress_safe(), removing its most important positive differentiator.
> That's because LZ4_decompress_fast() is "blind", it doesn't know the inpu=
t size.
> It just guesses it, from the requested output size, and by relying on end=
-of-block conditions.
> This effectively limits its capability to copy up to 8 bytes at a time,
> which proves slower than the 32-bytes at a time used in LZ4_decompress_sa=
fe().
>
> LZ4_decompress_fast() still has some possible usage :
> it doesn't need the compressed size.
> Therefore, in a scenario where decompressed size is known, but compressed=
 size isn't,
> it cannot be replaced by `LZ4_decompress_safe()`.
> This is pretty rare, but can happen in some cases, erofs for example.
> `LZ4_decompress_safe_partial()` *might* be able to replace it for such sc=
enario,
> but I haven't thoroughly tested it, so can't yet vouch for it.
>
> If it doesn't, then it will be necessary to create a new entry point.
> The main difference is that this new entry point will need a bound for th=
e input size, in order to guarantee it never reads beyond input buffer.
> But as said, for the time being, such dedicated entry point doesn't exist=
.
>
> The new FAST_DEC_LOOP setting works well on x86 and x64.
> Recently, it has been extended to gcc+arm64 (`dev` branch).
> The combination of clang+arm64 is less successful though (impacts vary, d=
epending on version and exact hardware), so it's still disabled by default.
> But anyone can test it by setting FAST_DEC_LOOP definition to 1, thus ena=
bling the new decoder loop.
>
>
> Y.
>
> Le mar. 14 mai 2019 =C3=A0 20:28, Mao, Chenxi <Chenxi.Mao@sony.com> a =C3=
=A9crit :
>>
>> Hi Xiang:
>>
>> Thanks for your reply, I will have a stress test on my device later.
>> I didn't have chance to test LZ4 with clang build because of device limi=
tation. I think I could do it later.
>> I guess the clang performance downgrade is caused by some compiler optim=
ization options.
>> I will double check it later if I got the device which can build kernel =
with clang.
>>
>> BTW, the FAST_DEC_LOOP leverage LZ4_wildCopy8 instead of LZ4_wildCopy,
>> however based on my test, original LZ4_wildCopy has the better performan=
ce.
>> Original LZ4_wildCopy API still invoked by FAST_DEC_LOOP apis.
>> That might be a problem for X86 devices for current patch.
>>
>> Chenxi
>>
>> -----Original Message-----
>> From: Gao Xiang [mailto:gaoxiang25@huawei.com]
>> Sent: Wednesday, May 15, 2019 10:21 AM
>> To: Mao, Chenxi <Chenxi.Mao@sony.com>
>> Cc: akpm@linux-foundation.org; linux-kernel@vger.kernel.org; Feng, Roy <=
Roy.Feng@sony.com>; Xu, Yuanli 2 <Yuanli.Xu@sony.com>; Alm, Robert 2 <Rober=
t.Alm@sony.com>; Takahashi, Masaya A (Sony Mobile) <Masaya.A.Takahashi@sony=
.com>; Miao Xie <miaoxie@huawei.com>
>> Subject: Re: [PATCH 1/1] LZ4: Port LZ4 1.9.x FAST_DEC_LOOP and enable it=
 on x86 and ARM64
>>
>> Hi Chenxi,
>>
>> On 2019/5/15 8:43, Chenxi Mao wrote:
>> > FAST_DEC_LOOP was introduced from LZ4 1.9.
>> > This change would be introduce 10% on decompress operation according
>> > to LZ4 benchmark result on X86 devices.
>> > Meanwhile, LZ4 with FAST_DEC_LOOP could get improvements, however
>> > clang compiler has downgrade if FAST_DEC_LOOP enabled.
>>
>> I noticed this optimization and lz4-1.9.0 [1] was just released month ag=
o with this big change therefore I'm a little afraid of its current stabili=
ty (especially some rare used decompression apis...)
>>
>> Could you Cc more people (e.g. lz4 original author Yann Collet) in order=
 to get some more ideas about this if possible?
>>
>> Anyway, I like this optimization as well since FAST_DEC_LOOP improves de=
compression speed a lot :)
>>
>> [1] https://github.com/lz4/lz4/releases/tag/v1.9.0
>>
>> Thanks,
>> Gao Xiang
>>
>> >
>> > So FAST_DEC_LOOP only enabled on X86/X86-64 or ARM64 with GCC build.
>> >
>> > Here is the test result on ARM64(cortex-A53)
>> >
>> > Benchmark via ZRAM:
>> >
>> > Test case:
>> > fio --bs=3D32k --randrepeat=3D1 --randseed=3D100 --refill_buffers \
>> > --buffer_compress_percentage=3D75 \
>> > --scramble_buffers=3D1 --direct=3D1 --loops=3D100 --numjobs=3D8 \
>> > --filename=3D/dev/block/zram0 --name=3Dseq-write --rw=3Dwrite --stonew=
all \
>> > --name=3Dseq-read --rw=3Dread --stonewall --name=3Dseq-readwrite \ --r=
w=3Drw
>> > --stonewall --name=3Drand-readwrite --rw=3Drandrw --stonewall
>> >
>> > Patched:
>> >    READ: bw=3D7077MiB/s (7421MB/s)
>> > Vanilla:
>> >    READ: bw=3D5134MiB/s (5384MB/s)
>> >
>> > Reference:
>> > 1. https://github.com/lz4/lz4/pull/645
>> > 2. https://github.com/lz4/lz4/pull/707
>> >
>> > Signed-off-by: chenxi.mao <chenxi.mao@sony.com>
>> > ---
>> >  lib/lz4/lz4_decompress.c | 425
>> > +++++++++++++++++++++++++++++++++------
>> >  1 file changed, 361 insertions(+), 64 deletions(-)
>> >
>> > diff --git a/lib/lz4/lz4_decompress.c b/lib/lz4/lz4_decompress.c index
>> > 0c9d3ad17e0f..a4c87e32b3c0 100644
>> > --- a/lib/lz4/lz4_decompress.c
>> > +++ b/lib/lz4/lz4_decompress.c
>> > @@ -50,6 +50,131 @@
>> >  #define assert(condition) ((void)0)
>> >  #endif
>> >
>> > +#ifndef LZ4_FAST_DEC_LOOP
>> > +#if defined(__i386__) || defined(__x86_64__) #define
>> > +LZ4_FAST_DEC_LOOP 1 #elif defined(__aarch64__) && !defined(__clang__)
>> > +     /* On aarch64, we disable this optimization for clang because on=
 certain
>> > +      * mobile chipsets and clang, it reduces performance. For more i=
nformation
>> > +      * refer to https://github.com/lz4/lz4/pull/707. */ #define
>> > +LZ4_FAST_DEC_LOOP 1 #else #define LZ4_FAST_DEC_LOOP 0 #endif #endif
>> > +
>> > +static const unsigned inc32table[8] =3D { 0, 1, 2, 1, 0, 4, 4, 4 };
>> > +static const int dec64table[8] =3D { 0, 0, 0, -1, -4, 1, 2, 3 };
>> > +
>> > +#if LZ4_FAST_DEC_LOOP
>> > +#define FASTLOOP_SAFE_DISTANCE 64
>> > +FORCE_INLINE void
>> > +LZ4_memcpy_using_offset_base(BYTE * dstPtr, const BYTE * srcPtr, BYTE=
 * dstEnd,
>> > +                          const size_t offset)
>> > +{
>> > +     if (offset < 8) {
>> > +             dstPtr[0] =3D srcPtr[0];
>> > +
>> > +             dstPtr[1] =3D srcPtr[1];
>> > +             dstPtr[2] =3D srcPtr[2];
>> > +             dstPtr[3] =3D srcPtr[3];
>> > +             srcPtr +=3D inc32table[offset];
>> > +             memcpy(dstPtr + 4, srcPtr, 4);
>> > +             srcPtr -=3D dec64table[offset];
>> > +             dstPtr +=3D 8;
>> > +     } else {
>> > +             memcpy(dstPtr, srcPtr, 8);
>> > +             dstPtr +=3D 8;
>> > +             srcPtr +=3D 8;
>> > +     }
>> > +
>> > +     LZ4_wildCopy(dstPtr, srcPtr, dstEnd); }
>> > +
>> > +/* customized variant of memcpy, which can overwrite up to 32 bytes
>> > +beyond dstEnd
>> > + * this version copies two times 16 bytes (instead of one time 32
>> > +bytes)
>> > + * because it must be compatible with offsets >=3D 16. */ FORCE_INLIN=
E
>> > +void LZ4_wildCopy32(void *dstPtr, const void *srcPtr, void *dstEnd) {
>> > +     BYTE *d =3D (BYTE *) dstPtr;
>> > +     const BYTE *s =3D (const BYTE *)srcPtr;
>> > +     BYTE *const e =3D (BYTE *) dstEnd;
>> > +
>> > +     do {
>> > +             memcpy(d, s, 16);
>> > +             memcpy(d + 16, s + 16, 16);
>> > +             d +=3D 32;
>> > +             s +=3D 32;
>> > +     } while (d < e);
>> > +}
>> > +
>> > +FORCE_INLINE void
>> > +LZ4_memcpy_using_offset(BYTE *dstPtr, const BYTE *srcPtr, BYTE *dstEn=
d,
>> > +                     const size_t offset)
>> > +{
>> > +     BYTE v[8];
>> > +     switch (offset) {
>> > +
>> > +     case 1:
>> > +             memset(v, *srcPtr, 8);
>> > +             goto copy_loop;
>> > +     case 2:
>> > +             memcpy(v, srcPtr, 2);
>> > +             memcpy(&v[2], srcPtr, 2);
>> > +             memcpy(&v[4], &v[0], 4);
>> > +             goto copy_loop;
>> > +     case 4:
>> > +             memcpy(v, srcPtr, 4);
>> > +             memcpy(&v[4], srcPtr, 4);
>> > +             goto copy_loop;
>> > +     default:
>> > +             LZ4_memcpy_using_offset_base(dstPtr, srcPtr, dstEnd, off=
set);
>> > +             return;
>> > +     }
>> > +
>> > +      copy_loop:
>> > +     memcpy(dstPtr, v, 8);
>> > +     dstPtr +=3D 8;
>> > +     while (dstPtr < dstEnd) {
>> > +             memcpy(dstPtr, v, 8);
>> > +             dstPtr +=3D 8;
>> > +     }
>> > +}
>> > +
>> > +/* Read the variable-length literal or match length.
>> > + *
>> > + * ip - pointer to use as input.
>> > + * lencheck - end ip.  Return an error if ip advances >=3D lencheck.
>> > + * loop_check - check ip >=3D lencheck in body of loop.  Returns loop=
_error if so.
>> > + * initial_check - check ip >=3D lencheck before start of loop.  Retu=
rns initial_error if so.
>> > + * error (output) - error code.  Should be set to 0 before call.
>> > + */
>> > +typedef enum { loop_error =3D -2, initial_error =3D -1, ok =3D 0}
>> > +variable_length_error; FORCE_INLINE unsigned read_variable_length(con=
st BYTE **ip,
>> > +                                        const BYTE *lencheck,
>> > +                                        int loop_check, int initial_c=
heck,
>> > +                                        variable_length_error *error)=
 {
>> > +     unsigned length =3D 0;
>> > +     unsigned s;
>> > +     if (initial_check && unlikely((*ip) >=3D lencheck)) {     /* ove=
rflow detection */
>> > +             *error =3D initial_error;
>> > +             return length;
>> > +     }
>> > +     do {
>> > +             s =3D **ip;
>> > +             (*ip)++;
>> > +             length +=3D s;
>> > +             if (loop_check && unlikely((*ip) >=3D lencheck)) {      =
  /* overflow detection */
>> > +                     *error =3D loop_error;
>> > +                     return length;
>> > +             }
>> > +     } while (s =3D=3D 255);
>> > +
>> > +     return length;
>> > +}
>> > +#endif
>> > +
>> >  /*
>> >   * LZ4_decompress_generic() :
>> >   * This generic decompression function covers all use cases.
>> > @@ -80,25 +205,28 @@ static FORCE_INLINE int LZ4_decompress_generic(
>> >        const size_t dictSize
>> >        )
>> >  {
>> > -     const BYTE *ip =3D (const BYTE *) src;
>> > -     const BYTE * const iend =3D ip + srcSize;
>> > +     const BYTE *ip =3D (const BYTE *)src;
>> > +     const BYTE *const iend =3D ip + srcSize;
>> >
>> >       BYTE *op =3D (BYTE *) dst;
>> > -     BYTE * const oend =3D op + outputSize;
>> > +     BYTE *const oend =3D op + outputSize;
>> >       BYTE *cpy;
>> >
>> > -     const BYTE * const dictEnd =3D (const BYTE *)dictStart + dictSiz=
e;
>> > -     static const unsigned int inc32table[8] =3D {0, 1, 2, 1, 0, 4, 4=
, 4};
>> > -     static const int dec64table[8] =3D {0, 0, 0, -1, -4, 1, 2, 3};
>> > +     const BYTE *const dictEnd =3D (const BYTE *)dictStart + dictSize=
;
>> >
>> >       const int safeDecode =3D (endOnInput =3D=3D endOnInputSize);
>> >       const int checkOffset =3D ((safeDecode) && (dictSize < (int)(64 =
*
>> > KB)));
>> >
>> >       /* Set up the "end" pointers for the shortcut. */
>> >       const BYTE *const shortiend =3D iend -
>> > -             (endOnInput ? 14 : 8) /*maxLL*/ - 2 /*offset*/;
>> > +         (endOnInput ? 14 : 8) /*maxLL*/ - 2 /*offset*/;
>> >       const BYTE *const shortoend =3D oend -
>> > -             (endOnInput ? 14 : 8) /*maxLL*/ - 18 /*maxML*/;
>> > +         (endOnInput ? 14 : 8) /*maxLL*/ - 18 /*maxML*/;
>> > +
>> > +     const BYTE *match;
>> > +     size_t offset;
>> > +     unsigned int token;
>> > +     size_t length;
>> >
>> >       DEBUGLOG(5, "%s (srcSize:%i, dstSize:%i)", __func__,
>> >                srcSize, outputSize);
>> > @@ -117,15 +245,194 @@ static FORCE_INLINE int LZ4_decompress_generic(
>> >       if ((endOnInput) && unlikely(srcSize =3D=3D 0))
>> >               return -1;
>> >
>> > -     /* Main Loop : decode sequences */
>> > +#if LZ4_FAST_DEC_LOOP
>> > +     if ((oend - op) < FASTLOOP_SAFE_DISTANCE) {
>> > +             DEBUGLOG(6, "skip fast decode loop");
>> > +             goto safe_decode;
>> > +     }
>> > +
>> > +     /* Fast loop : decode sequences as long as output <
>> > +iend-FASTLOOP_SAFE_DISTANCE */
>> >       while (1) {
>> > -             size_t length;
>> > -             const BYTE *match;
>> > -             size_t offset;
>> > +             /* Main fastloop assertion: We can always wildcopy FASTL=
OOP_SAFE_DISTANCE */
>> > +             assert(oend - op >=3D FASTLOOP_SAFE_DISTANCE);
>> > +             if (endOnInput) {
>> > +                     assert(ip < iend);
>> > +             }
>> > +             token =3D *ip++;
>> > +             length =3D token >> ML_BITS;      /* literal length */
>> > +
>> > +             assert(!endOnInput || ip <=3D iend);      /* ip < iend b=
efore the increment */
>> > +
>> > +             /* decode literal length */
>> > +             if (length =3D=3D RUN_MASK) {
>> > +                     variable_length_error error =3D ok;
>> > +                     length +=3D
>> > +                         read_variable_length(&ip, iend - RUN_MASK,
>> > +                                              endOnInput, endOnInput,
>> > +                                              &error);
>> > +                     if (error =3D=3D initial_error) {
>> > +                             goto _output_error;
>> > +                     }
>> > +                     if ((safeDecode)
>> > +                         && unlikely((uptrval) (op) + length <
>> > +                                     (uptrval) (op))) {
>> > +                             goto _output_error;
>> > +                     }       /* overflow detection */
>> > +                     if ((safeDecode)
>> > +                         && unlikely((uptrval) (ip) + length <
>> > +                                     (uptrval) (ip))) {
>> > +                             goto _output_error;
>> > +                     }
>> > +
>> > +                     /* overflow detection */
>> > +                     /* copy literals */
>> > +                     cpy =3D op + length;
>> > +                     LZ4_STATIC_ASSERT(MFLIMIT >=3D WILDCOPYLENGTH);
>> > +                     if (endOnInput) {       /* LZ4_decompress_safe()=
 */
>> > +                             if ((cpy > oend - 32)
>> > +                                 || (ip + length > iend - 32)) {
>> > +                                     goto safe_literal_copy;
>> > +                             }
>> > +                             LZ4_wildCopy32(op, ip, cpy);
>> > +                     } else {        /* LZ4_decompress_fast() */
>> > +                             if (cpy > oend - 8) {
>> > +                                     goto safe_literal_copy;
>> > +                             }
>> > +                             LZ4_wildCopy(op, ip, cpy);
>> > +                             /* LZ4_decompress_fast() cannot copy mor=
e than 8 bytes at a time */
>> > +                             /* it doesn't know input length, and onl=
y relies on end-of-block */
>> > +                             /* properties */
>> > +                     }
>> > +                     ip +=3D length;
>> > +                     op =3D cpy;
>> > +             } else {
>> > +                     cpy =3D op + length;
>> > +                     if (endOnInput) {       /* LZ4_decompress_safe()=
 */
>> > +                             DEBUGLOG(7,
>> > +                                      "copy %u bytes in a 16-bytes st=
ripe",
>> > +                                      (unsigned)length);
>> > +                             /* We don't need to check oend */
>> > +                             /* since we check it once for each loop =
below */
>> > +                             if (ip > iend - (16 + 1)) {     /*max li=
t + offset + nextToken */
>> > +                                     goto safe_literal_copy;
>> > +                             }
>> > +                             /* Literals can only be 14, but hope com=
pilers optimize */
>> > +                             /*if we copy by a register size */
>> > +                             memcpy(op, ip, 16);
>> > +                     } else {
>> > +                             /* LZ4_decompress_fast() cannot copy mor=
e than 8 bytes at a time */
>> > +                             /* it doesn't know input length, and rel=
ies on end-of-block */
>> > +                             /* properties */
>> > +                             memcpy(op, ip, 8);
>> > +                             if (length > 8) {
>> > +                                     memcpy(op + 8, ip + 8, 8);
>> > +                             }
>> > +                     }
>> > +                     ip +=3D length;
>> > +                     op =3D cpy;
>> > +             }
>> > +
>> > +             /* get offset */
>> > +             offset =3D LZ4_readLE16(ip);
>> > +             ip +=3D 2;        /* end-of-block condition violated */
>> > +             match =3D op - offset;
>> > +
>> > +             /* get matchlength */
>> > +             length =3D token & ML_MASK;
>> >
>> > -             /* get literal length */
>> > -             unsigned int const token =3D *ip++;
>> > -             length =3D token>>ML_BITS;
>> > +             if ((checkOffset) && (unlikely(match + dictSize < lowPre=
fix))) {
>> > +                     goto _output_error;
>> > +             }
>> > +             /* Error : offset outside buffers */
>> > +             if (length =3D=3D ML_MASK) {
>> > +                     variable_length_error error =3D ok;
>> > +                     length +=3D
>> > +                         read_variable_length(&ip, iend - LASTLITERAL=
S + 1,
>> > +                                              endOnInput, 0, &error);
>> > +                     if (error !=3D ok) {
>> > +                             goto _output_error;
>> > +                     }
>> > +                     if ((safeDecode)
>> > +                         && unlikely((uptrval) (op) + length < (uptrv=
al) op)) {
>> > +                             goto _output_error;
>> > +                     }       /* overflow detection */
>> > +                     length +=3D MINMATCH;
>> > +                     if (op + length >=3D oend - FASTLOOP_SAFE_DISTAN=
CE) {
>> > +                             goto safe_match_copy;
>> > +                     }
>> > +             } else {
>> > +                     length +=3D MINMATCH;
>> > +                     if (op + length >=3D oend - FASTLOOP_SAFE_DISTAN=
CE) {
>> > +                             goto safe_match_copy;
>> > +                     }
>> > +
>> > +                     /* Fastpath check: Avoids a branch in LZ4_wildCo=
py32 if true */
>> > +                     if (!(dict =3D=3D usingExtDict) || (match >=3D l=
owPrefix)) {
>> > +                             if (offset >=3D 8) {
>> > +                                     memcpy(op, match, 8);
>> > +                                     memcpy(op + 8, match + 8, 8);
>> > +                                     memcpy(op + 16, match + 16, 2);
>> > +                                     op +=3D length;
>> > +                                     continue;
>> > +                             }
>> > +                     }
>> > +             }
>> > +
>> > +             /* match starting within external dictionary */
>> > +             if ((dict =3D=3D usingExtDict) && (match < lowPrefix)) {
>> > +                     if (unlikely(op + length > oend - LASTLITERALS))=
 {
>> > +                             if (partialDecoding) {
>> > +                                     /* reach end of buffer */
>> > +                                     length =3D
>> > +                                         min(length, (size_t) (oend -=
 op));
>> > +                             } else {
>> > +                                     /* end-of-block condition violat=
ed */
>> > +                                     goto _output_error;
>> > +                             }
>> > +                     }
>> > +
>> > +                     if (length <=3D (size_t) (lowPrefix - match)) {
>> > +                             /* match fits entirely within external d=
ictionary : just copy */
>> > +                             memmove(op, dictEnd - (lowPrefix - match=
), length);
>> > +                             op +=3D length;
>> > +                     } else {
>> > +                             /* match stretches into both external di=
ct and current block */
>> > +                             size_t const copySize =3D
>> > +                                 (size_t) (lowPrefix - match);
>> > +                             size_t const restSize =3D length - copyS=
ize;
>> > +                             memcpy(op, dictEnd - copySize, copySize)=
;
>> > +                             op +=3D copySize;
>> > +                             if (restSize > (size_t) (op - lowPrefix)=
) {     /* overlap copy */
>> > +                                     BYTE *const endOfMatch =3D op + =
restSize;
>> > +                                     const BYTE *copyFrom =3D lowPref=
ix;
>> > +                                     while (op < endOfMatch) {
>> > +                                             *op++ =3D *copyFrom++;
>> > +                                     }
>> > +                             } else {
>> > +                                     memcpy(op, lowPrefix, restSize);
>> > +                                     op +=3D restSize;
>> > +                             }
>> > +                     }
>> > +                     continue;
>> > +             }
>> > +
>> > +             /* copy match within block */
>> > +             cpy =3D op + length;
>> > +
>> > +             assert((op <=3D oend) && (oend - op >=3D 32));
>> > +             if (unlikely(offset < 16)) {
>> > +                     LZ4_memcpy_using_offset(op, match, cpy, offset);
>> > +             } else {
>> > +                     LZ4_wildCopy32(op, match, cpy);
>> > +             }
>> > +
>> > +             op =3D cpy;       /* wildcopy correction */
>> > +     }
>> > +      safe_decode:
>> > +#endif
>> > +     /* Main Loop : decode sequences */
>> > +     while (1) {
>> > +             length =3D token >> ML_BITS;
>> >
>> >               /* ip < iend before the increment */
>> >               assert(!endOnInput || ip <=3D iend);
>> > @@ -143,26 +450,27 @@ static FORCE_INLINE int LZ4_decompress_generic(
>> >                * combined check for both stages).
>> >                */
>> >               if ((endOnInput ? length !=3D RUN_MASK : length <=3D 8)
>> > -                /*
>> > -                 * strictly "less than" on input, to re-enter
>> > -                 * the loop with at least one byte
>> > -                 */
>> > -                && likely((endOnInput ? ip < shortiend : 1) &
>> > -                          (op <=3D shortoend))) {
>> > +                 /*
>> > +                  * strictly "less than" on input, to re-enter
>> > +                  * the loop with at least one byte
>> > +                  */
>> > +                 && likely((endOnInput ? ip < shortiend : 1) &
>> > +                           (op <=3D shortoend))) {
>> >                       /* Copy the literals */
>> >                       memcpy(op, ip, endOnInput ? 16 : 8);
>> > -                     op +=3D length; ip +=3D length;
>> > +                     op +=3D length;
>> > +                     ip +=3D length;
>> >
>> >                       /*
>> >                        * The second stage:
>> >                        * prepare for match copying, decode full info.
>> >                        * If it doesn't work out, the info won't be was=
ted.
>> >                        */
>> > -                     length =3D token & ML_MASK; /* match length */
>> > +                     length =3D token & ML_MASK;       /* match lengt=
h */
>> >                       offset =3D LZ4_readLE16(ip);
>> >                       ip +=3D 2;
>> >                       match =3D op - offset;
>> > -                     assert(match <=3D op); /* check overflow */
>> > +                     assert(match <=3D op);    /* check overflow */
>> >
>> >                       /* Do not deal with overlapping matches. */
>> >                       if ((length !=3D ML_MASK) &&
>> > @@ -187,28 +495,24 @@ static FORCE_INLINE int LZ4_decompress_generic(
>> >
>> >               /* decode literal length */
>> >               if (length =3D=3D RUN_MASK) {
>> > -                     unsigned int s;
>> >
>> > -                     if (unlikely(endOnInput ? ip >=3D iend - RUN_MAS=
K : 0)) {
>> > -                             /* overflow detection */
>> > +                     variable_length_error error =3D ok;
>> > +                     length +=3D
>> > +                         read_variable_length(&ip, iend - RUN_MASK,
>> > +                                              endOnInput, endOnInput,
>> > +                                              &error);
>> > +                     if (error =3D=3D initial_error)
>> >                               goto _output_error;
>> > -                     }
>> > -                     do {
>> > -                             s =3D *ip++;
>> > -                             length +=3D s;
>> > -                     } while (likely(endOnInput
>> > -                             ? ip < iend - RUN_MASK
>> > -                             : 1) & (s =3D=3D 255));
>> >
>> >                       if ((safeDecode)
>> > -                         && unlikely((uptrval)(op) +
>> > -                                     length < (uptrval)(op))) {
>> > +                         && unlikely((uptrval) (op) +
>> > +                                     length < (uptrval) (op))) {
>> >                               /* overflow detection */
>> >                               goto _output_error;
>> >                       }
>> >                       if ((safeDecode)
>> > -                         && unlikely((uptrval)(ip) +
>> > -                                     length < (uptrval)(ip))) {
>> > +                         && unlikely((uptrval) (ip) +
>> > +                                     length < (uptrval) (ip))) {
>> >                               /* overflow detection */
>> >                               goto _output_error;
>> >                       }
>> > @@ -216,11 +520,15 @@ static FORCE_INLINE int LZ4_decompress_generic(
>> >
>> >               /* copy literals */
>> >               cpy =3D op + length;
>> > +#if LZ4_FAST_DEC_LOOP
>> > +           safe_literal_copy:
>> > +#endif
>> >               LZ4_STATIC_ASSERT(MFLIMIT >=3D WILDCOPYLENGTH);
>> >
>> >               if (((endOnInput) && ((cpy > oend - MFLIMIT)
>> > -                     || (ip + length > iend - (2 + 1 + LASTLITERALS))=
))
>> > -                     || ((!endOnInput) && (cpy > oend - WILDCOPYLENGT=
H))) {
>> > +                                   || (ip + length >
>> > +                                       iend - (2 + 1 + LASTLITERALS))=
))
>> > +                 || ((!endOnInput) && (cpy > oend - WILDCOPYLENGTH)))=
 {
>> >                       if (partialDecoding) {
>> >                               if (cpy > oend) {
>> >                                       /*
>> > @@ -231,7 +539,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
>> >                                       length =3D oend - op;
>> >                               }
>> >                               if ((endOnInput)
>> > -                                     && (ip + length > iend)) {
>> > +                                 && (ip + length > iend)) {
>> >                                       /*
>> >                                        * Error :
>> >                                        * read attempt beyond
>> > @@ -241,7 +549,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
>> >                               }
>> >                       } else {
>> >                               if ((!endOnInput)
>> > -                                     && (cpy !=3D oend)) {
>> > +                                 && (cpy !=3D oend)) {
>> >                                       /*
>> >                                        * Error :
>> >                                        * block decoding must
>> > @@ -250,7 +558,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
>> >                                       goto _output_error;
>> >                               }
>> >                               if ((endOnInput)
>> > -                                     && ((ip + length !=3D iend)
>> > +                                 && ((ip + length !=3D iend)
>> >                                       || (cpy > oend))) {
>> >                                       /*
>> >                                        * Error :
>> > @@ -288,29 +596,14 @@ static FORCE_INLINE int LZ4_decompress_generic(
>> >                       goto _output_error;
>> >               }
>> >
>> > -             /* costs ~1%; silence an msan warning when offset =3D=3D=
 0 */
>> > -             /*
>> > -              * note : when partialDecoding, there is no guarantee th=
at
>> > -              * at least 4 bytes remain available in output buffer
>> > -              */
>> > -             if (!partialDecoding) {
>> > -                     assert(oend > op);
>> > -                     assert(oend - op >=3D 4);
>> > -
>> > -                     LZ4_write32(op, (U32)offset);
>> > -             }
>> > -
>> >               if (length =3D=3D ML_MASK) {
>> > -                     unsigned int s;
>> > -
>> > -                     do {
>> > -                             s =3D *ip++;
>> > -
>> > -                             if ((endOnInput) && (ip > iend - LASTLIT=
ERALS))
>> > -                                     goto _output_error;
>> >
>> > -                             length +=3D s;
>> > -                     } while (s =3D=3D 255);
>> > +                     variable_length_error error =3D ok;
>> > +                     length +=3D
>> > +                         read_variable_length(&ip, iend - LASTLITERAL=
S + 1,
>> > +                                              endOnInput, 0, &error);
>> > +                     if (error !=3D ok)
>> > +                             goto _output_error;
>> >
>> >                       if ((safeDecode)
>> >                               && unlikely(
>> > @@ -322,6 +615,10 @@ static FORCE_INLINE int LZ4_decompress_generic(
>> >
>> >               length +=3D MINMATCH;
>> >
>> > +#if LZ4_FAST_DEC_LOOP
>> > +safe_match_copy:
>> > +#endif
>> > +
>> >               /* match starting within external dictionary */
>> >               if ((dict =3D=3D usingExtDict) && (match < lowPrefix)) {
>> >                       if (unlikely(op + length > oend - LASTLITERALS))=
 {
>> >
