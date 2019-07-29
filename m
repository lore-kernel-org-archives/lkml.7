Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04291C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 01:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87D32070B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 01:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="A3+kEApp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfG2BWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 21:22:52 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:48284 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfG2BWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 21:22:52 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190729012248epoutp04d8807da538a4ef5c084580802bd936f3~1vDH6DQM22747627476epoutp04y
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 01:22:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190729012248epoutp04d8807da538a4ef5c084580802bd936f3~1vDH6DQM22747627476epoutp04y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564363368;
        bh=7nRHgCPiqghLB/3Lv2RJ4KgCd8OSyKlqtd5fFhfhjwA=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=A3+kEAppLRGodSI70jCWsvM1Bus8pdebf/bYiXxd753+Pg2bIP1nQPqItRA9iv3xa
         l4Nb0ZB2BVd0BsixxNUeBTORMlrZ40ZHC2z3l2peny+x7MkOtlQPmwhOeIZEi33MDs
         2DEN8X/zIGC3IGpcJnKz5Z3xqJFPx3afV5jJCMRs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190729012248epcas1p3b9dabd6dc702b2fa44c7815d818f3816~1vDHl7jrT3103131031epcas1p3I;
        Mon, 29 Jul 2019 01:22:48 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 45xhkh0KgxzMqYkl; Mon, 29 Jul
        2019 01:22:36 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.E3.04075.23A4E3D5; Mon, 29 Jul 2019 10:21:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190729012153epcas1p18118c737bc7f641dfe515846bc6a13dd~1vCVLakGD1907219072epcas1p1K;
        Mon, 29 Jul 2019 01:21:53 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190729012153epsmtrp1df2a9c5aed2cf44f3eb2c80b3ed399b7~1vCVKxqBc2310823108epsmtrp1q;
        Mon, 29 Jul 2019 01:21:53 +0000 (GMT)
X-AuditID: b6c32a36-b61ff70000000feb-7d-5d3e4a32e574
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.51.03638.13A4E3D5; Mon, 29 Jul 2019 10:21:53 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190729012153epsmtip1b0254d56e3ffd8b5af743f3eca5406d8~1vCVD8baV3226732267epsmtip1c;
        Mon, 29 Jul 2019 01:21:53 +0000 (GMT)
Subject: Re: [PATCH v2 2/2] extcon: axp288: Use for_each_set_bit() in
 axp288_extcon_log_rsi()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <0454e9cd-e2fb-cb60-11c3-19bc0233ae03@samsung.com>
Date:   Mon, 29 Jul 2019 10:25:19 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726121820.69679-2-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmrq6Rl12swYEWJYvepulMFm+OA4nL
        u+awWdxuXMFm8fPQeSYHVo8Nj1azesw7Gejxft9VNo++LasYPT5vkgtgjcq2yUhNTEktUkjN
        S85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHaraRQlphTChQKSCwuVtK3
        synKLy1JVcjILy6xVUotSMkpsCzQK07MLS7NS9dLzs+1MjQwMDIFKkzIzji1aBNzwXT+ih/T
        axsYF/N0MXJySAiYSGx+PIWli5GLQ0hgB6PE/5+zoZxPjBKTJh1mhXC+MUr03/7JAtOy7PQ9
        ZojEXkaJ0/d+QDnvGSU2nrkPViUsEC+x5+ojsHYRgaOMEju+vWYGSbAJaEnsf3GDDcTmF1CU
        uPrjMSOIzStgJ/FgKcg+Tg4WAVWJL1eXgQ0SFYiQ+PQAIs4rIChxcuYTsDingLvEvSUrweLM
        AuISt57MZ4Kw5SWat84Gu0hC4DKbxLdLu4EaOIAcF4n7L6IgXhCWeHV8CzuELSXxsr8Nyq6W
        WHnyCBtEbwejxJb9F1ghEsYS+5dOZgKZwyygKbF+lz5EWFFi5++5jBB7+STefe1hhVjFK9HR
        JgRRoixx+cFdJghbUmJxeycbhO0h0bdlG/MERsVZSD6bheSbWUi+mYWweAEjyypGsdSC4tz0
        1GLDAiPk2N7ECE6XWmY7GBed8znEKMDBqMTD63DTNlaINbGsuDL3EKMEB7OSCO8WJetYId6U
        xMqq1KL8+KLSnNTiQ4ymwICfyCwlmpwPTOV5JfGGpkbGxsYWJoZmpoaGSuK8C39YxAoJpCeW
        pGanphakFsH0MXFwSjUwNt3t2vz9rL7KugeJ+TE87Qu/rN0lPnWm8Np3JQ8Peuu1+RQx/8rf
        6XjB9pXXmp4CgU9rf6+1+vviu3TuItlPV9ifLGJjjXpsKfao/OPrFO2/Geradit1TpbNfdGR
        1GU/8+Lyvp9Cx94YuS5uX1D6Tf/ODfvEZcaPzdUubFMJfDejzSzBMXFrlhJLcUaioRZzUXEi
        ABeLZ9StAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSnK6hl12swaQZ5ha9TdOZLN4cBxKX
        d81hs7jduILN4ueh80wOrB4bHq1m9Zh3MtDj/b6rbB59W1YxenzeJBfAGsVlk5Kak1mWWqRv
        l8CVcWrRJuaC6fwVP6bXNjAu5uli5OSQEDCRWHb6HnMXIxeHkMBuRolFj7oZIRKSEtMuHgVK
        cADZwhKHDxdD1LxllFj34x4bSI2wQLzEnquPWEESIgJHGSUWPpvMAlF1nVHi7tK/zCBVbAJa
        Evtf3ADr4BdQlLj64zHYBl4BO4kHSw+zgtgsAqoSX64uYwGxRQUiJA7vmAVVIyhxcuYTsDin
        gLvEvSUrweqZBdQl/sy7xAxhi0vcejKfCcKWl2jeOpt5AqPQLCTts5C0zELSMgtJywJGllWM
        kqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMERoqW1g/HEifhDjAIcjEo8vC+u2cYKsSaW
        FVfmHmKU4GBWEuHdomQdK8SbklhZlVqUH19UmpNafIhRmoNFSZxXPv9YpJBAemJJanZqakFq
        EUyWiYNTqoFR5+vp+6enfN18LzmDvbNiyd3WYxaS+puPHy7t9fqZP2eFcYBjyCa2T6UftNO6
        /QMrhT2jdLscTiYqvRIqU1v5vOR+lufCG8+m/7n2UT/z96KXgZ3mRw1OJWYxbc6YrSvxe7HN
        kYVdtQd1P6xa9dnnra78Hs+sLEkZuwm1wWwHZ80R1nwZLnJCiaU4I9FQi7moOBEAFwE8uIwC
        AAA=
X-CMS-MailID: 20190729012153epcas1p18118c737bc7f641dfe515846bc6a13dd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190726121826epcas3p203050cc7ed2678556b1694fc14397240
References: <20190726121820.69679-1-andriy.shevchenko@linux.intel.com>
        <CGME20190726121826epcas3p203050cc7ed2678556b1694fc14397240@epcas3p2.samsung.com>
        <20190726121820.69679-2-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 7. 26. 오후 9:18, Andy Shevchenko wrote:
> This simplifies and standardizes axp288_extcon_log_rsi()
> by using for_each_set_bit() library function.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/extcon/extcon-axp288.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
> index 694a8d4a57ff..415afaf479e7 100644
> --- a/drivers/extcon/extcon-axp288.c
> +++ b/drivers/extcon/extcon-axp288.c
> @@ -121,7 +121,6 @@ static const char * const axp288_pwr_up_down_info[] = {
>  	"Last shutdown caused by PMIC UVLO threshold",
>  	"Last shutdown caused by SOC initiated cold off",
>  	"Last shutdown caused by user pressing the power button",
> -	NULL,
>  };
>  
>  /*
> @@ -130,8 +129,8 @@ static const char * const axp288_pwr_up_down_info[] = {
>   */
>  static void axp288_extcon_log_rsi(struct axp288_extcon_info *info)
>  {
> -	const char * const *rsi;
>  	unsigned int val, i, clear_mask = 0;
> +	unsigned long bits;
>  	int ret;
>  
>  	ret = regmap_read(info->regmap, AXP288_PS_BOOT_REASON_REG, &val);
> @@ -140,12 +139,10 @@ static void axp288_extcon_log_rsi(struct axp288_extcon_info *info)
>  		return;
>  	}
>  
> -	for (i = 0, rsi = axp288_pwr_up_down_info; *rsi; rsi++, i++) {
> -		if (val & BIT(i)) {
> -			dev_dbg(info->dev, "%s\n", *rsi);
> -			clear_mask |= BIT(i);
> -		}
> -	}
> +	bits = val & GENMASK(ARRAY_SIZE(axp288_pwr_up_down_info) - 1, 0);
> +	for_each_set_bit(i, &bits, ARRAY_SIZE(axp288_pwr_up_down_info))
> +		dev_dbg(info->dev, "%s\n", axp288_pwr_up_down_info[i]);
> +	clear_mask = bits;
>  
>  	/* Clear the register value for next reboot (write 1 to clear bit) */
>  	regmap_write(info->regmap, AXP288_PS_BOOT_REASON_REG, clear_mask);
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
