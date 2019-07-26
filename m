Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8057CC76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 02:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CD022C7B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 02:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EQwwpktH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfGZCRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 22:17:08 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:59951 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGZCRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 22:17:08 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190726021704epoutp01872b4adefc2ac33287783dfec0f59a39~002pcZDFg1711317113epoutp01D
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 02:17:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190726021704epoutp01872b4adefc2ac33287783dfec0f59a39~002pcZDFg1711317113epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564107424;
        bh=7qNrTiJlRTkCJ6GSFE9lg+Iinb/r5caoU1xENKa/fzU=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=EQwwpktHb3YCOhlY5AEKuGU/M5UsmS1nWn27Pftw/9JmOpCGa3+Z9J4GwCsvTvpY1
         nMi7JKz/zSDgZPdgNpBD+5pzOyprVOCbflusDYMgtsHJwZ+3OkhxxMT+6Qt/qGf6aA
         /+FimLy0ugdQw24l9RDfYNkHvw0wxrFaXY9AL5wg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190726021704epcas1p1f41740136e72758310c3438a61c8eb14~002pMcXVJ2784827848epcas1p1I;
        Fri, 26 Jul 2019 02:17:04 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 45vt4s5dRQzMqYm0; Fri, 26 Jul
        2019 02:17:01 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.6C.04075.9926A3D5; Fri, 26 Jul 2019 11:16:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190726021657epcas1p12b275ce8e6f6a27ae7c4adda5f5ade63~002iw9Kc42787227872epcas1p1e;
        Fri, 26 Jul 2019 02:16:57 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190726021657epsmtrp277a10e55d7a4be48cefa75b71b8cb1a9~002iwIXPt3198631986epsmtrp2i;
        Fri, 26 Jul 2019 02:16:57 +0000 (GMT)
X-AuditID: b6c32a36-b49ff70000000feb-c7-5d3a62998edb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.58.03638.9926A3D5; Fri, 26 Jul 2019 11:16:57 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190726021656epsmtip24314e8d69f4fe82f5de0f0c1fd971106~002ikrVFv3082730827epsmtip2d;
        Fri, 26 Jul 2019 02:16:56 +0000 (GMT)
Subject: Re: [PATCH v1 2/2] extcon: axp288: Use for_each_set_bit() in
 axp288_extcon_log_rsi()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <c3c0fe37-73eb-d11c-2499-469ece09371c@samsung.com>
Date:   Fri, 26 Jul 2019 11:20:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725203405.65523-2-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0gUURjl7uxOo7Z2XbW+JEon/KGk7qi7rZESPRd6YNmPCmSddNoV9zHM
        rNHjRy9SWyp6ILlr75B8JIlpaGCL6yujsjBR0ihSKC2zssweRDs7Rv65nHvuOfd8370fRWjc
        ZBSVb3dygp210mSw8m5bnDbBvXtFtvbPmQTDqaMXFIYPXf6l995F0jB4pJI0/PD1KFapjHVv
        alTGy91bjRP3+0jj6YZqZJysX5yp2lWw0sKxeZwQzdlzHXn5dnM6vTHLtMak02uZBCbNsJyO
        trM2Lp1euykzYX2+1Z9NR+9lrYV+KpMVRTopY6XgKHRy0RaH6EynOT7PyqfxiSJrEwvt5sRc
        h20Fo9Um6/zCnAJL2bVzSn44dN+DjhrlYTQV4kJBFOBU+N7+aY4LBVMa3ITAV16tkjdfEIz2
        tyollQZPIXjSuv6f49n0kEIWtSCoevhwxjGB4PSr46SkCscm6GgeD9wbgTsQNE29J6QDEseD
        991AQDQPx0Df9DByIYpS4wxwf0uWoBLHQnnJRkkRiXfAl9dtKgmrcRh0u0cCBQXhDVBWeTLA
        E3gBvBi5opDxEjjWWE5IsYD7Sai9VaOSq14LE0VjhIzDYayrYY6Mo2DyYwsp44NQ1d1OyuYS
        BA3epzPmFPBWnFdIxRE4Dm7fS5LpGGj+dQnJwaHw8ZtUEOXn1VBSpJElS6H39UuFjBfCjeIT
        M1FGeNBVS5xBMZ5ZrXlmteOZ1Y7nf/BVpKxG8zletJk5keGTZ392PQqMZby+CV1/ssmHMIXo
        ueqnN9OyNSp2r7jf5kNAEXSEurHJT6nz2P0HOMFhEgqtnOhDOv/DnyWiInMd/iG3O02MLjkl
        JcWQyuh1DEMvUF+bNmRrsJl1cgUcx3PCP5+CCoo6jGqh9feunEchxvGkRTGfXeO2ndmPX2aR
        X1XNf+Itz0/ticj4filt5zb9fHcR4Wtxjwz8rNqudR+paOAve6Du+rpi4bcrrNjb03jy6NBA
        ZWenebRgMV9Stlpo27K51JzzNiSpB632ojAIDk0M79YPHlp2p9i0IZZYsmOykZ9XWkorRQvL
        xBOCyP4F2sUtEawDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSvO7MJKtYg9avbBa9TdOZLN4cBxKX
        d81hs7jduILN4ueh80wOrB4bHq1m9Zh3MtDj/b6rbB59W1YxenzeJBfAGsVlk5Kak1mWWqRv
        l8CVMWPhJJaCx3wVJ46uZmlg/MbdxcjJISFgInHxxx2mLkYuDiGB3YwSj/fNYIZISEpMu3gU
        yOYAsoUlDh8uhqh5yyixYdtpVpAaYYF4iaM737KDJEQEjjJKLHw2mQWi6jqjxIEnH1lAqtgE
        tCT2v7jBBmLzCyhKXP3xmBFkKq+AncTMr0YgJouAqsTsDm+QClGBCInDO2Yxgti8AoISJ2c+
        AZvCKeAuMWNFD9heZgF1iT/zLjFD2OISt57MZ4Kw5SWat85mnsAoNAtJ+ywkLbOQtMxC0rKA
        kWUVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZwfGhp7WA8cSL+EKMAB6MSD6/GKstY
        IdbEsuLK3EOMEhzMSiK8W3cAhXhTEiurUovy44tKc1KLDzFKc7AoifPK5x+LFBJITyxJzU5N
        LUgtgskycXBKNTBOmHsq4CTT19/XJY+teNraKbJhelry4db8I8WT7KvapF/aykcW1H6RWiF3
        vLVk7mE7RbOTs9R6ZjEbiJv5XM8xehYUsbHstsjh8mdvzu6KEWwt4e/IVlq9fblh6tE3SQyd
        D95b5yzNc+EMWPaoRUrt0wfZX2+mBfIal/x58r6s8ux1QccsjldKLMUZiYZazEXFiQCulx5c
        iwIAAA==
X-CMS-MailID: 20190726021657epcas1p12b275ce8e6f6a27ae7c4adda5f5ade63
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190725203412epcas5p415cab805f303ddaffe0f9b8b5dc1e013
References: <20190725203405.65523-1-andriy.shevchenko@linux.intel.com>
        <CGME20190725203412epcas5p415cab805f303ddaffe0f9b8b5dc1e013@epcas5p4.samsung.com>
        <20190725203405.65523-2-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 7. 26. 오전 5:34, Andy Shevchenko wrote:
> This simplifies and standardizes axp288_extcon_log_rsi()
> by using for_each_set_bit() library function.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/extcon/extcon-axp288.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
> index 4cbcc3b1aa6b..670334c362ac 100644
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
> @@ -130,20 +129,18 @@ static const char * const axp288_pwr_up_down_info[] = {
>   */
>  static void axp288_extcon_log_rsi(struct axp288_extcon_info *info)
>  {
> -	const char * const *rsi;
>  	unsigned int val, i, clear_mask = 0;
> +	unsigned long bits;
>  	int ret;
>  
>  	ret = regmap_read(info->regmap, AXP288_PS_BOOT_REASON_REG, &val);
>  	if (ret < 0)
>  		return;
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

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
