Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A68C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA7A21773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BgMbzYM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfEUILa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:11:30 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33764 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfEUIL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:11:29 -0400
Received: by mail-io1-f66.google.com with SMTP id z4so13243900iol.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 01:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=RnThzzUHSQZwdGPWAHShID/REfskUYDY2HJjG1jNb4I=;
        b=BgMbzYM79a+p2TrvR9uxu2/OVAD0AZ7E8erbWgF6BZ7hwgZjD6C+q4PMoXODRc9dos
         Ki7kuEORyeNJoSDVnkokpd4L7HVmkv5shTk2bw8IKQjJaaL0IGz7w4j0uOYnDq+bqPVZ
         N6liRBzodJ6AalQP3pZC6GAwT0i6u3nJPDSKfQ4hPcI6JFBieFrvPz9yxOhtRif0XKrM
         LCNK0RKJFnmdzPq/HRyeDYZ2S59AZNRHFCSD/vBxtKXekfAZSgu+wIveokOhaDr0VqFU
         QmWDV0p0ps0i1/r2rZ6y5P18noSRLC0NTou88SAYFhsMjK3B3b4d9LzdRkeCW7cl53P1
         v1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=RnThzzUHSQZwdGPWAHShID/REfskUYDY2HJjG1jNb4I=;
        b=CyHqIPuRPd013t4HC7CNkbg53kKWEHAeFY9eFHvgZm2I/wtFUqaxcdIlOue/hXMVBH
         zaN7LPfPx/aZAcQXWT/7YkNcnfEOn4mZk2UreDz6E+A4PQaGoO18ML+GsHGoUesietnv
         vwHXgtrluJp+IpY2i8HXXe69JNNoqA++kTaRKmA6TJE0adkpD04RmV3eZJGzFuunUGBG
         RrrEUx4cs6dKuN6M46lsSBWTNUJcBumEAvNwpuqCHJrzyaXwmipIuoUSskYaxcYfvamC
         ndzMiYhmPPrikvgQJVELGdkDZZablWR22NAyJGgNjl56BFxccqA7//2xzZNjDqG21k1F
         9xJw==
X-Gm-Message-State: APjAAAXCm4YaUYr7WDtoB92jSQzU4wxowCZXXSczV8Ovg0yLF0nYik+T
        f/eXxxB5xx+LnBfDAMhOR/U/rA==
X-Google-Smtp-Source: APXvYqzqWn+cSzhhbOaL+KLpktH+wZoMdtW0303kacHPjvZu9zDuJzAlbmaNkxEkFDjQAPxPnecjFQ==
X-Received: by 2002:a6b:e412:: with SMTP id u18mr47018533iog.132.1558426288439;
        Tue, 21 May 2019 01:11:28 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id b18sm1001759itd.40.2019.05.21.01.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 01:11:27 -0700 (PDT)
Date:   Tue, 21 May 2019 01:11:27 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Wesley Terpstra <wesley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] riscv: include generic support for MSI irqdomains
In-Reply-To: <20190521063551.GA5959@infradead.org>
Message-ID: <alpine.DEB.2.21.9999.1905210110220.24268@viisi.sifive.com>
References: <20190520182528.10627-1-paul.walmsley@sifive.com> <20190521063551.GA5959@infradead.org>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2019, Christoph Hellwig wrote:

> On Mon, May 20, 2019 at 11:25:28AM -0700, Paul Walmsley wrote:
> > Some RISC-V systems include PCIe host controllers that support PCIe
> > message-signaled interrupts.  For this to work on Linux, we need to
> > enable PCI_MSI_IRQ_DOMAIN and define struct msi_alloc_info.  Support
> > for the latter is enabled by including the architecture-generic msi.h
> > include.
> > 
> > Based on a patch from Wesley Terpstra <wesley@sifive.com>:
> > 
> > https://github.com/riscv/riscv-linux/commit/7d55f38fb79f459d2e88bcee7e147796400cafa8
> > 
> > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Cc: Wesley Terpstra <wesley@sifive.com>
> 
> Well, this is very much Wes' patch as-is.  It should probably be
> attributed to him and you should ask for his signoff.

Yeah.  There aren't many other ways to do it.

Wes, care to reply with your Signed-off-by: ? 


- Paul
