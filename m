Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F24C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BB9205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UIc0pMNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfLJElB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:41:01 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:41799 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfLJElB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:41:01 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191210044057epoutp022197a69eb2a315f73bbd087b719e5273~e6MYcLU4V0190601906epoutp021
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 04:40:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191210044057epoutp022197a69eb2a315f73bbd087b719e5273~e6MYcLU4V0190601906epoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575952857;
        bh=0aHgv6I5n6zloYGGXpmUFbpr1AC6keJ830N7MzWtD3k=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=UIc0pMNn/c04HQj81dkyoHw0KiJGGGU916hHaeNLMSH43iqQV7vQr1yRRCKBgAH+E
         ZuRWH1E+hMbBF0Dm4nxwB9+U4rJ2zRlbmoWIgm6K9hHaSW/v1iVviO0/tjXTpsLF5z
         LsrVu76U7uUSS64HgqXUvIAZ4rr87C2eCSznKArc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191210044056epcas1p469d65f6853c497793675e3e118eb9824~e6MX6O_ng2442824428epcas1p4P;
        Tue, 10 Dec 2019 04:40:56 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47X6nf3f5vzMqYkY; Tue, 10 Dec
        2019 04:40:54 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.F0.48019.FC12FED5; Tue, 10 Dec 2019 13:40:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191210044046epcas1p3e9343cc918be7dd39f49592cf1047e1c~e6MOp_BNz1727817278epcas1p3I;
        Tue, 10 Dec 2019 04:40:46 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191210044046epsmtrp282f32f7a7949189d4cbd74e06265cdb2~e6MOpEIsU0529105291epsmtrp2_;
        Tue, 10 Dec 2019 04:40:46 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-fe-5def21cfdb65
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BB.1A.06569.EC12FED5; Tue, 10 Dec 2019 13:40:46 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191210044046epsmtip14192116ffeb1cff8bdaae28f419c7ab8~e6MOiKLXs1173711737epsmtip1B;
        Tue, 10 Dec 2019 04:40:46 +0000 (GMT)
Subject: Re: [PATCH 01/10] extcon: arizona: Correct clean up if
 arizona_identify_headphone fails
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     myungjoo.ham@samsung.com, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <c1db1ef9-91e7-0475-8c19-86fd8102cd17@samsung.com>
Date:   Tue, 10 Dec 2019 13:47:12 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20191209110916.29524-1-ckeepax@opensource.cirrus.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTT/e84vtYg1Wt0hZXWjcxWlzeNYfN
        4nbjCjaLz+/3szqweEyf85/Ro2/LKkaPz5vkApijsm0yUhNTUosUUvOS81My89JtlbyD453j
        Tc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgLYpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yV
        UgtScgosC/SKE3OLS/PS9ZLzc60MDQyMTIEKE7IzOs6+ZC34z17xoX0mWwPjNbYuRk4OCQET
        iXm3jzJ3MXJxCAnsYJToaJnKBuF8YpR4f+g2lPONUWLbocmMMC1L+v5DtexllPhy6TYLhPOe
        UeLM6vvMIFXCAkkSb59cALNFBIwkPh6/xQRiMwtESyz4vAxsOZuAlsT+FzfAbH4BRYmrPx6D
        beAVsJP4390AVM/BwSKgKrFyuwdIWFQgTOLkthaoEkGJkzOfsIDYnALOEmue72KBGC8ucevJ
        fKhV8hLb384BO1RC4AibxNSJ06E+cJG40nKAGcIWlnh1fAs7hC0l8fndXmjAVEusPHmEDaK5
        g1Fiy/4LrBAJY4n9SyeDHccsoCmxfpc+RFhRYufvuYwQi/kk3n3tYQUpkRDglehoE4IoUZa4
        /OAuE4QtKbG4vZNtAqPSLCTvzELywiwkL8xCWLaAkWUVo1hqQXFuemqxYYEJcmxvYgSnRC2L
        HYx7zvkcYhTgYFTi4V3g8C5WiDWxrLgy9xCjBAezkgjv8TagEG9KYmVValF+fFFpTmrxIUZT
        YGBPZJYSTc4Hpuu8knhDUyNjY2MLE0MzU0NDJXFejh8XY4UE0hNLUrNTUwtSi2D6mDg4pRoY
        o367y20pkFNg8sm4uLTKMXLzpF4Z8Sd3GUT6L07M3pb52jvtt+K7j5MWFT79MWHP9UVBRuZ3
        Aj5/N/PY8UPkWKVmZKLLo97FlRka4mKbryyXr5F+suDH+/WZkjG5UisPbty67xTDhOap6ScC
        l/rotD9a3yN5iHWC1i5zm2mFT++a7LywSiZeRomlOCPRUIu5qDgRAMm2VvSfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSnO45xfexBu++qVtcad3EaHF51xw2
        i9uNK9gsPr/fz+rA4jF9zn9Gj74tqxg9Pm+SC2CO4rJJSc3JLEst0rdL4MroOPuSteA/e8WH
        9plsDYzX2LoYOTkkBEwklvT9Z+5i5OIQEtjNKHHjykNGiISkxLSLR4ESHEC2sMThw8UQNW8Z
        JWYsaWUBqREWSJJ4++QCM4gtImAk8fH4LSYQm1kgWuJS/1cWiIZpjBIdLyaDFbEJaEnsf3ED
        bDO/gKLE1R+PwZbxCthJ/O9uYAJZxiKgKrFyuwdIWFQgTGLnksdMECWCEidnPgHbyyngLLHm
        +S4WiF3qEn/mXWKGsMUlbj2ZD3WDvMT2t3OYJzAKz0LSPgtJyywkLbOQtCxgZFnFKJlaUJyb
        nltsWGCUl1quV5yYW1yal66XnJ+7iREcG1paOxhPnIg/xCjAwajEw+th9y5WiDWxrLgy9xCj
        BAezkgjv8TagEG9KYmVValF+fFFpTmrxIUZpDhYlcV75/GORQgLpiSWp2ampBalFMFkmDk6p
        BsbkoHf6l8relyXL8r3XDNpQ1dDSrasl0rWAU+RBjJV3Rfjfp6w/qubrb5+zvZT9QfcS3sAr
        ibahzjxnouNNNCLf35HJPrPGQqpRN0JqzcGmy032sksiJplcsf/PueHM7L+Ka+4udr9/iStT
        Rin9mYFQZb23hrmGUMnKQ0ffz/v1Sv+z+MLN65VYijMSDbWYi4oTAXUSQY6JAgAA
X-CMS-MailID: 20191210044046epcas1p3e9343cc918be7dd39f49592cf1047e1c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191209110925epcas4p3731ec3380f882027824b188439aa3bc9
References: <CGME20191209110925epcas4p3731ec3380f882027824b188439aa3bc9@epcas4p3.samsung.com>
        <20191209110916.29524-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/19 8:09 PM, Charles Keepax wrote:
> In the error path of arizona_identify_headphone, neither the clamp nor
> the PM runtime are cleaned up. Add calls to clean up both of these.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/extcon/extcon-arizona.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
> index e970134c95fab..79e9a24101823 100644
> --- a/drivers/extcon/extcon-arizona.c
> +++ b/drivers/extcon/extcon-arizona.c
> @@ -724,6 +724,9 @@ static void arizona_identify_headphone(struct arizona_extcon_info *info)
>  	return;
>  
>  err:
> +	arizona_extcon_hp_clamp(info, false);
> +	pm_runtime_put_autosuspend(info->dev);
> +
>  	regmap_update_bits(arizona->regmap, ARIZONA_ACCESSORY_DETECT_MODE_1,
>  			   ARIZONA_ACCDET_MODE_MASK, ARIZONA_ACCDET_MODE_MIC);
>  
> 

Applied these patches in this series. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
