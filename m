Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BDDC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7800208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="U4aVJDu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392538AbfIFWgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 18:36:13 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42300 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729719AbfIFWgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 18:36:12 -0400
Received: by mail-io1-f66.google.com with SMTP id n197so16345485iod.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 15:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=/OtDkC3pdZM2krctzGQ+0mwUr2A4Fs4btQ+iI6by6RE=;
        b=U4aVJDu5VXkgoIzNl4rkJ0nf2rR1BtS2JRC7srMfDmAux89pa3jMXCPQ+73gGP4pQo
         Fb6D2ltlQysy5TqKEABHdV+ayc4GTots+ylmlZ8aSR88vtlI4wIP+51mF7gDrjl1I3vb
         4O5WhDwC76LXCOkjNL+0FQRq7q8YIQVRKzBdI/ORwFTDo5PgD3CfM2FFCmGCjBE6Iz3W
         hZFSoXNEQMqtrToRHblAMK5u0Rd++k65C3zVKL8whgA0qN9mPt6L6fWeyb4MQ1SX/2zw
         w3/cEkDJ7QJAXrSsjya9DcI/Lc/UotopuyJ4alzf+dl0dV8OxKidh9YYMgKS6zkIR/cS
         IRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=/OtDkC3pdZM2krctzGQ+0mwUr2A4Fs4btQ+iI6by6RE=;
        b=ZaSlICDImysiHlHO74++AvDPl5UcS7nm8z2GLYDaJranTTvifILG3rO8OxwMVAyYTX
         N7wqH181pD5dpLbxXeGjiGb/9yZSa/HWGvy3aFdvO0FRXr/gCbSXEnALESqEMBhtUAHw
         8woiPzlCSWPSJFAUHqig8EBwBJK4fqO8uo+3suyJOeHkkm0Ow+UVHUt8o0OCkCNP/hA4
         d4tVocbOwUICMpkiCE+KMreBpn92J0CjGU5qLjSUnzfuYYMmCwBBe63nGjsDIOZSgA1X
         //qxLRZWU29aBzM7HCawgSwZ11aVr4XRYsB1eKwHfUU/r5adHtOWMk0IbBM4eH/l1pTn
         tZhQ==
X-Gm-Message-State: APjAAAU0HE0fX6It2N3Z9o1i1d+YCSthcMK1/GlGdzE9egRbFqnt/Zhb
        3f6b+DXoeU+im4zczJun18P91w==
X-Google-Smtp-Source: APXvYqz4MaleudQolCZG/PjbQC417j+Ug7KgFVxamxGmKjA3pdAN9qsIdwzmJJTiIGhfUx+hi+xiBA==
X-Received: by 2002:a02:c546:: with SMTP id g6mr12808435jaj.59.1567809372001;
        Fri, 06 Sep 2019 15:36:12 -0700 (PDT)
Received: from localhost (75-161-11-128.albq.qwest.net. [75.161.11.128])
        by smtp.gmail.com with ESMTPSA id d20sm6201253ioh.2.2019.09.06.15.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 15:36:11 -0700 (PDT)
Date:   Fri, 6 Sep 2019 15:36:09 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     palmer@sifive.com, bp@alien8.de, mchehab@kernel.org,
        linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: move sifive_l2_cache.c to drivers/soc
In-Reply-To: <alpine.DEB.2.21.9999.1909061525040.6292@viisi.sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1909061533260.6292@viisi.sifive.com>
References: <20190818082935.14869-1-hch@lst.de> <alpine.DEB.2.21.9999.1909061525040.6292@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One other comment on this patch:

On Fri, 6 Sep 2019, Paul Walmsley wrote:

> On Sun, 18 Aug 2019, Christoph Hellwig wrote:
>
> > diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> > index 200c04ce5b0e..9241b3e7a050 100644
> > --- a/drivers/edac/Kconfig
> > +++ b/drivers/edac/Kconfig
> > @@ -462,7 +462,7 @@ config EDAC_ALTERA_SDMMC
> >  
> >  config EDAC_SIFIVE
> >  	bool "Sifive platform EDAC driver"
> > -	depends on EDAC=y && RISCV
> > +	depends on EDAC=y && SIFIVE_L2

Since the guidance from the EDAC maintainers is that this driver is to be 
a platform driver -- which would, for example, also include EDAC support for 
other IP blocks (e.g., DRAM controllers) on SiFive SoCs -- this should 
depend on SOC_SIFIVE, not SIFIVE_L2.


- Paul
