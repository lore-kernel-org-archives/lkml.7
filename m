Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0586CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 04:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932592087E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 04:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eIOliDS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfJaEmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 00:42:53 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:35406 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfJaEmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 00:42:53 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191031044251epoutp02dc601b907e7ab581cd5a431acc2ecad6~Soanv1HH_1687316873epoutp024
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 04:42:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191031044251epoutp02dc601b907e7ab581cd5a431acc2ecad6~Soanv1HH_1687316873epoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572496971;
        bh=OAecQkkTsj6QSqDHVp6XSRMWpCIUpI3s7EMteQIPnZU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=eIOliDS3nyPGhljMbWQrmV/tZvfJw8CIzwrrL8kFyY8lVM5rA00PoRXVzHk2z727v
         GKwX4d+DpGx+zBpaqhXcIWVt+Hk+zM9ktNPEd8GUhsOr1Fk0cTa1IZ+Tt0YoVOK2PP
         T3s7o4RL5IbS+uvJlTFfUwOWthraTfP7O+MLYiFE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191031044250epcas1p4b664e0f2f421c7d9058c2069b6b350ff~SoandkBXC1654716547epcas1p4H;
        Thu, 31 Oct 2019 04:42:50 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 473XkK01ftzMqYm2; Thu, 31 Oct
        2019 04:42:48 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.E6.04135.E366ABD5; Thu, 31 Oct 2019 13:42:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191031044238epcas1p1cdd20e6a35d35ae34739d1df500f6634~SoacM0YGd0549005490epcas1p1O;
        Thu, 31 Oct 2019 04:42:38 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191031044238epsmtrp14a084bbfe7366e949b20a432143e406e~SoacMKVRu2586525865epsmtrp1L;
        Thu, 31 Oct 2019 04:42:38 +0000 (GMT)
X-AuditID: b6c32a36-7fbff70000001027-3d-5dba663e5cdc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.05.25663.E366ABD5; Thu, 31 Oct 2019 13:42:38 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191031044238epsmtip1eab391409a45e5a127625dfedc7f03f9~SoacEVzB31061910619epsmtip1f;
        Thu, 31 Oct 2019 04:42:38 +0000 (GMT)
Subject: Re: [PATCH] extcon: sm5502: remove redundant assignment to variable
 cable_type
To:     Colin King <colin.king@canonical.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <824f99c7-8de2-2b32-4d12-8a45e73b2349@samsung.com>
Date:   Thu, 31 Oct 2019 13:48:10 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025131227.24894-1-colin.king@canonical.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdljTQNc+bVeswYvfTBa/V/eyWWy9JW1x
        edccNovbjSvYHFg8ZjX0snn0bVnF6PF5k1wAc1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7yp
        mYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QMiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJq
        QUpOgWWBXnFibnFpXrpecn6ulaGBgZEpUGFCdsbeJ2eYCtZzVrw/95S9gfE6excjJ4eEgInE
        2q4tQDYXh5DADkaJM9fms0I4nxglPi14DOV8Y5S4ceEuC0zLxhc32CASe4FaDnxjhHDeM0r8
        +v6RCaRKWCBSYvWbVawgtohAiMTpCxPBFjILOEqsm38HbBKbgJbEfrBJnBz8AooSV388ZgSx
        eQXsJPZf/gjUy8HBIqAqse6qFIgpKhAhcfprIkSFoMTJmU/ApnACVb+82sgMMV1c4taT+UwQ
        trxE89bZzCCnSQicYJOY8WAn1AMuEnfuTGeDsIUlXh3fAg0LKYmX/W1QdrXEypNH2CCaOxgl
        tuy/wAqRMJbYv3QyE8hBzAKaEut36UOEFSV2/p7LCLGYT+Ld1x6w8yUEeCU62oQgSpQlLj+4
        ywRhS0osbu9km8CoNAvJO7OQvDALyQuzEJYtYGRZxSiWWlCcm55abFhghBzZmxjB6VDLbAfj
        onM+hxgFOBiVeHgnlO2MFWJNLCuuzD3EKMHBrCTC+80GKMSbklhZlVqUH19UmpNafIjRFBjW
        E5mlRJPzgak6ryTe0NTI2NjYwsTQzNTQUEmc13H50lghgfTEktTs1NSC1CKYPiYOTqkGRmcF
        necP1bzfJRi8/6Pjr9tV4nTpUfa0yxcOH1pVxnDfzKTkw3yumxd3zb/kV5/6pOH0EZO2PT3v
        y9clL2S0jFevsRfdKLZcX6r2kEAC6xXfd5J6jU05M11bVjUtX7D/QeHEd7oT99xY/nS5+fxY
        rfnV0VNKrl672WOlbjOlRbm8ddoWq2gxayWW4oxEQy3mouJEABSoYAmdAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSnK5d2q5Yg/Z7Wha/V/eyWWy9JW1x
        edccNovbjSvYHFg8ZjX0snn0bVnF6PF5k1wAcxSXTUpqTmZZapG+XQJXxt4nZ5gK1nNWvD/3
        lL2B8Tp7FyMnh4SAicTGFzfYuhi5OIQEdjNKHDi+gwkiISkx7eJR5i5GDiBbWOLw4WKImreM
        Eic3PmcGqREWiJRY/WYVK4gtIhAiMWv6JkYQm1nAUWLd/DssEA0TGSVeTD3JBpJgE9CS2A+2
        jZODX0BR4uqPx2ANvAJ2Evsvf2QFWcYioCqx7qoUSFhUIELi+fYbUCWCEidnPmEBsTmByl9e
        bWSG2KUu8WfeJShbXOLWk/lMELa8RPPW2cwTGIVnIWmfhaRlFpKWWUhaFjCyrGKUTC0ozk3P
        LTYsMMpLLdcrTswtLs1L10vOz93ECI4MLa0djCdOxB9iFOBgVOLhnVC2M1aINbGsuDL3EKME
        B7OSCO83G6AQb0piZVVqUX58UWlOavEhRmkOFiVxXvn8Y5FCAumJJanZqakFqUUwWSYOTqkG
        xpWygqZPeWWe5HekcEyy8/n1/+3BU2rmO3atWxlo07BY9eZ1X2lFo3SxbVETD25+7zbHjF23
        fBbfJ+OQJf9ZPe9XMR6O9uxIdas8kC3DuHMR0549F1zv9vWffVy/dPJfkd7d/GacIbxXlryZ
        9W7Gu4nCKt2M//5dWny64Nm2P52XP5w9bu1ipazEUpyRaKjFXFScCABvXeSfiAIAAA==
X-CMS-MailID: 20191031044238epcas1p1cdd20e6a35d35ae34739d1df500f6634
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191025131232epcas4p262cce6ea441f3f1b9251810ad9427732
References: <CGME20191025131232epcas4p262cce6ea441f3f1b9251810ad9427732@epcas4p2.samsung.com>
        <20191025131227.24894-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 10. 25. 오후 10:12, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable cable_type is being initialized with a value that
> is never read and is being re-assigned a little later on. The
> assignment is redundant and hence can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/extcon/extcon-sm5502.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
> index b3d93baf4fc5..bcf65aaca5d2 100644
> --- a/drivers/extcon/extcon-sm5502.c
> +++ b/drivers/extcon/extcon-sm5502.c
> @@ -276,7 +276,7 @@ static int sm5502_muic_set_path(struct sm5502_muic_info *info,
>  /* Return cable type of attached or detached accessories */
>  static unsigned int sm5502_muic_get_cable_type(struct sm5502_muic_info *info)
>  {
> -	unsigned int cable_type = -1, adc, dev_type1;
> +	unsigned int cable_type, adc, dev_type1;
>  	int ret;
>  
>  	/* Read ADC value according to external cable or button */
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
