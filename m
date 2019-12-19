Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A099C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 22:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C034D227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 22:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="dyL8piVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfLSWLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:11:34 -0500
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:43940 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726866AbfLSWLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 17:11:34 -0500
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
        by m0050095.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id xBJM6dkn027754;
        Thu, 19 Dec 2019 22:11:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=zUBIycOEJtYTxzZ3gh0GUV57uHLF7mozpJ1HXSmQSGg=;
 b=dyL8piVvzs81nXhkpCkenZoZEjxsVkZ6Qd88x1jvxe+0PP3Asd5MAh+TFIB5C4/uHu/A
 JcsSINApyDKcn3rIHDUsx2gFkcw5eovMwysUhefOFk9m7PQiknmENIjAHGyGXUxzL+tL
 +E+Jzou8Ih2cZmdMRP8pBm3L9mIPnICJPmWMnxfOQPvz1dhUoNkK0gju0T2YUy2cqBpp
 6NG7L9AuPL1+WFZmQblTBoDSBkcc0CwfwmsOgohNDjvI7DexCiGkt9fDww07relRQvLC
 4bDebuixxHjcQpop8+kjUXMUsViTcdNS3PYRHW96dhD9bS8MV6Bjwa2nbSpJxpU/WVt5 kA== 
Received: from prod-mail-ppoint8 (prod-mail-ppoint8.akamai.com [96.6.114.122] (may be forged))
        by m0050095.ppops.net-00190b01. with ESMTP id 2wyymnm1a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 22:11:22 +0000
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
        by prod-mail-ppoint8.akamai.com (8.16.0.27/8.16.0.27) with SMTP id xBJM2Cpg018117;
        Thu, 19 Dec 2019 17:11:21 -0500
Received: from prod-mail-relay14.akamai.com ([172.27.17.39])
        by prod-mail-ppoint8.akamai.com with ESMTP id 2wvuy2ync3-1;
        Thu, 19 Dec 2019 17:11:21 -0500
Received: from [172.28.3.71] (bos-lpjec.145bw.corp.akamai.com [172.28.3.71])
        by prod-mail-relay14.akamai.com (Postfix) with ESMTP id 4FC048122C;
        Thu, 19 Dec 2019 22:11:21 +0000 (GMT)
Subject: Re: [PATCH v5] lib/dynamic_debug: make better dynamic log output
To:     Huang Shijie <sjhuang@iluvatar.ai>
Cc:     linux-kernel@vger.kernel.org, 1537577747@qq.com,
        Joe Perches <joe@perches.com>
References: <20191209094437.14866-1-sjhuang@iluvatar.ai>
 <20191219074735.31640-1-sjhuang@iluvatar.ai>
From:   Jason Baron <jbaron@akamai.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jbaron@akamai.com; prefer-encrypt=mutual; keydata=
 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
 JeQ7iQ==
Message-ID: <ec04aa8b-5c2a-28be-a32b-6d85a17d2f21@akamai.com>
Date:   Thu, 19 Dec 2019 17:10:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191219074735.31640-1-sjhuang@iluvatar.ai>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-19_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=852
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912190164
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_07:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 phishscore=0 mlxlogscore=865 bulkscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912190164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/19/19 2:47 AM, Huang Shijie wrote:
> The driver strings, device name and net device name are not changed for
> the driver's dynamic log output. But the dynamic_emit_prefix() which contains
> the function names may change when the function names are changed.
> 
> So the patch makes the better dynamic log output.

Another point here is that currently the output precisely matches the
non-dynamic debug counterpart strings if not prefix is emitted. So that
changes with this patch. I think its nice to say that the output is the
same as the non dynamic debug output except it may have an optional
prefix....


> 
> Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
> ---
> v4 --> v5:
> 	remove the redundant whitespce in the tail.
> ---
>  lib/dynamic_debug.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index c60409138e13..bfc3b386d603 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -589,9 +589,9 @@ void __dynamic_dev_dbg(struct _ddebug *descriptor,
>  	} else {
>  		char buf[PREFIX_SIZE];
>  
> -		dev_printk_emit(LOGLEVEL_DEBUG, dev, "%s%s %s: %pV",
> -				dynamic_emit_prefix(descriptor, buf),
> +		dev_printk_emit(LOGLEVEL_DEBUG, dev, "%s %s %s%pV",
>  				dev_driver_string(dev), dev_name(dev),
> +				dynamic_emit_prefix(descriptor, buf),
>  				&vaf);
>  	}
>  
> @@ -619,11 +619,11 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
>  		char buf[PREFIX_SIZE];
>  
>  		dev_printk_emit(LOGLEVEL_DEBUG, dev->dev.parent,
> -				"%s%s %s %s%s: %pV",
> -				dynamic_emit_prefix(descriptor, buf),
> +				"%s %s %s %s %s%pV",
>  				dev_driver_string(dev->dev.parent),
>  				dev_name(dev->dev.parent),
>  				netdev_name(dev), netdev_reg_state(dev),
> +				dynamic_emit_prefix(descriptor, buf),
>  				&vaf);
>  	} else if (dev) {
>  		printk(KERN_DEBUG "%s%s: %pV", netdev_name(dev),
> @@ -655,11 +655,11 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
>  		char buf[PREFIX_SIZE];
>  
>  		dev_printk_emit(LOGLEVEL_DEBUG, ibdev->dev.parent,
> -				"%s%s %s %s: %pV",
> -				dynamic_emit_prefix(descriptor, buf),
> +				"%s %s %s %s%pV",
>  				dev_driver_string(ibdev->dev.parent),
>  				dev_name(ibdev->dev.parent),
>  				dev_name(&ibdev->dev),
> +				dynamic_emit_prefix(descriptor, buf),
>  				&vaf);
>  	} else if (ibdev) {
>  		printk(KERN_DEBUG "%s: %pV", dev_name(&ibdev->dev), &vaf);
> 
