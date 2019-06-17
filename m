Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4632EC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194872084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dtyfnzQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfFQKgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 06:36:48 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45955 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFQKgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 06:36:48 -0400
Received: by mail-ed1-f67.google.com with SMTP id a14so15409411edv.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 03:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=foRtQV0HznBQvrobiFOuEiKivCdw8jc2kSrqkF2ZKAQ=;
        b=dtyfnzQQJOBZ4MB/etiKp3JJacUjndPwKn9cCQc8XVqpVqvfPp7uQuOgXn4gzWMX8f
         JGpf3xUSw1UDP++0qbnCQrW9EZD8Ql465ZuNmk7eH9uazrFC/53wIv1bdrCaAcmwqzck
         OXG2afiaB87SkWlRho+v0VsJs3TumlDhuCIWVaMmVMB+/1Vdc9pVV/oe4w+SGEI3yImx
         gOVOQ6jn2SVLJIas9ISkq7YtpClizkjMjr/Ni+epk/Tjd1ZpmHkqYgBbSVSMgoPxtbBJ
         W69SwL2ChRgU4OHXYJXjo1FNfFX7NpOV9GjsXoEfV16Gd5X6qj5Y4nkA/2x5ZIltOoBm
         j3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=foRtQV0HznBQvrobiFOuEiKivCdw8jc2kSrqkF2ZKAQ=;
        b=kVVZ494+8Z2tH2xf6u0Ok4tAoPubFm88qUD2aIwN7tj0wn9vTW2aHVTdyX8cavjX9T
         XGRoyQ5sQTMawfnrG+2Vx+5G1wGxp0Q0gZt/oedHpApAAnnXM5gjT54i0awkwetnY1rT
         n2PnRk94qyydSCQmr1OMU+vgkNneS1k5Xzj/oiIsSGBcgia1lYwPLftpu76wXigDXRFR
         hEEUDnUsItOfCCYXMV2CPia9sDWlysTziylCJIjRDPzz18xbSb2RDQ1peajkOA2FpZ5V
         m3jhfRLiDc3nmMdU/SfEG0iDdv6pdffn45wd7tSOG6gVrZBZcK2jII5QYzDb0cgD5MYu
         H8Eg==
X-Gm-Message-State: APjAAAUqDuJersqryyysvLLQ72uUEuIPEsFu0d8uFFujqJAh6u3Jr3Rn
        vFuSG+Cz6LyNVXDCxWknoQApRAPGw6o=
X-Google-Smtp-Source: APXvYqxVKhD6zn5ewGdEh8iMLLEQmcpO+BQVHrPqxjSEi9jSt+Hx0pjFe3lvumU+o7wr3JxCSD62Vg==
X-Received: by 2002:a50:b7bc:: with SMTP id h57mr118085474ede.77.1560767806767;
        Mon, 17 Jun 2019 03:36:46 -0700 (PDT)
Received: from localhost ([81.92.102.43])
        by smtp.gmail.com with ESMTPSA id n7sm2093141ejl.58.2019.06.17.03.36.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 03:36:46 -0700 (PDT)
Date:   Mon, 17 Jun 2019 03:36:45 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@infradead.org>
cc:     Kevin Hilman <khilman@baylibre.com>,
        Loys Ollivier <lollivier@baylibre.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org, Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] RISC-V: defconfig: enable clocks, serial console
In-Reply-To: <20190609075544.GA32207@infradead.org>
Message-ID: <alpine.DEB.2.21.9999.1906170335140.19994@viisi.sifive.com>
References: <20190605175042.13719-1-khilman@baylibre.com> <alpine.DEB.2.21.9999.1906081848410.720@viisi.sifive.com> <20190609075544.GA32207@infradead.org>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jun 2019, Christoph Hellwig wrote:

> On Sat, Jun 08, 2019 at 06:49:09PM -0700, Paul Walmsley wrote:
> > On Wed, 5 Jun 2019, Kevin Hilman wrote:
> > 
> > > Enable PRCI clock driver and serial console by default, so the default
> > > upstream defconfig is bootable to a serial console.
> > > 
> > > Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> > 
> > Thanks, queued for v5.2-rc with Christoph's Reviewed-by:.
> 
> To repeat myself:  where do you apply it to?  And could we please just
> have a shared maintainer tree on infradead.org or kernel.org so that
> people don't have to chase multiple trees to base their patches on?

As you requested last week, the shared tree announcement was posted as a 
separate thread:

https://lore.kernel.org/linux-riscv/alpine.DEB.2.21.9999.1906170320300.19994@viisi.sifive.com/T/#u


- Paul
