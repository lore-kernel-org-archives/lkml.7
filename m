Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64440C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D96B218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Nj/gDrwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfGCN4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:56:02 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:20678 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbfGCN4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:56:02 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x63Dt5EO018724;
        Wed, 3 Jul 2019 08:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=L90T/GlgU1MaQGyAFE7vEL8Bp6VDhRgZMQRaYBA9ec4=;
 b=Nj/gDrwaFBX2pdJvGiLpjgRZAUioUtaCgRJYDcmTpJgiquleCI4TqvGwIi7lHBpTg6ZP
 Rax4PwyGhmj2PNloQLvCP9O+kWoFlsQTCmW3Jm818M8UcvaexmhGPHMcw2St3tWnxcqa
 v18GNO2MSplkvS0jTP6/pP+yAG98qUaIDR2wlnRKhOz2k0HDO6D1Cm0yYDqDJGD9FNz7
 JPk/wfi4kXvDo4DctmlUhbbLWecpKxnyucVqX61NRlSE2Il8FVx+7iYLTAiwyd0dCB8A
 v6K/SBaYEXO4IvvaujHShR+r1TqayrhWNyiXhmRrxFeuOyg+Aqy3wIqmrhqA00BxOqZk fQ== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0b-001ae601.pphosted.com with ESMTP id 2te4dr6mnw-1;
        Wed, 03 Jul 2019 08:55:04 -0500
Received: from EDIEX02.ad.cirrus.com (unknown [198.61.84.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 5DB74611C8BB;
        Wed,  3 Jul 2019 08:55:04 -0500 (CDT)
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 3 Jul
 2019 14:55:03 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Wed, 3 Jul 2019 14:55:03 +0100
Received: from [198.90.251.101] (edi-sw-dsktp006.ad.cirrus.com [198.90.251.101])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 79B792A1;
        Wed,  3 Jul 2019 14:55:03 +0100 (BST)
Subject: Re: [PATCH 30/30] sound/soc: Use kmemdup rather than duplicating its
 implementation
To:     Fuqian Huang <huangfq.daxian@gmail.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20190703131842.26082-1-huangfq.daxian@gmail.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <547c68b0-f55f-ca1d-c5b3-f6a5f89d93a9@opensource.cirrus.com>
Date:   Wed, 3 Jul 2019 14:55:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190703131842.26082-1-huangfq.daxian@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907030170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/19 14:18, Fuqian Huang wrote:
> kmemdup is introduced to duplicate a region of memory in a neat way.
> Rather than kmalloc/kzalloc + memset, which the programmer needs to
> write the size twice (sometimes lead to mistakes), kmemdup improves
> readability, leads to smaller code and also reduce the chances of mistakes.
> Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>   sound/soc/codecs/wm0010.c             | 4 +---
>   sound/soc/intel/atom/sst/sst_loader.c | 3 +--

Should be one patch per file as the drivers are not related to each
other at all, and if one needed a revert you couldn't revert this
patch because it would revert both drivers.

But apart from that, for wm0010.c:
Acked-by: Richard Fitzgerald <rf@opensource.cirrus.com>

>   2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
> index 727d6703c905..807826f30f58 100644
> --- a/sound/soc/codecs/wm0010.c
> +++ b/sound/soc/codecs/wm0010.c
> @@ -515,7 +515,7 @@ static int wm0010_stage2_load(struct snd_soc_component *component)
>   	dev_dbg(component->dev, "Downloading %zu byte stage 2 loader\n", fw->size);
>   
>   	/* Copy to local buffer first as vmalloc causes problems for dma */
> -	img = kzalloc(fw->size, GFP_KERNEL | GFP_DMA);
> +	img = kmemdup(&fw->data[0], fw->size, GFP_KERNEL | GFP_DMA);
>   	if (!img) {
>   		ret = -ENOMEM;
>   		goto abort2;
> @@ -527,8 +527,6 @@ static int wm0010_stage2_load(struct snd_soc_component *component)
>   		goto abort1;
>   	}
>   
> -	memcpy(img, &fw->data[0], fw->size);
> -
>   	spi_message_init(&m);
>   	memset(&t, 0, sizeof(t));
>   	t.rx_buf = out;
> diff --git a/sound/soc/intel/atom/sst/sst_loader.c b/sound/soc/intel/atom/sst/sst_loader.c
> index ce11c36848c4..cc95af35c060 100644
> --- a/sound/soc/intel/atom/sst/sst_loader.c
> +++ b/sound/soc/intel/atom/sst/sst_loader.c
> @@ -288,14 +288,13 @@ static int sst_cache_and_parse_fw(struct intel_sst_drv *sst,
>   {
>   	int retval = 0;
>   
> -	sst->fw_in_mem = kzalloc(fw->size, GFP_KERNEL);
> +	sst->fw_in_mem = kmemdup(fw->data, fw->size, GFP_KERNEL);
>   	if (!sst->fw_in_mem) {
>   		retval = -ENOMEM;
>   		goto end_release;
>   	}
>   	dev_dbg(sst->dev, "copied fw to %p", sst->fw_in_mem);
>   	dev_dbg(sst->dev, "phys: %lx", (unsigned long)virt_to_phys(sst->fw_in_mem));
> -	memcpy(sst->fw_in_mem, fw->data, fw->size);
>   	retval = sst_parse_fw_memcpy(sst, fw->size, &sst->memcpy_list);
>   	if (retval) {
>   		dev_err(sst->dev, "Failed to parse fw\n");
> 

