Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D98C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A104B2467A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="d53FeDY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfLFIBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 03:01:11 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46606 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfLFIBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 03:01:10 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191206080108euoutp019e209d4756ac2009c5dc1cdbb446b940~duWB2F_B00429004290euoutp01d
        for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2019 08:01:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191206080108euoutp019e209d4756ac2009c5dc1cdbb446b940~duWB2F_B00429004290euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575619268;
        bh=EcygHwsxTyq6TUi5duQ/Hoz6475NCD2mmpyueCxoqVg=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=d53FeDY+zHTQ3WQKUr/OBizKTraGzkXUnIARi5OAVK9eJtVLVij4xZS7d9CPQzl87
         arlfLZ0CFuZuaisPHMlk8QYBo6jZekpZw83g6T2FUbB4pOd4LKqCdvolie5xZOXjEw
         W/qVPNIHdvosXmO+4GCjV/gkrVUKsZP27vkZFkIA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191206080108eucas1p156d7c1eda564e86f0f4188891147750c~duWBrXcWA1683516835eucas1p1z;
        Fri,  6 Dec 2019 08:01:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5A.1B.61286.4CA0AED5; Fri,  6
        Dec 2019 08:01:08 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191206080108eucas1p12abaa49bcfd5b4df7d05ac904907a39b~duWBXr66F1687616876eucas1p1c;
        Fri,  6 Dec 2019 08:01:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191206080108eusmtrp16e4a5012c1dcb4e248a23c1d56c701c0~duWBXAjiV2370223702eusmtrp1q;
        Fri,  6 Dec 2019 08:01:08 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-1e-5dea0ac4cc02
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 56.C4.07950.3CA0AED5; Fri,  6
        Dec 2019 08:01:08 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191206080107eusmtip106dfe04754e29e63a27cfc84c3b0c7d2~duWA9g6DS1717117171eusmtip18;
        Fri,  6 Dec 2019 08:01:07 +0000 (GMT)
Subject: Re: [PATCH] ARM: exynos_defconfig: Bring back explicitly wanted
 options
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <08916577-3218-ecd4-a8e2-ab4fbff5332b@samsung.com>
Date:   Fri, 6 Dec 2019 09:01:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191205200006.5164-1-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7djPc7pHuF7FGmxoFbfof/ya2eL8+Q3s
        FpseX2O1uLxrDpvFjPP7mCwOv2lndWDz2LSqk81j85J6j74tqxg9Pm+SC2CJ4rJJSc3JLEst
        0rdL4Mo4cGwxY8FdwYoJC3rZGhjf8HUxcnBICJhI/Hjh1sXIxSEksIJRYtr07UwQzhdGiSsX
        rjJDOJ8ZJTadmsoC0/H5VQxEfDmjxNcrPWxdjJxAzltGiaOXBUFsYYEgiW+XD7GDFIkI9DBJ
        XJ36hgUkwSZgKNH1tgusgVfATuLLu+1gNouAisT19jeMIAtEBWIlOpZnQJQISpyc+QSslRNo
        78I9v9lBbGYBeYntb+cwQ9jiEreezAe7WkJgGbtEw++VYEUSAi4Sq/t3MUPYwhKvjm+BistI
        nJ7cwwLR0Mwo8fDcWnYIp4dR4nLTDEaIKmuJw8cvsoJcxCygKbF+lz5E2FFi/7UuaEjwSdx4
        KwhxBJ/EpG3TmSHCvBIdbUIQ1WoSs46vg1t78MIlqHM8JFZ+Wco4gVFxFpI3ZyF5bRaS12Yh
        3LCAkWUVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYKo5/e/4px2MXy8lHWIU4GBU4uGd
        8flFrBBrYllxZe4hRgkOZiUR3nS+l7FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeY0XAaUE0hNL
        UrNTUwtSi2CyTBycUg2M67emXU4NW+fhl3p5mau5ovzagxde2n/+M833m1Kg95ZZzF46RVnK
        Wre+fvB8FVC2q+7MCS7z7/LiUs8URE5yn2qLfOYzxcOvX6Sa5b3i627xZ9HLPFceD+aYn3CY
        zTT4pvfMz/seKbTXXHVzm8ucfMBzZ0+D1Z+cWWuncP+TnBYR/eK5RfN8JZbijERDLeai4kQA
        Kgp0cjEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xu7pHuF7FGlycxmTR//g1s8X58xvY
        LW41yFhsenyN1eLyrjlsFjPO72OyOPymndWB3WPTqk42j81L6j0OvtvD5NG3ZRWjx+dNcgGs
        UXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZB44t
        Ziy4K1gxYUEvWwPjG74uRg4OCQETic+vYroYuTiEBJYyStya/pCli5ETKC4jcXJaAyuELSzx
        51oXG0TRa0aJL8f2MoIkhAWCJL5dPsQOkhAR6GOSuP1uEwtEVTujxN1DN8Cq2AQMJbregrRz
        cvAK2El8ebcdzGYRUJG43v4GrEZUIFbi+8pPjBA1ghInZz4BO4MT6LyFe36zg9jMAmYS8zY/
        ZIaw5SW2v50DZYtL3Hoyn2kCo+AsJO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV5
        6XrJ+bmbGIGxte3Yzy07GLveBR9iFOBgVOLhnfH5RawQa2JZcWXuIUYJDmYlEd50vpexQrwp
        iZVVqUX58UWlOanFhxhNgZ6byCwlmpwPjPu8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6Ykl
        qdmpqQWpRTB9TBycUg2MidW8Pnyb1Ho5mA+wzDX7UbP7wu0/yQ1Ma97r8nWnerdxM2r8ZdRQ
        eMi8XzaDc2LHmltRs/cEm6pNFp8sYT5JwCjUO9FMZpPutn7Wqx1Vc86Z7nnhNVEuQuH4vjf/
        NSfrrI/ZvnAfA8uZ5lvaHI2vgvQUCsvmqcwxnzTx0tP8zI32LzbsSV6ixFKckWioxVxUnAgA
        UHoFCcMCAAA=
X-CMS-MailID: 20191206080108eucas1p12abaa49bcfd5b4df7d05ac904907a39b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191205200017epcas5p446f5f29988e34d939601287a7517fdfe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191205200017epcas5p446f5f29988e34d939601287a7517fdfe
References: <CGME20191205200017epcas5p446f5f29988e34d939601287a7517fdfe@epcas5p4.samsung.com>
        <20191205200006.5164-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzyszotof,

On 05.12.2019 21:00, Krzysztof Kozlowski wrote:
> Few options KALLSYMS_ALL, SCSI, PM_DEVFREQ and mutex/spinlock debugging
> were removed with savedefconfig because they were selected by other
> options.  However these are user-visible options and they might not be
> selected in the future.  Exactly this happened with commit 0e4a459f56c3
> ("tracing: Remove unnecessary DEBUG_FS dependency") removing the
> dependency between DEBUG_FS and TRACING.
>
> To avoid losing these options in the future, explicitly mention them in
> defconfig.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

I will not mind adding:

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

as this patch is a direct result of the discussion on my initial patch:

https://patchwork.kernel.org/patch/11260361/

and my previous findings.

> ---
>   arch/arm/configs/exynos_defconfig | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index e7e4bb5ad8d5..026407101cf2 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -38,6 +38,7 @@ CONFIG_CRYPTO_SHA256_ARM=m
>   CONFIG_CRYPTO_SHA512_ARM=m
>   CONFIG_CRYPTO_AES_ARM_BS=m
>   CONFIG_CRYPTO_CHACHA20_NEON=m
> +CONFIG_KALLSYMS_ALL=y
>   CONFIG_MODULES=y
>   CONFIG_MODULE_UNLOAD=y
>   CONFIG_PARTITION_ADVANCED=y
> @@ -92,6 +93,7 @@ CONFIG_BLK_DEV_LOOP=y
>   CONFIG_BLK_DEV_CRYPTOLOOP=y
>   CONFIG_BLK_DEV_RAM=y
>   CONFIG_BLK_DEV_RAM_SIZE=8192
> +CONFIG_SCSI=y
>   CONFIG_BLK_DEV_SD=y
>   CONFIG_CHR_DEV_SG=y
>   CONFIG_ATA=y
> @@ -291,6 +293,7 @@ CONFIG_CROS_EC_SPI=y
>   CONFIG_COMMON_CLK_MAX77686=y
>   CONFIG_COMMON_CLK_S2MPS11=y
>   CONFIG_EXYNOS_IOMMU=y
> +CONFIG_PM_DEVFREQ=y
>   CONFIG_DEVFREQ_GOV_PERFORMANCE=y
>   CONFIG_DEVFREQ_GOV_POWERSAVE=y
>   CONFIG_DEVFREQ_GOV_USERSPACE=y
> @@ -355,4 +358,7 @@ CONFIG_SOFTLOCKUP_DETECTOR=y
>   # CONFIG_DETECT_HUNG_TASK is not set
>   CONFIG_PROVE_LOCKING=y
>   CONFIG_DEBUG_ATOMIC_SLEEP=y
> +CONFIG_DEBUG_RT_MUTEXES=y
> +CONFIG_DEBUG_SPINLOCK=y
> +CONFIG_DEBUG_MUTEXES=y
>   CONFIG_DEBUG_USER=y

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

