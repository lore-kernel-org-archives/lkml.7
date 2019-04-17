Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5B9C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 01:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCBB21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 01:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jeH/bDGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbfDQBBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 21:01:36 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:22147 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfDQBBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 21:01:36 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190417010132epoutp021cdd50379139ff78cd7d4fc338f8f777~WHUJoyrz82130521305epoutp02e
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 01:01:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190417010132epoutp021cdd50379139ff78cd7d4fc338f8f777~WHUJoyrz82130521305epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555462892;
        bh=kbVyRbBkJIQSTO3fctjU3q1mQrZihQN25qYox3+sA9E=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=jeH/bDGIW2uaWi3jswnNRSEG9M22NDKwnxQZIt98QYC22Bm4ih4yoBs3tQzx0R+0c
         BfymrBSr4Mp5QSLfDB+y7Velkn9xJvEcNL7IIRSBSRcMQNV/0pELsGSAayhRP5ltoQ
         7bm3mmlzl5FhMWEVOgAS9eP0Cq7tsZIkH1yDzenI=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.153]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190417010118epcas1p1f2f55b13790baa1d6fab9128e64576ef~WHT8yxupI1362613626epcas1p1T;
        Wed, 17 Apr 2019 01:01:18 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.38.04108.DDA76BC5; Wed, 17 Apr 2019 10:01:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190417010117epcas1p4356130d02723698c03f9e85ab637abde~WHT7olLlP0706907069epcas1p4z;
        Wed, 17 Apr 2019 01:01:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190417010117epsmtrp271fa3427ca2f9b370442771c855cec63~WHT7nzl7i1760617606epsmtrp2C;
        Wed, 17 Apr 2019 01:01:17 +0000 (GMT)
X-AuditID: b6c32a39-8b7ff7000000100c-ae-5cb67adda029
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7A.BA.03692.DDA76BC5; Wed, 17 Apr 2019 10:01:17 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190417010117epsmtip28ed24b22f0055e57b7ee16c1d3b3c2a6~WHT7ZGyUP3118131181epsmtip2C;
        Wed, 17 Apr 2019 01:01:17 +0000 (GMT)
Subject: Re: [PATCH v2 02/19] PM / devfreq: tegra: Replace readl-writel with
 relaxed versions
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <127f2e0c-1cd0-25d9-1029-92af86775af8@samsung.com>
Date:   Wed, 17 Apr 2019 10:02:13 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415145505.18397-3-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzHfe957ukujqer+MhGHuVH2+ke5/KUEmPcJhM2w5rzrHtWp/vl
        nsv6gSFS+V0Kj4akzY8J7Wp1K80h+oNQIbkx9QdmNS7UNNzdw/Tf6/t9vz8/v18ZpqwlImRG
        i4OzW1gTRQTjDffmqVWevIY0dU37XOb6lz7EHBAu4czj/Z+DmE5XJcF4j95HTPGQQDC9+64Q
        zIjrPM4cu/GcWCrXNXouI12T4AnSHS0YIHTHnNeQzls3PVW6JSsxk2MNnD2Ss6RbDUZLRhK1
        eoN+uV4bp6ZVdDyziIq0sGYuiVqRkqpaaTT5GqIid7KmbN9VKsvzVOySRLs128FFZlp5RxLF
        2QwmW7xtPs+a+WxLxvx0qzmBVqsXaH3GbVmZPyt+S2ynJ+QIhY+ke9EXeQmSy4BcCPU/bkn8
        rCQbEQwf2l2Cgn38FcH75mZCFL4jeHhxRwmSBQJeuKNETwuCr4NeiXgYRNB7+lkgUyiph4LC
        poAQRv7yuVxnpH4BIzfDt7s1mJ8JMgZaP7wKVJhEzoTu4T7kZwW5BKpGmgN+nIwGd39bgMPJ
        TfC27ZZU9IRA+9l+3M9yMg4OjtbiYv4p8Lr/gkTkGVBQfw7zNwHkbwI6ejy4OPMKeHz5JSZy
        KHx66AwSOQK8Ay2EyPlwtf0+IQYXIXC2PpWKggZaa8ok/l1g5Dy46YoVi02EgW9HpOKKFFBU
        qBTds6DznUci8lSoPlT8N70Ohr1D0hNopjBmHGHMCMKYEYT/xS4i/BqazNl4cwbH0zbt2Meu
        Q4G/GhPfiNqepLgRKUPUBMW40fo0pZTdyeea3QhkGBWmWGZwpikVBjY3j7Nb9fZsE8e7kda3
        7ZNYRHi61ffzLQ49rV2g0WiYhXSclqapKYqbS5enKckM1sFlcZyNs/+Lk8jkEXtRh3HV1ekV
        Wxty+zaPFpVC16LShMmjx/MHz+5Y3eXqLvueUl4+dLh4/Zk53J0olzv0lSok58juU46Vv25H
        r+l40I/vck6aW5GHv+nlG41lRdNKkypnhy/evhHW7OmpbNlTCWXlWVXrulp7VHVhVPXa3Kbb
        UZqqsHUfc5KT9R1CQfJ4CuczWToGs/PsHyOY0lrBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSvO7dqm0xBjtncFus/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBl/J72n6lgOk/FrLYTrA2MHzm7GDk4JARMJK4d
        Uuli5OIQEtjNKLHr/FW2LkZOoLikxLSLR5khaoQlDh8uhqh5yyix9OJmsBphgXiJ5radTCAJ
        EYEmJonPD1uYQBLMApES/Y+6WSE6tjJKfLu2GSzBJqAlsf/FDbBufgFFias/HjOC2LwCdhIL
        f+5hBbFZBFQlDj05BmaLCkRInHm/ggWiRlDi5MwnYDangJlE6591LBDL1CX+zLvEDGGLS9x6
        Mh/qCHmJ5q2zmScwCs9C0j4LScssJC2zkLQsYGRZxSiZWlCcm55bbFhgmJdarlecmFtcmpeu
        l5yfu4kRHGNamjsYLy+JP8QowMGoxMO74ufWGCHWxLLiytxDjBIczEoivI4pW2KEeFMSK6tS
        i/Lji0pzUosPMUpzsCiJ8z7NOxYpJJCeWJKanZpakFoEk2Xi4JRqYJzd8kBd/fWuXyYZj9zY
        jK4lnZv1psxvr9w/p9cpzsv33TRhFObOiPx49Pz3n9df+tZ+u2rRGXFiqfu2A5c2/F3H/4vN
        6Or5IjGjbSy+uzPYRN7vuth7l/HfOZ4rsmstThSdYjqxzj9Frdb5+ZbbD/44MkxQ8vqb9Kfl
        2t3JwlbRB27P4zH6femhEktxRqKhFnNRcSIAqcnPf60CAAA=
X-CMS-MailID: 20190417010117epcas1p4356130d02723698c03f9e85ab637abde
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190415145804epcas1p2c0d9f207713ae198599d34468261d64b
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145804epcas1p2c0d9f207713ae198599d34468261d64b@epcas1p2.samsung.com>
        <20190415145505.18397-3-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 4. 15. 오후 11:54, Dmitry Osipenko wrote:
> There is no need to insert memory barrier on each readl/writel
> invocation, hence use the relaxed versions.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index 02905978abe1..0c0909fba545 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -191,23 +191,23 @@ static struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
>  
>  static u32 actmon_readl(struct tegra_devfreq *tegra, u32 offset)
>  {
> -	return readl(tegra->regs + offset);
> +	return readl_relaxed(tegra->regs + offset);
>  }
>  
>  static void actmon_writel(struct tegra_devfreq *tegra, u32 val, u32 offset)
>  {
> -	writel(val, tegra->regs + offset);
> +	writel_relaxed(val, tegra->regs + offset);
>  }
>  
>  static u32 device_readl(struct tegra_devfreq_device *dev, u32 offset)
>  {
> -	return readl(dev->regs + offset);
> +	return readl_relaxed(dev->regs + offset);
>  }
>  
>  static void device_writel(struct tegra_devfreq_device *dev, u32 val,
>  			  u32 offset)
>  {
> -	writel(val, dev->regs + offset);
> +	writel_relaxed(val, dev->regs + offset);
>  }
>  
>  static unsigned long do_percent(unsigned long val, unsigned int pct)
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
