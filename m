Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1115DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 04:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0E520866
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 04:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlVcq7fl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfJ3EMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 00:12:22 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40993 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfJ3EMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 00:12:22 -0400
Received: by mail-oi1-f195.google.com with SMTP id g81so814547oib.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 21:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q8SBmE+8CAuRsopHcvNfJ0iOGe3QE73CA4UWHXUOwzo=;
        b=NlVcq7fl9famiHFwVuXroRWduNF6YzH/4yHGpXWGNk+n1bQ4bvpjQCiEgUhbhk3mPO
         9IQaYBsuiz4qQWkVyMbfR379LhuuUs5OLKHBEhrqS7R77grOSQ5TK/b9ec1xu9JMbciY
         q4SvSpPDfoZOHMB/wiwAxLPSHHndu3xnpfwwgIIF8S6myDXUgwH6tB5HawuxGXGexwDn
         AyhsgCsoYV5GwdLBR7tQH7u2Tyr+T2VwgKooE6sztkuOu30ZRd7kgAI2O3QWVLUY2ogx
         xBeFY11McksdtVcE2QO0uNO+mDhhbsA4BtdLVWZRUTdDISkY1P8Gh21QTVXEuYslV5af
         VHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q8SBmE+8CAuRsopHcvNfJ0iOGe3QE73CA4UWHXUOwzo=;
        b=GRIvc0cU8C9npMUq5rBwoeC8llfnna/Eg8gHNMmR094bBvSS5QkjS2SJ/sOwiS9RNY
         QebAbkwyOgzJh+rcmu90+uNLyzX6mGSQrN2AmGjl3tkpmiprWM1/9aPeEGp1UJzPk/dy
         nFNpiy+HWUDzysQbqNG1R8/Yl3Q/u9VaXKdnUAl0MBLthaVH7KWoe3SKM62bjoXcNsTy
         B2+KIFN8ZZPiftgQ+frT0R3Ul7d32SeUxCLNAy7LEqOS/WholPtsCWWoTvkkSJT3O+dJ
         9PLq7BlFn8NcRRQxATTHfiUFvt7HJ4/GugMrSTR3ma4JV/RgOvB909FFzSJ2pSJnWUj8
         bV9Q==
X-Gm-Message-State: APjAAAVOW01q92BbfVEkJmEwur68g3LtQkQT7iB25PP9eC6ZKrda+DC6
        tDvCRoH5gk5+cZlFF4pSf/E+/Wwo
X-Google-Smtp-Source: APXvYqyxpEloNeg8lmz1nQNKAJqcYExDQ+n8NNJFQFby1voWeWfahZNM3WEyFGqPgTisHyRJNox65g==
X-Received: by 2002:aca:fc11:: with SMTP id a17mr6995309oii.59.1572408741122;
        Tue, 29 Oct 2019 21:12:21 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id z4sm300942oix.17.2019.10.29.21.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 21:12:20 -0700 (PDT)
Date:   Tue, 29 Oct 2019 21:12:18 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] powerpc/prom_init: Use -ffreestanding to avoid a
 reference to bcmp
Message-ID: <20191030041218.GB14630@ubuntu-m2-xlarge-x86>
References: <20190911182049.77853-1-natechancellor@gmail.com>
 <20191014025101.18567-1-natechancellor@gmail.com>
 <20191014025101.18567-4-natechancellor@gmail.com>
 <20191014093501.GE28442@gate.crashing.org>
 <CAKwvOdmcUT2A9FG0JD9jd0s=gAavRc_h+RLG6O3mBz4P1FfF8w@mail.gmail.com>
 <20191014191141.GK28442@gate.crashing.org>
 <20191018190022.GA1292@ubuntu-m2-xlarge-x86>
 <20191018200210.GR28442@gate.crashing.org>
 <20191022051529.GA44041@ubuntu-m2-xlarge-x86>
 <20191022085709.GI28442@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022085709.GI28442@gate.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 03:57:09AM -0500, Segher Boessenkool wrote:
> On Mon, Oct 21, 2019 at 10:15:29PM -0700, Nathan Chancellor wrote:
> > On Fri, Oct 18, 2019 at 03:02:10PM -0500, Segher Boessenkool wrote:
> > > I think the proper solution is for the kernel to *do* use -ffreestanding,
> > > and then somehow tell the kernel that memcpy etc. are the standard
> > > functions.  A freestanding GCC already requires memcpy, memmove, memset,
> > > memcmp, and sometimes abort to exist and do the standard thing; why cannot
> > > programs then also rely on it to be the standard functions.
> > > 
> > > What exact functions are the reason the kernel does not use -ffreestanding?
> > > Is it just memcpy?  Is more wanted?
> > 
> > I think Linus summarized it pretty well here:
> > 
> > https://lore.kernel.org/lkml/CAHk-=wi-epJZfBHDbKKDZ64us7WkF=LpUfhvYBmZSteO8Q0RAg@mail.gmail.com/
> 
> GCC recognises __builtin_memcpy (or any other __builtin) just fine even
> with -ffreestanding.
> 
> So the kernel wants a warning (or error) whenever a call to one of these
> library functions is generated by the compiler without the user asking
> for it directly (via a __builtin)?  And that is all that is needed for
> the kernel to use -ffreestanding?
> 
> That shouldn't be hard.  Anything missing here?
> 
> 
> Segher

Yes, I suppose that would be good enough.

I don't know if there are any other optimizations that are missed out on
by using -ffreestanding. It would probably be worth asking other kernel
developers on a separate thread (or the one I linked above).

Would be nice to get this shored up soon since our PowerPC builds have
been broken since the beginning of August :/

Cheers,
Nathan
