Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2196BCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B7F20663
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfJ2LWt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:22:49 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:49171 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfJ2LWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:22:49 -0400
X-Originating-IP: 91.217.168.176
Received: from xps13 (unknown [91.217.168.176])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 943B840008;
        Tue, 29 Oct 2019 11:22:46 +0000 (UTC)
Date:   Tue, 29 Oct 2019 12:22:47 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     joern@lazybastard.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH] mtd: devices: phram.c: Fix multiple kfree statement
 from phram_setup
Message-ID: <20191029122247.73e1c573@xps13>
In-Reply-To: <20191028181300.GA26250@saurav>
References: <20191028181300.GA26250@saurav>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saurav,

Saurav Girepunje <saurav.girepunje@gmail.com> wrote on Mon, 28 Oct 2019
23:43:01 +0530:

> Remove multiple kfree statement from phram_setup() in phram.c
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---

Here you should add a changelog with the changes you have done since
the last version.

Also when formatting the patch use -v <x> to add a version prefix
into the title, like [PATCH v<x>].

>  drivers/mtd/devices/phram.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
> index c467286ca007..38f95a1517ac 100644
> --- a/drivers/mtd/devices/phram.c
> +++ b/drivers/mtd/devices/phram.c
> @@ -243,22 +243,22 @@ static int phram_setup(const char *val)
>  
>  	ret = parse_num64(&start, token[1]);
>  	if (ret) {
> -		kfree(name);
>  		parse_err("illegal start address\n");
> +		goto free_nam;

s/nam/name

>  	}
>  
>  	ret = parse_num64(&len, token[2]);
>  	if (ret) {
> -		kfree(name);
>  		parse_err("illegal device length\n");
> +		goto free_nam;
>  	}
>  
>  	ret = register_device(name, start, len);
>  	if (!ret)
>  		pr_info("%s device: %#llx at %#llx\n", name, len, start);
> -	else
> -		kfree(name);
>  
> +free_nam:
> +	kfree(name);
>  	return ret;
>  }
>  

Thanks,
Miquèl
