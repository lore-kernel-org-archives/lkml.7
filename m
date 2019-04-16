Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1381FC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0B82070D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EUQL3v8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfDPCbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:31:39 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:26383 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDPCbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:31:39 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190416023135epoutp03a191319ecdfcd04d8b6625e34871d9ab~V05fdSN6J3011930119epoutp03T
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 02:31:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190416023135epoutp03a191319ecdfcd04d8b6625e34871d9ab~V05fdSN6J3011930119epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555381895;
        bh=VX/waeOcGicd8y0lWlTTkK+KotxzjZvsL3Ip17xe7wY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=EUQL3v8Y6VBukBKSRn0QSnTSOiUJm9uTJF5CRTghUWWMxKG+Lqb9NAF5/BTPipAdF
         aT8XjzFm0LMpReonWXsaxEyAQTKmsSyNtjxaTnGs9hmYZudqXosOw2MR93OpHD77qd
         TOnpO7MpTM1QGOFpE7u3Uqo10cM6lc6kEVbX86oM=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190416023132epcas1p28499e2f55510c0a4692c3a9904165182~V05cdF1l71782417824epcas1p2x;
        Tue, 16 Apr 2019 02:31:32 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.F2.04108.48E35BC5; Tue, 16 Apr 2019 11:31:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190416023131epcas1p2655921437f8fc56844e87f08a09ca671~V05bznXTT1782417824epcas1p2w;
        Tue, 16 Apr 2019 02:31:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190416023131epsmtrp1468782e7c96283b8cfcd7ad6231cb588~V05byvzd81279212792epsmtrp1g;
        Tue, 16 Apr 2019 02:31:31 +0000 (GMT)
X-AuditID: b6c32a39-89fff7000000100c-37-5cb53e84f36c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.31.03692.38E35BC5; Tue, 16 Apr 2019 11:31:31 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190416023131epsmtip149ced13d5daccfb6f79e9f4f649dab07~V05bm_7h01311713117epsmtip1g;
        Tue, 16 Apr 2019 02:31:31 +0000 (GMT)
Subject: Re: [PATCH v2 06/19] PM / devfreq: tegra: Fix missed error checking
 on devfreq initialization failure
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
Message-ID: <b610cdf7-5ca7-0f29-f74d-fb7892796577@samsung.com>
Date:   Tue, 16 Apr 2019 11:32:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415145505.18397-7-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHebezs6O1fJtZT4JpJyKytB3n7BgqlhKDpIS+VFjr4E5O3XbG
        zrSLBWZmJV6KCGqV2Y2sKMOslmWypZVEZna/jOxCqZRWpl2ky+Yx8tvvufzf5/I+lFx9lgyl
        sq0O3m7lzDQZSFy8PlMTVZx0IUNz9iPFnv78BrHFziMEe6fog5K933CAZPvLmxG746uTZJ9v
        riHZHw1VBFtxpoNMDtC7vMeQ/rLTq9SXb+kl9RX1p5C+v25KumJFboKJ54y8PYK3ZgrGbGtW
        Ir1oqSHFoIvTMFFMPDuXjrByFj6RTk1Lj1qYbfY1REfkc+Y8nyudE0V6TlKCXchz8BEmQXQk
        0rzNaLbF26JFziLmWbOiMwXLPEajidH5ElfnmsqutJO2ojHrhs4FF6LPVCmiKMCx8KnSWIoC
        KTV2IXh+6QSSjC8I9uzqV0rGIALnnZ3Kf4qf5YTkb0TwrbpqRNGH4OmLbkUpCqCCsQ2KrmxW
        +AMT8G8EXxr2DgfkeDkMuI/L/UziSGjqekL6OQhPhYff3yA/q3AS/DrSO+wn8HTY3/tQ6ecQ
        vAxe3jinkHLGQ+u+t4SfA3ActDR6Rt6fBM/eHpJJHA5bLuyX+5sAPERC7bsnw4UBp0LP4FdC
        4mDouVmvlDgUuitLRrgATrY2k5J4O4L6pnaFFNBC0/HdMv8u5Hgm1DbMkYqNg96BMoW0IhVs
        L1FL2dPgfqdXJvFkOLptBymxHlo698p2oqnOUeM4R43gHDWC83+xakScQhN5m2jJ4kXGphv9
        2XVo+FYj413oRluaB2EK0WNVVFl9hlrB5YvrLR4ElJyeoJpv9LlURm79Bt4uGOx5Zl70IJ1v
        27vkoSGZgu/yrQ4Do4vRarVsLBOnYxh6kqo2OSVDjbM4B5/L8zbe/k8nowJCC1FOQU0YTi7o
        zHngig5PTus7/21j7KvW1Q+ahYVewRS0tbEHBVqz+8hrA2vqEk1VriXmjoMhGYvDBd2MpJpH
        LYerC6bPFstk3y+786fEDF0dDDFUHL1qKDxsfv/U03brU7R7rff1n+Yg7SZ3mP5S18rWx6t+
        LVhCu823Z8XdfVc55h5NiCaOiZTbRe4vCKNHFcEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnG6z3dYYg9tTFSxWf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyenZfYCto4q74vUG4gfEjRxcjB4eEgInEr16W
        LkYuDiGB3YwSz1YtAHI4geKSEtMuHmWGqBGWOHy4GKLmLaPEhxuXmEBqhAUKJJp2N7KCJEQE
        mpgkPj9sAUswC0RK9D/qZoXo2Moose/HbrCpbAJaEvtf3GADsfkFFCWu/njMCGLzCthJ/F30
        DizOIqAqMfvdVXYQW1QgQuLM+xUsEDWCEidnPgGzOQXMJI7uPcQKsUxd4s+8S8wQtrjErSfz
        oY6Ql2jeOpt5AqPwLCTts5C0zELSMgtJywJGllWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ
        +bmbGMERpqW5g/HykvhDjAIcjEo8vAl9W2KEWBPLiitzDzFKcDArifA6pgCFeFMSK6tSi/Lj
        i0pzUosPMUpzsCiJ8z7NOxYpJJCeWJKanZpakFoEk2Xi4JRqYMwRebQo5cC8nJ5JW3k3nVm/
        Xmnr8mPRc+X2Tft+ufF43NaCO4G/b3Ws5Gg90rQgujSvdJXP6d9Tv/344tteOZ/fUOmi4oQJ
        1lefR/Lci6pasN+w7fu5ks5358SVbc/prZt+j5tPeOHdJ/91LhRePb73L3ex4PbzXtZfrA8d
        LFrks8Fym1rixdc3lViKMxINtZiLihMBco7M2KwCAAA=
X-CMS-MailID: 20190416023131epcas1p2655921437f8fc56844e87f08a09ca671
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190415145756epcas3p36a0597ca84dfbe079f9a453d8b28fea0
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145756epcas3p36a0597ca84dfbe079f9a453d8b28fea0@epcas3p3.samsung.com>
        <20190415145505.18397-7-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

patch6/7/8/9 are for handling of exception handling in probe() function.
Actually, I'm not sure that there are special reason to split out
the patches. I think that you can squash patch6/7/8/9 to only one patch.

Also, even if patch6/7/8/9 handle the exception handling in probe(),
the tegra_devfreq_probe() doesn't support the restoring sequence
when fail happen. I think that if you want to fix the fail case of probe(),
please add the restoring sequence about following function.
- clk_disable_unprepare()
- clk_notifier_unregister()
- dev_pm_opp_remove()


On 19. 4. 15. 오후 11:54, Dmitry Osipenko wrote:
> The code doesn't check for devfreq initialization failure, fix it.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index f0f0d78f6cbf..aa0478464b35 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -707,6 +707,10 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  						 &tegra_devfreq_profile,
>  						 "tegra_actmon",
>  						 NULL);
> +	if (IS_ERR(tegra->devfreq)) {
> +		err = PTR_ERR(tegra->devfreq);
> +		return err;
> +	}
>  
>  	return 0;
>  }
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
