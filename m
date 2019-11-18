Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A77C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 00:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D15020730
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 00:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1/qD5nxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfKRAk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 19:40:59 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:33508 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfKRAk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 19:40:59 -0500
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id xAI0ergl002444
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 09:40:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com xAI0ergl002444
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574037653;
        bh=hkPXAic6NPXzq/7n9TnXGwIxJXxKUEf9zWj/n2i4rVo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1/qD5nxSDwXF1BVmUT9IpqlkLvAHWLYNaJbr3FI8wYTJZ0x7Rp8PQNomHYw32jQms
         DFe0e39+F0v2g52Mdb3bWXovwb3fTl/piX7lu8aaNOwjmToXGYAUx2YCUDNip8T9Ra
         Zc6jH2F5dCFER5Rq6B4Y4U1WzGdh9YC9gijXGajqDIQWl/ATp9cCbbnCwpGL8jfJHC
         kmvE2N8MFtGwzsR8rDRQ3dA/UufIvoXl4V5TRmUqV4o5ZtLM1cLJk5Aweqvz3YKIkE
         3JZw0A9AWq9RVOStHNFpWQyPX1KFwDJPAbFSvLlppbVkuYl3PrVDFX95pe4Z+mzOJJ
         cjnHtC02CB0Vg==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id m9so10329848vsq.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 16:40:53 -0800 (PST)
X-Gm-Message-State: APjAAAVwyqyy3jLxbbLvn+jkGHxK+8KvOjFeXyoca1FdQpPVzeoK00eF
        JWM8irE756A/PWj/Ex/gFI58nlTFpNVTfsUJlm8=
X-Google-Smtp-Source: APXvYqybItcVCM2CCmBWq1V7TdcCN/76kG/hMiER2uQuDKycdTQXOFIQR22XfA0AhTNxDemt7wu288YiJbparz92QTY=
X-Received: by 2002:a05:6102:3204:: with SMTP id r4mr12870949vsf.181.1574037652398;
 Sun, 17 Nov 2019 16:40:52 -0800 (PST)
MIME-Version: 1.0
References: <d60946a1-fde3-ee6f-683a-42a611768bbf@kernel.dk>
 <CAK7LNATVHbMHqjboACJF8BbKianRfjiGhHTXjtQuJVmv2HFPUA@mail.gmail.com> <8caa1edf-9c6f-15e4-218d-c266013f8e28@kernel.dk>
In-Reply-To: <8caa1edf-9c6f-15e4-218d-c266013f8e28@kernel.dk>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 18 Nov 2019 09:40:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNARUzJx==c1gh33obme21JiRR1CrKELkGpmPJQANx0LqSw@mail.gmail.com>
Message-ID: <CAK7LNARUzJx==c1gh33obme21JiRR1CrKELkGpmPJQANx0LqSw@mail.gmail.com>
Subject: Re: Recent slowdown in single object builds
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2019 at 1:57 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 11/16/19 12:17 AM, Masahiro Yamada wrote:
> > On Sat, Nov 16, 2019 at 8:10 AM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> Hi,
> >>
> >> I've noticed that current -git is a lot slower at doing single object
> >> builds than earlier kernels. Here's an example, building the exact same
> >> file on 5.2 and -git:
> >>
> >> $ time make fs/io_uring.o
> >> real    0m5.953s
> >> user    0m5.402s
> >> sys     0m0.649s
> >>
> >> vs 5.2 based (with all the backports, identical file):
> >>
> >> $ time make fs/io_uring.o
> >> real    0m3.218s
> >> user    0m2.968s
> >> sys     0m0.520s
> >>
> >> Any idea what's going on here? It's almost twice as slow, which is
> >> problematic...


BTW, I am using a cheap machine based on Intel Core i7-6700K.
I can build fs/io_uring.o (based on x86_64_defconfig) much faster.


The slowdown (1.990 sec -> 2.861 sec) is not terrible for me.



masahiro@pug:~/ref/linux$ git describe
v5.2
masahiro@pug:~/ref/linux$ touch  fs/io_uring.c; time  make  fs/io_uring.o
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
  CC      fs/io_uring.o

real 0m1.990s
user 0m1.723s
sys 0m0.427s




masahiro@pug:~/ref/linux-next$ git describe
next-20191115
masahiro@pug:~/ref/linux-next$ touch   fs/io_uring.c; time  make  fs/io_uring.o
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
  CC      fs/io_uring.o

real 0m2.861s
user 0m2.373s
sys 0m0.642s





Snippet from my /proc/cpuinfo

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 94
model name      : Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz
stepping        : 3
microcode       : 0xd4
cpu MHz         : 800.023
cache size      : 8192 KB



> >
> >
> > This is necessary cost
> > to do single builds
> > (394053f4a4b3e3eeeaa67b67fc886a9a75bd9e4d)
> > but, it is much better in linux-next.
>
> Very sad that it's now twice as slow as before, that's a real problem.
> This isn't a marginal slowdown.
>
> I've never had issues with single object builds before, and in fact
> it's often useful to build stuff that's disabled as a single object.
> Where's the report that led to this commit being necessary?
>
> --
> Jens Axboe
>


-- 
Best Regards
Masahiro Yamada
