Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58130C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F45206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="L5CPBMEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfCSAjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 20:39:19 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:43075 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCSAjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 20:39:19 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190319003916epoutp017b31d97dc2eea0944e07567993e0cc33~NNTblbNGS1936819368epoutp01L
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 00:39:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190319003916epoutp017b31d97dc2eea0944e07567993e0cc33~NNTblbNGS1936819368epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1552955956;
        bh=xI2flKFqRN1fRtSR37mCun8XEO2TyR0sI73M/+V27EI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=L5CPBMEqmuWZd999JR6+FtJvkjazWp4lvVB61lYRBMlT53P6b+a1BKOChyD0zKn6V
         H1BfCSOz0GVzQBj8Fc50E3ynk0JWQccsrPjZ2OWSh6Do+DHmYbywscV4e+JOVRUPbq
         /Z7Cjuns4/wk5JOZb2h1KrvMkIUF6Gp/6SOMu6Ko=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190319003912epcas1p2d70653ba330c0568fa4241e0d4a7b7eb~NNTYUw32N2395223952epcas1p2B;
        Tue, 19 Mar 2019 00:39:12 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.66.04143.C2A309C5; Tue, 19 Mar 2019 09:39:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190319003908epcas1p1e195bf349dcb05b895b4fd8fc550bbe0~NNTTzNb3K0846108461epcas1p1W;
        Tue, 19 Mar 2019 00:39:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190319003908epsmtrp2d87dcc6d5852b47ad97267c9271f5929~NNTTyg5OK0794407944epsmtrp2I;
        Tue, 19 Mar 2019 00:39:08 +0000 (GMT)
X-AuditID: b6c32a37-f19ff7000000102f-24-5c903a2c282c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.41.03692.B2A309C5; Tue, 19 Mar 2019 09:39:07 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190319003907epsmtip14eb50a252b791266fc1d38738a9bed9a~NNTTkj8JH1192511925epsmtip1f;
        Tue, 19 Mar 2019 00:39:07 +0000 (GMT)
Subject: Re: [PATCH] extcon: fix a missing check of regmap_read
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <b902ff68-3054-80c3-f5c3-658fd0a1920e@samsung.com>
Date:   Tue, 19 Mar 2019 09:39:22 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318164121.13838-1-kjlu@umn.edu>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmrq6O1YQYg44PGhZvjk9nsjgx7yy7
        xeVdc9gsbjeuYLNYvPwno8XPQ+eZHNg8Njxazerxft9VNo++LasYPa4ubGL3+LxJLoA1Ktsm
        IzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+gCJYWyxJxS
        oFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BZYFecWJucWleul5yfq6VoYGBkSlQYUJ2xvIf
        ExkLHnBVzOttY2lgvMLRxcjJISFgIvHl72XGLkYuDiGBHYwSjx9+YoFwPjFK9B6dwQrhfGOU
        aD91hQmm5fTPV1Atexkl+vccZ4dw3jNK3Hs7mwWkSljAXuJmSw9Yh4iArMTHmw/ZQIqYBRYx
        Slxu/8QMkmAT0JLY/+IGG4jNL6AocfXHY0YQm1fATuLF70PsIDaLgKrE2it3wQaJCkRIvH+6
        mwWiRlDi5MwnYDangJHEvi+HwXqZBcQlbj2ZzwRhy0s0b53NDLJYQuA9m8Sqa6sZIX5wkTg/
        cTMrhC0s8er4FnYIW0ri87u9bBB2tcTKk0fYIJo7GCW27L8A1WAssX/pZKANHEAbNCXW79KH
        WMYn8e5rDytIWEKAV6KjTQiiWlni8oO70KCTlFjc3skGUeIhce+a1wRGxVlIvpmF5INZSD6Y
        hbBrASPLKkax1ILi3PTUYsMCY+To3sQITp5a5jsYN5zzOcQowMGoxMMbMK0/Rog1say4MvcQ
        owQHs5IIr70nUIg3JbGyKrUoP76oNCe1+BCjKTCwJzJLiSbnAxN7Xkm8oamRsbGxhYmhmamh
        oZI473oH5xghgfTEktTs1NSC1CKYPiYOTqkGxhntWz/PmnQlpyz3it8i7c7zyVklrX3NhQVz
        nnjKRRY+b03fyLUpdAn724gIa4eY/Z+2f5HOnSQke/rVRp+TLruXSQnxHOGQDP20UaL+v3ZD
        2swX2wJzuLxbGuf82pd8qvL3fg6O/V8WLP666oOo/c5FnF/0S04x2rCEue7xabnIe/rmMn3T
        HiWW4oxEQy3mouJEAKd2kt+0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJTlfbakKMwaRFFhZvjk9nsjgx7yy7
        xeVdc9gsbjeuYLNYvPwno8XPQ+eZHNg8Njxazerxft9VNo++LasYPa4ubGL3+LxJLoA1issm
        JTUnsyy1SN8ugStj+Y+JjAUPuCrm9baxNDBe4ehi5OSQEDCROP3zFSOILSSwm1Hi3DE3iLik
        xLSLR5m7GDmAbGGJw4eLuxi5gEreMko8+PyEGaRGWMBe4mZLDxOILSIgK/Hx5kM2kCJmgUWM
        En1r17JAdLQySjQdb2UBqWIT0JLY/+IGG4jNL6AocfXHY7DNvAJ2Ei9+H2IHsVkEVCXWXrkL
        NlVUIELi7sUXLBA1ghInZz4BszkFjCT2fTkM1sssoC7xZ94lZghbXOLWk/lMELa8RPPW2cwT
        GIVnIWmfhaRlFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI4iLc0d
        jJeXxB9iFOBgVOLhXTGjP0aINbGsuDL3EKMEB7OSCK+9J1CINyWxsiq1KD++qDQntfgQozQH
        i5I479O8Y5FCAumJJanZqakFqUUwWSYOTqkGRsWCmGluugHPFyjcCUkwUROYl7Yi7GfE8oor
        TYoy+yd9Zby28/b1ZpEMrvtrxGTVrl4w4XrEJFO6fCKzxtd5Ca9ffSrOLZvtnT07W23emu9T
        Z89gfDibdcuTkqUJKo+P3gi+dPNBsNikWVYb9yUsNdqU93d2Fhtn9o2HKv32d9zc1h36dHS7
        jKkSS3FGoqEWc1FxIgDWahmcngIAAA==
X-CMS-MailID: 20190319003908epcas1p1e195bf349dcb05b895b4fd8fc550bbe0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190318164133epcas5p1a539488d8614011bdf4e734d76da4cc3
References: <CGME20190318164133epcas5p1a539488d8614011bdf4e734d76da4cc3@epcas5p1.samsung.com>
        <20190318164121.13838-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 3. 19. 오전 1:41, Kangjie Lu wrote:
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
> +		dev_dbg(info->dev, "regmap_read error %d\n", ret);

dev_err is correct for handling the error case
instead of dev_dbg. And I recommend that you use following error log
because extcon-axp288.c already used the 'failed to ...' log style.
If there is no special reason, you better to keep the consistency
for the readability.

- dev_err(info->dev, "failed to read BOOT_REASON_REG: %d\n", ret);

> +		return;
> +	}
>  	for (i = 0, rsi = axp288_pwr_up_down_info; *rsi; rsi++, i++) {
>  		if (val & BIT(i)) {
>  			dev_dbg(info->dev, "%s\n", *rsi);
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
