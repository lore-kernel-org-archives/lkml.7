Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E00C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E990F20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfDHTBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:01:30 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:50623 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfDHTBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:01:30 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 44dKX7744Sz1rXtr;
        Mon,  8 Apr 2019 21:01:27 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 44dKX768Clz1qr64;
        Mon,  8 Apr 2019 21:01:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id ZPXLf5woQrhu; Mon,  8 Apr 2019 21:01:26 +0200 (CEST)
X-Auth-Info: +MLpf2AoXkRdfoTcWWaN0KzQhljWziyowuPyM6ImORQ=
Received: from crub (p508B6C31.dip0.t-ipconnect.de [80.139.108.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  8 Apr 2019 21:01:26 +0200 (CEST)
Date:   Mon, 8 Apr 2019 21:01:26 +0200
From:   Anatolij Gustschin <agust@denx.de>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, broonie@kernel.org, atull@kernel.org
Subject: Re: [PATCH v4 3/3] fpga: Add fpga manager driver for ARRI Altera
 FPP
Message-ID: <20190408210126.74920213@crub>
In-Reply-To: <20190408180151.GA5643@archbook>
References: <20190221202506.17744-1-agust@denx.de>
        <20190221202506.17744-4-agust@denx.de>
        <20190408180151.GA5643@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Moritz,

On Mon, 8 Apr 2019 11:05:49 -0700
Moritz Fischer mdf@kernel.org wrote:

>Hi Anatolij,
>
>looks mostly good, a couple of nits inline.

Thanks for review.

...
>> +++ b/drivers/fpga/ftdi-fifo-fpp.c
>> @@ -0,0 +1,594 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Altera FPGA firmware upload via FPP using FT232H Bitbang/FT245-FIFO.
>> + *
>> + * Copyright (C) 2017 - 2018 DENX Software Engineering  
>Maybe bump that to 2019 ;-)

I'll update it in next version.

...
>> +	gpiod_set_raw_value_cansleep(priv->nconfig, 1);
>> +	gpiod_set_raw_value_cansleep(priv->conf_done, 0);
>> +	msleep(50);  
>
>You could use a constant here for the 50 ...

Do you mean something like below?

  const unsigned int wait_50ms = 50;
  ...
  msleep(wait_50ms);

...
>and here ...
>> +	gpiod_set_value_cansleep(priv->nconfig, 1);
>> +	msleep(50);  
>and here ...
>> +	gpiod_set_value_cansleep(priv->nconfig, 0);
>> +
>> +	/* Wait for CONF_DONE to get low */  
>Does the retry number come from datasheet?

No, it is an empirical value.

...
>> +	if (!retries) {
>> +		dev_warn(dev, "CONF_DONE wait timeout\n");  
>
>warn or err?

err fits better here, I'll update to dev_err().

...
>> +	struct fpp_fpga_mgr_priv *priv = mgr->priv;
>> +	struct device *dev = &priv->pdev->dev;
>> +	int retries = MAX_RETRIES;
>> +	int ret;
>> +	u8 mask, status;  
>
>Can you swap the two lines, reverse xmas-tree please.

Will do in v5.

Thanks,
Anatolij
