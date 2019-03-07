Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF784C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF7520675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LLAENmU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfCGA6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:58:48 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:18043 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfCGA6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:58:48 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190307005845epoutp048f1f6f338aa16de410bb5e9212d79b11~Jh1BEngDB1470014700epoutp04z
        for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2019 00:58:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190307005845epoutp048f1f6f338aa16de410bb5e9212d79b11~Jh1BEngDB1470014700epoutp04z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551920325;
        bh=nwEhyaWsra4BNCfNS0VttJzozicRxypqhT/mMRXQxdM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LLAENmU5lRxy7o+JdCWpjuOeHzMfPpCQZansiQ7tnTE5v+k5DCCv7Lg3gY49/VX+V
         7XN12iQKo7YaRQGL3xH33I+X9QeXE65FBV1nsGfq8mCT5F9SdmvRyiyTn/nGtblmsI
         CHI0zUfr9HsKn7MDwsz8X20EIC3RU72ldFdxNk+c=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.158]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190307005841epcas1p2389beb3b731ddb1e2c7ef85963b2afb9~Jh0926KCV1310913109epcas1p2-;
        Thu,  7 Mar 2019 00:58:41 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.CE.04173.0CC608C5; Thu,  7 Mar 2019 09:58:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190307005840epcas1p4d6a27167393a1c9adfabc2580f466b7f~Jh08WATWo1251812518epcas1p4M;
        Thu,  7 Mar 2019 00:58:40 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190307005840epsmtrp280c806eec49d9533ede791411a392168~Jh08VN4uC2971329713epsmtrp2J;
        Thu,  7 Mar 2019 00:58:40 +0000 (GMT)
X-AuditID: b6c32a36-5c1ff7000000104d-66-5c806cc0ed4d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.75.03601.0CC608C5; Thu,  7 Mar 2019 09:58:40 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190307005840epsmtip13852b9ec4f1c3797cb33ab803f4e8268~Jh08MOJdg2301023010epsmtip1S;
        Thu,  7 Mar 2019 00:58:40 +0000 (GMT)
Subject: Re: [PATCH] extcon-ptn5150: fix COMPILE_TEST dependencies
To:     Arnd Bergmann <arnd@arndb.de>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <24376645-b7e6-ee6e-5d77-a91fa62bbc00@samsung.com>
Date:   Thu, 7 Mar 2019 09:58:40 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190306110906.2622957-1-arnd@arndb.de>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmnu6BnIYYg4ddqhZ/Jx1jt7i8aw6b
        xe3GFWwWL/dPZ3Vg8fj9axKjx85Zd9k9+rasYvT4vEkugCUq2yYjNTEltUghNS85PyUzL91W
        yTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKWSQlliTilQKCCxuFhJ386mKL+0JFUh
        I7+4xFYptSAlp8CyQK84Mbe4NC9dLzk/18rQwMDIFKgwITujZ/cFtoLbvBVTjk1gbWB8w9XF
        yMkhIWAiMWdTK0sXIxeHkMAORoldP+ezQjifGCWuvZ3HDuF8Y5TY8rCVuYuRA6xl9xlTiPhe
        RonLPzYzQzjvGSX+r+9mBJkrLOAk0f94IpgtIuAlMfPdVHYQm1kgRGLGmcVsIDabgJbE/hc3
        wGx+AUWJqz8eg9XzCthJrJl3FqyeRUBFYk77XFYQW1QgQuL9090sEDWCEidnPgGzOQVMJXY/
        PcQMMV9c4taT+UwQtrxE89bZYMdJCJxhk/j3cTE7xNMuEg+adkHZwhKvjm+BsqUkPr/bywZh
        V0usPHmEDaK5A+j9/RdYIRLGEvuXTmYCBQWzgKbE+l36EMv4JN597WGFhBCvREebEES1ssTl
        B3eZIGxJicXtnVDjPST2fZnANoFRcRaSd2YheWEWkhdmISxbwMiyilEstaA4Nz212LDACDm2
        NzGCk6OW2Q7GRed8DjEKcDAq8fBGnK6PEWJNLCuuzD3EKMHBrCTCq5jRECPEm5JYWZValB9f
        VJqTWnyI0RQY2hOZpUST84GJO68k3tDUyNjY2MLE0MzU0FBJnHe9g3OMkEB6YklqdmpqQWoR
        TB8TB6dUA+Ou3ti++WmFm+xO+x/+a/L1/cXoChOpV9GvZU82H9zE4Mf96dCmmzHJcQ9v7yv4
        evx8SdmR4IX7RJL/5lgGrubpOHYv4kJzXdOxTub/D/dcvDMhOsxx1VK3ny9aK64d0ovsSXqg
        nBxYIf81bf3WnfdD2XmezGk0XHGWVaHgRXTKy7bNFS6VqpFKLMUZiYZazEXFiQD8ABEgpAMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSnO6BnIYYg5t/+S3+TjrGbnF51xw2
        i9uNK9gsXu6fzurA4vH71yRGj52z7rJ79G1ZxejxeZNcAEsUl01Kak5mWWqRvl0CV0bP7gts
        Bbd5K6Ycm8DawPiGq4uRg0NCwERi9xnTLkYuDiGB3YwSDQc/snYxcgLFJSWmXTzKDFEjLHH4
        cDFEzVtGia1f7rCD1AgLOEn0P57ICGKLCHhJzHw3FSzOLBAi0X3lOCNEQwejxIu7X8GK2AS0
        JPa/uMEGYvMLKEpc/fEYLM4rYCexZt5ZsGYWARWJOe1zwY4QFYiQuHvxBQtEjaDEyZlPwGxO
        AVOJ3U8PMUMsU5f4M+8SlC0ucevJfCYIW16ieets5gmMwrOQtM9C0jILScssJC0LGFlWMUqm
        FhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIER4mW1g7GEyfiDzEKcDAq8fBGnK6PEWJNLCuu
        zD3EKMHBrCTCq5jRECPEm5JYWZValB9fVJqTWnyIUZqDRUmcVz7/WKSQQHpiSWp2ampBahFM
        lomDU6qBUbGzLGBOXfr5X5sd7K+IrFP6bXH41luvpu9rav99nbPr5aPf33bN9N2wcMnbO8oP
        G97NnOXzdTKvl2CO1Utvv/M2qdXpvP/Ete8JWbTvvPJsqipXt+0lnx/KUxsvW5zozPRJ1mc8
        5rVDqP3JBINlqmt8lMrtOtJlrmknSrOl/Fbutl/7VCFNSImlOCPRUIu5qDgRAE00hiaOAgAA
X-CMS-MailID: 20190307005840epcas1p4d6a27167393a1c9adfabc2580f466b7f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190306110913epcas4p1a346e77b3523020d04ee385b5eac80e9
References: <CGME20190306110913epcas4p1a346e77b3523020d04ee385b5eac80e9@epcas4p1.samsung.com>
        <20190306110906.2622957-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 3. 6. 오후 8:08, Arnd Bergmann wrote:
> The PTN5150 dependencies look like they were meant to do the
> right thing, but they actually should not allow building without
> I2C for compile testing, as that results in a Kconfig warning
> and subsequent build failure:
> 
> WARNING: unmet direct dependencies detected for REGMAP_I2C
>   Depends on [m]: I2C [=m]
>   Selected by [y]:
>   - EXTCON_PTN5150 [=y] && EXTCON [=y] && (I2C [=m] && GPIOLIB [=y] || COMPILE_TEST [=y])
>   Selected by [m]:
>   - EEPROM_AT24 [=m] && I2C [=m] && SYSFS [=y]
>   - KEYBOARD_CAP11XX [=m] && !UML && INPUT [=y] && INPUT_KEYBOARD [=y] && OF [=y] && I2C [=m]
>   - INPUT_DRV260X_HAPTICS [=m] && !UML && INPUT_MISC [=y] && INPUT [=y] && I2C [=m] && (GPIOLIB [=y] || COMPILE_TEST [=y])
>   - ... [many others]
> 
> Add parentheses around the expression so we can compile-test
> without GPIOLIB but not without I2C.
> 
> Fixes: 4ed754de2d66 ("extcon: Add support for ptn5150 extcon driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/extcon/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index 8e17149655f0..540e8cd16ee6 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -116,7 +116,7 @@ config EXTCON_PALMAS
>  
>  config EXTCON_PTN5150
>  	tristate "NXP PTN5150 CC LOGIC USB EXTCON support"
> -	depends on I2C && GPIOLIB || COMPILE_TEST
> +	depends on I2C && (GPIOLIB || COMPILE_TEST)
>  	select REGMAP_I2C
>  	help
>  	  Say Y here to enable support for USB peripheral and USB host
> 

Applied it to extcon-fixes branch for v5.0-rc2.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
