Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F07C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 00:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5F520679
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 00:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hHhYgVjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfGaARY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 20:17:24 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:48479 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbfGaARW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 20:17:22 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190731001720epoutp011d74c14887b5d5b19cd24a3e39536048~2Vch1W1FW0648506485epoutp01S
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 00:17:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190731001720epoutp011d74c14887b5d5b19cd24a3e39536048~2Vch1W1FW0648506485epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564532240;
        bh=0wsN+KJA8xiJvr3XyIgCaOEJjalBpg3xXR11DXL3shc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hHhYgVjgI3z1EVj8zFc2fcOg7RsjnHXnffcG91510k2HSHemqF0o1shHNEpDDiNVu
         4Yi5tN+wHH12FDTF0w2ko55m+Yoxf1RJtvZeYP5sobYZ6o5Rp+VvZLy4+w/JICU0uK
         +UJBVIAUSC6hMpQK5T4ocvq3syoisc2izVzheSVM=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190731001719epcas1p45b4429fee3eadbb9e963f7ef373f3c2b~2VchiSiqW3240232402epcas1p4O;
        Wed, 31 Jul 2019 00:17:19 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.152]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 45yvBN1vqqzMqYkl; Wed, 31 Jul
        2019 00:17:16 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.8B.04066.B0ED04D5; Wed, 31 Jul 2019 09:17:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190731001715epcas1p2b6c26041de170892ebb332fd1df29447~2VcdM4l_r0306403064epcas1p2h;
        Wed, 31 Jul 2019 00:17:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190731001715epsmtrp1f15c1f44490639399904f8b92a79dd7f~2VcdMGw5j1858918589epsmtrp1s;
        Wed, 31 Jul 2019 00:17:15 +0000 (GMT)
X-AuditID: b6c32a37-29ba59c000000fe2-f0-5d40de0b7926
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.BD.03706.A0ED04D5; Wed, 31 Jul 2019 09:17:14 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190731001714epsmtip262b28069a48f3a443e4ddccfa5cc8a68~2VcdALDMx0669706697epsmtip2t;
        Wed, 31 Jul 2019 00:17:14 +0000 (GMT)
Subject: Re: [PATCH v6 12/57] extcon: Remove dev_err() usage after
 platform_get_irq()
To:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <c186f55f-1179-aa11-ba46-d6771723018c@samsung.com>
Date:   Wed, 31 Jul 2019 09:20:19 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730181557.90391-13-swboyd@chromium.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTT5f7nkOswaNvYhbNi9ezWVzeNYfN
        4nbjCjaL43eeMjmweMxuuMjisX/uGnaPvi2rGD0+b5ILYInKtslITUxJLVJIzUvOT8nMS7dV
        8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBWqmkUJaYUwoUCkgsLlbSt7Mpyi8tSVXI
        yC8usVVKLUjJKbAs0CtOzC0uzUvXS87PtTI0MDAyBSpMyM6YcOceY8EL3orGlswGxj9cXYyc
        HBICJhJ7jtxk7GLk4hAS2MEoserDUjYI5xOjREvXVnYI5xujxP3D15lgWqZeug1VtZdRordh
        ExtIQkjgPaPE8Z9JILawQLhE98mdLCC2iICLxOEfS8FqmAXiJFbMPAIWZxPQktj/4gZYnF9A
        UeLqj8dAd3Bw8ArYSRz9owMSZhFQlVh39RvYXlGBCIlPDw6zgti8AoISJ2c+ARvDKWAlcez0
        XBaI8eISt57MZ4Kw5SWat85mBrlTQuAym8TeswfYIR5wkbh1fSEbhC0s8er4Fqi4lMTL/jYo
        u1pi5ckjbBDNHYwSW/ZfYIVIGEvsXzqZCeRQZgFNifW79CHCihI7f89lhFjMJ/Huaw8rSImE
        AK9ER5sQRImyxOUHd6FhKCmxuL2TbQKj0iwk78xC8sIsJC/MQli2gJFlFaNYakFxbnpqsWGB
        MXJcb2IEJ0Yt8x2MG875HGIU4GBU4uE9EesQK8SaWFZcmXuIUYKDWUmEd7G4fawQb0piZVVq
        UX58UWlOavEhRlNgaE9klhJNzgcm7bySeENTI2NjYwsTQzNTQ0Mlcd6FPyxihQTSE0tSs1NT
        C1KLYPqYODilGhiD9rJtPlb78dSd5yvuvHu22ejOvMaNFxvOzYn58n/trQ4Jx65fpmeSXl8R
        XuazZ+76Qqe6lb0dSoyOmQ5XDtdej28umZZfuJLFpIg7dcLvebtrprEeMEqY6TO957uNvURV
        80LRP7WhKg/Fvsk90Ugqnq+0wkc2wsVc1ud445qNT/5NWbm+dPJ/JZbijERDLeai4kQA0Nz6
        X6IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSvC7XPYdYg6cHzS2aF69ns7i8aw6b
        xe3GFWwWx+88ZXJg8ZjdcJHFY//cNewefVtWMXp83iQXwBLFZZOSmpNZllqkb5fAlTHhzj3G
        ghe8FY0tmQ2Mf7i6GDk5JARMJKZeus3WxcjFISSwm1GipeUJM0RCUmLaxaNANgeQLSxx+HAx
        RM1bRonVO9czgtQIC4RLdJ/cyQJiiwi4SBz+sZQNxGYWiJM4OuUZE0TDHkaJKb13mEASbAJa
        Evtf3AAr4hdQlLj64zEjyAJeATuJo390QMIsAqoS665+AysXFYiQOLxjFtguXgFBiZMzn4Dt
        4hSwkjh2ei4LxC51iT/zLjFD2OISt57MZ4Kw5SWat85mnsAoPAtJ+ywkLbOQtMxC0rKAkWUV
        o2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwjGhp7mC8vCT+EKMAB6MSD++JWIdYIdbE
        suLK3EOMEhzMSiK8i8XtY4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzPs07FikkkJ5YkpqdmlqQ
        WgSTZeLglGpgLFl33yX7iPt7ueal0Sw7m8PlOSbqN7AXPHukrG5vuCzH/2mt4V0bZ+vkk9uT
        lnLv3ximIbVVaX0qz27Z72arluSt23LnrI84K8fEAPkrurmrixw7f79vZ+Bz2/d/xebXrzfx
        WqZlseqGuN5qUVZfPdfvlccK7++VcuvLn9ixbvshFxJ3OCFLiaU4I9FQi7moOBEAmqaw3I0C
        AAA=
X-CMS-MailID: 20190731001715epcas1p2b6c26041de170892ebb332fd1df29447
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190730181616epcas5p17ffc6701dd37593e06caaa91576984cf
References: <20190730181557.90391-1-swboyd@chromium.org>
        <CGME20190730181616epcas5p17ffc6701dd37593e06caaa91576984cf@epcas5p1.samsung.com>
        <20190730181557.90391-13-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 7. 31. 오전 3:15, Stephen Boyd wrote:
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
> 
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
> 
> ret =
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
> 
> if ( \( ret < 0 \| ret <= 0 \) )
> {
> (
> -if (ret != -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
> 
> While we're here, remove braces on if statements that only have one
> statement (manually).
> 
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Please apply directly to subsystem trees
> 
>  drivers/extcon/extcon-adc-jack.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-adc-jack.c b/drivers/extcon/extcon-adc-jack.c
> index ee9b5f70bfa4..ad02dc6747a4 100644
> --- a/drivers/extcon/extcon-adc-jack.c
> +++ b/drivers/extcon/extcon-adc-jack.c
> @@ -140,10 +140,8 @@ static int adc_jack_probe(struct platform_device *pdev)
>  		return err;
>  
>  	data->irq = platform_get_irq(pdev, 0);
> -	if (data->irq < 0) {
> -		dev_err(&pdev->dev, "platform_get_irq failed\n");
> +	if (data->irq < 0)
>  		return -ENODEV;
> -	}
>  
>  	err = request_any_context_irq(data->irq, adc_jack_irq_thread,
>  			pdata->irq_flags, pdata->name, data);
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
