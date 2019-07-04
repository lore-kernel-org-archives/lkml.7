Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14C8C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A952133F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hxDqEPxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfGDHqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:46:39 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45341 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfGDHqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:46:38 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190704074637euoutp025f99471e246b106b2ede06b8e5f4a013~uJKGZimcM1719117191euoutp02y
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2019 07:46:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190704074637euoutp025f99471e246b106b2ede06b8e5f4a013~uJKGZimcM1719117191euoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1562226397;
        bh=4UC6gdDWM7A5kpeQCVnHlWnkr4RWGuGbjJWamlwmHpo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hxDqEPxLxM7WJSREIptQTgzOdkyjFBsrlCB7H0ctb13EXC8wT3BwQFOfbkBR4E/Rp
         9r7SxDJBoLCv1D9a2bAmzbdcGmDCeQyTbm+NdYIMxh5R0ebPBL2nu1i7ACQMBedyPm
         7fUmjDpAqBspVGXUFqti7yz0Vsd+SFnDq5/Cro2c=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190704074636eucas1p22238c80a38a7b64e99dc14e804ad4f42~uJKFwGxVV0336803368eucas1p2G;
        Thu,  4 Jul 2019 07:46:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 37.FB.04325.CDEAD1D5; Thu,  4
        Jul 2019 08:46:36 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190704074635eucas1p1391ed25106f50ee6c42b1ab2572f4863~uJKFCrVk22425124251eucas1p17;
        Thu,  4 Jul 2019 07:46:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190704074635eusmtrp2f2a548162d9a73e6408f575faeb41d7f~uJKE0mMvY1513115131eusmtrp2r;
        Thu,  4 Jul 2019 07:46:35 +0000 (GMT)
X-AuditID: cbfec7f5-fbbf09c0000010e5-86-5d1daedc8032
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BD.6B.04140.BDEAD1D5; Thu,  4
        Jul 2019 08:46:35 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190704074635eusmtip1fe0cf36872cfdac6aa6e17d698554e50~uJKEaj62e2962529625eusmtip1u;
        Thu,  4 Jul 2019 07:46:35 +0000 (GMT)
Subject: Re: [PATCH -next] drm/bridge: sii902x: Make
 sii902x_audio_digital_mute static
To:     YueHaibing <yuehaibing@huawei.com>,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        daniel@ffwll.ch, jsarha@ti.com
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <b7f2d9cf-ee64-04a5-d303-272e1839c4a3@samsung.com>
Date:   Thu, 4 Jul 2019 09:46:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190614153623.28708-1-yuehaibing@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djP87p31snGGpy+wG/Re+4kk8X/bROZ
        La58fc9m0d3ZwWrROXEJu8XlXXPYLO58fc7iwO6x99sCFo+WI29ZPWZ3zGT12P7tAavH/e7j
        TB7Hb2xn8vi8SS6APYrLJiU1J7MstUjfLoEr411rO3PBJo6KnQ9fszcwfmfrYuTkkBAwkfh9
        eT9rFyMXh5DACkaJp3sPsEE4XxglvhxbxQxSJSTwmVHi1YQomI6bb75BxZczSqxY4w1hv2WU
        uLPBD8QWFoiQePdxAguILSJQK7Fs0gJGEJtZwFHi5tRjrCA2m4CmxN/NN8Gu4BWwk3i9txds
        JouAisTs7avA6kWB5lzesosRokZQ4uTMJ2AzOQWsJXrnHmKDmCkvsf3tHGYIW1zi1pP5TCAP
        SAjsYpe4dOwaK8TRLhK9v58wQ9jCEq+Ob2GHsGUk/u8EaQCx6yXur2hhhmjuYJTYumEnVIO1
        xOHjF4EGcQBt0JRYv0sfIuwosWT3OjaQsIQAn8SNt4IQN/BJTNo2nRkizCvR0SYEUa0ocf/s
        VqiB4hJLL3xlm8CoNAvJZ7OQfDMLyTezEPYuYGRZxSieWlqcm55abJyXWq5XnJhbXJqXrpec
        n7uJEZiSTv87/nUH474/SYcYBTgYlXh4H2yRiRViTSwrrsw9xCjBwawkwvv9N1CINyWxsiq1
        KD++qDQntfgQozQHi5I4bzXDg2ghgfTEktTs1NSC1CKYLBMHp1QD44qzGYHl12OOt/hMnbLs
        zE/b/C+KCg5Vqfte/67uu3LVZPfWh4ay+6e5CuqW1upvlV/Wei/32OXpHHK1TE2rj4otbxCe
        HLmmzkXyfX1U7RWR1sCbKrzxoZpTHwhNzFn/u//V2xWN+z69n3o2z/hSvsOrivh7ThNm3w6b
        zHn86En9bRM3cbq7PFJiKc5INNRiLipOBAAV5KyKRQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xu7q318nGGjycJ2/Re+4kk8X/bROZ
        La58fc9m0d3ZwWrROXEJu8XlXXPYLO58fc7iwO6x99sCFo+WI29ZPWZ3zGT12P7tAavH/e7j
        TB7Hb2xn8vi8SS6APUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1
        J7MstUjfLkEv411rO3PBJo6KnQ9fszcwfmfrYuTkkBAwkbj55htzFyMXh5DAUkaJU7fPsUMk
        xCV2z3/LDGELS/y51sUGUfSaUeLl5eMsIAlhgQiJdx8nANkcHCICtRKneqNAwswCjhI3px5j
        hajvY5SYffMPWD2bgKbE3803wTbzCthJvN7bC7aARUBFYvb2VYwgtijQzL622VA1ghInZz4B
        6+UUsJbonXuIDWKBusSfeZeYIWx5ie1v50DZ4hK3nsxnmsAoNAtJ+ywkLbOQtMxC0rKAkWUV
        o0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYCRuO/Zzyw7GrnfBhxgFOBiVeHgfbJGJFWJNLCuu
        zD3EKMHBrCTC+/03UIg3JbGyKrUoP76oNCe1+BCjKdBzE5mlRJPzgUkiryTe0NTQ3MLS0NzY
        3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDY1feDt3J4uwP/4RV87boii9uVgtctuu0
        dvrCK9crHTsLtwXbvDg81Ufgzq5CTjlZtqZs3/btX7j2cucfN3r1f83XiyYeRpY/trj+FL5q
        1av6a33FDKm/tkav09q1bBlDSufrfHx6fdeU2PKzZxjPZe1euqL3yosQmawleY9nsXRNEdzO
        uVLmvBJLcUaioRZzUXEiAIEMIvbaAgAA
X-CMS-MailID: 20190704074635eucas1p1391ed25106f50ee6c42b1ab2572f4863
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190614153645epcas1p31033b923528a79f6356d01f40ad129a6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190614153645epcas1p31033b923528a79f6356d01f40ad129a6
References: <CGME20190614153645epcas1p31033b923528a79f6356d01f40ad129a6@epcas1p3.samsung.com>
        <20190614153623.28708-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.06.2019 17:36, YueHaibing wrote:
> Fix sparse warning:
>
> drivers/gpu/drm/bridge/sii902x.c:665:5: warning:
>  symbol 'sii902x_audio_digital_mute' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/bridge/sii902x.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index dd7aa46..c2f97e5 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -662,7 +662,8 @@ static void sii902x_audio_shutdown(struct device *dev, void *data)
>  	clk_disable_unprepare(sii902x->audio.mclk);
>  }
>  
> -int sii902x_audio_digital_mute(struct device *dev, void *data, bool enable)
> +static int sii902x_audio_digital_mute(struct device *dev,
> +				      void *data, bool enable)
>  {
>  	struct sii902x *sii902x = dev_get_drvdata(dev);
>  


Thanks,


Applied to drm-misc-next.


Regards

Andrzej


