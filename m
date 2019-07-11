Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BF7C74A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4651221019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfGKI0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 04:26:50 -0400
Received: from smtprelay0091.hostedemail.com ([216.40.44.91]:40729 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725963AbfGKI0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 04:26:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 9D6DB100E86C8;
        Thu, 11 Jul 2019 08:26:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: suit25_5871eab84d660
X-Filterd-Recvd-Size: 1586
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 11 Jul 2019 08:26:47 +0000 (UTC)
Message-ID: <acf9141ed9e4c33585a9784d14a6b95ec58558c8.camel@perches.com>
Subject: Re: [PATCH v2] gnss: core: added logging statement when kfifo_alloc
 fails
From:   Joe Perches <joe@perches.com>
To:     Keyur Patel <iamkeyur96@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
Date:   Thu, 11 Jul 2019 01:26:46 -0700
In-Reply-To: <20190709235957.2481-1-iamkeyur96@gmail.com>
References: <61c2ba4e229a6971e90627433bedae2dd28ea6a1.camel@perches.com>
         <20190709235957.2481-1-iamkeyur96@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-09 at 19:59 -0400, Keyur Patel wrote:
> Added missing logging statement when kfifo_alloc fails, to improve
> debugging.
[]
> Changes in v2:
> - fixed braces
[]
> diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
[]
> @@ -255,8 +255,10 @@ struct gnss_device *gnss_allocate_device(struct device *parent)
>  	init_waitqueue_head(&gdev->read_queue);
>  
>  	ret = kfifo_alloc(&gdev->read_fifo, GNSS_READ_FIFO_SIZE, GFP_KERNEL);
> -	if (ret)
> +	if (ret) {
> +		pr_err("kfifo_alloc failed\n");
>  		goto err_put_device;
> +	}

This isn't really necessary as kfifo_alloc just
calls kmalloc_array and without the __GFP_NOWARN
flag, already does a dump_stack()


