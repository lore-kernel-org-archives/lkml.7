Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E04FC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 15:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6525620880
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 15:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="VKiz+78S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfDNPBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 11:01:40 -0400
Received: from mout.web.de ([212.227.17.11]:34865 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfDNPBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 11:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1555254085;
        bh=IDZDPyVdrNZ07lME+S7h+RcleTLsi5BPpeVJa/7UGxc=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=VKiz+78SIUrDHx8eNyE2cVfVQjzOl14h16bmG77Uv457HXU84blk1s7+yCJBPWe4a
         S7oLAnJzl2A6OGtg1q0etRMY+G4e1IBFmGKHqnZ8Gnunw6J8J9PAs8sKC2d55GJmd6
         3XlQQxzADO+y0erY6D1U3f+L2/hZ9Au2zhuG/39Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.103.133]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2dg1-1gyz7w1c97-00sM9k; Sun, 14
 Apr 2019 17:01:25 +0200
To:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Mukesh Ojha <mojha@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
References: <1550928043-14889-3-git-send-email-Julia.Lawall@lip6.fr>
Subject: Re: [PATCH 02/12] drm/tegra: rgb: add missing of_node_put after
 of_device_is_available
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <564652ed-d398-33ae-0f05-088d1235bf9f@web.de>
Date:   Sun, 14 Apr 2019 17:01:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1550928043-14889-3-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2IHVR4VWYbgcAMhBilZcWfr27SmN1zF4H0ZaRrIwOeVxNWuA7TF
 wLCcg+8CgbKbPAd563s0vZ6txAqn5A6+vGTpAs9jT4HM6kQ3gRs7CbAuHOQ6X+FI+6l7054
 Zzp7dwfj/X3NUIBhZP1XKyc++yocxb/9TSdp0StTCSEue8u8yecMCwTu6WuJCGt5C/zzKlY
 JX/5wGjblEuTwgu/AOEew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gokQ1FClNiM=:SeNHIxkPnwY1uU/MN4yoYp
 Q6TTyou8JXMl+ZFSWbK8Sk1j6pfiFKtaZs6pz9iUXSGO6E4iNQYpSPK9xF0oPGVLabW2waJtP
 QAcXfBf1+OC+qdc85fpAJoQO1gPY2oidvMmEFhhQPhedmL9zz5R+Tav97tFgENzLt4fPqlmgs
 ONHSXc4k26KgdENSQuY8dsXYXQ+BzzGBBKQ2p4Etr8DB6/Xtgao/ndHgYxV5RlwapD5vOxEMC
 eti3uLpCKMEkfgvLMd7Cb4fy7zsEmWv0oiq5QMCMx3yQy8/ka25Q7y5h7FnHEP9eNFa8Mc6oS
 J9aDeJzhTrUZu+e8UU9mphmdxDUvJMypOJezugxbPhxERCQJztNoAwLoCaAzqZ9Lq0J7y2/pY
 f0GEomODenNnRzHJRrmey4Z9ex9WYz8G7o9zCYREbWd9fgdI6Xtcglor2tjFDFlSwtcIPuTX8
 sIV3utuSczPa6nfxo2nH5VYsB4Oxev62yiauBO937C5Co1zUyOeIp5s7usqBtSXSo0MPWGb4z
 tuVe2XuUxyQz7XzRVA95zDlN+DO9Mt8nYD7Vdm068xLHQXGqWLkpjrTbvYBHro6O0SwNzpTmy
 LWid1Cus+/JBEh3gmIZXKUIO2TwmzPj0V5xyUAdrOZPrLPde4qTfweHJ0XcY9c73/QaBgVsve
 xkkRvIBGlQ9eqBOe+xXvd3yjyGDeIVIKs3SIEBx2mI64ajidcJZEsWI+OFhxLEDZrvyRhMDUV
 25+1+PrUKLXSZwpcwao1C48kNGVBd9MT5F0zEiS0uq6Z+31SBhrK4ldV++aMoL0+ksLoZYmgL
 xc+v87OG/CU0GdNjzd4DzjXx4FJwI+BRPGcpFifJRPVnv6/WhJk9/n53VrKJ6+NSYlgjfa5K9
 P0XhkKcOAmL1GbIeePi62P1VzwZHGnnzAb+tViJ4ZeBGShIlfJUy7Yuq5uqd4kehR6qp6uCQE
 fRkTvIy1Ekw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -221,8 +221,10 @@  int tegra_dc_rgb_probe(struct tegra_dc *
>  	int err;
>
>  	np =3D of_get_child_by_name(dc->dev->of_node, "rgb");
> -	if (!np || !of_device_is_available(np))
> +	if (!np || !of_device_is_available(np)) {
> +		of_node_put(np);
>  		return -ENODEV;
> +	}
>
>  	rgb =3D devm_kzalloc(dc->dev, sizeof(*rgb), GFP_KERNEL);
>  	if (!rgb)

How do you think about to move this function call to an additional jump ta=
rget
for the desired exception handling?

Regards,
Markus
