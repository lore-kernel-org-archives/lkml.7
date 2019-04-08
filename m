Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79943C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B831214D8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfDHMfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:35:18 -0400
Received: from smtprelay0250.hostedemail.com ([216.40.44.250]:37786 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726510AbfDHMfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:35:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 52D988368EFA;
        Mon,  8 Apr 2019 12:35:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cable22_85062fffc6945
X-Filterd-Recvd-Size: 2330
Received: from XPS-9350 (unknown [172.56.7.132])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Mon,  8 Apr 2019 12:35:13 +0000 (UTC)
Message-ID: <55d0cb7ecb968e4a2cc82fda5950b237ffbb435c.camel@perches.com>
Subject: Re: [PATCH] staging: iio: cdc: ad7746: Replace bitshift by BIT
From:   Joe Perches <joe@perches.com>
To:     Lucas Oshiro <lucasseikioshiro@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, stefan.popa@analog.com,
        jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Date:   Mon, 08 Apr 2019 05:34:44 -0700
In-Reply-To: <20190403204502.28917-1-lucasseikioshiro@gmail.com>
References: <20190403204502.28917-1-lucasseikioshiro@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-03 at 17:45 -0300, Lucas Oshiro wrote:
> Replace bitshifts on lines 54, 56 and 78 of ad7746.c.

checkpatch is not something that should be followed
blindly.  Look at the shifted blocks and determine if
you think it was better before your proposed change.

> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
[]
> @@ -51,9 +51,9 @@
>  #define AD7746_CAPSETUP_CACHOP		BIT(0)
>  
>  /* Voltage/Temperature Setup Register Bit Designations (AD7746_REG_VT_SETUP) */
> -#define AD7746_VTSETUP_VTEN		(1 << 7)
> +#define AD7746_VTSETUP_VTEN		BIT(7)
>  #define AD7746_VTSETUP_VTMD_INT_TEMP	(0 << 5)
> -#define AD7746_VTSETUP_VTMD_EXT_TEMP	(1 << 5)
> +#define AD7746_VTSETUP_VTMD_EXT_TEMP	BIT(5)
>  #define AD7746_VTSETUP_VTMD_VDD_MON	(2 << 5)
>  #define AD7746_VTSETUP_VTMD_EXT_VIN	(3 << 5)
>  #define AD7746_VTSETUP_EXTREF		BIT(4)
> @@ -75,7 +75,7 @@
>  #define AD7746_CONF_VTFS_MASK		GENMASK(7, 6)
>  #define AD7746_CONF_CAPFS_MASK		GENMASK(5, 3)
>  #define AD7746_CONF_MODE_IDLE		(0 << 0)
> -#define AD7746_CONF_MODE_CONT_CONV	(1 << 0)
> +#define AD7746_CONF_MODE_CONT_CONV	BIT(0)
>  #define AD7746_CONF_MODE_SINGLE_CONV	(2 << 0)
>  #define AD7746_CONF_MODE_PWRDN		(3 << 0)
>  #define AD7746_CONF_MODE_OFFS_CAL	(5 << 0)

Now the code looks unbalanced.

