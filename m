Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30A8C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7C921920
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dtnWhUTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfJKBjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 21:39:45 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:30639 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbfJKBjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 21:39:44 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191011013941epoutp0359d8de98908c83e572c16a658b31c804~MdA-CQtGo0976209762epoutp03K
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 01:39:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191011013941epoutp0359d8de98908c83e572c16a658b31c804~MdA-CQtGo0976209762epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570757981;
        bh=FLiLxeLnYPsqkocvnQZ7jVry7G7CObnrO9EAQ2IVVsk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dtnWhUTeajq58uzTao948KpLsufEFjNCKuXLUM0Q9KiyZGpQmxwUQstgd+svpron3
         eruwlplcDBU1aXSIou2qi1CfpXJwdldVegXR9pssOpUC6PnzHx0ghOkSAOMVKioZSQ
         xPLO08sdJV2Xb5plWySD5tmtmfDctNjIG5+MAXKk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191011013940epcas1p19e420ea129c9d89ecaf4f0c83d910b5a~MdA_cNSaL0730507305epcas1p1j;
        Fri, 11 Oct 2019 01:39:40 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.152]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 46q9cB0P25zMqYlh; Fri, 11 Oct
        2019 01:39:38 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.C3.04144.45DDF9D5; Fri, 11 Oct 2019 10:39:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191011013931epcas1p2b9c547ee3cb8cc383791590104796e82~MdA2NlQvX0996609966epcas1p22;
        Fri, 11 Oct 2019 01:39:31 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191011013931epsmtrp2f648c8987246ebd42bc9d031a8ae924e~MdA2M9oXT1193611936epsmtrp2O;
        Fri, 11 Oct 2019 01:39:31 +0000 (GMT)
X-AuditID: b6c32a35-2dfff70000001030-46-5d9fdd54cd71
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.5F.03889.35DDF9D5; Fri, 11 Oct 2019 10:39:31 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191011013931epsmtip2e5343484b72b1832aefbab4d213e1d0f~MdA1-1lD22054720547epsmtip2j;
        Fri, 11 Oct 2019 01:39:31 +0000 (GMT)
Subject: Re: [PATCH] extcon: sm5502: Reset registers during initialization
To:     Stephan Gerhold <stephan@gerhold.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <7432858f-3a22-b7f6-ec02-4e44dc9e71b5@samsung.com>
Date:   Fri, 11 Oct 2019 10:44:34 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010154720.52330-1-stephan@gerhold.net>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0gUURTm7uyOo7U2rZpnJXSdHqSg7qhra2gJhUgFSklEJjas19XcFzNr
        tIWhSb4oyx6Qqzam2MM/1qKigigamkRhWGKFZWkYCUpaEVbU7o6R/75z7nfOd75zD0WoysgQ
        qsBix7yFMzGkn7xrKEIblTklZmsnKlT68d4GUv+m9B6pn2yMTyHSypv2pNV0tKG0ZVdoBnGs
        MCkfc7mY12CLwZpbYDEmMwcO5+zN0SVo2Sg2Ub+T0Vg4M05m9h3MiEotMLllGM0pzlTkTmVw
        gsDE7E7irUV2rMm3CvZkBttyTbZEW7TAmYUiizHaYDXvYrXaWJ2beKIwX1xZRLa7qtPnP7qI
        ErTsX40oCuh4GC4trEZ+lIruRtBaLvpIwRKCqc6a1eA7gqeLX1E18vVWjL37RUgPfQjqGluR
        FCwimH5QT3pYAfR+uN086uPRCKQzoXMo3pMmaA2svHUpPJikI6H/06SXvoEOh5c/ZrwCSno3
        zPVUyDxYTm+DV7MePkUF0UfhyTdOomyE0bpZuQf70onwR7yDpPbB8HpWlEk4DMo6671zAj1A
        whNnk0IysA8ezt1aNRMAn0c6fCQcAssLfaSEz8L90UekVFyJoKN/bLU4Dvpbr8k8AxF0BLT3
        xkjpcOj52bg6hD8sfLuokNarhMpylUTZAuPTUzIJq6Glooq8ghjnGjvONRacayw4/4s1IXkb
        2oRtgtmIBdbGrv1rF/IeYKSuG11/dnAQ0RRi1itvhonZKgV3SnCYBxFQBBOobHY2ZKuUuZzj
        DOatOXyRCQuDSOdedi0REmSwus/ZYs9hdbFxcXH6eDZBx7JMsFKB3H1oI2fHhRjbMP+vTkb5
        hpQg0V88kO5Xf26PNXTIUWxMUbc8L3hx1ZSK1Znamb4HBnWQo3NE83h8uql7PnMurbwiqz3G
        eSnvSDhWJ0Y3Fl//Ke64sO5GXixeudwwukQEh2ePbUyIKXt/Mosfbv79LN0wkvJYc8jCT1Z1
        fZnP2z6QpKRSP/yZqLtW/bz2+OaSrYxcyOfYSIIXuL8Ee9J8lgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSvG7w3fmxBj9nyVpc3jWHzeJ24wo2
        ixtzTRyYPdoW2Hv0bVnF6PF5k1wAcxSXTUpqTmZZapG+XQJXxvxf7xkLlgtVND3dxNzA+Jmv
        i5GTQ0LAROLC/T/MXYxcHEICuxkltr47zAaRkJSYdvEoUIIDyBaWOHy4GKLmLaPEoddrwWqE
        BbwkFi46yQ5iiwiESFw7tZAZxGYWUJD4dW8TK0RDD6NEy6FXTCAJNgEtif0vboA18wsoSlz9
        8ZgRxOYVsJN4vrMdrIZFQFXi5hOQZk4OUYEIiefbb0DVCEqcnPmEBcTmFLCU+D9/GSPEMnWJ
        P/MuQS0Wl7j1ZD4ThC0v0bx1NvMERuFZSNpnIWmZhaRlFpKWBYwsqxglUwuKc9Nziw0LjPJS
        y/WKE3OLS/PS9ZLzczcxguNBS2sH44kT8YcYBTgYlXh4Z8jPjxViTSwrrsw9xCjBwawkwrto
        1pxYId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzy+ccihQTSE0tSs1NTC1KLYLJMHJxSDYyNroa2
        h5/tK56yYGP/v2iOqXnBsbK7WP/yqPw8njlX2G+C0ONd9232Jxy/cM3eunGCNq+3Q33vixmF
        3naFMU3O+vk6dn4O31alqVjlzvrWoJ97e9431bVBbU7XZ7A88z01v3TqzebQb0uXTDo3b5/g
        lfuF0X36p/yZixl3qa7kYO2UShDznabEUpyRaKjFXFScCACCW38ngwIAAA==
X-CMS-MailID: 20191011013931epcas1p2b9c547ee3cb8cc383791590104796e82
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191010154845epcas4p2c3aa5f0afd9fad05c0ab88d99792415a
References: <CGME20191010154845epcas4p2c3aa5f0afd9fad05c0ab88d99792415a@epcas4p2.samsung.com>
        <20191010154720.52330-1-stephan@gerhold.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 10. 11. 오전 12:47, Stephan Gerhold wrote:
> On some devices (e.g. Samsung Galaxy A5 (2015)), the bootloader
> seems to keep interrupts enabled for SM5502 when booting Linux.
> Changing the cable state (i.e. plugging in a cable) - until the driver
> is loaded - will therefore produce an interrupt that is never read.
> 
> In this situation, the cable state will be stuck forever on the
> initial state because SM5502 stops sending interrupts.
> This can be avoided by clearing those pending interrupts after
> the driver has been loaded.
> 
> One way to do this is to reset all registers to default state
> by writing to SM5502_REG_RESET. This ensures that we start from
> a clean state, with all interrupts disabled.
> 
> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  drivers/extcon/extcon-sm5502.c | 4 ++++
>  drivers/extcon/extcon-sm5502.h | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
> index dc43847ad2b0..b3d93baf4fc5 100644
> --- a/drivers/extcon/extcon-sm5502.c
> +++ b/drivers/extcon/extcon-sm5502.c
> @@ -65,6 +65,10 @@ struct sm5502_muic_info {
>  /* Default value of SM5502 register to bring up MUIC device. */
>  static struct reg_data sm5502_reg_data[] = {
>  	{
> +		.reg = SM5502_REG_RESET,
> +		.val = SM5502_REG_RESET_MASK,
> +		.invert = true,
> +	}, {
>  		.reg = SM5502_REG_CONTROL,
>  		.val = SM5502_REG_CONTROL_MASK_INT_MASK,
>  		.invert = false,
> diff --git a/drivers/extcon/extcon-sm5502.h b/drivers/extcon/extcon-sm5502.h
> index 9dbb634d213b..ce1f1ec310c4 100644
> --- a/drivers/extcon/extcon-sm5502.h
> +++ b/drivers/extcon/extcon-sm5502.h
> @@ -237,6 +237,8 @@ enum sm5502_reg {
>  #define DM_DP_SWITCH_UART			((DM_DP_CON_SWITCH_UART <<SM5502_REG_MANUAL_SW1_DP_SHIFT) \
>  						| (DM_DP_CON_SWITCH_UART <<SM5502_REG_MANUAL_SW1_DM_SHIFT))
>  
> +#define SM5502_REG_RESET_MASK			(0x1)
> +
>  /* SM5502 Interrupts */
>  enum sm5502_irq {
>  	/* INT1 */
> 

Applied it. Thanks.

When you send the patch on later, you better to specify the version
on patch title as following:
	[PATCH v2] extcon: sm5502: Reset registers during initialization

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
