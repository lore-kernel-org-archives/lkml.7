Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9992C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F09E2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WBigNEzJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbfDPHnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:43:03 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:50095 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPHnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:43:02 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190416074259epoutp01f77f81ffc7bcbbfe38b4c9da0d664f5f~V5JYMt3h52068420684epoutp014
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 07:42:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190416074259epoutp01f77f81ffc7bcbbfe38b4c9da0d664f5f~V5JYMt3h52068420684epoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555400579;
        bh=kPHTnWTD1IjGbJFuaA1eHJsTziiU0q/Ml4+LbSF9wBU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WBigNEzJ0RiRyqURZe2aZICmqPuXocq16NX/4o9BxIY1hsxsVMqEas5AUQw7lYBSh
         3YRcGkFVAGfzszKOjJGMrUDUTwiWc1RTgiyD6Me8vjjZ92bbpu/DhYXv+dchYj8spt
         OMtdNdz5414FYeOnE9NSBfs5dfF+vXtzUuTlrjjo=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.157]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190416074254epcas1p4c5b727c06c79ae1a73e1ec642a84451f~V5JTy9eQV1754017540epcas1p4M;
        Tue, 16 Apr 2019 07:42:54 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.7F.04142.E7785BC5; Tue, 16 Apr 2019 16:42:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190416074254epcas1p36c8f4d1f1cb435a9cc07340373744f91~V5JTZBGM41321713217epcas1p3E;
        Tue, 16 Apr 2019 07:42:54 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190416074254epsmtrp235d89f280fde2cc7f590213020dc7bac~V5JTYS-0j1822018220epsmtrp2D;
        Tue, 16 Apr 2019 07:42:54 +0000 (GMT)
X-AuditID: b6c32a36-ce1ff7000000102e-ef-5cb5877ec5a3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.20.03662.E7785BC5; Tue, 16 Apr 2019 16:42:54 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190416074254epsmtip2844d0408abe702c017e865fefcaee7c3~V5JTNQvJB3033930339epsmtip2M;
        Tue, 16 Apr 2019 07:42:54 +0000 (GMT)
Subject: Re: [PATCH v2 18/19] PM / devfreq: tegra: Enable COMPILE_TEST for
 the driver
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
Message-ID: <8d8c55b8-b4aa-e072-7c5f-0b1e5e883031@samsung.com>
Date:   Tue, 16 Apr 2019 16:43:48 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415145505.18397-19-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmvm5d+9YYg94PaharPz5mtGiZtYjF
        4mzTG3aLy7vmsFl87j3CaNH5ZRabxe3GFWwWP3fNY7HoW3uJzYHTY8fdJYweO2fdZffobX7H
        5tG3ZRWjx+dNcgGsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZK
        Lj4Bum6ZOUAHKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKLAv0ihNzi0vz0vWS
        83OtDA0MjEyBChOyM2bO+8xY8IC94uzyiSwNjHPZuhg5OSQETCTOdbYwdjFycQgJ7GCUaJw1
        lwnC+cQo8fjoNmYI5xujxNGLn5hgWtY/Xc0OkdjLKPH3zTUo5z2jxMOjd4CqODiEBcIl+q5G
        gMRFBP4xSnzaNYMVpJtZIFLi68GlzCA2m4CWxP4XN8AO4RdQlLj64zEjSC+vgJ3Em+Z4kDCL
        gKrEgXkdjCC2qECExP1jG8DG8AoISpyc+YQFxOYUMJf4f/ccI8R4cYlbT+YzQdjyEs1bZ4N9
        ICHQzC7RfuI9M8QHLhJ3DzVBA0BY4tXxLewQtpTE53d7oeLVEitPHmGDaO5glNiy/wIrRMJY
        Yv/SyWBPMgtoSqzfpQ+xjE/i3dceVpCwhACvREebEES1ssTlB3ehAScpsbi9E2q8h8TLQ33M
        ExgVZyF5ZxaSF2YheWEWwrIFjCyrGMVSC4pz01OLDQuMkGN7EyM4sWqZ7WBcdM7nEKMAB6MS
        Dy9Hz5YYIdbEsuLK3EOMEhzMSiK8jilAId6UxMqq1KL8+KLSnNTiQ4ymwNCeyCwlmpwPTPp5
        JfGGpkbGxsYWJoZmpoaGSuK86x2cY4QE0hNLUrNTUwtSi2D6mDg4pRoYYx2CT/yR7VfY0laX
        vVD8mPljvV88tmkTzE9stkzskrq2uPWFvGeq/BH2nhQ1Xu9+fdUHS641Ca4J//x+s+gJg+Wd
        vck6iwReJxcUR24N6bVJV7a6czVuibje9Pl39I9FX/8pfELGdf+ZB8nJPmcXX9O5mXPk2TL2
        wG4xnbPzTKfm62l0+uYpsRRnJBpqMRcVJwIA3EDEVMIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSvG5d+9YYg+3feSxWf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyZs77zFjwgL3i7PKJLA2Mc9m6GDk5JARMJNY/
        Xc3excjFISSwm1Hi/P15TBAJSYlpF48ydzFyANnCEocPF4OEhQTeMkpceKoBYgsLhEvcu/CX
        FaRXRKCJSeLzwxawXmaBSIn+R92sEEO3MUr8e7eSHSTBJqAlsf/FDbDN/AKKEld/PGYEWcAr
        YCfxpjkeJMwioCpxYF4HI4gtKhAhceb9ChYQm1dAUOLkzCdgNqeAucT/u+cYIXapS/yZd4kZ
        whaXuPVkPtQN8hLNW2czT2AUnoWkfRaSlllIWmYhaVnAyLKKUTK1oDg3PbfYsMAoL7Vcrzgx
        t7g0L10vOT93EyM4wrS0djCeOBF/iFGAg1GJhzehb0uMEGtiWXFl7iFGCQ5mJRFexxSgEG9K
        YmVValF+fFFpTmrxIUZpDhYlcV75/GORQgLpiSWp2ampBalFMFkmDk6pBkbW2LUTyope7Vi8
        qlpjYvTHs33XC+dGOHjMUbkvFZDj2pIY+mDigwDFvT3MJ258ODlDty86v23qrNC6nZ9dT/wK
        muv862TRscsWt/VF8mznTS7V+a5cwf+f9dKxqg956fxTAl4r7Pg/y3nzk+TUBt+/3IzXzZjk
        bxrWsfhNuz31pV57hPyut4uVWIozEg21mIuKEwHxx/fqrAIAAA==
X-CMS-MailID: 20190416074254epcas1p36c8f4d1f1cb435a9cc07340373744f91
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190415145614epcas4p494a515b20cd351e220ac4eb37c05b7fb
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145614epcas4p494a515b20cd351e220ac4eb37c05b7fb@epcas4p4.samsung.com>
        <20190415145505.18397-19-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 4. 15. 오후 11:55, Dmitry Osipenko wrote:
> The driver's compilation doesn't have any specific dependencies, hence
> the COMPILE_TEST option can be supported in Kconfig.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 78c33ddd4eea..bd6652863e7d 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -93,7 +93,7 @@ config ARM_EXYNOS_BUS_DEVFREQ
>  
>  config ARM_TEGRA_DEVFREQ
>  	tristate "NVIDIA Tegra30+ DEVFREQ Driver"
> -	depends on ARCH_TEGRA
> +	depends on ARCH_TEGRA || COMPILE_TEST
>  	select PM_OPP
>  	help
>  	  This adds the DEVFREQ driver for the Tegra family of SoCs.
> 

I think that it doesn't need to make it a separate patch.
You can merge this patch to patch17 and then drop this patch.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
