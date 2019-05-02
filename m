Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B99C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 04:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EA82075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 04:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="oC51hi27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfEBEws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 00:52:48 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:36554 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfEBEws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 00:52:48 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44vjYn5z2vz9v0BV;
        Thu,  2 May 2019 06:52:45 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=oC51hi27; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 0TUnsWMW3vXT; Thu,  2 May 2019 06:52:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44vjYn4rZBz9v0BC;
        Thu,  2 May 2019 06:52:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556772765; bh=oTUoNAvTbptkwHiQB4BoNv5xEebc0qVEEYx9fowqT+s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oC51hi27WAkc8iHZkPAl58pflieW+TouGLtmSDXZSe87JlN74wedySK6NhkoeGFA1
         Jq+AyX73+z7yScKsRYE+TYvzCeieb6eQ15HoV7fS9NC/ot6sx+7berTcq+2fmHLuJ/
         wmUYb/IjZpoGDMHaiuuZ/GwuFwGZdzX13EV1SlyU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 79AC18B84E;
        Thu,  2 May 2019 06:52:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lb_56fQc7pmk; Thu,  2 May 2019 06:52:46 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DD09C8B74C;
        Thu,  2 May 2019 06:52:45 +0200 (CEST)
Subject: Re: [PATCH v2 5/6] soc/fsl/qe: qe.c: support fsl,qe-snums property
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Scott Wood <oss@buserror.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
References: <20190430133615.25721-1-rasmus.villemoes@prevas.dk>
 <20190501092841.9026-1-rasmus.villemoes@prevas.dk>
 <20190501092841.9026-6-rasmus.villemoes@prevas.dk>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <53c8e642-5efa-c476-92b7-a70d5598b217@c-s.fr>
Date:   Thu, 2 May 2019 06:52:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501092841.9026-6-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 01/05/2019 à 11:29, Rasmus Villemoes a écrit :
> Add driver support for the newly introduced fsl,qe-snums property.
> 
> Conveniently, of_property_read_variable_u8_array does exactly what we
> need: If the property fsl,qe-snums is found (and has an allowed size),
> the array of values get copied to snums, and the return value is the
> number of snums - we cannot assign directly to num_of_snums, since we
> need to check whether the return value is negative.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   drivers/soc/fsl/qe/qe.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
> index 0fb8b59f61ad..325d689cbf5c 100644
> --- a/drivers/soc/fsl/qe/qe.c
> +++ b/drivers/soc/fsl/qe/qe.c
> @@ -283,7 +283,6 @@ EXPORT_SYMBOL(qe_clock_source);
>    */
>   static void qe_snums_init(void)
>   {
> -	int i;
>   	static const u8 snum_init_76[] = {
>   		0x04, 0x05, 0x0C, 0x0D, 0x14, 0x15, 0x1C, 0x1D,
>   		0x24, 0x25, 0x2C, 0x2D, 0x34, 0x35, 0x88, 0x89,
> @@ -304,7 +303,21 @@ static void qe_snums_init(void)
>   		0x28, 0x29, 0x38, 0x39, 0x48, 0x49, 0x58, 0x59,
>   		0x68, 0x69, 0x78, 0x79, 0x80, 0x81,
>   	};
> +	struct device_node *qe;
>   	const u8 *snum_init;
> +	int i;
> +
> +	bitmap_zero(snum_state, QE_NUM_OF_SNUM);
> +	qe = qe_get_device_node();
> +	if (qe) {
> +		i = of_property_read_variable_u8_array(qe, "fsl,qe-snums",
> +						       snums, 1, QE_NUM_OF_SNUM);
> +		of_node_put(qe);
> +		if (i > 0) {
> +			qe_num_of_snum = i;
> +			return;
> +		}
> +	}
>   
>   	qe_num_of_snum = qe_get_num_of_snums();
>   
> @@ -313,7 +326,6 @@ static void qe_snums_init(void)
>   	else
>   		snum_init = snum_init_46;
>   
> -	bitmap_zero(snum_state, QE_NUM_OF_SNUM);
>   	memcpy(snums, snum_init, qe_num_of_snum);
>   }
>   
> 
