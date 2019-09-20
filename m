Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CEFC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD1C206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OHCOK+V0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393791AbfITWkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 18:40:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40437 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390810AbfITWkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 18:40:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id x127so5462787pfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 15:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=qpo1CPqc73MCadVo8iRju2Ls/5Qlein+jmhvtvLiZqY=;
        b=OHCOK+V0HKEyBFqOJ32B3ABP50mz0poRDGAM4/FfFIrfiImdUTCHk+RaUb6ter2Yl5
         +Et1oYNNUkR+uOTJkaKKY0IEaojK2nUTV1L+l60d4hWIc/lqSm9GVJEkoHnfUvQyPi5M
         juollKtqCpYuPTpDCLlLKy0M/AmdwOSAHC1qg7bfTt+sxiwTWkJGxvx3SLVAPFsedxq4
         EHXXoib7FuHxCyHCiAQ/xfZ8Ds7AMkJAtSbplkIfzN58pf74LUcPaguQeSs024cUPimZ
         Wzwg+bhFvXToTKCTuDJFkglFJfP4lH2p5Z7JOIFNLQe9AKKIrsXMrt6SqN9a+3288815
         m55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=qpo1CPqc73MCadVo8iRju2Ls/5Qlein+jmhvtvLiZqY=;
        b=k3pVNq2uhNqGEZF74KzQhNnSDlQItAoxzSCZW5sEO/Wcm+Ev7fIndZd9yoX0LevMtV
         UruiPZmzolRVKCk0usyw8GfXLnSSe3YdS5iDfB2GZQNcjpiMF2BJ4w4EJmKd5JYc/VBV
         lWjGsLcYgfVVoss3LjhIl1mJR59OWIe2iTkv9twAmkePremE0+wUroj5UeP4imIAGbM1
         JR4YkmYqUOoDAZPic/+X78m0nsne1bFKGrq+7q29rffVRovVOZMD/WJpl3gwbkjKsX5P
         6DL69oU9Dym2Llsrfj76H3Ig8gLnzc3bpfWdAo0HcBKUCILnpAPmlmjkeHZDUq0BOKVZ
         WDzQ==
X-Gm-Message-State: APjAAAXtKAdAT0VsCyhCJdccWOIHJWOy9AW5ZsEgBJf8iX55bpZyJ8eX
        RCjTYpEhbG7T7EBPFch7+OopQg==
X-Google-Smtp-Source: APXvYqxBLLCCHEO/jL8pLzoAfxhjW5ynBcF9ZKHvN1WdzOpo7zRbplvUWd30cWCyGZsTMoCFuQrFOg==
X-Received: by 2002:a62:fc46:: with SMTP id e67mr20195478pfh.153.1569019230813;
        Fri, 20 Sep 2019 15:40:30 -0700 (PDT)
Received: from localhost ([2607:fb90:5de:df7b:9794:c3bf:6169:a06c])
        by smtp.gmail.com with ESMTPSA id b16sm5242640pfb.54.2019.09.20.15.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 15:40:29 -0700 (PDT)
Date:   Fri, 20 Sep 2019 15:40:29 -0700 (PDT)
X-Google-Original-Date: Fri, 20 Sep 2019 15:35:11 PDT (-0700)
Subject:     RE: [RFC] buildtar: add case for riscv architecture
In-Reply-To: <lMUhcsewB9GAKeZH2cH-zl3vFME8u2z5IzCqDBFhtT2IbG71vhHnjrlHKbhyxFee5XFe1X1gRllNJBR9e9dQlC0vbIpSffL_y0pLb46VddQ=@aurabindo.in>
CC:     Anup Patel <Anup.Patel@wdc.com>,
        Troy Benjegerdes <troy.benjegerdes@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     mail@aurabindo.in
Message-ID: <mhng-79e5204f-e7b6-43d0-94cb-815d3be314ae@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2019 02:35:10 PDT (-0700), mail@aurabindo.in wrote:
> ‐‐‐‐‐‐‐ Original Message ‐‐‐‐‐‐‐
> On Sunday, September 15, 2019 12:57 AM, Palmer Dabbelt <palmer@sifive.com> wrote:
>
>> On Sat, 14 Sep 2019 06:05:59 PDT (-0700), Anup Patel wrote:
>>
>> > > -----Original Message-----
>> > > From: linux-kernel-owner@vger.kernel.org <linux-kernel-
>> > > owner@vger.kernel.org> On Behalf Of Palmer Dabbelt
>> > > Sent: Saturday, September 14, 2019 6:30 PM
>> > > To: mail@aurabindo.in
>> > > Cc: Troy Benjegerdes troy.benjegerdes@sifive.com; Paul Walmsley
>> > > paul.walmsley@sifive.com; aou@eecs.berkeley.edu; linux-
>> > > riscv@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
>> > > kbuild@vger.kernel.org
>> > > Subject: Re: [RFC] buildtar: add case for riscv architecture
>> > > On Wed, 11 Sep 2019 05:54:07 PDT (-0700), mail@aurabindo.in wrote:
>> > >
>> > > > > None of the available RiscV platforms that I’m aware of use compressed
>> > > > > images, unless there are some new bootloaders I haven’t seen yet.
>> > > >
>> > > > >
>> > > >
>> > > > I noticed that default build image is Image.gz, which is why I thought its a
>> > > > good idea to copy it into the tarball. Does such a copy not make sense at this
>> > > > point ?
>> > >
>> > > Image.gz can't be booted directly: it's just Image that's been compressed
>> > > with the standard gzip command. A bootloader would have to decompress
>> > > that image before loading it into memory, which requires extra bootloader
>> > > support.
>> > > Contrast that with the zImage style images (which are vmlinuz on x86), which
>> > > are self-extracting and therefor require no bootloader support. The
>> > > examples for u-boot all use the "booti" command, which expects
>> > > uncompressed images.
>> > > Poking around I couldn't figure out a way to have u-boot decompress the
>> > > images, but that applies to arm64 as well so I'm not sure if I'm missing
>> > > something.
>> > > If I was doing this, I'd copy over arch/riscv/boot/Image and call it
>> > > "/boot/image-${KERNELRELEASE}", as calling it vmlinuz is a bit confusing to
>> > > me because I'd expect vmlinuz to be a self-extracting compressed
>> > > executable and not a raw gzip file.
>> >
>> > On the contrary, it is indeed possible to boot Image.gz directly using
>> > U-Boot booti command so this patch would be useful.
>> > Atish had got it working on U-Boot but he has deferred booti Image.gz
>> > support due to few more dependent changes. May be he can share
>> > more info.
>>
>> Oh, great. I guess it makes sense to just put both in the tarball, then, as
>> users will still need to use the Image format for now.
>>
>
> Uncompressed vmlinux is already copied by default. This patch just adds the
> Image.gz into the archive as vmlinuz. But as you said, since the name vmlinuz is
> reserved for self extracting archives, should I keep the original name Image.gz ?

vmlinux is not the same as Image: vmlinux is an ELF file that can't be loaded 
directly by most bootloaders, Image is a mostly-flat binary with a small header 
that we're expecting can be booted by most bootloaders.
