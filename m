Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7581CC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4397E2075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YyLoqA+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfECTFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 15:05:13 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35283 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfECTFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 15:05:12 -0400
Received: by mail-it1-f195.google.com with SMTP id l140so10696246itb.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 12:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=WUEvVuMZ7YPl2dVmcnur9vXgWXYbDp4Kv2NYf/KfC/E=;
        b=YyLoqA+MOSgu5Z/mdOZYresCbnsrP9MOECqAR4bgemiqd1NPH4z1kTNshqMr1wGxrO
         1ulkumKpTQ6uWLtA2Ene+eq+HrTs1KZoMqs9xg+p39iicmy0zTCL7uVABR+WOuDZA063
         +oNPgr10wY9fURWnsMIn4Glzq/w4seTiQt6nzHUkagCRCpv7txThNbb5poKXXUtiaq0C
         amJC+5CNfkSN3LxFTXn27zjZN09O67v/k/iPmRYOidALpODycYOWZxGJ1kWkYY3q8zeE
         jHByq6IVQuw2xmMN/9K1zm6po5Ybx+hPTG4ELBhJgSBqEWzHWP+zmvqJygso2YzaXz1P
         hhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=WUEvVuMZ7YPl2dVmcnur9vXgWXYbDp4Kv2NYf/KfC/E=;
        b=fbq3Fj35ZPg3+LCrg8HFT7zuOkPPklcBOhhdB8Lj8qPvlQE3lqwd9LRrbIuWhQJccK
         AX/bXg/71/4tLipNGGI8RXuXzLbIC29Te2EEWRwSOWTX+qhPcS1uoyCvkkp8D+TjBho8
         sn+50tJ18bUlfU3hJ37wx2m3M67G0JSMgVUYwUcze7/2XcHYLn6WChiJQKL0cJ0amt+W
         u9o8jreoJti/fmVFBYKCCVrvsCrJp577JKZmrf1aM+bJ2hP0qdmzmQwDcRO5WXOELQB8
         EkPT9+YgoTxrQRvBIU2NDZiNYRFLS5xR7/XWmJPabe49YoAf2p70k8Ykl5GrDgGZu9sh
         5iZQ==
X-Gm-Message-State: APjAAAVJ9dRsrahRimg2QQYevAl9fXdyIGcZXjLjbUCo6eo6vpFdoop/
        TbJtu1zVvu1dZL7Gs6MasSQqAg==
X-Google-Smtp-Source: APXvYqzFS3nViSd8Ml55qWBQUACdB1pGNmsO/5+y7g1p6Gt2X232FHXVSyZ7sg92TLGrQz/n1IlHPQ==
X-Received: by 2002:a02:1146:: with SMTP id 67mr8522400jaf.10.1556910311443;
        Fri, 03 May 2019 12:05:11 -0700 (PDT)
Received: from localhost (74-95-18-198-Albuquerque.hfc.comcastbusiness.net. [74.95.18.198])
        by smtp.gmail.com with ESMTPSA id d193sm1154451iog.34.2019.05.03.12.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 12:05:10 -0700 (PDT)
Date:   Fri, 3 May 2019 12:05:09 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Kevin Hilman <khilman@baylibre.com>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atish.patra@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 0/2] tty: serial: add DT bindings and serial driver
 for the SiFive FU540 UART
In-Reply-To: <7hsgtwlm5t.fsf@baylibre.com>
Message-ID: <alpine.DEB.2.21.9999.1905031141530.4777@viisi.sifive.com>
References: <20190413020111.23400-1-paul.walmsley@sifive.com> <7hmukmew5j.fsf@baylibre.com> <883f3d5f-9b04-1435-30d3-2b48ab7eb76d@wdc.com> <7h5zr9dcsi.fsf@baylibre.com> <f2bb876c-2b44-663b-ea06-d849f721fb6c@wdc.com> <7htvetbupi.fsf@baylibre.com>
 <alpine.DEB.2.21.9999.1904191407310.5118@viisi.sifive.com> <7hsgtwlm5t.fsf@baylibre.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 May 2019, Kevin Hilman wrote:

> Paul Walmsley <paul.walmsley@sifive.com> writes:
> 
> > I'd recommend testing the DT patches with BBL and the open-source FSBL.  
> > That's the traditional way of booting RISC-V Linux systems.
> 
> OK, but as you know, not the tradiaional way of booting most other linux
> systems.  ;)
> 
> I'm working on getting RISC-V supported in kernelCI in a fully-automated
> way, and I don't currently have the time to add add support for BBL+FSBL
> to kernelCI automation tooling, so having u-boot support is the best way
> to get support in kernelCI, IMO.

That's great.  Please keep hacking away on RISC-V support for kernelCI.  
My point is just that the U-boot and OpenSBI software stack you're working 
with is not going to be useful for automatic tests of some kernel patches 
yet.  That stack is still very new, and was written around a non-upstream 
set of DT data.  We are in the process of posting and merging patches to 
fix that, but it's going to take a few releases of both the kernel and 
those other boot stack components until things are sorted out in a more 
durable way.


- Paul
