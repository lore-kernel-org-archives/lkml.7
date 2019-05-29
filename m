Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1B2C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 06:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174B121019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 06:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfE2G2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 02:28:00 -0400
Received: from shell.v3.sk ([90.176.6.54]:40965 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfE2G2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 02:28:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id BC1881048EC;
        Wed, 29 May 2019 08:27:56 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qKbt9HKp92yJ; Wed, 29 May 2019 08:27:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 332101048ED;
        Wed, 29 May 2019 08:27:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tXFwvtFdL22f; Wed, 29 May 2019 08:27:47 +0200 (CEST)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 73F761048EC;
        Wed, 29 May 2019 08:27:47 +0200 (CEST)
Message-ID: <d8518bc65fd909723904637b19332760768f73e7.camel@v3.sk>
Subject: Re: linux-next: Tree for May 28 (platform/olpc/olpc-xo175-ec)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Lennert Buytenhek <buytenh@wantstofly.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Date:   Wed, 29 May 2019 08:27:45 +0200
In-Reply-To: <68b2b71a-970b-8e0e-1ee3-e05a51c3bdf2@infradead.org>
References: <20190528145838.23b73e25@canb.auug.org.au>
         <68b2b71a-970b-8e0e-1ee3-e05a51c3bdf2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-28 at 11:05 -0700, Randy Dunlap wrote:
> On 5/27/19 9:58 PM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20190524:
> > 
> 
> on x86, there are some issues with drivers/platform/olpc/olpc-xo175-ec.c:
> 
> a. when CONFIG_SPI is not set/enabled:
> 
> WARNING: unmet direct dependencies detected for SPI_SLAVE
>   Depends on [n]: SPI [=n]
>   Selected by [y]:
>   - OLPC_XO175_EC [=y] && (ARCH_MMP || COMPILE_TEST [=y])
> 
> ld: drivers/platform/olpc/olpc-xo175-ec.o: in function `olpc_xo175_ec_remove':
> olpc-xo175-ec.c:(.text+0x79): undefined reference to `spi_slave_abort'
> ld: drivers/platform/olpc/olpc-xo175-ec.o: in function `olpc_xo175_ec_send_command':
> olpc-xo175-ec.c:(.text+0x24d): undefined reference to `spi_async'
> ld: drivers/platform/olpc/olpc-xo175-ec.o: in function `olpc_xo175_ec_cmd':
> olpc-xo175-ec.c:(.text+0xb3c): undefined reference to `spi_slave_abort'
> ld: drivers/platform/olpc/olpc-xo175-ec.o: in function `olpc_xo175_ec_spi_driver_init':
> olpc-xo175-ec.c:(.init.text+0xa): undefined reference to `__spi_register_driver'
> 
> b. when CONFIG_INPUT is not set/enabled:
> 
> ERROR: "input_register_device" [drivers/platform/olpc/olpc-xo175-ec.ko] undefined!
> ERROR: "input_set_capability" [drivers/platform/olpc/olpc-xo175-ec.ko] undefined!
> ERROR: "devm_input_allocate_device" [drivers/platform/olpc/olpc-xo175-ec.ko] undefined!
> ERROR: "input_event" [drivers/platform/olpc/olpc-xo175-ec.ko] undefined!
> 
> c. when some power mgt. Kconfig symbol is not set/enabled:
> 
> ERROR: "power_supply_put" [drivers/platform/olpc/olpc-xo175-ec.ko] undefined!
> ERROR: "power_supply_changed" [drivers/platform/olpc/olpc-xo175-ec.ko] undefined!
> ERROR: "power_supply_get_by_name" [drivers/platform/olpc/olpc-xo175-ec.ko] undefined!
> 
> d. drivers/platform/olpc/Kconfig needs to use "menuconfig" like all of the other
>    Kconfig files in drivers/platform/ so that its menu is listed in the correct
>    place in *config interfaces.

Hi

Thanks for the heads up.

I think YueHaibing <yuehaibing@huawei.com> sent in patches for a. and
b. -- I'll follow up with the fixes for the rest.

> :(

:(

Lubo

