Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962DDC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE8B2199C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fE8HJvWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfGXKNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 06:13:37 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:57993 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfGXKNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 06:13:36 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190724101334epoutp02cd183d0634ad4590878940f1d5d3d787~0UEHKmuTE2872328723epoutp023
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 10:13:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190724101334epoutp02cd183d0634ad4590878940f1d5d3d787~0UEHKmuTE2872328723epoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563963214;
        bh=dlSU5Hb7KyERK56QTSeEqX63Sp8U8qWENv6AcYBRUqU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fE8HJvWbFGY+VQluPPKBZSnAtkzFN2UIqhXK4xP/Rd5xLw+IdGo8+qRdKYwAMfWDM
         dYNHLlc1zSfAyT5UUzLGxxT52iyhQgPH2eNi0U4JXrgcTcwbpht6XwcUqO9ybBu5HI
         uiG6CpV+YkE3dD4vKT3tDkv8M1IdMchK9Pfp3T3c=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190724101333epcas1p164333765f1b988c16aec598a26dbba31~0UEGtXPqI2134821348epcas1p1w;
        Wed, 24 Jul 2019 10:13:33 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 45trlb1509zMqYkV; Wed, 24 Jul
        2019 10:13:31 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.A8.04066.A4F283D5; Wed, 24 Jul 2019 19:13:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190724101329epcas1p4922898dd0fdee60ad26461f0e0ff6ffc~0UEDQwxDz0895808958epcas1p4F;
        Wed, 24 Jul 2019 10:13:29 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190724101329epsmtrp2f7ebc7ffe6142def73def602a9eb9c57~0UEDQDOJn1150711507epsmtrp2D;
        Wed, 24 Jul 2019 10:13:29 +0000 (GMT)
X-AuditID: b6c32a37-e3fff70000000fe2-ce-5d382f4a8605
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.32.03638.94F283D5; Wed, 24 Jul 2019 19:13:29 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190724101329epsmtip29ed3b8771bbbe0ada22168cc7a3ee31e~0UEDGTNQC2396923969epsmtip2i;
        Wed, 24 Jul 2019 10:13:29 +0000 (GMT)
Subject: Re: [PATCH] extcon: arizona: Update binding example to use
 available defines
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     myungjoo.ham@samsung.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        patches@opensource.cirrus.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <55bef964-1680-27ef-2bd9-c44de2ee07fc@samsung.com>
Date:   Wed, 24 Jul 2019 19:16:32 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724094914.19284-1-ckeepax@opensource.cirrus.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH++3uXme0+nXVPC2wdSNIxcd1Tm8PIzBikH8o/VFEa13cTcW9
        2J2WWaDFSi3snbRSAxPKwmqo2UwGy1ILRk+K3pmVRfmsyAps213kf5/z+n3POb+jIOhzlEpR
        ZHEIdgtvYqiZ8o6b8clJ61I4ferFyQjukdONuMYeP8k99JyhuOYn92Xc88rzFDcx4iU5Z3dP
        xOoI3aWGS0jnbqmmdHVnppCutq0F6SbccbnkpuKVhQJvFOxqwZJvNRZZCrKYdesN2QZtRiqb
        xC7jMhm1hTcLWcyanNyktUWmQBuMupQ3lQRcubwoMimrVtqtJQ5BXWgVHVmMYDOabMtsySJv
        FkssBcn5VvNyNjU1TRtI3FpceHTIL7e1UjuuTnWRFaiVrEGRCsDpsM/5lqpBMxU07kTwa8AT
        NsYRtPo9csn4geDQ3dGIfyXjAx8JKdCNYLTrhCwYoPEIgsq9xiBH4Q3g+dqBghyN02Cs95ks
        WEDgJgS+K7WhAIUTwDv0lAryHLwIHv98F/Ir8SpoGmkkgizHS6D2jj8kEIM3wvibm6SUMxf6
        Tw3KgxyJs+HO4IFQDoFj4dlgY5gXwt7204TU9QQFB/yBWkWA10DfGCu5o+Bzb1t4MBVMDHdT
        EpfDhf6e0CoAVyFo894LL0wD3uZjsuA7BI6Hy54Uyb0Irv+uR5LsbBj+fjAspYSqfbSUshge
        vnkpk3g+NO2vpg4jxjVtGNe0AVzTBnD9FzuL5C1onmATzQWCyNo00z/bjUIXmpDZia74c3wI
        KxAzS6mekamnSb5ULDP7ECgIJlqZV5Ghp5VGvmynYLca7CUmQfQhbWDXRwhVTL41cO8Wh4HV
        pmk0Gi6dzdCyLBOrbPgTr6dxAe8QigXBJtj/1ckUkaoKFBWzvf12JfXCXEOfdGWzZIxuvCFf
        P7+O1D9Y/H750Bf/0/7JgW2JiTe0J291v875o7R/Kvs69iHy+PPH3uq5S03I+M25S0O38nGG
        jGvvvuxR1emaN/NTn9N/yfzO+qr6vBelSz+siJ4cjotNS8l9taWmKNqdYOm6nXWhfIHat7uP
        kYuFPJtA2EX+L7qUfgq3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSvK6nvkWswcEVxhZXWjcxWsw/co7V
        4vKuOWwWS69fZLK43biCzeLz+/2sFq17j7A7sHusmbeG0WPTqk42j+lz/jN69G1ZxejxeZNc
        AGsUl01Kak5mWWqRvl0CV8akF+dYCtaxVWz8v5u1gXEdaxcjJ4eEgInEp0fPmbsYuTiEBHYz
        SkxruM0OkZCUmHbxKFCCA8gWljh8uBii5i2jxNxDF8CahQXCJRouNLOA2CICRhIfj99iAili
        FljMKPFo7mGwIiGBaYwS15+VgdhsAloS+1/cYAOx+QUUJa7+eMwIYvMK2Eksfj+fGcRmEVCV
        6Dt1jgnEFhWIkDi8YxZUjaDEyZlPwJZxCjhLnHrSDVbDLKAu8WfeJWYIW1zi1pP5UHF5ieat
        s5knMArPQtI+C0nLLCQts5C0LGBkWcUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERxP
        Wlo7GE+ciD/EKMDBqMTDq8BgHivEmlhWXJl7iFGCg1lJhDewwSxWiDclsbIqtSg/vqg0J7X4
        EKM0B4uSOK98/rFIIYH0xJLU7NTUgtQimCwTB6dUA2P3ND3fM18rg57ty+hQznunWe3Gpj+b
        Sf1hzg4h9QNJbSEXdrvMb3xzmPvrv+5lk8IzD/PIzbw6//GZ0D9ym1amTTw+PYTxp+hmreIJ
        cbLP+fpbzjVm2y+/lcS32yhP1zM86IYM97bnZ/U2ZJhOv/pBR/f4VFXrwKbHqxmb9MM/5jmc
        fDdR7ZQSS3FGoqEWc1FxIgBFlPHTowIAAA==
X-CMS-MailID: 20190724101329epcas1p4922898dd0fdee60ad26461f0e0ff6ffc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190724094922epcas5p3382c6fedfd2c450fc975223cef1de319
References: <CGME20190724094922epcas5p3382c6fedfd2c450fc975223cef1de319@epcas5p3.samsung.com>
        <20190724094914.19284-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 7. 24. 오후 6:49, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  Documentation/devicetree/bindings/extcon/extcon-arizona.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-arizona.txt b/Documentation/devicetree/bindings/extcon/extcon-arizona.txt
> index 7f3d94ae81ffb..208daaff0be4f 100644
> --- a/Documentation/devicetree/bindings/extcon/extcon-arizona.txt
> +++ b/Documentation/devicetree/bindings/extcon/extcon-arizona.txt
> @@ -72,5 +72,5 @@ codec: wm8280@0 {
>  		1 2 1 /* MICDET2 MICBIAS2 GPIO=high */
>  	>;
>  
> -	wlf,gpsw = <0>;
> +	wlf,gpsw = <ARIZONA_GPSW_OPEN>;
>  };
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
