Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4BAC10F13
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340F22073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HcyJ10X8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbfDQA1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 20:27:46 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:34912 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbfDQA1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 20:27:46 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190417002743epoutp011ac19e9ed491e9af2eb22b20a7ae1643~WG2oNN8kD0702707027epoutp01W
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 00:27:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190417002743epoutp011ac19e9ed491e9af2eb22b20a7ae1643~WG2oNN8kD0702707027epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555460863;
        bh=a7J62TfEs1W7hSPBK+5vJQFrE1BRhOdR/XKG0+yLoo0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HcyJ10X8YQOHlyYPrqnRQo1riD75RM+k5bGOtgUsAaVX5SrIDCXzGZmpvb9adJkem
         y49KawsFxkCsR4+wTo3tBSkhf23Bvi5ag3XfcXWPiOyhh68VXsIfbVduAMVkv0fzV5
         m7wrKXHozYHm6sm05JHYjGDQZE867CIE2On7JxbE=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190417002740epcas1p30c8bf2f589fc8e947f6a7b1d07ec36cb~WG2lrphqh1345713457epcas1p31;
        Wed, 17 Apr 2019 00:27:40 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.BF.04139.CF276BC5; Wed, 17 Apr 2019 09:27:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190417002740epcas1p4fa9a0166e66f7acddb9ef8932daf032c~WG2lVBSXc1514915149epcas1p4Z;
        Wed, 17 Apr 2019 00:27:40 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190417002740epsmtrp27924d23fe5de19ff22ac06fbb97c72d8~WG2lURzdn0378703787epsmtrp2e;
        Wed, 17 Apr 2019 00:27:40 +0000 (GMT)
X-AuditID: b6c32a35-98bff7000000102b-fc-5cb672fc87ed
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.17.03662.CF276BC5; Wed, 17 Apr 2019 09:27:40 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190417002740epsmtip13621ef84673a550a93576e407ac3e282~WG2lJdRh81974919749epsmtip15;
        Wed, 17 Apr 2019 00:27:40 +0000 (GMT)
Subject: Re: [PATCH v2 17/19] PM / devfreq: tegra: Support Tegra30
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
Message-ID: <4e896313-8fd9-1c1e-10f6-eac80aa01580@samsung.com>
Date:   Wed, 17 Apr 2019 09:28:37 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <53d0ead1-3a82-01d3-3b8a-094c1e6e34e0@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTYRDH83XbZUtsXRbUsQ9aV00ULXYtxfUoQfFoIg8YTDxCxA1dKemZ
        bkFRHxA8KvEWo9QzKEZBPEg5rBpiJSiKaKwmRoOagAkeQQ4PUBTbLkbefjPzn+v7hsCo67iK
        yLW7eZeds9J4tLTu3kyNZshVl6ntvZvIVvV2IHant1zKPi76HMUG/adwtn9/E2L3fvXi7Osd
        l3B20H9Gyh6ofoanyI0N7ReQ8aa3Pcq4v7gbNx7wVSJjf82kdNl6yyIzz5l4l5q3ZztMufYc
        A70yIys1S5+kZTTMfHYerbZzNt5AL01L1yzPtYYGotX5nDUv5ErnBIGek7zI5chz82qzQ3Ab
        aN5psjrnOxMEzibk2XMSsh22BYxWO1cfEm60mI888OHOutgtw8GXqBB1ji1BcgLIRHj/7IW0
        BEUTFNmAoKToSpRo9CFoLe2ThFUU+R2Bt1j5L2NguEciiu4g8Dz/MWJ8QRDsPyQLq2LJJXD6
        cAALB+LIPwj6/CciAYxcB9/uVmBhxsl4aOx6iYd5LDkFXgx0oDAryGTYHSiMaKTkdCg+PSQN
        8zhyLbxtvi4TNTHQUtYZ8ctJAwz8rEdi/QnwqvOsROTJUFx7MjIEkMM47Cu6hYk7LIWaq41R
        IsfCx/u+EVZBf/cdXORtcLmlCReTPQh8jU9lYkAHjRVHQx2IUIeZcM0/R2ymhO5v+2RhN5AK
        8OymRPVUCL5rl4g8Ec7v2TtS3gifHt3GDqEp3lHreEet4B21gvd/s3NIWonG807BlsMLjJMZ
        /d01KHKt8foGVNqWFkAkgegxikuDtZmUjMsXCmwBBARGxykWm3yZlMLEFWzlXY4sV56VFwJI
        H3rtw5hqXLYjdPt2dxajn6vT6dhEJknPMPQExbWU1EyKzOHcvIXnnbzrX56EkKsK0eMjHy58
        n7HkiqoX+93U0pq6tfXXnmZlddDPNLUeHxK4N56SMrm1euGTg9SZ+qpNVNs0S59OE7N6xcHa
        SkVph2CqH/Y1P0xZltCz/dh538eE/J/l9l3Js9Zd1MZdLp1t/uM3dG3YrPQkZXStGoyxpN5f
        PLm+Sr3G+TxWWCNXPiFu0FLBzDHxmEvg/gL0xQuhwwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSnO6fom0xBoevS1qs/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBlTDqxha1gm3DF/8s3GBsYn/B3MXJySAiYSPz4
        /4Gpi5GLQ0hgN6PEtct72SASkhLTLh5l7mLkALKFJQ4fLoaoecsoMe/5B7AaYQEnibkTDzGD
        JEQEmpgkPj9sYQJJMAtESvQ/6maF6JjHJPH+6Wx2kASbgJbE/hc3wLr5BRQlrv54zAhi8wrY
        SbQdamAGsVkEVCWa5/5hAbFFBSIkzrxfwQJRIyhxcuYTMJtTwFbix6/tjBDL1CX+zLvEDGGL
        S9x6Mh/qCHmJ5q2zmScwCs9C0j4LScssJC2zkLQsYGRZxSiZWlCcm55bbFhglJdarlecmFtc
        mpeul5yfu4kRHGVaWjsYT5yIP8QowMGoxMO74ufWGCHWxLLiytxDjBIczEoivI4pW2KEeFMS
        K6tSi/Lji0pzUosPMUpzsCiJ88rnH4sUEkhPLEnNTk0tSC2CyTJxcEo1MC70tSivvKmZdOFL
        41aGyLMZciwbLcPlPF/Vnc/p6lu1r8Zltotos8ecpHk1s1XYAnxb9lY6M6T/9b0jv5UhNH+i
        YNXRV+u+SD5LX6q5Qrw38r3UgWPn9Szs0rqKRN6wLouP2vREYVNI6guVJbPED9dwWhb5Hvh7
        L64xQ+EOi8R3FZV0rbIuJZbijERDLeai4kQAqcO//a4CAAA=
X-CMS-MailID: 20190417002740epcas1p4fa9a0166e66f7acddb9ef8932daf032c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190415145707epcas3p27b7b927b14ef3c54274626c9df7cc14f
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145707epcas3p27b7b927b14ef3c54274626c9df7cc14f@epcas3p2.samsung.com>
        <20190415145505.18397-18-digetx@gmail.com>
        <203f3cbf-d825-0597-b64a-dc876743ae86@samsung.com>
        <53d0ead1-3a82-01d3-3b8a-094c1e6e34e0@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 4. 17. 오전 12:49, Dmitry Osipenko wrote:
> 16.04.2019 10:48, Chanwoo Choi пишет:
>> Hi,
>>
>> On 19. 4. 15. 오후 11:55, Dmitry Osipenko wrote:
>>> The devfreq driver can be used on Tegra30 without any code change and
>>> it works perfectly fine, the default Tegra124 parameters are good enough
>>> for Tegra30.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/devfreq/Kconfig         | 4 ++--
>>>  drivers/devfreq/tegra-devfreq.c | 1 +
>>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>>> index a78dffe603c1..78c33ddd4eea 100644
>>> --- a/drivers/devfreq/Kconfig
>>> +++ b/drivers/devfreq/Kconfig
>>> @@ -92,8 +92,8 @@ config ARM_EXYNOS_BUS_DEVFREQ
>>>  	  This does not yet operate with optimal voltages.
>>>  
>>>  config ARM_TEGRA_DEVFREQ
>>> -	tristate "Tegra DEVFREQ Driver"
>>> -	depends on ARCH_TEGRA_124_SOC
>>> +	tristate "NVIDIA Tegra30+ DEVFREQ Driver"
>>
>> Looks good to me. But, I have a question.
>>
>> 'Tegra30+' expression is enough in order to indicate
>> the support for both tegra30 and tegra124?
>>
>> In my case, it is difficult to catch the meaning
>> of which tegra30+ support the kind of tegra124.
> 
> The ACTMON serves Tegra30, Tegra124 and Tegra210 SoC's. The later Tegra generations also have the ACTMON hardware unit, but most of actual drivers have been moved into firmware on the later gens, including the ACTMON driver. I'll change the wording to "Tegra30/124/210" for clarity. Note that Tegra210 support isn't implemented at the moment by the driver, but that may change in the future.

OK. Thanks.

> 
>>> +	depends on ARCH_TEGRA
>>>  	select PM_OPP
>>>  	help
>>>  	  This adds the DEVFREQ driver for the Tegra family of SoCs.
>>> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
>>> index f0711d5ad27d..0a2465a58cf5 100644
>>> --- a/drivers/devfreq/tegra-devfreq.c
>>> +++ b/drivers/devfreq/tegra-devfreq.c
>>> @@ -719,6 +719,7 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
>>>  }
>>>  
>>>  static const struct of_device_id tegra_devfreq_of_match[] = {
>>> +	{ .compatible = "nvidia,tegra30-actmon" },
>>>  	{ .compatible = "nvidia,tegra124-actmon" },
>>>  	{ },
>>>  };
>>>
>>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>
> 
> Thanks.
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
