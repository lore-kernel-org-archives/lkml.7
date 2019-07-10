Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8E4C73C66
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 03:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7955520656
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 03:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfGJDkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 23:40:52 -0400
Received: from smtprelay0042.hostedemail.com ([216.40.44.42]:48678 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725880AbfGJDkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 23:40:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id C7D05837F24D;
        Wed, 10 Jul 2019 03:40:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bears20_749b75478f19
X-Filterd-Recvd-Size: 1410
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jul 2019 03:40:49 +0000 (UTC)
Message-ID: <61c2ba4e229a6971e90627433bedae2dd28ea6a1.camel@perches.com>
Subject: Re: [PATCH] gnss: core: added logging statement when kfifo_alloc
 fails
From:   Joe Perches <joe@perches.com>
To:     Keyur Patel <iamkeyur96@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
Date:   Tue, 09 Jul 2019 20:40:48 -0700
In-Reply-To: <20190709231448.30799-1-iamkeyur96@gmail.com>
References: <20190709231448.30799-1-iamkeyur96@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-09 at 19:14 -0400, Keyur Patel wrote:
> Added missing logging statement when kfifo_alloc fails, to improve
> debugging.\

Nack

> diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
[]
> @@ -256,6 +256,7 @@ struct gnss_device *gnss_allocate_device(struct device *parent)
>  
>  	ret = kfifo_alloc(&gdev->read_fifo, GNSS_READ_FIFO_SIZE, GFP_KERNEL);
>  	if (ret)
> +		pr_err("kfifo_alloc failed\n");
>  		goto err_put_device;

c is not python.
This will not do what you might expect.
 
>  	gdev->write_buf = kzalloc(GNSS_WRITE_BUF_SIZE, GFP_KERNEL);

