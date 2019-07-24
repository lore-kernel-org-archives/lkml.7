Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED8BC76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D666121BF6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kA675OiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfGXJzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 05:55:02 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:31395 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfGXJzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 05:55:02 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190724095500epoutp0321615cf0c2be4671dd3e83b2d32d28a1~0Tz51uR481721017210epoutp03x
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 09:55:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190724095500epoutp0321615cf0c2be4671dd3e83b2d32d28a1~0Tz51uR481721017210epoutp03x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563962100;
        bh=gacQlWzC8sJvTnfd8Tarac+RZzf+ZzOI2k0StCEZXIc=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=kA675OiN9RRb9aCKJZPVt5Agi/KsCnjmFwSYYi5d3DMFiqwQZHkRSz0BdRuWDinDi
         WIiBLI3A+cC2IYiyewfyqXsbyl32j1MWLVlV2M8BMiMOQ475pfTyJdHgQ9VzqSxxsi
         0B8uKyd0Bg+1CXa0CkCzAxMk/LXtZYNL+X/6sMUk=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190724095459epcas1p3700b508076e53793ef992750c929a1ee~0Tz5cq4Pl0461504615epcas1p3r;
        Wed, 24 Jul 2019 09:54:59 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 45trL94S4yzMqYkW; Wed, 24 Jul
        2019 09:54:57 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.D9.04160.1FA283D5; Wed, 24 Jul 2019 18:54:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190724095457epcas1p2fb48717e6929f4183da7caa11c11c886~0Tz291erl3246332463epcas1p21;
        Wed, 24 Jul 2019 09:54:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190724095457epsmtrp2c0bf8ef7c388ce39b5d4b82a8743a724~0Tz26oQdO3228832288epsmtrp22;
        Wed, 24 Jul 2019 09:54:57 +0000 (GMT)
X-AuditID: b6c32a38-b33ff70000001040-cc-5d382af19f5e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.91.03706.0FA283D5; Wed, 24 Jul 2019 18:54:57 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190724095456epsmtip1c8f346f971230f1a6cc4c6364fdf1b47~0Tz2pdpDp0058000580epsmtip1S;
        Wed, 24 Jul 2019 09:54:56 +0000 (GMT)
Subject: Re: [PATCH v1] extcon: arizona: Switch to use
 device_property_count_u32()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <7f7a9bae-2ffc-8cc2-1121-c861045cfa59@samsung.com>
Date:   Wed, 24 Jul 2019 18:57:59 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723174021.66718-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmge5HLYtYgxudKha9TdOZLK60bmK0
        uLxrDpvF7cYVbA4sHvNOBnpMn/Of0aNvyypGj8+b5AJYorJtMlITU1KLFFLzkvNTMvPSbZW8
        g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4A2KimUJeaUAoUCEouLlfTtbIryS0tSFTLy
        i0tslVILUnIKLAv0ihNzi0vz0vWS83OtDA0MjEyBChOyM2YcW8Je0MBesbN/G1sD42PWLkZO
        DgkBE4lZV38wdzFycQgJ7GCUWHfpEiuE84lRonfOWiYI5xtQ5sQt9i5GDrCWGc2lEPG9jBJH
        ek8xQjjvGSXunzrMBDJXWCBEou/VPrCEiMAmRom1S1aDJdgEtCT2v7jBBmLzCyhKXP3xmBHE
        5hWwk/jYexbMZhFQlbi5ZQrYgaICERKfHhxmhagRlDg58wkLiM0p4C5x5MM+sHpmAXGJW0/m
        M0HY8hLNW2czQzx3gE1i6dNkCNtF4v6UG+wQtrDEq+NboGwpic/v9rJB2NUSK08eYQM5WkKg
        g1Fiy/4L0FAylti/dDITyPvMApoS63fpQ4QVJXb+ngt1A5/Eu689rJAQ4pXoaBOCKFGWuPzg
        LhOELSmxuL0TapWHxKvus+wTGBVnIflsFpJvZiH5ZhbC4gWMLKsYxVILinPTU4sNC0yQY3sT
        Izg1alnsYNxzzucQowAHoxIPrwKDeawQa2JZcWXuIUYJDmYlEd7ABrNYId6UxMqq1KL8+KLS
        nNTiQ4ymwICfyCwlmpwPTNt5JfGGpkbGxsYWJoZmpoaGSuK88/5oxgoJpCeWpGanphakFsH0
        MXFwSjUwynZe+XjelTny4CO9xvyH+/YLbrJl+7fpxmGt2vjIHo3U/8+1U7gtAwJkwzpNRRaU
        +pz82xz469yPdE3z3ytKF054kJD9qdTni5O9w/rzy/9XnOC46bU/LMFTybDm2Y0ZcwXP7Xjz
        tWjHl1OiRhcsYn+zK9/J3XX8QWtc8sLfurHz/T/W3//3QImlOCPRUIu5qDgRAMdeM0ejAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSnO5HLYtYg1PTmSx6m4DEldZNjBaX
        d81hs7jduILNgcVj3slAj+lz/jN69G1ZxejxeZNcAEsUl01Kak5mWWqRvl0CV8aMY0vYCxrY
        K3b2b2NrYHzM2sXIwSEhYCIxo7m0i5GLQ0hgN6PEtR+HmLoYOYHikhLTLh5lhqgRljh8uBii
        5i2jxPdZXSwgNcICIRJ9r/YxgiREBDYxSvy6/YsdomoWo8Serk9gk9gEtCT2v7jBBmLzCyhK
        XP3xmBHE5hWwk/jYexbMZhFQlbi5ZQoriC0qECFxeMcsqBpBiZMzn4Bt4xRwlzjyYR9YnFlA
        XeLPvEvMELa4xK0n85kgbHmJ5q2zmScwCs1C0j4LScssJC2zkLQsYGRZxSiZWlCcm55bbFhg
        mJdarlecmFtcmpeul5yfu4kRHA1amjsYLy+JP8QowMGoxMOrwGAeK8SaWFZcmXuIUYKDWUmE
        N7DBLFaINyWxsiq1KD++qDQntfgQozQHi5I479O8Y5FCAumJJanZqakFqUUwWSYOTqkGRrPH
        4hX1p9umJ0sWmopdYRBaZavBZfGjlDfj/rTjp38c3aWZpBawz0jlTA+XpkOUsY2JvaPNwnSx
        0Mm1luZLFLslDapWfPfLveukcDNK6+5zpknqy19nnG3M8YxOFzEVK7poc/zYyUs2kVNaNuxw
        Nrvh1WjbHC2ub7ez8WHbuvlxO7ynK29UYinOSDTUYi4qTgQADoyP5oICAAA=
X-CMS-MailID: 20190724095457epcas1p2fb48717e6929f4183da7caa11c11c886
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190723174028epcas3p28ace5fe5d945c9d13a67f8658d7be49e
References: <CGME20190723174028epcas3p28ace5fe5d945c9d13a67f8658d7be49e@epcas3p2.samsung.com>
        <20190723174021.66718-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 7. 24. 오전 2:40, Andy Shevchenko wrote:
> Use use device_property_count_u32() directly, that makes code neater.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/extcon/extcon-arizona.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
> index 7e9f4c9ee87d..e970134c95fa 100644
> --- a/drivers/extcon/extcon-arizona.c
> +++ b/drivers/extcon/extcon-arizona.c
> @@ -1253,7 +1253,7 @@ static int arizona_extcon_get_micd_configs(struct device *dev,
>  	int i, j;
>  	u32 *vals;
>  
> -	nconfs = device_property_read_u32_array(arizona->dev, prop, NULL, 0);
> +	nconfs = device_property_count_u32(arizona->dev, prop);
>  	if (nconfs <= 0)
>  		return 0;
>  
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
