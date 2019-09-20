Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76082C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32231207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OWzWpTQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408324AbfITIjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 04:39:21 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:17901 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405234AbfITIjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 04:39:20 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190920083916epoutp012e33b8b7716003bf920dead1aab208e1~GGMV4NTb53155131551epoutp01h
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 08:39:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190920083916epoutp012e33b8b7716003bf920dead1aab208e1~GGMV4NTb53155131551epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568968756;
        bh=efRw/gfY7ubfwMTEkAs6Gt4/SlO0Dgp1d7MUXfkN+ck=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OWzWpTQ4wMJnpmLhrgmw/6ejTyUI3uX60U+c/OOPLQ1AEOpJz9LrSfhUKgnU1JM9b
         KywsSmkOMBxPpPZ0o6fidqqfGsod48p+TMRGyzwzFt+FX86Y4rbmw4oKdoosg6mRaS
         yQnXN2SN3pwt+skoKuPbGKxYLuPeuGrQ5aDZYB6U=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190920083916epcas1p3f6cdc4f9ebff598567d36f574407ed35~GGMVplhlz0377503775epcas1p35;
        Fri, 20 Sep 2019 08:39:16 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 46ZRw06dwpzMqYkV; Fri, 20 Sep
        2019 08:39:12 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        51.D1.04088.E20948D5; Fri, 20 Sep 2019 17:39:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190920083909epcas1p3bc3ad873a3d16033bc333ab18ffc89f9~GGMPc-_TB2597825978epcas1p3d;
        Fri, 20 Sep 2019 08:39:09 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190920083909epsmtrp1cba64cd55cc183482686b81ed572e96d~GGMPcS5TR3033830338epsmtrp1u;
        Fri, 20 Sep 2019 08:39:09 +0000 (GMT)
X-AuditID: b6c32a35-845ff70000000ff8-d1-5d84902e1586
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.54.03638.D20948D5; Fri, 20 Sep 2019 17:39:09 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190920083909epsmtip2dff0a4965bbd896e7eaa57abd07d0117~GGMPSiQyp3085130851epsmtip2g;
        Fri, 20 Sep 2019 08:39:09 +0000 (GMT)
Subject: Re: [PATCH v2] extcon-intel-cht-wc: Don't reset USB data connection
 at probe
To:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <28c4f3e6-1863-6a72-8edb-ad0639d126f9@samsung.com>
Date:   Fri, 20 Sep 2019 17:43:37 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916211536.29646-2-jekhor@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmga7ehJZYgxeLpCx6m6YzWbw5DiQO
        rlvKanF51xw2i9uNK9gcWD12zrrL7jHvZKDH+31X2Tz6tqxi9Pi8SS6ANSrbJiM1MSW1SCE1
        Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdot5JCWWJOKVAoILG4WEnf
        zqYov7QkVSEjv7jEVim1ICWnwLJArzgxt7g0L10vOT/XytDAwMgUqDAhO+PpsRVsBfOkKw4t
        2c7cwLhWtIuRk0NCwERi45JJTF2MXBxCAjsYJSb9nMUG4XxilPh+8zgrhPONUWLi1O2sMC1z
        79xnArGFBPYySpxZKglR9J5R4kLXZRaQhLBAuMSDqxcYQWwRgXyJ3nvdYDazQJxE14S3YDab
        gJbE/hc32EBsfgFFias/HoPFeQXsJCZNfA+2gEVAVeLt9glgtqhAhMSnB4dZIWoEJU7OfAK2
        i1PATOLG/JesEPPFJW49mc8EYctLNG+dzQxynITAdTaJI/0HGSE+cJHYc3UiO4QtLPHq+BYo
        W0riZX8blF0tsfLkETaI5g5GiS37L0C9byyxf+lkoA0cQBs0Jdbv0ocIK0rs/D0X6kk+iXdf
        e1hBSiQEeCU62oQgSpQlLj+4ywRhS0osbu9km8CoNAvJO7OQvDALyQuzEJYtYGRZxSiWWlCc
        m55abFhgiBzbmxjB6VLLdAfjlHM+hxgFOBiVeHgVyptjhVgTy4orcw8xSnAwK4nwzjFtihXi
        TUmsrEotyo8vKs1JLT7EaAoM7YnMUqLJ+cBUnlcSb2hqZGxsbGFiaGZqaKgkzuuR3hArJJCe
        WJKanZpakFoE08fEwSnVwLjFpqNE43vk14tb8o4rM25tat7gqL1Z8/bcvfY8D5UeVrxcnbST
        6SlT0lWBWMMTtqnOR5yMvtYXCzYbGmY9Oz1d/vK3vDTezetqeloFph1cXH/i6/7Atxk3vD+r
        WZtPfLpKWOI2R1Ok5II7KnfqfhQvTu3v0d9uv/aYWI+ut7LeT3EvkQlWkUosxRmJhlrMRcWJ
        ABUo8u2tAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42LZdlhJXld3QkusQeMxNYvepulMFm+OA4mD
        65ayWlzeNYfN4nbjCjYHVo+ds+6ye8w7Gejxft9VNo++LasYPT5vkgtgjeKySUnNySxLLdK3
        S+DKeHpsBVvBPOmKQ0u2MzcwrhXtYuTkkBAwkZh75z4TiC0ksJtRYvLaPIi4pMS0i0eZuxg5
        gGxhicOHiyFK3jJK7HwgDGILC4RLPLh6gRHEFhHIl3i0aDMriM0sECdx6NFJqJFbGSUObFAE
        sdkEtCT2v7jBBmLzCyhKXP3xGKyXV8BOYtLE92D1LAKqEm+3TwCzRQUiJA7vmAVVIyhxcuYT
        FhCbU8BM4sb8l1C71CX+zLvEDGGLS9x6Mp8JwpaXaN46m3kCo/AsJO2zkLTMQtIyC0nLAkaW
        VYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwTGjpbWD8cSJ+EOMAhyMSjy8CuXNsUKs
        iWXFlbmHGCU4mJVEeOeYNsUK8aYkVlalFuXHF5XmpBYfYpTmYFES55XPPxYpJJCeWJKanZpa
        kFoEk2Xi4JRqYAwv2n78xqRo9y2ub24zVN79++iTTdfh9StCzQ//Dfu9jkPvjcBa96xkaa/r
        es3HhX8X7th6MVH0Q0f3nWlLLx/0+uP4tqOd5UfSk5VtHSI/Qut/PxSJmn/1u+SkT6uSRJN9
        Cy9obkjS256x8MqSgtMPpr05fc12WY1Yvdsu50fpB0PSp57d8j1IiaU4I9FQi7moOBEArms9
        U5UCAAA=
X-CMS-MailID: 20190920083909epcas1p3bc3ad873a3d16033bc333ab18ffc89f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190916211554epcas5p12a0e99ce7fd3b015dded6ec4f01d1ff1
References: <20190916211536.29646-1-jekhor@gmail.com>
        <CGME20190916211554epcas5p12a0e99ce7fd3b015dded6ec4f01d1ff1@epcas5p1.samsung.com>
        <20190916211536.29646-2-jekhor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 9. 17. 오전 6:15, Yauhen Kharuzhy wrote:
> Intel Cherry Trail Whiskey Cove extcon driver connect USB data lines to
> PMIC at driver probing for further charger detection. This causes reset of
> USB data sessions and removing all devices from bus. If system was
> booted from Live CD or USB dongle, this makes system unusable.
> 
> Check if USB ID pin is floating and re-route data lines in this case
> only, don't touch otherwise.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>  drivers/extcon/extcon-intel-cht-wc.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
> index 9d32150e68db..da1886a92f75 100644
> --- a/drivers/extcon/extcon-intel-cht-wc.c
> +++ b/drivers/extcon/extcon-intel-cht-wc.c
> @@ -338,6 +338,7 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
>  	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
>  	struct cht_wc_extcon_data *ext;
>  	unsigned long mask = ~(CHT_WC_PWRSRC_VBUS | CHT_WC_PWRSRC_USBID_MASK);
> +	int pwrsrc_sts, id;
>  	int irq, ret;
>  
>  	irq = platform_get_irq(pdev, 0);
> @@ -387,8 +388,19 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
>  		goto disable_sw_control;
>  	}
>  
> -	/* Route D+ and D- to PMIC for initial charger detection */
> -	cht_wc_extcon_set_phymux(ext, MUX_SEL_PMIC);
> +	ret = regmap_read(ext->regmap, CHT_WC_PWRSRC_STS, &pwrsrc_sts);
> +	if (ret) {
> +		dev_err(ext->dev, "Error reading pwrsrc status: %d\n", ret);
> +		goto disable_sw_control;
> +	}
> +
> +	id = cht_wc_extcon_get_id(ext, pwrsrc_sts);
> +
> +	/* If no USB host or device connected, route D+ and D- to PMIC for
> +	 * initial charger detection
> +	 */
> +	if (id != INTEL_USB_ID_GND)
> +		cht_wc_extcon_set_phymux(ext, MUX_SEL_PMIC);
>  
>  	/* Get initial state */
>  	cht_wc_extcon_pwrsrc_event(ext);
> 

I edit this patch as following by myself and then applied it.

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 9d32150e68db..771f6f4cf92e 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -338,6 +338,7 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
        struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
        struct cht_wc_extcon_data *ext;
        unsigned long mask = ~(CHT_WC_PWRSRC_VBUS | CHT_WC_PWRSRC_USBID_MASK);
+       int pwrsrc_sts, id;
        int irq, ret;

        irq = platform_get_irq(pdev, 0);
@@ -387,8 +388,19 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
                goto disable_sw_control;
        }

-       /* Route D+ and D- to PMIC for initial charger detection */
-       cht_wc_extcon_set_phymux(ext, MUX_SEL_PMIC);
+       ret = regmap_read(ext->regmap, CHT_WC_PWRSRC_STS, &pwrsrc_sts);
+       if (ret) {
+               dev_err(ext->dev, "Error reading pwrsrc status: %d\n", ret);
+               goto disable_sw_control;
+       }
+
+       /*
+        * If no USB host or device connected, route D+ and D- to PMIC for
+        * initial charger detection
+        */
+       id = cht_wc_extcon_get_id(ext, pwrsrc_sts);
+       if (id != INTEL_USB_ID_GND)
+               cht_wc_extcon_set_phymux(ext, MUX_SEL_PMIC);



-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
