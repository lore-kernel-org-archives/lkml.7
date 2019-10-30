Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D38CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 00:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA2A20830
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 00:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572394304;
	bh=Snc/eKAWN/e4HyPEVAaf/ZlF4nOjFosVpeQ+TXvql/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cTYodw5XSSeKNKBzmljJhuDGCB9Q6n2+tVE0En8nOllyss9q9DD/SOdLZ3aZHb41k
	 YhC2M1ZxE77X74fS9ACrLAXoP/RPRLZ20cGWrKjGpceBs6eRPN1j4DsOpb+ggG43cb
	 gIzxoF+pstQccnDD+gvsK/8YAnlFYWxIKpqOgntk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfJ3ALA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 20:11:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37264 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfJ3AK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 20:10:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id u9so258293pfn.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 17:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qi25s6eGSzLvxBeYzXnvhnXvWNnh8inr62cHZ+9aVUg=;
        b=ayX1hGoFZHL5xN1xN/Bg67FoJA3c9aMK58FlXtha843HkBRyRmLyNPFLHU7Gsb/ij4
         xbmNPLfT2bm0lLAU9u2R6AFyRbe0bZixTmamcdpfexrps+VHQUd3NSKB3pRmWkyqS+vF
         jYvY5D8BA5tifzgJpZiuItlzrMlv/ME4uYkhQ15W7k7VsRxrpvROr5H8qlc+2gZrs+ri
         J/MMrcCGONRPmITp+J5Ec4tQ/mvteDPcNUa2o0RNEiRTUIkJ1g7JvEuQDDcgW0VgSzVW
         hCVLaHfcZEVBu+1I70zjCz4AGm9Hmf4kyyCtw3/HEhePuVLSpfvVxcSwhTqYH979+8jU
         a3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qi25s6eGSzLvxBeYzXnvhnXvWNnh8inr62cHZ+9aVUg=;
        b=GqPPVFlmTZiash2ynLjESDFZTcP063s0bcENydrCoewa8oOJLC/qvCkm1P9PDyIMZG
         0Y+VanUABzwygMaH78EiaOnv77nZL19JsXPVUQ16AbH+DxJPduDT6oE72BYadByMdkK0
         h0j4LKlksY2UVSHw9r7pPMb3qlGl2K6+MjckqmLTw8dhd8mL1DD2E5EZCL29WGELiuA3
         0gk9GJo/oPtT1HZGD7liSs2ZFB1tzTUbv4n+Z56FE6aAS34oUqOr6Kw6LrIbp1fKNX46
         AzsgmeBLOj6jL7YyPdrVxnkk2T3ALvzPCtrIkCCfmtAP/2VtEChrl+qBNzGAN14di3AW
         BK8A==
X-Gm-Message-State: APjAAAWEsDWABmm/NnV9Trc+FSH9G2cezf3M45i+XHE3xGL5az2FW1ip
        dEUH+DKMm/5t/xfzRI9t+ieCiFbl
X-Google-Smtp-Source: APXvYqwQ/l949uFzkt6NiNvMGzkFXUXnmUmyoO3y4a+93XVBrNS85c+jEJXhcLRpe6+xzVtoACFvWQ==
X-Received: by 2002:a65:6119:: with SMTP id z25mr30900920pgu.332.1572394258089;
        Tue, 29 Oct 2019 17:10:58 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id x14sm246347pfm.96.2019.10.29.17.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 17:10:56 -0700 (PDT)
Date:   Tue, 29 Oct 2019 17:10:54 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Vitaly Wool <vitalywool@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Streetman <ddstreet@ieee.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Henry Burns <henrywolfeburns@gmail.com>,
        Theodore Ts'o <tytso@thunk.org>
Subject: Re: [PATCH 0/3] Allow ZRAM to use any zpool-compatible backend
Message-ID: <20191030001054.GA175126@google.com>
References: <20191010230414.647c29f34665ca26103879c4@gmail.com>
 <20191014164110.GA58307@google.com>
 <CAMJBoFOqG8GYby-MLCgiYgsfntNP2hiX25WibxvUjpkLHvwsUQ@mail.gmail.com>
 <20191015200044.GA233697@google.com>
 <CAMJBoFM48tbay5B7VqvuNQrPkaXEvzG19n++Ke4p6cdSMCDQZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMJBoFM48tbay5B7VqvuNQrPkaXEvzG19n++Ke4p6cdSMCDQZw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 04:21:21PM +0200, Vitaly Wool wrote:
> On Tue, Oct 15, 2019 at 10:00 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > On Tue, Oct 15, 2019 at 09:39:35AM +0200, Vitaly Wool wrote:
> > > Hi Minchan,
> > >
> > > On Mon, Oct 14, 2019 at 6:41 PM Minchan Kim <minchan@kernel.org> wrote:
> > > >
> > > > On Thu, Oct 10, 2019 at 11:04:14PM +0300, Vitaly Wool wrote:
> > > > > The coming patchset is a new take on the old issue: ZRAM can currently be used only with zsmalloc even though this may not be the optimal combination for some configurations. The previous (unsuccessful) attempt dates back to 2015 [1] and is notable for the heated discussions it has caused.
> > > > >
> > > > > The patchset in [1] had basically the only goal of enabling ZRAM/zbud combo which had a very narrow use case. Things have changed substantially since then, and now, with z3fold used widely as a zswap backend, I, as the z3fold maintainer, am getting requests to re-interate on making it possible to use ZRAM with any zpool-compatible backend, first of all z3fold.
> > > > >
> > > > > The preliminary results for this work have been delivered at Linux Plumbers this year [2]. The talk at LPC, though having attracted limited interest, ended in a consensus to continue the work and pursue the goal of decoupling ZRAM from zsmalloc.
> > > > >
> > > > > The current patchset has been stress tested on arm64 and x86_64 devices, including the Dell laptop I'm writing this message on now, not to mention several QEmu confugirations.
> > > > >
> > > > > [1] https://lkml.org/lkml/2015/9/14/356
> > > > > [2] https://linuxplumbersconf.org/event/4/contributions/551/
> > > >
> > > > Please describe what's the usecase in real world, what's the benefit zsmalloc
> > > > cannot fulfill by desgin and how it's significant.
> > >
> > > I'm not entirely sure how to interpret the phrase "the benefit
> > > zsmalloc cannot fulfill by design" but let me explain.
> > > First, there are multi multi core systems where z3fold can provide
> > > better throughput.
> >
> > Please include number in the description with workload.
> 
> Sure. So on an HMP 8-core ARM64 system with ZRAM, we run the following command:
> fio --bs=4k --randrepeat=1 --randseed=100 --refill_buffers \
>     --buffer_compress_percentage=50 --scramble_buffers=1 \
>     --direct=1 --loops=15 --numjobs=4 --filename=/dev/block/zram0 \
>      --name=seq-write --rw=write --stonewall --name=seq-read \
>      --rw=read --stonewall --name=seq-readwrite --rw=rw --stonewall \
>      --name=rand-readwrite --rw=randrw --stonewall
> 
> The results are the following:
> 
> zsmalloc:
> Run status group 0 (all jobs):
>   WRITE: io=61440MB, aggrb=1680.4MB/s, minb=430167KB/s,
> maxb=440590KB/s, mint=35699msec, maxt=36564msec
> 
> Run status group 1 (all jobs):
>    READ: io=61440MB, aggrb=1620.4MB/s, minb=414817KB/s,
> maxb=414850KB/s, mint=37914msec, maxt=37917msec
> 
> Run status group 2 (all jobs):
>   READ: io=30615MB, aggrb=897979KB/s, minb=224494KB/s,
> maxb=228161KB/s, mint=34351msec, maxt=34912msec
>   WRITE: io=30825MB, aggrb=904110KB/s, minb=226027KB/s,
> maxb=229718KB/s, mint=34351msec, maxt=34912msec
> 
> Run status group 3 (all jobs):
>    READ: io=30615MB, aggrb=772002KB/s, minb=193000KB/s,
> maxb=193010KB/s, mint=40607msec, maxt=40609msec
>   WRITE: io=30825MB, aggrb=777273KB/s, minb=194318KB/s,
> maxb=194327KB/s, mint=40607msec, maxt=40609msec
> 
> z3fold:
> Run status group 0 (all jobs):
>   WRITE: io=61440MB, aggrb=1224.8MB/s, minb=313525KB/s,
> maxb=329941KB/s, mint=47671msec, maxt=50167msec
> 
> Run status group 1 (all jobs):
>    READ: io=61440MB, aggrb=3119.3MB/s, minb=798529KB/s,
> maxb=862883KB/s, mint=18228msec, maxt=19697msec
> 
> Run status group 2 (all jobs):
>    READ: io=30615MB, aggrb=937283KB/s, minb=234320KB/s,
> maxb=234334KB/s, mint=33446msec, maxt=33448msec
>   WRITE: io=30825MB, aggrb=943682KB/s, minb=235920KB/s,
> maxb=235934KB/s, mint=33446msec, maxt=33448msec
> 
> Run status group 3 (all jobs):
>    READ: io=30615MB, aggrb=829591KB/s, minb=207397KB/s,
> maxb=210285KB/s, mint=37271msec, maxt=37790msec
>   WRITE: io=30825MB, aggrb=835255KB/s, minb=208813KB/s,
> maxb=211721KB/s, mint=37271msec, maxt=37790msec
> 
> So, z3fold is faster everywhere (including being *two* times faster on
> read) except for sequential write which is the least important use
> case in real world.

No. write is also important because it affects reclaim speed.

I ran fio on x86 with various compression sizes.

left is zsmalloc. right is z3fold

The operation order is
	seq-write
	rand-write
	seq-read
	rand-read
	mixed-seq
	mixed-rand
	trim
	mem_used - byte unit

Last column mem_used is to indicate how many allocator used the memory
to store compressed page

1) compression ratio 75

     WRITE     2535          WRITE     1928
     WRITE     2425          WRITE     1886
      READ     6211           READ     5731
      READ     6339           READ     6182
      READ     1791           READ     1592
     WRITE     1790          WRITE     1591
      READ     1704           READ     1493
     WRITE     1699          WRITE     1489
     WRITE      984          WRITE      974
      TRIM      984           TRIM      974
  mem_used 29986816       mem_used 61239296

For every operation, zsmalloc is faster than z3fold.
Even, it used the 1/2 memory compared to z3fold.

2) compression ratio 66

     WRITE     2125          WRITE     1258
     WRITE     2107          WRITE     1233
      READ     5714           READ     5793
      READ     5948           READ     6065
      READ     1667           READ     1248
     WRITE     1666          WRITE     1247
      READ     1521           READ     1218
     WRITE     1517          WRITE     1215
     WRITE      943          WRITE      870
      TRIM      943           TRIM      870
  mem_used 38158336       mem_used 76779520

For only read operation, z3fold is a bit faster than zsmalloc about 2%.
However, look at other operations which zsmalloc is much faster.
Even, look at used memory.

3) compression ratio 50

     WRITE     2051          WRITE     1109
     WRITE     2029          WRITE     1087
      READ     5366           READ     6364
      READ     5575           READ     5785
      READ     1497           READ     1121
     WRITE     1496          WRITE     1121
      READ     1432           READ     1065
     WRITE     1428          WRITE     1062
     WRITE      930          WRITE      838
      TRIM      930           TRIM      838
  mem_used 59932672       mem_used 104873984

sequential read on z3fold is faster about 15%. However, look at other
operations and used memory. zsmalloc is better.

Why zsmalloc is slow for 50% compression ratio is it needs page copy
for every read operation since compressed objects cross over page boundary.
However, I don't think it's real workload because compressed ratio will
spread out into various sizes. Having said that, I could enhance zsmalloc
to avoid the copy operation. I will work on it.

4) compression ratio 33

     WRITE     1945          WRITE     1239
     WRITE     1869          WRITE     1222
      READ     5319           READ     6206
      READ     5416           READ     6645
      READ     1480           READ     1188
     WRITE     1479          WRITE     1188
      READ     1403           READ     1114
     WRITE     1399          WRITE     1110
     WRITE      930          WRITE      793
      TRIM      930           TRIM      793
  mem_used 78667776       mem_used 104873984

5) compression ratio 25

     WRITE     1862          WRITE     1080
     WRITE     1840          WRITE     1052
      READ     5260           READ     6240
      READ     5540           READ     6359
      READ     1445           READ     1040
     WRITE     1444          WRITE     1039
      READ     1354           READ     1006
     WRITE     1350          WRITE     1003
     WRITE      909          WRITE      775
      TRIM      909           TRIM      775
  mem_used 83902464       mem_used 104873984

If compress ratio is bad, zram read operation with zsmalloc could
be slower about 15% than z3fold because it needs additional memory
copy as I mentioned. However, it's still faster if compression ratio
ig greater than 50%, which is usual case(I believe that's why you
makes z3fold).

> 
> > > Then, there are low end systems with hardware
> > > compression/decompression support which don't need zsmalloc
> > > sophistication and would rather use zbud with ZRAM because the
> > > compression ratio is relatively low.
> >
> > I couldn't imagine how it's bad with zsmalloc. Could you be more
> > specific?
> 
> 
> > > Finally, there are MMU-less systems targeting IOT and still running
> > > Linux and having a compressed RAM disk is something that would help
> > > these systems operate in a better way (for the benefit of the overall
> > > Linux ecosystem, if you care about that, of course; well, some people
> > > do).
> >
> > Could you write down what's the problem to use zsmalloc for MMU-less
> > system? Maybe, it would be important point rather other performance
> > argument since other functions's overheads in the callpath are already
> > rather big.
> 
> Well, I assume you had the reasons to make zsmalloc depend on MMU in Kconfig:
> ...
> config ZSMALLOC
>     tristate "Memory allocator for compressed pages"
>     depends on MMU
>     help
> ...

It's old piece left since zsmalloc used mapping API so I think we could
remove the dependency now. However, I want to know it's the only problem
to use zram in MMU-less system. IOW, if we could remove the zsmalloc MMU
dependency, it's ready to use zram on MMU-less system now?

> 
> But even disregarding that, let's compare ZRAM/zbud and ZRAM/zsmalloc
> performance and memory these two consume on a relatively low end
> 2-core ARM.
> Command:
> fio --bs=4k --randrepeat=1 --randseed=100 --refill_buffers
> --scramble_buffers=1 \
>         --direct=1 --loops=15 --numjobs=2 --filename=/dev/block/zram0 \
>         --name=seq-write --rw=write --stonewall --name=seq-read --rw=read \
>         --stonewall --name=seq-readwrite --rw=rw --stonewall
> --name=rand-readwrite \
>         --rw=randrw --stonewall
> 
> zsmalloc:
> Run status group 0 (all jobs):
>   WRITE: io=30720MB, aggrb=374763KB/s, minb=187381KB/s,
> maxb=188389KB/s, mint=83490msec, maxt=83939msec
> 
> Run status group 1 (all jobs):
>    READ: io=30720MB, aggrb=964000KB/s, minb=482000KB/s,
> maxb=482015KB/s, mint=32631msec, maxt=32632msec
> 
> Run status group 2 (all jobs):
>    READ: io=15308MB, aggrb=431263KB/s, minb=215631KB/s,
> maxb=215898KB/s, mint=36302msec, maxt=36347msec
>   WRITE: io=15412MB, aggrb=434207KB/s, minb=217103KB/s,
> maxb=217373KB/s, mint=36302msec, maxt=36347msec
> 
> Run status group 3 (all jobs):
>    READ: io=15308MB, aggrb=327328KB/s, minb=163664KB/s,
> maxb=163667KB/s, mint=47887msec, maxt=47888msec
>   WRITE: io=15412MB, aggrb=329563KB/s, minb=164781KB/s,
> maxb=164785KB/s, mint=47887msec, maxt=47888msec
> 
> zbud:
> Run status group 0 (all jobs):
>   WRITE: io=30720MB, aggrb=735980KB/s, minb=367990KB/s,
> maxb=373079KB/s, mint=42159msec, maxt=42742msec
> 
> Run status group 1 (all jobs):
>    READ: io=30720MB, aggrb=927915KB/s, minb=463957KB/s,
> maxb=463999KB/s, mint=33898msec, maxt=33901msec
> 
> Run status group 2 (all jobs):
>    READ: io=15308MB, aggrb=403467KB/s, minb=201733KB/s,
> maxb=202051KB/s, mint=38790msec, maxt=38851msec
>   WRITE: io=15412MB, aggrb=406222KB/s, minb=203111KB/s,
> maxb=203430KB/s, mint=38790msec, maxt=38851msec
> 
> Run status group 3 (all jobs):
>    READ: io=15308MB, aggrb=334967KB/s, minb=167483KB/s,
> maxb=167487KB/s, mint=46795msec, maxt=46796msec
>   WRITE: io=15412MB, aggrb=337254KB/s, minb=168627KB/s,
> maxb=168630KB/s, mint=46795msec, maxt=46796msec
> 
> Pretty equal except for sequential write which is twice as good with zbud.

Thanks for the testing. I also tried to test zbud with zram but failed because fio
submit incompressible pages to zram even though it specifiy compress ratio 100%
However, zbud doesn't support 4K page allocation so zram couldn't work on it
at this moment. I tried various fio versions as well as old but everything failed.

How did you test it successfully? Let me know your fio version.
I want to investigate what's the performance bottleneck beside page copy
so that I will optimize it.

> 
> Now to the fun part.
> zsmalloc:
>   0 .text         00002908  0000000000000000  0000000000000000  00000040  2**2
>                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
> zbud:
>   0 .text         0000072c  0000000000000000  0000000000000000  00000040  2**2
>                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
> 
> And this does not cover dynamic memory allocation overhead which is
> higher for zsmalloc. So once again, given that the compression ratio
> is low (e. g. a simple HW accelerator is used), what would most
> unbiased people prefer to use in this case?

Zsmalloc has more features than zbud. That's why you see the code size
difference. It was intentional because at that time most of users were
mobile phones, TV and other smart devices. They needed those features.

We could make those feature turned off at build time, which will improve
performance and reduce code size a lot. It would be no problem if the
user wanted to use zbud which is alredy lacking of those features.

> 
> > > > I really don't want to make fragmentaion of allocator so we should really see
> > > > how zsmalloc cannot achieve things if you are claiming.
> > >
> > > I have to say that this point is completely bogus. We do not create
> > > fragmentation by using a better defined and standardized API. In fact,
> > > we aim to increase the number of use cases and test coverage for ZRAM.
> > > With that said, I have hard time seeing how zsmalloc can operate on a
> > > MMU-less system.
> > >
> > > > Please tell us how to test it so that we could investigate what's the root
> > > > cause.
> > >
> > > I gather you haven't read neither the LPC documents nor my
> > > conversation with Sergey re: these changes, because if you did you
> > > wouldn't have had the type of questions you're asking. Please also see
> > > above.
> >
> > Please include your claims in the description rather than attaching
> > file. That's the usualy way how we work because it could make easier to
> > discuss by inline.
> 
> Did I attach something? I don't quite recall that. I posted links to
> previous discussions and conference materials, each for a reason.
> 
> > >
> > > I feel a bit awkward explaining basic things to you but there may not
> > > be other "root cause" than applicability issue. zsmalloc is a great
> > > allocator but it's not universal and has its limitations. The
> > > (potential) scope for ZRAM is wider than zsmalloc can provide. We are
> > > *helping* _you_ to extend this scope "in real world" (c) and you come
> > > up with bogus objections. Why?
> >
> > Please add more detail to convince so we need to think over why zsmalloc
> > cannot be improved for the usecase.
> 
> This approach is wrong. zsmalloc is good enough and covers a lot of
> use cases but there are still some where it doesn't work that well by
> design. E. g. on an XIP system we do care about the code size since
> it's stored uncompressed but still want to use ZRAM. Why would we want
> to waste almost 10K just on zsmalloc code if the counterpart (zbud in
> that case) works better?

As I mentiond, we could improve zsmalloc to reduce code size as well as
performance. I will work on it.
