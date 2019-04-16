Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C19C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3FE2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QZvmpqR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfDPHsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:48:01 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:29098 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbfDPHsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:48:01 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190416074759epoutp03060460623ca7b7042e08e5cf9d6f36c4~V5NvUSxCu3146431464epoutp03W
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 07:47:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190416074759epoutp03060460623ca7b7042e08e5cf9d6f36c4~V5NvUSxCu3146431464epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555400879;
        bh=mUCOfsw/4l1KxtNlMA1E4n05wbdzIV5hAVn7fm9KwJU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QZvmpqR5iGFDuc9lLLejO78/aji3Y0ZU9M+eJ78y6Ggy7G92qF9VAiG9e0km1ObDe
         qxlvNhsEPeZYNPXtpyWaWX0jYh71YCahaw4QRtIEykst2Mre1hWmouxSonK2oLqjMy
         zL95ClpoOzcNvSDM3+X1I2RSHkVpt//Jj03dVnGY=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190416074757epcas1p42ed9745e8075fe1fe091d3b03015627b~V5NtcgOSS3117031170epcas1p4o;
        Tue, 16 Apr 2019 07:47:57 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.1A.04257.AA885BC5; Tue, 16 Apr 2019 16:47:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190416074754epcas1p3086ede498759271efc1b083d9eee77ea~V5NqmF4ow0476504765epcas1p3n;
        Tue, 16 Apr 2019 07:47:54 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190416074754epsmtrp2648174caff0e3650d0b136ac803fc1a3~V5NqlRoCw1984319843epsmtrp2H;
        Tue, 16 Apr 2019 07:47:54 +0000 (GMT)
X-AuditID: b6c32a38-5e3ff700000010a1-f2-5cb588aaad0b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.60.03662.9A885BC5; Tue, 16 Apr 2019 16:47:53 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190416074753epsmtip2a1b768d20ed69cde9f140923d8af797e~V5NqZUuOj2766227662epsmtip2B;
        Tue, 16 Apr 2019 07:47:53 +0000 (GMT)
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
Message-ID: <203f3cbf-d825-0597-b64a-dc876743ae86@samsung.com>
Date:   Tue, 16 Apr 2019 16:48:48 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415145505.18397-18-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAJsWRmVeSWpSXmKPExsWy7bCmvu6qjq0xBq83y1is/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRmXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoq
        ufgE6Lpl5gAdpKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpsCzQK07MLS7NS9dL
        zs+1MjQwMDIFKkzIztj67ChzwSq+iuPfz7I1MJ7i7mLk5JAQMJFYcKadqYuRi0NIYAejxJO2
        DhYI5xOjxLzLv9hAqoQEvjFKbNpWDNPxqH8rK0TRXkaJCTu+skM47xklrl1axQhSJSzgJDF3
        4iFmkISIwD9GiU+7ZrCCJJgFIiW+HlzKDGKzCWhJ7H9xA2wFv4CixNUfj8GaeQXsJA43XwWL
        swioSixqOwZWLyoQIXH/2AZWiBpBiZMzn7CA2JwC5hI37l+Bmi8ucevJfCYIW16ieetssCMk
        BP6zSTzcuY4Z4gcXickHf0LZwhKvjm9hh7ClJD6/28sGYVdLrDx5hA2iuYNRYsv+C6wQCWOJ
        /UsnA23gANqgKbF+lz7EMj6Jd197WEHCEgK8Eh1tQhDVyhKXH9xlgrAlJRa3d0KN95B4fXoP
        8wRGxVlI3pmF5IVZSF6YhbBsASPLKkax1ILi3PTUYsMCE+To3sQITq1aFjsY95zzOcQowMGo
        xMOb0LclRog1say4MvcQowQHs5IIr2MKUIg3JbGyKrUoP76oNCe1+BCjKTC0JzJLiSbnA9N+
        Xkm8oamRsbGxhYmhmamhoZI473oH5xghgfTEktTs1NSC1CKYPiYOTqkGxnbWOUGf01+yzl77
        1vrBnK4PTyMnzH/8XCH/+zSlSL89rTNMW1e4xL47nK4krx3Qw7wxx7lm50c2WV2p7xrez5cU
        /jHTZfff1dE2T0fjTf8i34mHTFtbwto9jO24Qpy+/MoTmrrahLNjX5vCj3/q/72nnPkhaCay
        6eSRNu1DHAul1t5MC1wkqcRSnJFoqMVcVJwIAHD2W7HDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSvO7Kjq0xBjtPWlus/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBlbH12lLlgFV/F8e9n2RoYT3F3MXJySAiYSDzq
        38raxcjFISSwm1Hi7qlGJoiEpMS0i0eZuxg5gGxhicOHiyFq3jJKXH1znxGkRljASWLuxEPM
        IAkRgSYmic8PW8CamQUiJfofdUNN3cYocWXOTbAONgEtif0vbrCB2PwCihJXfzwGi/MK2Ekc
        br4KFmcRUJVY1HaMGcQWFYiQOPN+BQtEjaDEyZlPwGxOAXOJG/evsEIsU5f4M+8SM4QtLnHr
        yXyoI+QlmrfOZp7AKDwLSfssJC2zkLTMQtKygJFlFaNkakFxbnpusWGBUV5quV5xYm5xaV66
        XnJ+7iZGcJRpae1gPHEi/hCjAAejEg9vQt+WGCHWxLLiytxDjBIczEoivI4pQCHelMTKqtSi
        /Pii0pzU4kOM0hwsSuK88vnHIoUE0hNLUrNTUwtSi2CyTBycUg2MrIuDpvvbf9i4Mib+4rxD
        dw933bj1xPVahK39jnvr39/8bGbyqXZqPJO1v7DN1+tmQsf+x09eIPah8R37noudt7akrzp2
        79iV5ydt733+tbeYI33tu/f2/17sLq49tcp0Uu+/WPbs4xo3rqnob+6RVH57ftXV29uS1ou/
        ZBMOdez6XOcgIL2hTlaJpTgj0VCLuag4EQCcMkKZrgIAAA==
X-CMS-MailID: 20190416074754epcas1p3086ede498759271efc1b083d9eee77ea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190415145707epcas3p27b7b927b14ef3c54274626c9df7cc14f
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145707epcas3p27b7b927b14ef3c54274626c9df7cc14f@epcas3p2.samsung.com>
        <20190415145505.18397-18-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 4. 15. 오후 11:55, Dmitry Osipenko wrote:
> The devfreq driver can be used on Tegra30 without any code change and
> it works perfectly fine, the default Tegra124 parameters are good enough
> for Tegra30.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/Kconfig         | 4 ++--
>  drivers/devfreq/tegra-devfreq.c | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index a78dffe603c1..78c33ddd4eea 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -92,8 +92,8 @@ config ARM_EXYNOS_BUS_DEVFREQ
>  	  This does not yet operate with optimal voltages.
>  
>  config ARM_TEGRA_DEVFREQ
> -	tristate "Tegra DEVFREQ Driver"
> -	depends on ARCH_TEGRA_124_SOC
> +	tristate "NVIDIA Tegra30+ DEVFREQ Driver"

Looks good to me. But, I have a question.

'Tegra30+' expression is enough in order to indicate
the support for both tegra30 and tegra124?

In my case, it is difficult to catch the meaning
of which tegra30+ support the kind of tegra124.

> +	depends on ARCH_TEGRA
>  	select PM_OPP
>  	help
>  	  This adds the DEVFREQ driver for the Tegra family of SoCs.
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index f0711d5ad27d..0a2465a58cf5 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -719,6 +719,7 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id tegra_devfreq_of_match[] = {
> +	{ .compatible = "nvidia,tegra30-actmon" },
>  	{ .compatible = "nvidia,tegra124-actmon" },
>  	{ },
>  };
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
