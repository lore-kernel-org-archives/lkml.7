Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5B4C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1782206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DHiuhSXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfDPH7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:59:16 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:29613 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfDPH7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:59:16 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190416075913epoutp0293bafe4065ead4b6f06573deffdbae80~V5XjKfV9S1687816878epoutp02q
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 07:59:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190416075913epoutp0293bafe4065ead4b6f06573deffdbae80~V5XjKfV9S1687816878epoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555401553;
        bh=SSQnk7O4d4hR5RaDGoPwGnmwcDCBb6CGRjXGVC5Nq2o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=DHiuhSXkNyVIEYqQ+C2ZZgB9cb6DkVFAvxdbkTtC9O908ad/VvIAc7n96XworD840
         GkhEG7AQ60CFjSJSslhv0oGW1SBDVm2RBOgDsJUsOeHcAjCBT0kGynhIVFuCuBDT0t
         QjzOkZAePI726Yb7thpWMI/SHQ5a6wzSbv74zdRg=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190416075907epcas1p2e7e95c331617a9a362213590d94f47c1~V5Xd5uz2Z0985809858epcas1p2Y;
        Tue, 16 Apr 2019 07:59:07 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.7B.04139.B4B85BC5; Tue, 16 Apr 2019 16:59:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190416075907epcas1p42dc7016b49e3301f595f008fbafe43d6~V5XdjxEG_0271602716epcas1p4_;
        Tue, 16 Apr 2019 07:59:07 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190416075907epsmtrp220e0b81939fbbac585e524ee9c3bf8e7~V5XdjDbCj2309323093epsmtrp2b;
        Tue, 16 Apr 2019 07:59:07 +0000 (GMT)
X-AuditID: b6c32a35-98bff7000000102b-d0-5cb58b4b0ee0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.51.03662.B4B85BC5; Tue, 16 Apr 2019 16:59:07 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190416075907epsmtip2777303bc256b707804fc4ea6bf6f69a0~V5XdVdIH52964229642epsmtip2a;
        Tue, 16 Apr 2019 07:59:07 +0000 (GMT)
Subject: Re: [PATCH v2 05/19] PM / devfreq: tegra: Replace write memory
 barrier with the read barrier
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <e0a9def6-e3ed-f134-e612-aa257aa3fa12@samsung.com>
Date:   Tue, 16 Apr 2019 17:00:01 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415145505.18397-6-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURT1dZlO0epYBK+NURiXCLGUoRYGA4pCtAYTif6okOBIx0LoZqcl
        rgkqKlRxj0vdRRJFTUktiBXSgLgLIaCCEsQENK4QQI3GhNh2auTvvHvOfeee9y4ulFdjCrzA
        ZGOtJsZAYmGi2vsxccrMAzU58cXVs+gbQ32ILnFeEdEtu79K6A7vOYweKW9GdNl3J0Z377qG
        0b+9F0T0oVvtWJpUW9dzFWnvOnsk2vI9A5j2kKcKaUfcM7LE6wtT8llGx1qjWFOeWVdg0qeS
        mWty03M1ifGUkkqmk8goE2NkU8mMlVnKZQUG/0BkVBFjsPtLWQzHkapFKVaz3cZG5Zs5WyrJ
        WnQGS7IljmOMnN2kj8szGxdS8fEJGr9wQ2F+1ZAPs7wYv6XrfIewGPmkDiTFgVgAnXc6BQ4U
        hsuJOgQPPL1YgJATwwhuetN44ieCly9GRP86XvdcCXU0IGhzVoYOgwh+ffKJA6pwQg+OU/fE
        AWIKMYpg2Hs6SAiJdfCjsVIYwBgRC76PXUG/SUQ0vPzVhwJYRiyCw6OngnoRMQcuux1BHEGs
        hd6H1WJeMxmenOkPjiQlEqHl1TcBf/9UeNN/MYRnwp6as8LAEED8weDk+2IJnyED2ve+RTwO
        h8+PPKG6AkYGGjAeb4frT5oxvrkUgcfXJuYJNfgqj/sdcL9DDLi8Kt5sIgz8OCgOlIGQQek+
        Oa+eBR3vegQ8ngYV+8tC12uh3jUqOYKinWPiOMdEcI6J4PxvdgmJqlAka+GMepajLNTY73aj
        4LbGaurQidaVTYjAETlBhh/05MjFTBG31diEABeSU2RLdP6STMds3cZazblWu4HlmpDG/9pH
        hYqIPLN/9022XEqToFar6QVUooaiyKkyV1p6jpzQMza2kGUtrPVfnwCXKopRxQWH6t7qxaXQ
        r36caWqtH+wTzI/uRHPnlVhWZJ5PUrpKl/2ZWDXnw61sxdIaV1H5o3O1dsk4jfvYqqEdFQmc
        AreW3f8im/4+KXs4fTMeGfY0RVkhmxRBVUZu7B0tYSardg7GNBbVL29w3/65vHlzxrPuDbM/
        70LJyaLnNdfKVJtIEZfPULFCK8f8BU8Lx4HDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSvK5399YYg+75nBarPz5mtGiZtYjF
        4mzTG3aLy7vmsFl87j3CaNH5ZRabxe3GFWwWP3fNY7HoW3uJzYHTY8fdJYweO2fdZffobX7H
        5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZqz7uZyu4wl1xY+5l5gbG/ZxdjJwcEgImEjfv
        LmLqYuTiEBLYzShx+uZ5JoiEpMS0i0eZuxg5gGxhicOHiyFq3jJKrGrZyAxSIyyQLtE1fTcr
        SEJEoIlJ4vPDFrBmZoFIif5H3awQHVsZJfp+n2IFSbAJaEnsf3GDDcTmF1CUuPrjMSOIzStg
        J9H/bzpYDYuAqsTCTV1gtqhAhMSZ9ytYIGoEJU7OfAJmcwqYSZy99hZqmbrEn3mXmCFscYlb
        T+ZDxeUlmrfOZp7AKDwLSfssJC2zkLTMQtKygJFlFaNkakFxbnpusWGBUV5quV5xYm5xaV66
        XnJ+7iZGcJRpae1gPHEi/hCjAAejEg9vQt+WGCHWxLLiytxDjBIczEoivI4pQCHelMTKqtSi
        /Pii0pzU4kOM0hwsSuK88vnHIoUE0hNLUrNTUwtSi2CyTBycUg2MEg+TI3NtDn9mamGu1Jg+
        0XJL7KrVqRdWPvLZujyGaTHPsR8SyUp9k1fdiljCGNfa7D1XIP7KFO7HjfIBxg9/itfcqVjB
        3Zj+Mzeg6ZW3w/be7Ven+1mlM+U/exiT81R8wyJx5so17Hkp95n2sVX1evx8lLrq0IE7f1q1
        E9w0dJ1dT3pP2C2lxFKckWioxVxUnAgAjfk3C64CAAA=
X-CMS-MailID: 20190416075907epcas1p42dc7016b49e3301f595f008fbafe43d6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190415145805epcas1p209d0e2a8ba052ad11e91155c4585b1bd
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145805epcas1p209d0e2a8ba052ad11e91155c4585b1bd@epcas1p2.samsung.com>
        <20190415145505.18397-6-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 4. 15. 오후 11:54, Dmitry Osipenko wrote:
> The write memory barrier isn't needed because the BUS buffer is flushed
> by read after write that happens after the removed wmb(), we will also
> use readl() instead of the relaxed version to ensure that read is indeed
> completed.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index d62fb1b0d9bb..f0f0d78f6cbf 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -243,8 +243,7 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
>  static void actmon_write_barrier(struct tegra_devfreq *tegra)
>  {
>  	/* ensure the update has reached the ACTMON */
> -	wmb();
> -	actmon_readl(tegra, ACTMON_GLB_STATUS);
> +	readl(tegra->regs + ACTMON_GLB_STATUS);

I think that this meaning of actmon_write_barrier() keeps
the order of 'store' assembly command without the execution change
from compiler optimization by using the wmb().

But, this patch edits it as following:
The result of the following two cases are same?

[original code]
	wmb()
	read_relaxed()

[new code by this patch]
	readl_relaxed()
	rmb()


>  }
>  
>  static void actmon_isr_device(struct tegra_devfreq *tegra,
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
