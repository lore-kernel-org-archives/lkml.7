Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D73C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44E120818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfDJILR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:11:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53150 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfDJILQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:11:16 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A92282817AB;
        Wed, 10 Apr 2019 09:11:13 +0100 (BST)
Date:   Wed, 10 Apr 2019 10:11:10 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     masonccyang@mxic.com.tw
Cc:     "Marek Vasut" <marek.vasut@gmail.com>, bbrezillon@kernel.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Simon Horman" <horms@verge.net.au>, juliensu@mxic.com.tw,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>,
        zhengxunli@mxic.com.tw
Subject: Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI
 controller driver
Message-ID: <20190410101110.2224eb91@collabora.com>
In-Reply-To: <OF75EDBF48.5C308F1B-ON482583D8.0027A537-482583D8.002C0A64@mxic.com.tw>
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
        <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
        <a2dc294f-f2a1-2469-1f44-db67f9b8cc10@cogentembedded.com>
        <OFC7F0028A.CFF6BD04-ON482583D8.00084FA1-482583D8.0008985F@mxic.com.tw>
        <2095d059-8276-a01a-7c3a-da4647f7b7df@gmail.com>
        <OF75EDBF48.5C308F1B-ON482583D8.0027A537-482583D8.002C0A64@mxic.com.tw>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019 16:01:02 +0800
masonccyang@mxic.com.tw wrote:

> Hi,
>  
> > Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller   
> driver
> > 
> > On 4/10/19 3:33 AM, masonccyang@mxic.com.tw wrote:  
> > > Hi Sergei,
> > >   
> > >> > +static ssize_t rpc_spi_mem_dirmap_write(struct spi_mem_dirmap_desc  
> > > *desc,  
> > >> > +               u64 offs, size_t len, const void *buf)
> > >> > +{
> > >> > +   struct rpc_spi *rpc =
> > >> > +         spi_controller_get_devdata(desc->mem->spi->controller);
> > >> > +   int ret;
> > >> > +
> > >> > +   if (offs + desc->info.offset + len > U32_MAX)
> > >> > +      return -EINVAL;
> > >> > +
> > >> > +   if (len > RPC_WBUF_SIZE)
> > >> > +      len = RPC_WBUF_SIZE;
> > >> > +
> > >> > +   ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
> > >> > +   if (ret)
> > >> > +      return ret;
> > >> > +
> > >> > +   rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
> > >> > +                &desc->info.op_tmpl, &offs, &len);
> > >> > +
> > >> > +   regmap_update_bits(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD,  
> > > RPC_CMNCR_MD);  
> > >> > +
> > >> > +   regmap_write(rpc->regmap, RPC_SMDRENR, 0);
> > >> > +
> > >> > +   regmap_update_bits(rpc->regmap, RPC_PHYCNT,   
> RPC_PHYCNT_STRTIM(7) |
> > >> > +            RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF,
> > >> > +            RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF);
> > >> > +
> > >> > +   memcpy_toio(rpc->wbuf, buf, len);  
> > >>
> > >>    Wait, doesn't the manual say that the whole 256-byte buffer should   
> be
> > >> filled?   
> 
> it could be less than 256 bytes, i.e., 128 bytes to rpc->wbuf !
> 
>  I think that short chunks have to be written w/o WBUF (done,
> > > in fact,  
> > >> by the HF driver).
> > >>  
> > > 
> > > From spi-nor.c layer always transfer 256 bytes data with page program
> > > command.  
> > 
> > Does that apply even for flashes with not-256-byte pages ?
> >   
> 
> I think it needs to patch in case of nor->page_size = 512 bytes.

I think the main problem here is that you assume the memory is a
NOR :-). Just do what the spi-mem user asks: if he asks you to write
X bytes, then write no more than X bytes. Use whatever trick you have
to make sure this is always true, and if this requires using a slow
path for non-aligned accesses, then do it, because it's better to have
a slow+working memory than a fast+non-working one :P.
