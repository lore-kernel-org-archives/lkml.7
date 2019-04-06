Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284C1C282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD2C21855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554530843;
	bh=KsrQE2MTBp3bk98l3KOK/flwpZegAQ2o0wmrUkaT1qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FCtd2oBnXH0QADwZIAHahDiKf3uZ9dcuiBWZo7MHhdqNWxLZ4O9/GEUs2XL64kFXp
	 +6kNax2+hoWjin/Gsw89Ubjwl5D3p4ROyDBguVn0IFcqbHrqM+HQfnw21+vBP7X0w1
	 QDfgVicm/0Myl9kB7VYUHYg28cEja8m/4w21Q88c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfDFGHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 02:07:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42789 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfDFGHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 02:07:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so4190851pgh.9;
        Fri, 05 Apr 2019 23:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=CrDN3pSofWfhjPsMJgky5ErEeSo4CNJyaPHKeeJSTRE=;
        b=L6lyTRkthYY743tKivdLDTH2ckQc1NJTWFNJ5htLeYt4ry5l5eTSjE1nY5cmqncVi3
         wc2GdnSd/eujdIdHgKbNCPqiGHV212ytIneFA3ipexxoAagtJ5kzFZeM1TXLvWubTutV
         nYAWAiBplJ3NN0kOq5ZqNBOxcGgMHRO1DsuxoU63JgSenqrKg6UrgvzmTFv9Hix50wX2
         Qo7GyPNigTt3NUDshse+moLETdeu6PCP0eu+FmiP0ZiiTcV/qdEXP1VfztuLOzEm+RyJ
         tv+E00GuUTLfU8YwNbjxx8nXOwMpHRFLawezBeuNoeFHDhr74p8uk+XeduFLt/49nvis
         Ue1g==
X-Gm-Message-State: APjAAAXaeqV27JMB14AEWFdf6lp04+RZJWxkyiuFY8JeiPVIaUt+ipME
        8Mon5xqN9oVE9JSVxlCYgQ==
X-Google-Smtp-Source: APXvYqy4GAsrJVsherGMBDLhOFGl5ut5+YkFmH6wbcv+3GV2SAxFqxzf+b7mgrWEcTE/wH7jQ3L5NA==
X-Received: by 2002:a63:9dc4:: with SMTP id i187mr15185563pgd.259.1554530839480;
        Fri, 05 Apr 2019 23:07:19 -0700 (PDT)
Received: from localhost ([210.160.217.71])
        by smtp.gmail.com with ESMTPSA id l88sm41573983pfb.104.2019.04.05.23.07.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 23:07:18 -0700 (PDT)
Message-ID: <5ca84216.1c69fb81.3205c.592c@mx.google.com>
Date:   Sat, 06 Apr 2019 01:07:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "pantelis.antoniou@konsulko.com" <pantelis.antoniou@konsulko.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
Subject: Re: Using device tree overlays in Linux
References: <71fb0ff289e84c55bd92ecd96bc9aa76@svr-chch-ex1.atlnz.lc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71fb0ff289e84c55bd92ecd96bc9aa76@svr-chch-ex1.atlnz.lc>
X-Mutt-References: <71fb0ff289e84c55bd92ecd96bc9aa76@svr-chch-ex1.atlnz.lc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 01:50:20AM +0000, Chris Packham wrote:
> Hi,
> 
> I'm implementing support for some modular Linux based systems using 
> device tree overlays. The code is working but it seems a little more 
> fiddly that than it should be so I'm wondering if I'm doing it right.
> 
> An example of what I'm doing is
> 
> 
> arch/arm/boot/dts/Makefile:
> DTC_FLAGS_myboard += -@
> 
> drivers/foo/Makefile:
> obj-y += myplugin.dtb.o
> obj-y += mydriver.o
> 
> drivers/foo/myplugin.dts:
> /dts-v1/;
> /plugin/;
> /{
> 	fragment@0 {
> 		target = <&i2c0>;
> 		__overlay__ {
> 			gpio@74 {
> 				compatible = "nxp,pca9539";
> 				reg = <0x74>
> 			};
> 		};
> 	};
> };
> 
> drivers/foo/mydriver.c:
> extern uint8_t __dtb_myplugin_begin[];
> extern uint8_t __dtb_myplugin_end[];
> 
> int mydriver_probe(struct platform_device *pdev)
> {
> 	u32 size = __dtb_myplugin_end - __dtb_myplugin_begin;
> 	int overlay_id;
> 	int ret;
> 	
> 	ret = of_overlay_fdt_apply(__dtb_myplugin_begin,
> 				   size, &overlay_id);
> 	return ret;
> }
> 
> 
> The first issue is that I need to add -@ to the DTC_FLAGS for my board 
> dtb. I kind of understand that I only need -@ if my overlay targets 
> something symbolic so I might not need it but I was surprised that there 
> wasn't a Kconfig option that makes this happen automatically.

Whether overlays make sense or are needed are per board.

You could add a kconfig entry that drivers which depend on overlays 
select, but turning on '-@' has to be per board (or SoC family if the 
SoC maintainer is okay with that).

> externing things in C files makes checkpatch.pl complain. I see the 
> of/unittests.c and rcar_du_of.c hide this with a macro. I was again 
> surprised that there wasn't a common macro to declare these.

Feel free to propose something. There just aren't that many cases that 
anyone has cared what checkpatch says.

Rob

