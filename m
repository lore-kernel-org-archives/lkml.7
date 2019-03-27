Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CDEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC5F2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iX3q+S3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfC0ONn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:13:43 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41130 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfC0ONn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:13:43 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190327141341euoutp020844e76caf6e22af89c657393a4e3332~P1ky5M5EU0571105711euoutp02V
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 14:13:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190327141341euoutp020844e76caf6e22af89c657393a4e3332~P1ky5M5EU0571105711euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1553696021;
        bh=8YjBP2EQ9XgQkylcabp6C67qA7HwpE0jcoo3d0MvC1I=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=iX3q+S3y3tYNTbVJDgoLJvTzyAFV49pNwPmvzhvxrBAt7XlhWwJVSpPlgrtt8fbXM
         OpaJMID3j1L4KfyL+qefN3OTyN2Ndf5QyHgPLHGH+MpgfH3ndpu8+b5pNZjVmLtFu4
         qGELsoc15HWbH9+GSXFBItsjQ1N7nq7oH6bF0fqE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190327141340eucas1p265e98ef970ae13fb34910415472337d4~P1kyNitKp0799307993eucas1p2m;
        Wed, 27 Mar 2019 14:13:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 2F.1A.04377.4158B9C5; Wed, 27
        Mar 2019 14:13:40 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190327141339eucas1p2ab64c1eb8e56a2697a315e46948a8187~P1kxc3Jz30799307993eucas1p2l;
        Wed, 27 Mar 2019 14:13:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190327141339eusmtrp225db6a5d8027092ae98bbb9ea8c69fd9~P1kxOxGjI1760617606eusmtrp2-;
        Wed, 27 Mar 2019 14:13:39 +0000 (GMT)
X-AuditID: cbfec7f4-5632c9c000001119-0d-5c9b8514a2f0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 48.1B.04146.3158B9C5; Wed, 27
        Mar 2019 14:13:39 +0000 (GMT)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190327141339eusmtip205df072fa74b8a0b197f5e31a39b4b8e~P1kwmMrwf1145011450eusmtip2U;
        Wed, 27 Mar 2019 14:13:38 +0000 (GMT)
Subject: Re: [PATCH v3 1/4] drm/bridge: sil_sii8620: depend on INPUT instead
 of selecting it.
To:     =?UTF-8?Q?Ronald_Tschal=c3=a4r?= <ronald@innovation.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Inki Dae <inki.dae@samsung.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <9fd8af5b-20ed-5dca-7d5c-98f2926b9b0c@samsung.com>
Date:   Wed, 27 Mar 2019 15:13:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190327014807.7472-2-ronald@innovation.ch>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SeyxVcRzvd8+55x53jn4u8iXrcac/akNaf5wK1WbrrK1Vq7WG0ZUzj1yP
        e6NkK3HjyphMHle5LSUsNK7HVdxG5RFitYbl0dIyTa+LMiHXYfnv8/g+Pt/tSxOyb2JnOjzq
        Iq+KUkTKKSlZ/2rujZv9jaKA3UPVwGYm54vYtvsTiH03851iu2YWKDalpJpic0azSXbw16yY
        fdt0h2Invmxm707fJtiJkSkR26IdE7Eds3kittL8SXLIhjNXTIo5o25YwmlahiRcbjpwNRXp
        FFfceZIz3X0s4UYz2kVclqECcc0jBpIz12zhCtLqxSes/aReIXxkeDyv8vA5Jw1rHu4Vx3Tb
        Xc5L66aSkBbfRFY04L1gmM0nbyIpLcNlCPobcsUCmV4m76cpgZgRVBkWqbWW/Lyx1ZZHCHL0
        HYRAphA0lqUiS5UdDgJNf7PIYtjjJAKSJ/NWDAL/RvDl5wkLpvBOWKgdXB5L0wz2AeNkhEUm
        8Q4YMOklFuyAz8L3z09JC2awLXQWjq9gK7wPsopzSWHkVkipKyIE7AhD4/qVvYALaSht+rEa
        2xf0H00iAdvBZLtBImAXWDLqV/VrMFqmIYRmLYK6J0ZCMA5AW3u/2BKUWA5d3eQhyIeh+EE5
        aZEB28DAlK2QwQZy6vMJQWZAmyoTqrfDaE/d6kBHeNg3Q2UjuW7dZbp11+jWXaP7v/ceIiuQ
        Ix+nVoby6j1R/CV3tUKpjosKdT8fraxBy1/4erF9uhE1/Q1uRZhGcmtmW3RRgEysiFcnKFsR
        0ITcnhl3KAiQMSGKhCu8KjpIFRfJq1vRZpqUOzKJG8b8ZThUcZG/wPMxvGrNFdFWzknIJ6HL
        VaOPP+MU+LLBtch4bCm9Ids7sCOjQzqMnjNDDW7a07EpH7wj5o/HzPc7134dOThiXd5TWZm8
        xUlpJq6W3JrfVLvROHA9I9Eq1lOTc2SwLtG8pHcx+Raf2h98JfPJXG9WadUB05Kfl+3RWzPP
        GP/ageHmxKBzf/pebPiM7Tg5qQ5TeO4iVGrFP1Q9KNaBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42I5/e/4PV3h1tkxBkfnq1j0Nk1nsji86AWj
        xZWv79ksTn39y2bRvHg9m8Wk+xNYLG5++sZqcXnXHDaLF8+lLeZ+mcps8eLeWyaLfR0PmCxO
        fJvGZLH282N2Bz6Pz6tesXrsnHWX3aNl3y12jymdEh6bVnWyecw7Geixf+4ado/73ceZPPq2
        rGL02HtvC4vH501yHjPat7EG8ETp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZ
        Kunb2aSk5mSWpRbp2yXoZey9e4614IxwxbT2M2wNjB0CXYycHBICJhLTpz1g6WLk4hASWMoo
        8aLnFTNEQlxi9/y3ULawxJ9rXWwQRa8ZJWZt/skIkhAWiJdoubiXCSQhItDCLHHv2wdGEIdZ
        4DujxJ+jfVAtuxklDt9pAGthE9CU+Lv5JlCCg4NXwE5i56sskDCLgKrEjf3z2UFsUYEIibsX
        X7CA2LwCghInZz4BszkFLCX65k0Bs5kF1CX+zLvEDGHLSzRvnQ1li0vcejKfaQKj0Cwk7bOQ
        tMxC0jILScsCRpZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgfG/7djPzTsYL20MPsQowMGo
        xMOrkD87Rog1say4MvcQowQHs5II7xPRGTFCvCmJlVWpRfnxRaU5qcWHGE2BnpvILCWanA9M
        TXkl8YamhuYWlobmxubGZhZK4rznDSqjhATSE0tSs1NTC1KLYPqYODilGhgX3I5b9ZoxR3Fj
        U3CX/JlHF8uZugtVOXd94T7PGS/WeO9m+BZW0dOK0rLq65kE7gvGcqiU8/X1Ms6/L7q8674s
        8zWlaof5n057nyiMiONeMNHlz3uJ18/Uv82c+vKaeazr8kiv8H9Fx28+ftQulClYuX/vTImw
        FZ/OrN3fEPK95/CPlbvqmMWVWIozEg21mIuKEwFnXrCIFQMAAA==
X-CMS-MailID: 20190327141339eucas1p2ab64c1eb8e56a2697a315e46948a8187
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190327014824epcas2p1f79a41c58f76150f7324169805f506f0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190327014824epcas2p1f79a41c58f76150f7324169805f506f0
References: <20190327014807.7472-1-ronald@innovation.ch>
        <CGME20190327014824epcas2p1f79a41c58f76150f7324169805f506f0@epcas2p1.samsung.com>
        <20190327014807.7472-2-ronald@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc: dri-devel

On 27.03.2019 02:48, Ronald Tschalär wrote:
> commit d6abe6df706c66d803e6dd4fe98c1b6b7f125a56 (drm/bridge:
> sil_sii8620: do not have a dependency of RC_CORE) added a dependency on
> INPUT. However, this causes problems with other drivers, in particular
> an input driver that depends on MFD_INTEL_LPSS_PCI (to be added in a
> future commit):
>
>   drivers/clk/Kconfig:9:error: recursive dependency detected!
>   drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MFD_INTEL_LPSS
>   drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected by MFD_INTEL_LPSS_PCI
>   drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implied by KEYBOARD_APPLESPI
>   drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI depends on INPUT
>   drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL_SII8620
>   drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depends on DRM_BRIDGE
>   drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is selected by DRM_PL111
>   drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on COMMON_CLK
>
> According to the docs, select should only be used for non-visible
> symbols. Furthermore almost all other references to INPUT throughout the
> kernel config are depends, not selects. Hence this change.
>
> CC: Inki Dae <inki.dae@samsung.com>
> CC: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>


This is drm bridge driver, next time please cc it to dri-devel ML also.

Anyway this is not the solution we have agreed to.

Why have you abandoned the patch [1]? It needed just some minor
polishing, as I wrote in response to this mail.


[1]:
https://lore.kernel.org/lkml/20190124082423.23139-1-ronald@innovation.ch/T/#mf620df0b1583096a214d8e2e690387078583472f


Regards

Andrzej


> ---
>  drivers/gpu/drm/bridge/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 2fee47b0d50b..eabedc83f25c 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -83,9 +83,9 @@ config DRM_PARADE_PS8622
>  config DRM_SIL_SII8620
>  	tristate "Silicon Image SII8620 HDMI/MHL bridge"
>  	depends on OF
> +	depends on INPUT
>  	select DRM_KMS_HELPER
>  	imply EXTCON
> -	select INPUT
>  	select RC_CORE
>  	help
>  	  Silicon Image SII8620 HDMI/MHL bridge chip driver.


