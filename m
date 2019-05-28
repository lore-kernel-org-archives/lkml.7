Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557EAC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB5921848
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z/G3eU4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfE1SFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 14:05:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfE1SFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c4UYGdsKZq4NWqEx58QdiCg0rhfNu1KBY55h4BFMWyo=; b=Z/G3eU4sXgkwxGprjOpXcSzLe
        FTtNHYcgOv34akNz/txX2tXTNsgieQtVKHlKXqAXBFJ+9Gn1usByy9aX7Rll9b+ncwnyOWBLN7vEQ
        pNaYuP7UgOn/7apSRvDMPXvGQojZF7h4G8KLK8JhlUD4GHLoNOcc0LUfDGaSa02y8aSNOrfkmsZPs
        suIz4JJzLFZdAPZ2j29SFwVJNv4sOOn1Xt8jwjtZ4ON7TUoMkH7nZu4Tg9q4dmyBTAQvPP0w0WRpI
        gx2s7xb3rv4/cU7HG4E54EcIHlONdBWs7NugwaXHKqfWoigrHtM8HXzPwO2GJnXMbWq+Xv33MjFud
        48I6pFdcQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVgTF-0001MV-Sq; Tue, 28 May 2019 18:05:09 +0000
Subject: Re: linux-next: Tree for May 28 (platform/olpc/olpc-xo175-ec)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Lennert Buytenhek <buytenh@wantstofly.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
References: <20190528145838.23b73e25@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <68b2b71a-970b-8e0e-1ee3-e05a51c3bdf2@infradead.org>
Date:   Tue, 28 May 2019 11:05:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528145838.23b73e25@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/19 9:58 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190524:
> 

on x86, there are some issues with drivers/platform/olpc/olpc-xo175-ec.c:

a. when CONFIG_SPI is not set/enabled:

WARNING: unmet direct dependencies detected for SPI_SLAVE
  Depends on [n]: SPI [=n]
  Selected by [y]:
  - OLPC_XO175_EC [=y] && (ARCH_MMP || COMPILE_TEST [=y])

ld: drivers/platform/olpc/olpc-xo175-ec.o: in function `olpc_xo175_ec_remove':
olpc-xo175-ec.c:(.text+0x79): undefined reference to `spi_slave_abort'
ld: drivers/platform/olpc/olpc-xo175-ec.o: in function `olpc_xo175_ec_send_command':
olpc-xo175-ec.c:(.text+0x24d): undefined reference to `spi_async'
ld: drivers/platform/olpc/olpc-xo175-ec.o: in function `olpc_xo175_ec_cmd':
olpc-xo175-ec.c:(.text+0xb3c): undefined reference to `spi_slave_abort'
ld: drivers/platform/olpc/olpc-xo175-ec.o: in function `olpc_xo175_ec_spi_driver_init':
olpc-xo175-ec.c:(.init.text+0xa): undefined reference to `__spi_register_driver'

b. when CONFIG_INPUT is not set/enabled:

ERROR: "input_register_device" [drivers/platform/olpc/olpc-xo175-ec.ko] undefined!
ERROR: "input_set_capability" [drivers/platform/olpc/olpc-xo175-ec.ko] undefined!
ERROR: "devm_input_allocate_device" [drivers/platform/olpc/olpc-xo175-ec.ko] undefined!
ERROR: "input_event" [drivers/platform/olpc/olpc-xo175-ec.ko] undefined!

c. when some power mgt. Kconfig symbol is not set/enabled:

ERROR: "power_supply_put" [drivers/platform/olpc/olpc-xo175-ec.ko] undefined!
ERROR: "power_supply_changed" [drivers/platform/olpc/olpc-xo175-ec.ko] undefined!
ERROR: "power_supply_get_by_name" [drivers/platform/olpc/olpc-xo175-ec.ko] undefined!

d. drivers/platform/olpc/Kconfig needs to use "menuconfig" like all of the other
   Kconfig files in drivers/platform/ so that its menu is listed in the correct
   place in *config interfaces.


:(

-- 
~Randy
