Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3DDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957F92146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="t4U744us"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfCTIA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:00:28 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:63732 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfCTIA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:00:27 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190320080022epoutp01a5dcb74aa22f9ca2fecc3909a6b6e977~Nm92l0i1E1662016620epoutp01S
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 08:00:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190320080022epoutp01a5dcb74aa22f9ca2fecc3909a6b6e977~Nm92l0i1E1662016620epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1553068822;
        bh=LxsewvNoI+aMXKLRN6G51cKNCXVZf7moishJrgvLooA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=t4U744usnX+DVQ37QrjPQeW68jE3Op1qp5VsPnx4R0ZOXg1RmXaYIuLg810Dm1jPG
         XIrLLv4sleF4FqlcQW3leMKePrAP19YP/eSyNj6HbmkRnDlDsW2ktphpTariEDacIn
         uxYnK4yQc5CSKvG/vFVZdto4ggVhCscqXbjcw7jk=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.152]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190320080019epcas1p31e38e4272326b27ea41742c755eff524~Nm9z60h1y2592225922epcas1p3G;
        Wed, 20 Mar 2019 08:00:19 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.29.04139.013F19C5; Wed, 20 Mar 2019 17:00:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190320080015epcas1p2c5201e617e5270d6b8ca5ab543afb5a2~Nm9vbQ0S10385703857epcas1p2t;
        Wed, 20 Mar 2019 08:00:15 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190320080015epsmtrp19f6bf38f7f38377cfc2f362ff58ee326~Nm9vXIJ4n0519305193epsmtrp14;
        Wed, 20 Mar 2019 08:00:15 +0000 (GMT)
X-AuditID: b6c32a35-deaec9c00000102b-b9-5c91f31001d0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.56.03662.E03F19C5; Wed, 20 Mar 2019 17:00:14 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190320080014epsmtip19d9c1466bd255121f53f02c7322f7aed~Nm9vGo9u52455624556epsmtip1F;
        Wed, 20 Mar 2019 08:00:14 +0000 (GMT)
Subject: Re: [PATCH] extcon: fix a missing check of regmap_read
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <7c1c38a8-a493-a2ec-370a-8661c11fda80@samsung.com>
Date:   Wed, 20 Mar 2019 17:00:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190320073522.26143-1-kjlu@umn.edu>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmga7A54kxBifua1q8OT6dyeLEvLPs
        Fpd3zWGzuN24gs1i8fKfjBY/D51ncmDz2PBoNavH+31X2Tz6tqxi9Li6sInd4/MmuQDWqGyb
        jNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKALlBTKEnNK
        gUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFlgV6xYm5xaV56XrJ+blWhgYGRqZAhQnZGW83
        zGUqWMFT8XLTerYGxrecXYycHBICJhJ7ztxl6WLk4hAS2MEocWzBKSYI5xOjxJ+bF6Gcb4wS
        p45OYIRpWd37jBkisZdRonVmI5TznlGipekoE0iVsIC9xM2WHjBbREBW4uPNh2wgRcwCixgl
        Llx+ywqSYBPQktj/4gYbiM0voChx9cdjsBW8AnYS36fPBathEVCVmHb+LtggUYEIifdPd7NA
        1AhKnJz5BMjm4OAUMJJY/c4IJMwsIC5x68l8JghbXqJ562yw4yQE3rNJXHu4iw3iBReJu0dP
        Q9nCEq+Ob2GHsKUkXva3QdnVEitPHmGDaO5glNiy/wIrRMJYYv/SyUwgi5kFNCXW79KHWMYn
        8e5rDytIWEKAV6KjTQiiWlni8gOI8yUEJCUWt3dCrfWQODzxIOMERsVZSL6ZheSFWUhemIWw
        bAEjyypGsdSC4tz01GLDAkPk6N7ECE6eWqY7GKec8znEKMDBqMTDq/FqQowQa2JZcWXuIUYJ
        DmYlEd6ixIkxQrwpiZVVqUX58UWlOanFhxhNgYE9kVlKNDkfmNjzSuINTY2MjY0tTAzNTA0N
        lcR51zs4xwgJpCeWpGanphakFsH0MXFwSjUwrg5TLbv1UC1pkTOrtMaGlfrvlqmtdGCRTGT7
        vC40/M6uc9L3V/k8r8u68uXqS23xwzdq9A7nyDVZTmxK9xHKqEn2v/2oNuaQ8Ma9N55HTq+Y
        /qJHnT/sROCb3LScl7ea01vWmV7YuvN77saT5rNs1zlVcpyxLz7FLrrtI2PZX/eFF5nPfZAO
        UWIpzkg01GIuKk4EAGYK+zC0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJTpfv88QYg+6HVhZvjk9nsjgx7yy7
        xeVdc9gsbjeuYLNYvPwno8XPQ+eZHNg8Njxazerxft9VNo++LasYPa4ubGL3+LxJLoA1issm
        JTUnsyy1SN8ugSvj7Ya5TAUreCpeblrP1sD4lrOLkZNDQsBEYnXvM+YuRi4OIYHdjBLfZk1k
        hEhISky7eBQowQFkC0scPlwMUfOWUeLw9lssIDXCAvYSN1t6mEBsEQFZiY83H7KBFDELLGKU
        WLHrLhNExy5GiYkfp7GDVLEJaEnsf3GDDcTmF1CUuPrjMdg2XgE7ie/T57KC2CwCqhLTzt8F
        myoqECFx9+ILFogaQYmTM5+wgFzEKWAksfqdEUiYWUBd4s+8S8wQtrjErSfzmSBseYnmrbOZ
        JzAKz0LSPQtJyywkLbOQtCxgZFnFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcRVpa
        OxhPnIg/xCjAwajEw3viwYQYIdbEsuLK3EOMEhzMSiK8RYkTY4R4UxIrq1KL8uOLSnNSiw8x
        SnOwKInzyucfixQSSE8sSc1OTS1ILYLJMnFwSjUwrppmmMe0USDAv+1h2IKTTrEOK39llUpu
        cu7IYxGKtmR6wX93Wm5xqNuZnQ2c3y3EyyZzyWzp+nJlzsd1E+ODl96Zfc00ef/f1YkHJdpa
        5tlZPLH5ucTtKkPIx2Vcb4OWb67e07Tq1wKrJH6BOfmbDlpo80lM+S9y8KFGNUu44ad0Du4m
        uSePlViKMxINtZiLihMBTcA9U54CAAA=
X-CMS-MailID: 20190320080015epcas1p2c5201e617e5270d6b8ca5ab543afb5a2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190320073541epcas5p4d4bcbe8aad4324edf3badd1c9b0617b0
References: <b902ff68-3054-80c3-f5c3-658fd0a1920e@samsung.com>
        <CGME20190320073541epcas5p4d4bcbe8aad4324edf3badd1c9b0617b0@epcas5p4.samsung.com>
        <20190320073522.26143-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You better to edit the patch title as following
in order to sustain the title format for extcon:

extcon: fix a missing check of regmap_read
-> extcon: axp288: Fix a missing check of regmap_read


On 19. 3. 20. 오후 4:35, Kangjie Lu wrote:
> When regmap_read fails, it doesn't make sense to use the read
> value "val" because it can be uninitialized.
> 
> The fix returns if regmap_read fails.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/extcon/extcon-axp288.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
> index a983708b77a6..b2ba5f073aa7 100644
> --- a/drivers/extcon/extcon-axp288.c
> +++ b/drivers/extcon/extcon-axp288.c
> @@ -143,6 +143,10 @@ static void axp288_extcon_log_rsi(struct axp288_extcon_info *info)
>  	int ret;
>  
>  	ret = regmap_read(info->regmap, AXP288_PS_BOOT_REASON_REG, &val);
> +	if (ret) {
> +		dev_err(info->dev, "failed to read BOOT_REASON_REG: %d\n", ret);
> +		return;
> +	}

Have to add the blank line. time.

And I think that axp288_extcon_log_rsi() have to return the 'error value'
instead of 'void' return type. And then should handle the return value
of axp288_extcon_log_rsi() within the axp288_extcon_probe().

For example,
	ret = axp288_extcon_log_rsi(info)
	if (ret < 0)
		return ret;


>  	for (i = 0, rsi = axp288_pwr_up_down_info; *rsi; rsi++, i++) {
>  		if (val & BIT(i)) {
>  			dev_dbg(info->dev, "%s\n", *rsi);
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
