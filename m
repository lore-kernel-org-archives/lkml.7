Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB65C46477
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF54220873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUfY19w6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfFRNpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:45:34 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36012 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbfFRNpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:45:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id k21so21832497edq.3;
        Tue, 18 Jun 2019 06:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8Ozm0kNXGZ6CrbSELxUIOO1h6nGc9IzMfpC34Z0SD2M=;
        b=GUfY19w6kzf5SZnyGMiG1tzqdsZk4aD4CnOjJZqwJdxGullC1MpIwW/faJLDF8Vcz+
         wz46jjlICzjku17MCY9E1bWQjvsmZDo4jcp7AT0urduu3/UBYhIB4IWkB3f4s92yv46v
         fPogtNPvgH/4iFE6KtQBKbaeqy/B6pIv+wMfLtmPc++HzMv7eQqkPvcZXBbz/OBq7Mf5
         z2CiavRTmCSmpLa42Ps3vaIR4NqdJPO+G1gFzHmToCdG1cN46wT2h1UYC4/1pox7f9FL
         n4Ms+mxt1KYo5KvsWRqTHzhrD681HX1b5HudJ5MsixKIw3yVxECLEYw0EPOTE0k0WCro
         s3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8Ozm0kNXGZ6CrbSELxUIOO1h6nGc9IzMfpC34Z0SD2M=;
        b=jq6qaaQ5KYgaPvLFTCRgGrsXO9CQVN+Nt+WhU/mvCae7DoAoN3ZCCL22eK2hPa0PT0
         VdWIqwo3ke7+hdzAgTAhOim0x0dWxtT/V8D0Ka9HtLnjhTe1HWh3qd2TQdvs2JyYZI2y
         ECyVYHYLTFEsRR7GZe3AyezNmiXovEr8QXMximpq7/XoXNAeZ8TAYSiOZEQsgLKqhk5W
         7+0yS/barkR38Kmcd1baVNzRxPcQZtcZ4nkf2MJnB9+3DjM4CTr6lc3Hhq0wyBI3mgoQ
         Ay8z9JYWPo4EM9xqqXyVGLYQzA9UjyRJyNM1yaPmbOqbuzKiWRcIQBDSIBp6rNvWA/7A
         Xd7A==
X-Gm-Message-State: APjAAAWb/juT9muYvYZgT+Gd/3noG1H4tUSL+IyNmV7ADjSRqHDeXNyM
        c0z3KSa7UhE1zkB4iTt3WHScdQAeByM=
X-Google-Smtp-Source: APXvYqy0rhzhm+Byo0NdWj7HzjqGVyNN16kK3vuJMl9HkqDxhsJkQNSjefHb7HdYZpMUpxsHbpGPjQ==
X-Received: by 2002:aa7:c149:: with SMTP id r9mr37612196edp.92.1560865530547;
        Tue, 18 Jun 2019 06:45:30 -0700 (PDT)
Received: from ziggy.stardust ([37.223.140.27])
        by smtp.gmail.com with ESMTPSA id u15sm4672646edi.10.2019.06.18.06.45.29
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 06:45:29 -0700 (PDT)
Subject: Re: [PATCH v7 17/21] memory: mtk-smi: Get rid of need_larbid
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, yingjoe.chen@mediatek.com,
        youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>,
        anan.sun@mediatek.com, Matthias Kaehlcke <mka@chromium.org>
References: <1560169080-27134-1-git-send-email-yong.wu@mediatek.com>
 <1560169080-27134-18-git-send-email-yong.wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 jrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <1af7b67a-b73a-efb9-e1f8-5701f05a4af0@gmail.com>
Date:   Tue, 18 Jun 2019 15:45:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1560169080-27134-18-git-send-email-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/06/2019 14:17, Yong Wu wrote:
> The "mediatek,larb-id" has already been parsed in MTK IOMMU driver.
> It's no need to parse it again in SMI driver. Only clean some codes.
> This patch is fit for all the current mt2701, mt2712, mt7623, mt8173
> and mt8183.
> 
> After this patch, the "mediatek,larb-id" only be needed for mt2712
> which have 2 M4Us. In the other SoCs, we can get the larb-id from M4U
> in which the larbs in the "mediatek,larbs" always are ordered.
> 
> Correspondingly, the larb_nr in the "struct mtk_smi_iommu" could also
> be deleted.
> 

I think we can get rid of struct mtk_smi_iommu and just add the
struct mtk_smi_larb_iommu larb_imu[MTK_LARB_NR_MAX] directly to mtk_iommu_data,
passing just that array to the components bind function.

Never the less this patch looks fine:
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> ---
>  drivers/iommu/mtk_iommu.c    |  1 -
>  drivers/iommu/mtk_iommu_v1.c |  2 --
>  drivers/memory/mtk-smi.c     | 26 ++------------------------
>  include/soc/mediatek/smi.h   |  1 -
>  4 files changed, 2 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index ec4ce74..6053b8b 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -634,7 +634,6 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>  					     "mediatek,larbs", NULL);
>  	if (larb_nr < 0)
>  		return larb_nr;
> -	data->smi_imu.larb_nr = larb_nr;
>  
>  	for (i = 0; i < larb_nr; i++) {
>  		struct device_node *larbnode;
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index 52b01e3..73308ad 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -624,8 +624,6 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>  		larb_nr++;
>  	}
>  
> -	data->smi_imu.larb_nr = larb_nr;
> -
>  	platform_set_drvdata(pdev, data);
>  
>  	ret = mtk_iommu_hw_init(data);
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 08cf40d..10e6493 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -67,7 +67,6 @@ struct mtk_smi_common_plat {
>  };
>  
>  struct mtk_smi_larb_gen {
> -	bool need_larbid;
>  	int port_in_larb[MTK_LARB_NR_MAX + 1];
>  	void (*config_port)(struct device *);
>  	unsigned int larb_direct_to_common_mask;
> @@ -153,18 +152,9 @@ void mtk_smi_larb_put(struct device *larbdev)
>  	struct mtk_smi_iommu *smi_iommu = data;
>  	unsigned int         i;
>  
> -	if (larb->larb_gen->need_larbid) {
> -		larb->mmu = &smi_iommu->larb_imu[larb->larbid].mmu;
> -		return 0;
> -	}
> -
> -	/*
> -	 * If there is no larbid property, Loop to find the corresponding
> -	 * iommu information.
> -	 */
> -	for (i = 0; i < smi_iommu->larb_nr; i++) {
> +	for (i = 0; i < MTK_LARB_NR_MAX; i++) {
>  		if (dev == smi_iommu->larb_imu[i].dev) {
> -			/* The 'mmu' may be updated in iommu-attach/detach. */
> +			larb->larbid = i;
>  			larb->mmu = &smi_iommu->larb_imu[i].mmu;
>  			return 0;
>  		}
> @@ -243,7 +233,6 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
>  };
>  
>  static const struct mtk_smi_larb_gen mtk_smi_larb_mt2701 = {
> -	.need_larbid = true,
>  	.port_in_larb = {
>  		LARB0_PORT_OFFSET, LARB1_PORT_OFFSET,
>  		LARB2_PORT_OFFSET, LARB3_PORT_OFFSET
> @@ -252,7 +241,6 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
>  };
>  
>  static const struct mtk_smi_larb_gen mtk_smi_larb_mt2712 = {
> -	.need_larbid = true,
>  	.config_port                = mtk_smi_larb_config_port_gen2_general,
>  	.larb_direct_to_common_mask = BIT(8) | BIT(9),      /* bdpsys */
>  };
> @@ -291,7 +279,6 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct device_node *smi_node;
>  	struct platform_device *smi_pdev;
> -	int err;
>  
>  	larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
>  	if (!larb)
> @@ -321,15 +308,6 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>  	}
>  	larb->smi.dev = dev;
>  
> -	if (larb->larb_gen->need_larbid) {
> -		err = of_property_read_u32(dev->of_node, "mediatek,larb-id",
> -					   &larb->larbid);
> -		if (err) {
> -			dev_err(dev, "missing larbid property\n");
> -			return err;
> -		}
> -	}
> -
>  	smi_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
>  	if (!smi_node)
>  		return -EINVAL;
> diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
> index 5201e90..a65324d 100644
> --- a/include/soc/mediatek/smi.h
> +++ b/include/soc/mediatek/smi.h
> @@ -29,7 +29,6 @@ struct mtk_smi_larb_iommu {
>  };
>  
>  struct mtk_smi_iommu {
> -	unsigned int larb_nr;
>  	struct mtk_smi_larb_iommu larb_imu[MTK_LARB_NR_MAX];
>  };
>  
> 
