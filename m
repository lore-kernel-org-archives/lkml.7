Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF27C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 15:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267A9218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 15:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfGDPpv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 11:45:51 -0400
Received: from mailout02.agenturserver.de ([185.15.192.33]:48860 "EHLO
        mailout02.agenturserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727066AbfGDPpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 11:45:51 -0400
Received: from mail02.agenturserver.de (mail02.internal [172.16.51.35])
        by mailout02.agenturserver.de (Postfix) with ESMTP id 7F5401209BB;
        Thu,  4 Jul 2019 17:45:47 +0200 (CEST)
Received: from localhost (ac02.internal [172.16.51.82])
        by mail02.agenturserver.de (Postfix) with ESMTP id 7323380670;
        Thu,  4 Jul 2019 17:45:47 +0200 (CEST)
Received: from mail.agenturserver.de ([172.16.51.35])
        by localhost (ac02.mittwald.de [172.16.51.82]) (amavisd-new, port 10026)
        with ESMTP id Ky2jPVPPeh4V; Thu,  4 Jul 2019 17:45:47 +0200 (CEST)
Received: from karo-electronics.de (unknown [89.1.81.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lw@karo-electronics.de)
        by mail.agenturserver.de (Postfix) with ESMTPSA;
        Thu,  4 Jul 2019 17:45:46 +0200 (CEST)
Date:   Thu, 4 Jul 2019 17:45:43 +0200
From:   Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To:     fugang.duan@nxp.com
Cc:     srinivas.kandagatla@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH nvmem 1/1] nvmem: imx: correct the fuse word index
Message-ID: <20190704174543.194a0158@karo-electronics.de>
In-Reply-To: <20190704142015.10701-1-fugang.duan@nxp.com>
References: <20190704142015.10701-1-fugang.duan@nxp.com>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu,  4 Jul 2019 22:20:15 +0800 fugang.duan@nxp.com wrote:
> From: Fugang Duan <fugang.duan@nxp.com>
> 
> iMX8 fuse word index represent as one 4-bytes word,
> it should not be divided by 4.
> 
> Exp:
> - MAC0 address layout in fuse:
> offset 708: MAC[3] MAC[2] MAC[1] MAC[0]
> offset 709: XX     xx     MAC[5] MAC[4]
> 
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> ---
>  drivers/nvmem/imx-ocotp-scu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.c
> index d9dc482..be2f5f0 100644
> --- a/drivers/nvmem/imx-ocotp-scu.c
> +++ b/drivers/nvmem/imx-ocotp-scu.c
> @@ -71,8 +71,8 @@ static int imx_scu_ocotp_read(void *context, unsigned int offset,
>  	void *p;
>  	int i, ret;
>  
> -	index = offset >> 2;
> -	num_bytes = round_up((offset % 4) + bytes, 4);
> +	index = offset;
> +	num_bytes = round_up(bytes, 4);
>  	count = num_bytes >> 2;
>  
>  	if (count > (priv->data->nregs - index))
> @@ -100,7 +100,7 @@ static int imx_scu_ocotp_read(void *context, unsigned int offset,
>  		buf++;
>  	}
>  
> -	memcpy(val, (u8 *)p + offset % 4, bytes);
> +	memcpy(val, (u8 *)p, bytes);
>  
>  	kfree(p);
>  
With these changes you could use the 'val' pointer directly
as the destination for ocotp_read() without need for an intermediate
buffer.


Lothar Waßmann
