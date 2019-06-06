Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ADAC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D8E207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="b3AstkD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfFFLKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 07:10:23 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54800 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfFFLKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 07:10:22 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190606111021euoutp02513fcec98d620345a4e743d34188b570~ll3-N5E4f0772307723euoutp02e
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2019 11:10:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190606111021euoutp02513fcec98d620345a4e743d34188b570~ll3-N5E4f0772307723euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559819421;
        bh=JX5ePPbYDBj+wqAFZmENFNBcm+t5STmGGG0MveRD7Bg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=b3AstkD3mqMih7MzPDFPEUKAZ2s0fo69lXpdUpf9x0LEqTZ+pGS4XJqwPESKiydtw
         S3tqMlhbIo/WdShuPADsD4Ulr+z7yo1VjTMLHEo6gAZ93b5Otc71rpHp2hIqZQu6qf
         dRCEL00eWpT65t/TanStPkpr5xPF2SIkeNG96kuQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190606111020eucas1p2ae590e632b72a7fc971e7b5005897fcb~ll3_kDOEA1056510565eucas1p2D;
        Thu,  6 Jun 2019 11:10:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 9B.57.04325.C94F8FC5; Thu,  6
        Jun 2019 12:10:20 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190606111019eucas1p2a87be594ff9713c779d669f8083ddf2e~ll39rAGwO1170411704eucas1p2i;
        Thu,  6 Jun 2019 11:10:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190606111019eusmtrp100a478d21a61320b6d0a67440621eba0~ll39bchOD0108201082eusmtrp1d;
        Thu,  6 Jun 2019 11:10:19 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-cc-5cf8f49c0078
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 84.AA.04140.B94F8FC5; Thu,  6
        Jun 2019 12:10:19 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190606111018eusmtip2a05f105da59bf9223938cba20d49757d~ll38mU85n0472604726eusmtip2n;
        Thu,  6 Jun 2019 11:10:18 +0000 (GMT)
Subject: Re: [PATCH v3 08/15] drm/bridge: tc358767: Increase AUX transfer
 length limit
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <96f190bb-8d16-84c7-e43b-7748fec9ae6e@samsung.com>
Date:   Thu, 6 Jun 2019 13:10:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190605070507.11417-9-andrew.smirnov@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SW0gUYRiG+2dmZ0ZtZdxMP1KLpgxLPEReDJRW1MVQGHURVFq65XggDzGj
        pgVlJrUeKjPCdjUysrSsNGstRdNdD2uZuabhAWwljEBcOphklNaOo+Td87/vd3g/+Glc06Na
        QSckpwpisjaRJZ2Juo5fPQGlP6Yjgz+2k9x5XSiXbc5Scdk6u4qb7m8lOFOjBeP6p76Q3OjN
        IYzLvVpOcX0NpSQ38qGT4KpvDZPbXPi+y5cwfvT6X4yvN4xQfIlOr+Jt+RaMvzITzFsGn2P8
        ZO1K/u31bmyv0yHnLTFCYkK6IAaFRTvHmxqKsRMFrhlFXQFZqN8lDznRwITA6KyJykPOtIap
        RPC1qX3+8QNBzWTn/GMSge11EbbQUmF5iBSjAsG4VU/JhoaxI3jUGiHzMuYANBdWz+nuzF74
        nl1Pyg04M4VBy7urc5NIZj3MPB1yGDStZsJgZiJWlglmLYwMNM+VLHfMsXXUqGRWM27wSj9G
        yOzkKDfmXEQy48wqOG8swRX2hOGxW5i8Cxg7Bfdum0gl9U5onrgzz8tg3PKMUtgbuq4VEAqf
        BVtlDq406xAYa+pxxdgMrZZelRwUd4SubghS5O1Qfu4zIcvAuMKg3U3J4ApFdcW4IqtBd0Gj
        VK8GW7dxfqAn3LVOkYWINSy6zLDoGsOiawz/95Yh4gHyFNKkpDhB2pQsnAyUtElSWnJc4LGU
        pFrk+GZds5apF+jln6NmxNCIXaqGJz8jNSptupSZZEZA46y7Ot06HalRx2gzTwliSpSYlihI
        ZuRFE6yn+vSS0QgNE6dNFY4LwglBXHAx2mlFFjJ/GvMQ9T6qrbv0G9z79LGsr7f02+dBm79p
        j9fLGwPG/X7oSnxFi58udHeUDWOsTWWH/f8sCc53WxdyMy/Dg5Ow+iZCd6xwrdjpO5sxJK18
        03j2DPutf1+WX5XVXzqyJoC9HJ27Iz88+PFG+8H3p9upobaqKKpALAqnev3vV7CEFK/duAEX
        Je0/M2qld2IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsVy+t/xe7qzv/yIMVjUxmbR3GFr0XSogdWi
        qeMtq8WPK4dZLA7uOc5kceXrezaLB3NvMll0TlzCbnF51xw2i7v3TrBYrJ9/i82B2+NyXy+T
        x4Op/5k8ds66y+4xu2Mmq8f97uNMHv1/DTyO39jO5PF5k5zHualnmQI4o/RsivJLS1IVMvKL
        S2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyDu6azlTQw1cx6bRuA+MV
        7i5GTg4JAROJ5cfXMHYxcnEICSxllHi7ppUFIiEusXv+W2YIW1jiz7UuNoii14wSazZ8ZAVJ
        CAtESOyfsJ4dxBYR8JPomneACaSIWeA7k8TE5XtZIDqOMko0LYAYyyagKfF3802gURwcvAJ2
        En/fpIGEWQRUJO5e388EYosCDT3zfgVYOa+AoMTJmU/AbE6g8q0t7YwgNrOAusSfeZeYIWx5
        ieats6FscYlbT+YzTWAUmoWkfRaSlllIWmYhaVnAyLKKUSS1tDg3PbfYSK84Mbe4NC9dLzk/
        dxMjMIK3Hfu5ZQdj17vgQ4wCHIxKPLwSG7/HCLEmlhVX5h5ilOBgVhLhLbvwI0aINyWxsiq1
        KD++qDQntfgQoynQcxOZpUST84HJJa8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6Yklqdmpq
        QWoRTB8TB6dUA2Ok//OsiM16MrmnHicon9v3znnKljlLzq41tDd4k8qhsOHmq/P/M/9KGes/
        NE1isPnIO9u058UaC+0Mj9A/aquP/Svj9hJ32Pjwgm9Bbtyfa88jv9yfuKNtIesVF+nYROHJ
        zVu31VUr/Gp5t/exp82y5Z1XMuTX6f2JkBDsOMKnEqqu4J27SliJpTgj0VCLuag4EQA27RQ5
        9gIAAA==
X-CMS-MailID: 20190606111019eucas1p2a87be594ff9713c779d669f8083ddf2e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605070538epcas3p105f3800f1f1afc37fd01f9dfa08fc582
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605070538epcas3p105f3800f1f1afc37fd01f9dfa08fc582
References: <20190605070507.11417-1-andrew.smirnov@gmail.com>
        <CGME20190605070538epcas3p105f3800f1f1afc37fd01f9dfa08fc582@epcas3p1.samsung.com>
        <20190605070507.11417-9-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.06.2019 09:05, Andrey Smirnov wrote:
> According to the datasheet tc358767 can transfer up to 16 bytes via
> its AUX channel, so the artificial limit of 8 apperas to be too
> low. However only up to 15-bytes seem to be actually supported and
> trying to use 16-byte transfers results in transfers failing
> sporadically (with bogus status in case of I2C transfers), so limit it
> to 15.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Archit Taneja <architt@codeaurora.org>


Please remove Archit's mail (from all patches), it is no longer valid.


Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej


> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Cory Tusar <cory.tusar@zii.aero>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/gpu/drm/bridge/tc358767.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index 260fbcd0271e..0125e2f7e076 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -374,7 +374,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
>  			       struct drm_dp_aux_msg *msg)
>  {
>  	struct tc_data *tc = aux_to_tc(aux);
> -	size_t size = min_t(size_t, 8, msg->size);
> +	size_t size = min_t(size_t, DP_AUX_MAX_PAYLOAD_BYTES - 1, msg->size);
>  	u8 request = msg->request & ~DP_AUX_I2C_MOT;
>  	int ret;
>  


