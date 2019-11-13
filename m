Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441D9C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4CB22C8A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573663021;
	bh=91BwXUpt7QfI68Pc0+7Gor1e7juvndWGl4jc/nPmeP8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GWIOD9TPc7ajnWQ0HYlMVs/JgxTZ8FDdPLQNig5Sdb2XjfnN+ZHgFcHLxA2WNr5c7
	 MBnXYAw8K35p0xDsJ+K1QmvbP2nZ4DwCHCMxN0i9uNto6fO4wblKspwVydyiqIuSR4
	 R1+YEbxeNVbcUdELIISSr+JmOVVDwnSMkNjfEtH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbfKMQhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 11:37:02 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33668 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfKMQhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:37:01 -0500
Received: by mail-lf1-f68.google.com with SMTP id d6so2518328lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 08:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZrrJxUm37MwzOHZARPAtPN97Qeo3bve+3YkG041g53s=;
        b=Mn6BNFnYW1bkG15A7Sor9ynnXRgzP8PN+BRA0Iqrx/Fygjwn/rTGXLTIJm35Sniesy
         cIGkmDclUGM4VNAEt5mOIOTLVdMJHHgip/K0K8i+kNa+1z4OL7zelRz1oW/0HveIQiRT
         cnEhwtm8sDkFtYLDnz1AlwNWC51Y+epmEIytw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZrrJxUm37MwzOHZARPAtPN97Qeo3bve+3YkG041g53s=;
        b=dWMe0wN1y5kqPM6fQUyY8MDtrHma2R3xyo0HT02Ht3SRDK9YId/354uhvE79dW4YqH
         iHA+1oCVlD7emne4I92cT/1dTZp0/e8o1/Qcxksz/j33d95Va6aYwbGx+nS3G6jCsi1n
         ReTWJnFeToX/fVn/F0xy4lIahOJQoClcKDIPY7hJI3DSg2uP2JQOmS4yImWISxUIGsUt
         ib8Lk9hHaKmWJYpfl+f2Yjg/xlvDUVuFqmyBBoxZbV8bNsBVryBcCEFeAMev1m9uR2h5
         Zwf8KZxB4DwdohQvPZjUFZyslv1ZS7Jq/RkRO8JMMcTaraSYufgBOMZpIUQMOt09fHhO
         lX2Q==
X-Gm-Message-State: APjAAAU/eC8mTKeVanAWho9hAORBHaj95RZwbDMHZASkQxvUcpXdzeQg
        Wd7oyTue1A4X4QB8B02QD7SRPQsgbmc=
X-Google-Smtp-Source: APXvYqyAD0fSFUHqkN4GZ2/7FWa/xMHEOiyGVK/EhIbdidfYb7oHfqeAiBiiQnrrdanzsPtfxczk1g==
X-Received: by 2002:a19:8ac5:: with SMTP id m188mr3497451lfd.186.1573663018438;
        Wed, 13 Nov 2019 08:36:58 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id u5sm1215397ljg.68.2019.11.13.08.36.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 08:36:57 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id n21so3276264ljg.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 08:36:57 -0800 (PST)
X-Received: by 2002:a2e:22c1:: with SMTP id i184mr3290842lji.1.1573663016714;
 Wed, 13 Nov 2019 08:36:56 -0800 (PST)
MIME-Version: 1.0
References: <20191112130244.16630-1-vincent.whitchurch@axis.com>
 <20191112160855.GA22025@arrakis.emea.arm.com> <20191112180034.GB19889@willie-the-truck>
 <20191112182249.GB22025@arrakis.emea.arm.com> <CAHk-=wg4vi27mnMVgZ-rzcEdDAjTXrY1Jyz3+=5STcY0bw4-jQ@mail.gmail.com>
 <20191113102357.GA25875@willie-the-truck>
In-Reply-To: <20191113102357.GA25875@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Nov 2019 08:36:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjmyEdYW4vEaNDP4UMB+H7wWneOwLUR3FmPG-Fb6U8dZg@mail.gmail.com>
Message-ID: <CAHk-=wjmyEdYW4vEaNDP4UMB+H7wWneOwLUR3FmPG-Fb6U8dZg@mail.gmail.com>
Subject: Re: [PATCH v2] buffer: Fix I/O error due to ARM read-after-read hazard
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jens Axboe <axboe@kernel.dk>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Vincent Whitchurch <rabinv@axis.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 2:24 AM Will Deacon <will@kernel.org> wrote:
>
> Ok, I'll stick my neck out here, but if test_bit() is being used to read
> a bitmap that is being concurrently modified (e.g. by set_bit() which boils
> down to atomic_long_or()), then why isn't READ_ONCE() required? Right now,
> test_bit takes a 'const volatile unsigned long *addr' argument, so I don't
> see that you'll get a change in codegen except on alpha and, with this
> erratum, arm32.

You're right. We've moved back to actually having it volatile (or
possibly never got away from it). My bad.

At one point, we tried very hard to make test_bit() perform much
better when you tested multiple bits, and I thought we ended up having
that merged and didn't want to regress. But apparently we never did
that, or it got undone.

test_bit() is a very unfortunate interface, in that we actually use it
in some situations where we _really_ would want to merge reads (not
split them, but merge them). There are several cases where we do
constant test-bits on the same word, and don't care about ordering.
Things like thread flags etc.

It's explicitly not ordered, so *merging* reads would be right and
lovely, it's the "don't read twice" that is bad. But we have no way to
tell the compiler that ;(

Anyway, READ_ONCE() is ok by me when I look at the code, because as
you say, it's already volatile (like my memory ;).

           Linus
