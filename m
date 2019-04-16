Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E63AC10F12
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 01:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFB620854
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 01:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NU0Uk0ZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfDPBwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 21:52:02 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:57613 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbfDPBwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 21:52:01 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190416015157epoutp03e7469fc85e016e3455ddf7f91fab3c04~V0W4sJCLz2459624596epoutp03j
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 01:51:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190416015157epoutp03e7469fc85e016e3455ddf7f91fab3c04~V0W4sJCLz2459624596epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555379517;
        bh=chTSeolOb4H3nSuRqWP7iRv0nT+9y0gq0Uu81e/arLw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NU0Uk0ZDNRyIuDX9IA1gNJC3bIQQZbof+pAl4SFVUaDirmIjk5ZSnskZ/Z+z7zPJV
         cD19a5ck6wpFlRk95H1usjaiwWoR1M0xweOg70z2nt+lWX4KZCAQyr7DcFEQpZzU9x
         1yL+XTplBEs6sYR89esYHzwcWdW+carEq/vf/4Oo=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190416015154epcas1p3f79a3e8a42ecd8a3ce5778cba9b8c437~V0W1uOAhN3154731547epcas1p3u;
        Tue, 16 Apr 2019 01:51:54 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.AA.04143.53535BC5; Tue, 16 Apr 2019 10:51:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190416015149epcas1p15bb993e9d8436dd766a9ab7b4c6838ef~V0WxJ4zEQ0996509965epcas1p1h;
        Tue, 16 Apr 2019 01:51:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190416015149epsmtrp1bc7bc8f31f648e9939cf57ca52b65bdb~V0WxGI4J_3124131241epsmtrp1P;
        Tue, 16 Apr 2019 01:51:49 +0000 (GMT)
X-AuditID: b6c32a37-f31ff7000000102f-6e-5cb535354105
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.CE.03692.53535BC5; Tue, 16 Apr 2019 10:51:49 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190416015149epsmtip1dff38df0cbdff2f118e9fd0e08ca8836~V0Ww8ZIN20286502865epsmtip1J;
        Tue, 16 Apr 2019 01:51:49 +0000 (GMT)
Subject: Re: [PATCH v2 03/19] PM / devfreq: tegra: Don't ignore clk errors
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
Message-ID: <1e4038d1-0fd3-f6d2-4e01-d34b16aeddbd@samsung.com>
Date:   Tue, 16 Apr 2019 10:52:44 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415145505.18397-4-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmnq6Z6dYYgw8v2CxWf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22V
        XHwCdN0yc4AOUlIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfmFpfmpesl
        5+daGRoYGJkCFSZkZ5zpn8lU0M1bsffjSbYGxjNcXYycHBICJhKvezawdDFycQgJ7GCUmPWk
        lx3C+cQo8f3jdmYI5xujxJnvd5hgWta+PcIIkdjLKLGprx/Kec8osb7xKwtIlbCAl8S334fZ
        QBIiAv8YJT7tmsEKkmAWiJT4enApM4jNJqAlsf/FDTYQm19AUeLqj8eMIDavgJ3E2QePwWpY
        BFQl1m15A1YjKhAhcf/YBlaIGkGJkzOfgC3jFDCTuPNoAdR8cYlbT+YzQdjyEs1bZ4P9ICHw
        n03i/LoVbBA/uEhs+vOJHcIWlnh1fAuULSXxsr8Nyq6WWHnyCBtEcwejxJb9F1ghEsYS+5dO
        BtrAAbRBU2L9Ln2IZXwS7772sIKEJQR4JTrahCCqlSUuP7gLDTpJicXtnVAneEj8uHKCcQKj
        4iwk78xC8sIsJC/MQli2gJFlFaNYakFxbnpqsWGBMXJ8b2IEJ1ct8x2MG875HGIU4GBU4uFN
        6NsSI8SaWFZcmXuIUYKDWUmE1zEFKMSbklhZlVqUH19UmpNafIjRFBjaE5mlRJPzgYk/ryTe
        0NTI2NjYwsTQzNTQUEmcd72Dc4yQQHpiSWp2ampBahFMHxMHp1QDo8hEL7sVkyWbn3/qaL64
        kE1T/MzvPdpSnTax96/Zyv/8d2w7d1VzrczSwMwfm57tuS6vxzQn72lex+sq7V3Hz3Flc23L
        KJ9fu/reJfZwbnk1FpPeifOvMUYKqBxX3c6nHFW39mFI/CmbV9YVcUcnpU6qTLrVw+327Ub3
        sX2WHivY0yfOMNDWVGIpzkg01GIuKk4EAP/Au+PEAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSnK6p6dYYg9PH+SxWf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyzvTPZCro5q3Y+/EkWwPjGa4uRk4OCQETibVv
        jzB2MXJxCAnsZpTouLuGBSIhKTHt4lHmLkYOIFtY4vDhYoiat4wSb+7dZAapERbwkvj2+zAb
        SEJEoIlJ4vPDFiaQBLNApET/o25WiI6tjBLzVh8G62AT0JLY/+IGG4jNL6AocfXHY0YQm1fA
        TuLsg8dgNSwCqhLrtrwBqxEViJA4834FC0SNoMTJmU/AbE4BM4k7jxawQixTl/gz7xIzhC0u
        cevJfKgj5CWat85mnsAoPAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFp
        Xrpecn7uJkZwlGlp7mC8vCT+EKMAB6MSD29C35YYIdbEsuLK3EOMEhzMSiK8jilAId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rxP845FCgmkJ5akZqemFqQWwWSZODilGhhFXdonzGTdt0/Jvovj
        ZJCg/D+bqi+38pnrfTMfB/lsSbrHf0ElqJ/p2D3hsos33j/c8dQ2beW9Qod7N2vYHe4vD37A
        8nDfCyX2sJRLOTytRlLrlZ588Evv7ftbkSMzn201S4OX0N27pgWC3mGZLhPE/GvfK+6QMRCd
        /Pi34e3F69oPlX+e2qDEUpyRaKjFXFScCAD9yH3nrgIAAA==
X-CMS-MailID: 20190416015149epcas1p15bb993e9d8436dd766a9ab7b4c6838ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190415145811epcas2p45772ac8ae956928341d76b80d3fa5e91
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145811epcas2p45772ac8ae956928341d76b80d3fa5e91@epcas2p4.samsung.com>
        <20190415145505.18397-4-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 4. 15. 오후 11:54, Dmitry Osipenko wrote:
> The clk_set_min_rate() could fail and in this case clk_set_rate() sets
> rate to 0, which may drop EMC rate to minimum and make machine very
> difficult to use.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index 0c0909fba545..69581c9082d4 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -487,6 +487,7 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>  	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
>  	struct dev_pm_opp *opp;
>  	unsigned long rate;
> +	int err;
>  
>  	opp = devfreq_recommended_opp(dev, freq, flags);
>  	if (IS_ERR(opp)) {
> @@ -496,8 +497,13 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>  	rate = dev_pm_opp_get_freq(opp);
>  	dev_pm_opp_put(opp);
>  
> -	clk_set_min_rate(tegra->emc_clock, rate);
> -	clk_set_rate(tegra->emc_clock, 0);
> +	err = clk_set_min_rate(tegra->emc_clock, rate);
> +	if (err)
> +		return err;
> +
> +	err = clk_set_rate(tegra->emc_clock, 0);
> +	if (err)

Why don't you restore the previous minimum clock for tegra->emc_clock
when failed to execute 'clk_set_rate(tegra->emc_clock, 0);'?

I think that if you control the restoring the previous minimum clock,
it is more nice to handle the error handling.

> +		return err;
>  
>  	return 0;
>  }
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
