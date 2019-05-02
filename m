Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D498C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 04:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CE12075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 04:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="i34RksDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfEBEyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 00:54:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:62658 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfEBEyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 00:54:10 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44vjbM5M91z9v0BV;
        Thu,  2 May 2019 06:54:07 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=i34RksDU; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id fsoG583XIQdN; Thu,  2 May 2019 06:54:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44vjbM41xVz9v0BC;
        Thu,  2 May 2019 06:54:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556772847; bh=I0FeEl/w+6bt1GR2o7dyQEdLVhu5vJLVUHB5TTIyQLM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=i34RksDU0m+1D9lH5cGRWzmbilcKtHDaRv5ToGo9d6faaqXA3nnFcxEChzcW4WNRj
         r5bQzwZP3VUqOInhA8yiITExOyffCWXBQ5nPmvz8u6fxSEPbYd9u3ZQFU2jhDEH24i
         N+I8zab8zf7Uaxq0qv8xBEQdzhpCBkMjYPdAdDOM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 583318B852;
        Thu,  2 May 2019 06:54:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fI6na7e6-yyE; Thu,  2 May 2019 06:54:08 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A81188B74C;
        Thu,  2 May 2019 06:54:07 +0200 (CEST)
Subject: Re: [PATCH v2 6/6] soc/fsl/qe: qe.c: fold qe_get_num_of_snums into
 qe_snums_init
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
 <20190501092841.9026-7-rasmus.villemoes@prevas.dk>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <5457d33f-b691-6406-138d-0fc633c1d24c@c-s.fr>
Date:   Thu, 2 May 2019 06:54:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501092841.9026-7-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 01/05/2019 à 11:29, Rasmus Villemoes a écrit :
> The comment "No QE ever has fewer than 28 SNUMs" is false; e.g. the
> MPC8309 has 14. The code path returning -EINVAL is also a recipe for
> instant disaster, since the caller (qe_snums_init) uncritically
> assigns the return value to the unsigned qe_num_of_snum, and would
> thus proceed to attempt to copy 4GB from snum_init_46[] to the snum[]
> array.
> 
> So fold the handling of the legacy fsl,qe-num-snums into
> qe_snums_init, and make sure we do not end up using the snum_init_46
> array in cases other than the two where we know it makes sense.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   drivers/soc/fsl/qe/qe.c | 46 ++++++++++++++---------------------------
>   1 file changed, 16 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
> index 325d689cbf5c..276d7d78ebfc 100644
> --- a/drivers/soc/fsl/qe/qe.c
> +++ b/drivers/soc/fsl/qe/qe.c
> @@ -308,24 +308,33 @@ static void qe_snums_init(void)
>   	int i;
>   
>   	bitmap_zero(snum_state, QE_NUM_OF_SNUM);
> +	qe_num_of_snum = 28; /* The default number of snum for threads is 28 */
>   	qe = qe_get_device_node();
>   	if (qe) {
>   		i = of_property_read_variable_u8_array(qe, "fsl,qe-snums",
>   						       snums, 1, QE_NUM_OF_SNUM);
> -		of_node_put(qe);
>   		if (i > 0) {
> +			of_node_put(qe);
>   			qe_num_of_snum = i;
>   			return;
>   		}
> +		/*
> +		 * Fall back to legacy binding of using the value of
> +		 * fsl,qe-num-snums to choose one of the static arrays
> +		 * above.
> +		 */
> +		of_property_read_u32(qe, "fsl,qe-num-snums", &qe_num_of_snum);
> +		of_node_put(qe);
>   	}
>   
> -	qe_num_of_snum = qe_get_num_of_snums();
> -
> -	if (qe_num_of_snum == 76)
> +	if (qe_num_of_snum == 76) {
>   		snum_init = snum_init_76;
> -	else
> +	} else if (qe_num_of_snum == 28 || qe_num_of_snum == 46) {
>   		snum_init = snum_init_46;
> -
> +	} else {
> +		pr_err("QE: unsupported value of fsl,qe-num-snums: %u\n", qe_num_of_snum);
> +		return;
> +	}
>   	memcpy(snums, snum_init, qe_num_of_snum);
>   }
>   
> @@ -641,30 +650,7 @@ EXPORT_SYMBOL(qe_get_num_of_risc);
>   
>   unsigned int qe_get_num_of_snums(void)
>   {
> -	struct device_node *qe;
> -	int size;
> -	unsigned int num_of_snums;
> -	const u32 *prop;
> -
> -	num_of_snums = 28; /* The default number of snum for threads is 28 */
> -	qe = qe_get_device_node();
> -	if (!qe)
> -		return num_of_snums;
> -
> -	prop = of_get_property(qe, "fsl,qe-num-snums", &size);
> -	if (prop && size == sizeof(*prop)) {
> -		num_of_snums = *prop;
> -		if ((num_of_snums < 28) || (num_of_snums > QE_NUM_OF_SNUM)) {
> -			/* No QE ever has fewer than 28 SNUMs */
> -			pr_err("QE: number of snum is invalid\n");
> -			of_node_put(qe);
> -			return -EINVAL;
> -		}
> -	}
> -
> -	of_node_put(qe);
> -
> -	return num_of_snums;
> +	return qe_num_of_snum;
>   }
>   EXPORT_SYMBOL(qe_get_num_of_snums);
>   
> 
