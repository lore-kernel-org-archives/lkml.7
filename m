Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21631CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF18C20700
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="zYh25urd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732749AbfJVRaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 13:30:04 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32798 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbfJVRaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 13:30:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id a22so18082784ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 10:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=HmmPBl6eQCJQQpK05KW2nNJH7nyGoslANOpWRy61vOw=;
        b=zYh25urd8gs/0FeIw9pUR75l7cU4AlLmzOJvB6ZLBSpfGISKg9PuCs9ZV2wD0jAI7V
         cKcsmwjQWpX/u/wIY3StphOwuuFtS/TuWDnRTA42d6kACzgwf0gyqwpERegSyMe2dIMn
         LIUDxpLB9H8xTqkLR+RhcjAyMsrw+rc/EaSQldj/orTbyI734aVIWjj7GZd6MtmU5Znh
         i2b9LYEIiZtRB73o1wmzfB2xBuzW+gKyJfEqcev98AZ5SVm2QXuz2VhM07AqGahfr4Iu
         VaDKlG7ehiyVq5urU0fsWwcwl2WX0avYGr7HBnb3BjEoJGegVQ5LdaqXKmskejbCYh3e
         ItfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=HmmPBl6eQCJQQpK05KW2nNJH7nyGoslANOpWRy61vOw=;
        b=MQU23qx0CBT8TS4J3bizzB8zHqoK1aCaF/Ci7Eyf8YA7taeVxP+1BJ1kxUWcgjD9aX
         nQNTPgjJGY+rucF6QIE5v5hA4KDt+Tmhtpvy8EbaTmZyLacNTiKNo4hmg54HrPzTKc6a
         nmHUE93ZyI258w6Rl4v7dnrOL2nX3BC4CKyHf45scKYLVbjYkUux2KCLgCmOYo5HUGyF
         7L7/eWYf7t8UsTnJA6EtQFoqpJLmX0pOt+xn+sD6Zb2Dm8XsSTVfaneQEbEHkkMUXgPV
         CNkTZ8UqAYirlE8XnwfB9Bek62F24Xf43VjjjhsOACgwOgp7Pvt2xRRkRtpO5PTQHU2j
         JtiA==
X-Gm-Message-State: APjAAAWHKOnintAE0hnk18DveELTrVWVp9vgeNZxxc8lahFcg4+B+0Pf
        21/bimQaU/CsYiHUsppyup/jQ1vP1Rc=
X-Google-Smtp-Source: APXvYqxpzJg00yRe3OjBd6BnC1zysssaNWZcfUFrdIXzW/KSn/Vdod1X21VKHzDtvBdgHy9erg6Qcw==
X-Received: by 2002:a2e:416:: with SMTP id 22mr3073575lje.55.1571765400271;
        Tue, 22 Oct 2019 10:30:00 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id h21sm1288560ljl.20.2019.10.22.10.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 10:30:00 -0700 (PDT)
Date:   Tue, 22 Oct 2019 10:29:52 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        davem@davemloft.net, netdev@vger.kernel.org,
        anirudha.sarangi@xilinx.com, john.linn@xilinx.com,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net: axienet: In kconfig add ARM64 as
 supported platform
Message-ID: <20191022102952.09211971@cakuba.netronome.com>
In-Reply-To: <cbdd6608-804a-086c-1892-1903ec4a7d80@xilinx.com>
References: <1571653110-20505-1-git-send-email-radhey.shyam.pandey@xilinx.com>
        <cbdd6608-804a-086c-1892-1903ec4a7d80@xilinx.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 16:15:45 +0200, Michal Simek wrote:
> On 21. 10. 19 12:18, Radhey Shyam Pandey wrote:
> > xilinx axi_emac driver is supported on ZynqMP UltraScale platform.
> > So enable ARCH64 in kconfig. It also removes redundant ARCH_ZYNQ
> > dependency. Basic sanity testing is done on zu+ mpsoc zcu102
> > evaluation board.
> > 
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > ---
> > Changes for v2:
> > Remove redundant ARCH_ZYNQ dependency.
> > Modified commit description.
> > ---
> >  drivers/net/ethernet/xilinx/Kconfig | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
> > index 8d994ce..da11876 100644
> > --- a/drivers/net/ethernet/xilinx/Kconfig
> > +++ b/drivers/net/ethernet/xilinx/Kconfig
> > @@ -6,7 +6,7 @@
> >  config NET_VENDOR_XILINX
> >  	bool "Xilinx devices"
> >  	default y
> > -	depends on PPC || PPC32 || MICROBLAZE || ARCH_ZYNQ || MIPS || X86 || ARM || COMPILE_TEST
> > +	depends on PPC || PPC32 || MICROBLAZE || MIPS || X86 || ARM || ARM64 || COMPILE_TEST
> >  	---help---
> >  	  If you have a network (Ethernet) card belonging to this class, say Y.
> >  
> > @@ -26,11 +26,11 @@ config XILINX_EMACLITE
> >  
> >  config XILINX_AXI_EMAC
> >  	tristate "Xilinx 10/100/1000 AXI Ethernet support"
> > -	depends on MICROBLAZE || X86 || ARM || COMPILE_TEST
> > +	depends on MICROBLAZE || X86 || ARM || ARM64 || COMPILE_TEST
> >  	select PHYLINK
> >  	---help---
> >  	  This driver supports the 10/100/1000 Ethernet from Xilinx for the
> > -	  AXI bus interface used in Xilinx Virtex FPGAs.
> > +	  AXI bus interface used in Xilinx Virtex FPGAs and Soc's.
> >  
> >  config XILINX_LL_TEMAC
> >  	tristate "Xilinx LL TEMAC (LocalLink Tri-mode Ethernet MAC) driver"
> >   
> 
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> 
> But I can image that others could prefer to remove all dependencies.

Yes, we'd much rather see this litany of architectures removed.
Is there any reason it's there in the first place?

Most drivers are tested on just a few architectures, but as long
as correct APIs are used they are assumed to work across the board.
Otherwise 75% of our drivers would be x86 only. Don't be shy.
