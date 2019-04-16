Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF53C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF402073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sFKt8uOA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfDPHOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:14:38 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:36913 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfDPHOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:14:37 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190416071433epoutp04298081f1217a9bd2940f335fa74aa0b4~V4wj3rjJx0156801568epoutp04k
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 07:14:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190416071433epoutp04298081f1217a9bd2940f335fa74aa0b4~V4wj3rjJx0156801568epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555398874;
        bh=858S4hsDuPrVdU7z3ISnT6DboAcsQjVO2DwweJrHURY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=sFKt8uOAlpkvgSCxveUWL4hUk8kJr0I7OifKYAPMnw41pYio/P2x9rDpEOJa9WDaW
         JxE6XW9VkZV56h0wx9KpzRcWzLdoA5v+Pnt74D9cY6qiEZOSn9A6lpcyBL7xQAeSiy
         p1dhSNJG0Gj0nBqGjQh0yOSei1m//aVHoRgNqcvI=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190416071431epcas1p3084648e3b4f19026ebea05b00c67fbd6~V4whWry1Z0457504575epcas1p3m;
        Tue, 16 Apr 2019 07:14:31 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.37.04108.7C085BC5; Tue, 16 Apr 2019 16:14:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190416071415epcas1p30f91496a3ea6550157702db7120dab59~V4wSx4jX10452504525epcas1p3a;
        Tue, 16 Apr 2019 07:14:15 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190416071415epsmtrp2e1dbf881d8b6488df8ffa96bd714d90b~V4wSxBssQ0849908499epsmtrp2N;
        Tue, 16 Apr 2019 07:14:15 +0000 (GMT)
X-AuditID: b6c32a39-d0c179c00000100c-5b-5cb580c7be6b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.6E.03662.7C085BC5; Tue, 16 Apr 2019 16:14:15 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190416071415epsmtip1cf7bd106da1e7d8c053ea53ef0abdc62~V4wShLtVS1887918879epsmtip1-;
        Tue, 16 Apr 2019 07:14:15 +0000 (GMT)
Subject: Re: [PATCH v2 12/19] PM / devfreq: tegra: Avoid inconsistency of
 current frequency value
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
Message-ID: <375ebaba-1762-2675-3ae3-2ea9ec4cbcb2@samsung.com>
Date:   Tue, 16 Apr 2019 16:15:10 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415145505.18397-13-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGvV2mU0NxLIKHxiiO8YEmIGOpTA0YiVuNJBJ9UEiTOmknlNAt
        nZa4vIAgIhGjcWUUN8QoLhAoWolIBAR90OBCggsigmsMaikoIS6dDkbevnvOf9Z7cKm6HtPg
        +U4v63EydhKbKbvRkZiUdL+o2ZRycxDRV74PIbqUPy+jH+7+oqCftpzC6NHKTkTvC/EY/bL4
        EkZPtJyW0QeuPcFWKo2B/gvIeIvvVxgrS0Yw4wF/HTKONs7PlucWpNtYxsp6ElinxWXNd+Zl
        kBs2m1eZ9ctSqCTKQKeRCU7GwWaQq7Oyk9bm28MNkQmFjN0XNmUzHEcuWZHucfm8bILNxXkz
        SNZttbsN7mSOcXA+Z16yxeVYTqWkLNWHhdsKbMGau5h7QL29rmaPrAhVzapAOA5EKrx5oalA
        SlxNBBC8up5RgWaGOYjgZF2xRHyMIwg9+SAVVELARE+nVHS0IghcH5tSfUXQ8K1JIqhiCAtU
        F3dhgmMO8RtBsOWEXHBIiRwYu1sbSYURWmj72IcJPItYCL0/h5DAKmIFTPZ9ibCMWAyT599G
        ksYSW2Ggq0EuambDg6phmcBKIg2aOtslYv658GL4zBQvgJLmk5FWgZjEIMj/mJphNTzv7UAi
        x8Dnbr9CZA2MjrRiIu+Cyw86MTG4HIG/rUcuOnTQVntYImxPSiRCfcsSsVg0jIztl4tLVUF5
        mVpUL4Knb/olIsdDzd59U+mNUP34iPwgWshPG4efNgI/bQT+f7GzSFaH4lg358hjOcqtn/7b
        jShyrFpDAHU9ympHBI7IKBW+329Sy5lCboejHQEuJeeoMq1hk8rK7NjJelxmj8/Ocu1IH972
        Iakm1uIKn77Ta6b0S3U6HZ1KLdNTFDlXVb9ylUlN5DFetoBl3aznX5wEV2qK0Anf4Ixfpuqa
        39urzL9yxs1vj8xfVzL8epDpI3tRE3kxric3tjZug2X8Q/m50vSCDmU3enWsqVLXvCZ+y8TV
        7qFok9b/x5uqeD5P+W0g+Gz93jKqMZTmu5cVun3nUOZGSRzxqbY1M2fy7NHy9dHvdvPHo+yF
        VTMCiT/PqN/3GDZpSRlnYyit1MMxfwETvraZwgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSnO7xhq0xBkf75S1Wf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyPi0+yFZwX6hi1eJWlgbGmfxdjJwcEgImEj8v
        HGHuYuTiEBLYzShx+P40NoiEpMS0i0eBEhxAtrDE4cPFEDVvGSWaj71hBKkRFkiWmNt4jA0k
        ISLQxCTx+WELE0iCWSBSov9RNytExzZGia6vM5lBEmwCWhL7X9wA28AvoChx9cdjsEm8AnYS
        v29ATGURUJX4vegR2CBRgQiJM+9XsEDUCEqcnPkEzOYUMJfYfOQQ1DJ1iT/zLjFD2OISt57M
        h4rLSzRvnc08gVF4FpL2WUhaZiFpmYWkZQEjyypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k
        /NxNjOAo09LawXjiRPwhRgEORiUe3oS+LTFCrIllxZW5hxglOJiVRHgdU4BCvCmJlVWpRfnx
        RaU5qcWHGKU5WJTEeeXzj0UKCaQnlqRmp6YWpBbBZJk4OKUaGNckRotuYbHeVxFR7XDI1cL0
        nekz38T1q5gOXq0LfR7CaDvrn/+quxfuLX11SK3q/WwtrYgm9rqJXVMebig7nH2d7a5720uT
        r6efb4h581Dycwzno+O2HxIrPJWms+s+OxnbX58es889xPCUyOPrW4Qmmmxkzs1ueHVt1TLG
        Kwstb7/9bs+9bLsSS3FGoqEWc1FxIgCPn2HIrgIAAA==
X-CMS-MailID: 20190416071415epcas1p30f91496a3ea6550157702db7120dab59
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190415145721epcas1p4936edf8cf61a7d373a6e3f6aba76a029
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145721epcas1p4936edf8cf61a7d373a6e3f6aba76a029@epcas1p4.samsung.com>
        <20190415145505.18397-13-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 4. 15. 오후 11:54, Dmitry Osipenko wrote:
> The frequency value potentially could change in-between. It doesn't
> cause any real problem at all right now, but that could change in the
> future. Hence let's avoid the inconsistency.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index a668e4fbc874..f1a6f951813a 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -496,13 +496,15 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>  {
>  	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
>  	struct tegra_devfreq_device *actmon_dev;
> +	unsigned long cur_freq;
>  
> -	stat->current_frequency = tegra->cur_freq * KHZ;
> +	cur_freq = READ_ONCE(tegra->cur_freq);
>  
>  	/* To be used by the tegra governor */
>  	stat->private_data = tegra;
>  
>  	/* The below are to be used by the other governors */
> +	stat->current_frequency = cur_freq * KHZ;
>  
>  	actmon_dev = &tegra->devices[MCALL];
>  
> @@ -513,7 +515,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>  	stat->busy_time *= 100 / BUS_SATURATION_RATIO;
>  
>  	/* Number of cycles in a sampling period */
> -	stat->total_time = ACTMON_SAMPLING_PERIOD * tegra->cur_freq;
> +	stat->total_time = ACTMON_SAMPLING_PERIOD * cur_freq;
>  
>  	stat->busy_time = min(stat->busy_time, stat->total_time);
>  
> 

The read/write access of tegra->cur_freq is in the single routine
of update_devfreq() as following. I think that there are no any
potential problem about the inconsistency of tegra->cur_freq.

IMHO, if there are no any problem now, I'm not sure that we need
to apply this patch.

update_devfreq()
{
	devfreq->governor->get_target_freq()
		devfreq_update_stats(devfreq)
			tegra_devfreq_get_dev_status()
				stat->current_frequency = tegra->cur_freq * KHZ;

	devfreq_set_target()
		tegra_devfreq_target()
			clk_set_min_rate(emc_rate, )
				tegra_actmon_rate_notify_cb()
					tegra->cur_freq = data->new_rate / KHZ;
		
			clk_set_rate(emc_rate, )
				tegra_actmon_rate_notify_cb()
					tegra->cur_freq = data->new_rate / KHZ;
}


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
