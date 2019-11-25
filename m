Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D036C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E29520740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SrjUydCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfKYOap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:30:45 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47587 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbfKYOap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:30:45 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191125143042euoutp018e6a643b21f8429d02e7eab5212db2a7~abkB5XFRx0115901159euoutp01n
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 14:30:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191125143042euoutp018e6a643b21f8429d02e7eab5212db2a7~abkB5XFRx0115901159euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574692242;
        bh=ZChMOgIHLEnNOY4NNVPrYG8C83I/sXPFP/0oqDp+8Xw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SrjUydCvgqWZFkck5xn3iIA1/dr3Vi7TB6zVLy49abaHtaFVbDDiYLo0KetnRv6dw
         Hvc7rEBotPDrn0wy4syoaedgtN2+9LG4XKHKjoKAOAIop/CUW1NUR5BcIOrPPGEZV9
         1CUjFQOAetSF+1ZifdN9/OxV1h3fSq8Q6bq3KkbU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191125143042eucas1p2abfeb945dd9dcab62ba32796ee0652ed~abkBsjcJ-1853018530eucas1p2J;
        Mon, 25 Nov 2019 14:30:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 57.95.61286.295EBDD5; Mon, 25
        Nov 2019 14:30:42 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191125143042eucas1p17520800862c01c94da1a25dd30499f37~abkBXE0gc1826918269eucas1p14;
        Mon, 25 Nov 2019 14:30:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191125143042eusmtrp149945470fb5787f16e5f5657e50d7b83~abkBUObOL2840228402eusmtrp14;
        Mon, 25 Nov 2019 14:30:42 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-5b-5ddbe592dfa8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F4.48.07950.295EBDD5; Mon, 25
        Nov 2019 14:30:42 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191125143041eusmtip137c3adc4ec8e536202e98eea2305cea5~abkA-Sdyo2945329453eusmtip1J;
        Mon, 25 Nov 2019 14:30:41 +0000 (GMT)
Subject: Re: [PATCH] arm: exynos_config: Restore debugfs support
To:     Kusanagi Kouichi <slash@ac.auone-net.jp>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <7f6a5924-58f9-aafb-18c5-c749ad355a02@samsung.com>
Date:   Mon, 25 Nov 2019 15:30:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191125125515.30795-1-m.szyprowski@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djPc7qTnt6ONXiySMPi/PkN7BaXd81h
        s5hxfh+Txdojd9kt9nU8YLJ4/uosswObx4pFe9k9WvbdYvfYtKqTzaNvyypGj8+b5AJYo7hs
        UlJzMstSi/TtErgyLrduYCn4z10x+20jYwNjM1cXIyeHhICJxMbuX+xdjFwcQgIrGCU2/TzO
        CuF8YZRY2H2SCaRKSOAzo8TpJYYwHQ9WPWCDKFrOKHGx8xIjhPOWUeLR309gHcICDhIPOpcz
        g9giAjoS6xq/MILYzAIHGSV2HNEBsdkErCQmtq8Ci/MK2Ems23yPBcRmEVCV2PbjKhuILSoQ
        IfHpwWFWiBpBiZMzn4DVcALVz215zwoxU1zi1pP5TBC2vMT2t3OYIS7dxC7R+K0QwnaR2Dz9
        DCOELSzx6vgWdghbRuL05B4WkAckBNYxSvzteMEM4WxnlFg++R8bRJW1xOHjF4G2cQBt0JRY
        v0sfIuwocexiE1hYQoBP4sZbQYgb+CQmbZvODBHmlehoE4KoVpPYsGwDG8zarp0rmScwKs1C
        8tksJN/MQvLNLIS9CxhZVjGKp5YW56anFhvmpZbrFSfmFpfmpesl5+duYgQmntP/jn/awfj1
        UtIhRgEORiUe3h9nb8cKsSaWFVfmHmKU4GBWEuF1O3sjVog3JbGyKrUoP76oNCe1+BCjNAeL
        kjhvNcODaCGB9MSS1OzU1ILUIpgsEwenVAOjX+ISoa9BU6v17qfductXJqy6aOue/3/qllVI
        bWXRUK1gz6qMK8mbmcD1NDvj/tvMH+q7RLUu+POrnDjftFHxxJkKRwfDWzGM0l9rNq59Yi57
        J0bgoFzWkrKe9RlTpI1cT+W/8G20dBOdGMt+dV/XZt309dsUlefPn7xri//liqNmcn7xv+8r
        sRRnJBpqMRcVJwIAZCVKIzgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xu7qTnt6ONfh1i9/i/PkN7BaXd81h
        s5hxfh+Txdojd9kt9nU8YLJ4/uosswObx4pFe9k9WvbdYvfYtKqTzaNvyypGj8+b5AJYo/Rs
        ivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyLrduYCn4
        z10x+20jYwNjM1cXIyeHhICJxINVD9hAbCGBpYwSGxpjuxg5gOIyEsfXl0GUCEv8udYFVMIF
        VPKaUWLvwj4mkISwgIPEg87lzCC2iICOxLrGL4wgRcwCBxklDh3pZYXomMgo8WLDGkaQKjYB
        K4mJ7avAbF4BO4l1m++xgNgsAqoS235cBbtCVCBC4vCOWVA1ghInZz4Bq+EEqp/b8p4VxGYW
        UJf4M+8SM4QtLnHryXwmCFteYvvbOcwTGIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbS
        K07MLS7NS9dLzs/dxAiMtW3Hfm7Zwdj1LvgQowAHoxIP74+zt2OFWBPLiitzDzFKcDArifC6
        nb0RK8SbklhZlVqUH19UmpNafIjRFOi5icxSosn5wDSQVxJvaGpobmFpaG5sbmxmoSTO2yFw
        MEZIID2xJDU7NbUgtQimj4mDU6qBceWrA/ESrsZ1WQzzqmQmznFkm2242y42ZtncFx2574sT
        Vk+6v2D7lhMLwv4LGxtN365/YPr1uklBN7jjzx/+3fjvw7R4542HPZ1cLeqeXFr288PSzmnm
        mY7BM8s+mD4xXci87tHlmI8bklem3X+YFdK3aOPJGcs69/V9evL7juzpdVf4LY326L5RYinO
        SDTUYi4qTgQATFU/ecsCAAA=
X-CMS-MailID: 20191125143042eucas1p17520800862c01c94da1a25dd30499f37
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191125125531eucas1p17f4044301903eeafe56865ed63738798
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191125125531eucas1p17f4044301903eeafe56865ed63738798
References: <CGME20191125125531eucas1p17f4044301903eeafe56865ed63738798@eucas1p1.samsung.com>
        <20191125125515.30795-1-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 11/25/19 1:55 PM, Marek Szyprowski wrote:
> Commit 0e4a459f56c3 ("tracing: Remove unnecessary DEBUG_FS dependency")
> removed the dependency between DEBUG_FS and TRACING, so DEBUG_FS is no
> longer enabled in default builds. Enable it again manually, as it provides
> a lots of useful data for automated testing tools.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/configs/exynos_defconfig | 1 +
>  1 file changed, 1 insertion(+)

It seems that commit 0e4a459f56c3 ("tracing: Remove unnecessary DEBUG_FS
dependency") disabled DEBUG_FS also in some other ARM defconfigs.

For some of them it may be a correct change but a preferred way to
introduce such changes would be to:

- add explicit CONFIG_DEBUG_FS=y instances to all affected defconfigs
  while removing DEBUG_FS selection from TRACING config item

- let platform maintainers disable DEBUG_FS manually in corresponding
  defconfigs later if desirable

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index e7e4bb5ad8d5..fde84f123fbb 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -350,6 +350,7 @@ CONFIG_PRINTK_TIME=y
>  CONFIG_DYNAMIC_DEBUG=y
>  CONFIG_DEBUG_INFO=y
>  CONFIG_MAGIC_SYSRQ=y
> +CONFIG_DEBUG_FS=y
>  CONFIG_DEBUG_KERNEL=y
>  CONFIG_SOFTLOCKUP_DETECTOR=y
>  # CONFIG_DETECT_HUNG_TASK is not set
