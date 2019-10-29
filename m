Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D12ACA9EC2
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 06:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591352053B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 06:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfJ2GwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 02:52:20 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:35387
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726483AbfJ2GwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 02:52:19 -0400
X-IronPort-AV: E=Sophos;i="5.68,243,1569276000"; 
   d="scan'208";a="324944045"
Received: from ppp-seco11pareq2-46-193-149-47.wb.wifirst.net (HELO hadrien) ([46.193.149.47])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 07:52:16 +0100
Date:   Tue, 29 Oct 2019 07:52:15 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        kim.jamie.bradley@gmail.com, nishkadg.linux@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: Re: [Outreachy kernel] [PATCH 3/5] staging: rts5208: Eliminate the
 use of Camel Case in file xd.c
In-Reply-To: <20191029014316.6452-4-gabrielabittencourt00@gmail.com>
Message-ID: <alpine.DEB.2.21.1910290750110.2328@hadrien>
References: <20191029014316.6452-1-gabrielabittencourt00@gmail.com> <20191029014316.6452-4-gabrielabittencourt00@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 28 Oct 2019, Gabriela Bittencourt wrote:

> Cleans up checks of "Avoid CamelCase" in file xd.c
>
> Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
> ---
>  drivers/staging/rts5208/xd.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/rts5208/xd.c b/drivers/staging/rts5208/xd.c
> index f3dc96a4c59d..0f369935fb6c 100644
> --- a/drivers/staging/rts5208/xd.c
> +++ b/drivers/staging/rts5208/xd.c
> @@ -630,13 +630,13 @@ static int reset_xd(struct rtsx_chip *chip)
>  			xd_card->zone_cnt = 32;
>  			xd_card->capacity = 1024000;
>  			break;
> -		case xD_1G_X8_512:
> +		case XD_1G_X8_512:

This looks wrong.  You have changed the uses of these names, but their
definitions don't get changed until patch number 4.  So this patch will
break the build.

Please redo the whole series so that definitions and uses are changed in
the same patch.  Be sure that you can compile the code after applying each
patch.

julia

>  			XD_PAGE_512(xd_card);
>  			xd_card->addr_cycle = 4;
>  			xd_card->zone_cnt = 64;
>  			xd_card->capacity = 2048000;
>  			break;
> -		case xD_2G_X8_512:
> +		case XD_2G_X8_512:
>  			XD_PAGE_512(xd_card);
>  			xd_card->addr_cycle = 4;
>  			xd_card->zone_cnt = 128;
> @@ -669,10 +669,10 @@ static int reset_xd(struct rtsx_chip *chip)
>  		return STATUS_FAIL;
>  	}
>
> -	retval = xd_read_id(chip, READ_xD_ID, id_buf, 4);
> +	retval = xd_read_id(chip, READ_XD_ID, id_buf, 4);
>  	if (retval != STATUS_SUCCESS)
>  		return STATUS_FAIL;
> -	dev_dbg(rtsx_dev(chip), "READ_xD_ID: 0x%x 0x%x 0x%x 0x%x\n",
> +	dev_dbg(rtsx_dev(chip), "READ_XD_ID: 0x%x 0x%x 0x%x 0x%x\n",
>  		id_buf[0], id_buf[1], id_buf[2], id_buf[3]);
>  	if (id_buf[2] != XD_ID_CODE)
>  		return STATUS_FAIL;
> --
> 2.20.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20191029014316.6452-4-gabrielabittencourt00%40gmail.com.
>
