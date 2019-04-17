Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9876CC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FE92176F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aIRHTsOD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbfDQIVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:21:49 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:20831 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731228AbfDQIVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:21:48 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190417082145epoutp0459e8ebba840af3358adc820b54f77e44~WNUgUnzrW0655106551epoutp04A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 08:21:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190417082145epoutp0459e8ebba840af3358adc820b54f77e44~WNUgUnzrW0655106551epoutp04A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555489305;
        bh=ZjBncSuRjgI+9O2M+bHltTNeNW1h7pWIO3nbSMlcoi0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=aIRHTsODj2bzqJN/V0DtIERNg0I7iqhBuMSiZGvAzMp3ABYVdqBO+byI9iGBLIHzQ
         oQub0zC6I2UZYqau+RQkES9vOsB5CsqzyWGWqLb3R7SQyw5AZv+2jHK24ehM1atb41
         D5ydE8n85R8H52s08aQf/L9jDhr7DAxvikaHs63c=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.158]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190417082141epcas1p29e134bcb5247a8a7ea4afef4e7b30c90~WNUdbKXDa0596905969epcas1p2L;
        Wed, 17 Apr 2019 08:21:41 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.0A.04142.512E6BC5; Wed, 17 Apr 2019 17:21:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190417082141epcas1p4abc40e104f9db13c91b2d9f1d8a6a893~WNUczAi-v2159921599epcas1p4o;
        Wed, 17 Apr 2019 08:21:41 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190417082141epsmtrp28002c0a1ed79dfc7f6cbf96c15443de5~WNUcyE-cq0996209962epsmtrp2-;
        Wed, 17 Apr 2019 08:21:41 +0000 (GMT)
X-AuditID: b6c32a36-14a859c00000102e-62-5cb6e215e87d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.8F.03662.512E6BC5; Wed, 17 Apr 2019 17:21:41 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190417082140epsmtip1280e320101bf3210c4e60c2383ffacbc~WNUcl1u_w2611726117epsmtip1l;
        Wed, 17 Apr 2019 08:21:40 +0000 (GMT)
Subject: Re: [PATCH 2/3] drivers: devfreq: events: extend events by type of
 counted data
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, kgene@kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <628d298a-0c44-11c9-d27b-165cdfc0d2a2@samsung.com>
Date:   Wed, 17 Apr 2019 17:22:37 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555487288-4777-3-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMJsWRmVeSWpSXmKPExsWy7bCmnq7oo20xBtsmGlhsnLGe1WL+kXOs
        Fv2PXzNbnD+/gd3ibNMbdotbDTIWmx5fY7W4vGsOm8Xn3iOMFjPO72OyWHvkLrvF0usXmSxu
        N65gs2jde4Td4vCbdlYHfo8189Ywemxa1cnmsXlJvcfBd3uYPPq2rGL0+LxJLoAtKtsmIzUx
        JbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hiJYWyxJxSoFBA
        YnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BZYFecWJucWleul5yfq6VoYGBkSlQYUJ2xvbJG5gL
        vupUzO+9ztTAuFW5i5GTQ0LAROLKkSlMXYxcHEICOxglbv5bxgLhfGKUmL/iMzOE841RYmPz
        VnaYlj0/vzJCJPYyShyefQeq6j2jxKOHm1hBqoQFoiQeNH0HqxIROMsI5GxjA3GYBa4wSjz9
        sogZpIpNQEti/4sbbCA2v4CixNUfjxlBbF4BO4klu2+wgNgsAqoSF+59AKsXFYiQuH9sAytE
        jaDEyZlPwGo4Bbwkjk5bDRZnFhCXuPVkPhOELS/RvHU22HkSArvYJXav6mOGeMJFYtnlk2wQ
        trDEq+NboJ6Tkvj8bi9UvFpi5ckjbBDNHYwSW/ZfYIVIGEvsXzoZaAMH0AZNifW79CGW8Um8
        +9rDChKWEOCV6GgTgqhWlrj84C4ThC0psbi9E2q8h8SpjmfsExgVZyF5ZxaSF2YheWEWwrIF
        jCyrGMVSC4pz01OLDQuMkCN8EyM4QWuZ7WBcdM7nEKMAB6MSD++Kn1tjhFgTy4orcw8xSnAw
        K4nwOqZsiRHiTUmsrEotyo8vKs1JLT7EaAoM7YnMUqLJ+cDskVcSb2hqZGxsbGFiaGZqaKgk
        zrvewTlGSCA9sSQ1OzW1ILUIpo+Jg1OqgVFgnmlbawdjb+nK+ZY/fmYx8K3n6Duy59GzivjD
        Das1n3htzP6j/rHN1XNbwvHZbpt3CnSsK30gtOjbjb3n13tGq6771OH2dWead/j2fH3hr/xb
        Jty+9vghw4fv9yMbpm0oeuqpM+tXM39I+jpT24J3KvMbncrZZ67rvaO1V1fjtarW5pumwu1K
        LMUZiYZazEXFiQCYKirs5gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsWy7bCSnK7oo20xBquXc1psnLGe1WL+kXOs
        Fv2PXzNbnD+/gd3ibNMbdotbDTIWmx5fY7W4vGsOm8Xn3iOMFjPO72OyWHvkLrvF0usXmSxu
        N65gs2jde4Td4vCbdlYHfo8189Ywemxa1cnmsXlJvcfBd3uYPPq2rGL0+LxJLoAtissmJTUn
        syy1SN8ugStj++QNzAVfdSrm915namDcqtzFyMkhIWAisefnV8YuRi4OIYHdjBLT37xmh0hI
        Sky7eJS5i5EDyBaWOHy4GKLmLaNE/+35zCA1wgJREg+avoM1iwicZZRYNGkBO4jDLHCFUWL5
        tcmsEC13GSWmXDjOAtLCJqAlsf/FDTYQm19AUeLqj8eMIDavgJ3Ekt03wGpYBFQlLtz7ALZC
        VCBC4sz7FSwQNYISJ2c+AbM5Bbwkjk5bzQpiMwuoS/yZd4kZwhaXuPVkPhOELS/RvHU28wRG
        4VlI2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCI1VLawfj
        iRPxhxgFOBiVeHhX/NwaI8SaWFZcmXuIUYKDWUmE1zFlS4wQb0piZVVqUX58UWlOavEhRmkO
        FiVxXvn8Y5FCAumJJanZqakFqUUwWSYOTqkGRp+jOclKe0OYN944OyF/xcP/e1j5X73hWD7p
        isWrkpD2osnVfyuzXTe+mv/kJXcgj8rz0xwRTTm/9F48XCAZJ/vLcib/soVVDBwsO1awlEv5
        PDOOO5qwe/oKkcOCOkI/njyawcR9pvmA1+zS/9+fXIrZxFqyjyV9VtexzQqHteqrN33gDju5
        aJYSS3FGoqEWc1FxIgAUrwK30AIAAA==
X-CMS-MailID: 20190417082141epcas1p4abc40e104f9db13c91b2d9f1d8a6a893
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190417074834eucas1p1faa327cb6394d899a8e107ba61f28fda
References: <1555487288-4777-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190417074834eucas1p1faa327cb6394d899a8e107ba61f28fda@eucas1p1.samsung.com>
        <1555487288-4777-3-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 19. 4. 17. 오후 4:48, Lukasz Luba wrote:
> This patch adds posibility to choose what type of data should be counted
> by the PPMU counter. Now the type comes from DT where the event has been
> defined. When there is no 'event-data-type' the default value is used,
> which is 'read data in bytes'.
> It is needed when you want to know not only read+write data bytes but
> i.e. only write data in byte, or number of read requests, etc.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/event/exynos-ppmu.c | 38 +++++++++++++++++++++++++------------
>  include/linux/devfreq-event.h       |  6 ++++++
>  2 files changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index c61de0b..e5f81a5 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -140,6 +140,7 @@ static int exynos_ppmu_set_event(struct devfreq_event_dev *edev)
>  	int id = exynos_ppmu_find_ppmu_id(edev);
>  	int ret;
>  	u32 pmnc, cntens;
> +	u32 evt_sel = edev->desc->data_type;
>  
>  	if (id < 0)
>  		return id;
> @@ -154,9 +155,12 @@ static int exynos_ppmu_set_event(struct devfreq_event_dev *edev)
>  	if (ret < 0)
>  		return ret;
>  
> -	/* Set the event of Read/Write data count  */
> -	ret = regmap_write(info->regmap, PPMU_BEVTxSEL(id),
> -				PPMU_RO_DATA_CNT | PPMU_WO_DATA_CNT);
> +	/* Check if the data type has been defined in DT, use default if not */
> +	if (evt_sel == UINT_MAX)
> +		evt_sel = PPMU_RO_DATA_CNT | PPMU_WO_DATA_CNT;
> +
> +	/* Set the event of Read or Write or both (RDWR) data count  */
> +	ret = regmap_write(info->regmap, PPMU_BEVTxSEL(id), evt_sel);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -357,6 +361,7 @@ static int exynos_ppmu_v2_set_event(struct devfreq_event_dev *edev)
>  	unsigned int pmnc, cntens;
>  	int id = exynos_ppmu_find_ppmu_id(edev);
>  	int ret;
> +	u32 evt_sel = edev->desc->data_type;
>  
>  	/* Enable all counters */
>  	ret = regmap_read(info->regmap, PPMU_V2_CNTENS, &cntens);
> @@ -368,24 +373,28 @@ static int exynos_ppmu_v2_set_event(struct devfreq_event_dev *edev)
>  	if (ret < 0)
>  		return ret;
>  
> -	/* Set the event of Read/Write data count  */
> +
> +	/* Set the event of proper data type counting.
> +	 * Check if the data type has been defined in DT,
> +	 * use default if not.
> +	 */
>  	switch (id) {
>  	case PPMU_PMNCNT0:
>  	case PPMU_PMNCNT1:
>  	case PPMU_PMNCNT2:
> -		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
> -				PPMU_V2_RO_DATA_CNT | PPMU_V2_WO_DATA_CNT);
> -		if (ret < 0)
> -			return ret;
> +		if (evt_sel == UINT_MAX)
> +			evt_sel = PPMU_V2_RO_DATA_CNT | PPMU_V2_WO_DATA_CNT;
>  		break;
>  	case PPMU_PMNCNT3:
> -		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
> -				PPMU_V2_EVT3_RW_DATA_CNT);
> -		if (ret < 0)
> -			return ret;
> +		if (evt_sel == UINT_MAX)
> +			evt_sel = PPMU_V2_EVT3_RW_DATA_CNT;
>  		break;
>  	}
>  
> +	ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id), evt_sel);
> +	if (ret < 0)
> +		return ret;
> +
>  	/* Reset cycle counter/performance counter and enable PPMU */
>  	ret = regmap_read(info->regmap, PPMU_V2_PMNC, &pmnc);
>  	if (ret < 0)
> @@ -508,6 +517,7 @@ static int of_get_devfreq_events(struct device_node *np,
>  	struct device *dev = info->dev;
>  	struct device_node *events_np, *node;
>  	int i, j, count;
> +	int ret;
>  
>  	events_np = of_get_child_by_name(np, "events");
>  	if (!events_np) {
> @@ -544,6 +554,10 @@ static int of_get_devfreq_events(struct device_node *np,
>  		desc[j].driver_data = info;
>  
>  		of_property_read_string(node, "event-name", &desc[j].name);
> +		ret = of_property_read_u32(node, "event-data-type",
> +					   &desc[j].data_type);
> +		if (!ret)
> +			desc[i].data_type = UINT_MAX;

I think that it is not proper to use 'UINT_MAX'.
If you want to use the default value, you can initialize
the 'desc[i].data_type' according to the device type or compatible name.

For all exynos SoC except for exynos5433,
	desc[i].data_type = PPMU_RO_DATA_CNT | PPMU_WO_DATA_CNT;

For exynos5433,
	desc[i].data_type = PPMU_V2_EVT3_RW_DATA_CNT;

>  
>  		j++;
>  	}
> diff --git a/include/linux/devfreq-event.h b/include/linux/devfreq-event.h
> index 4db00b0..cc160b1 100644
> --- a/include/linux/devfreq-event.h
> +++ b/include/linux/devfreq-event.h
> @@ -81,14 +81,20 @@ struct devfreq_event_ops {
>   * struct devfreq_event_desc - the descriptor of devfreq-event device
>   *
>   * @name	: the name of devfreq-event device.
> + * @data_type	: the data type which is going to be counted in the register.
>   * @driver_data	: the private data for devfreq-event driver.
>   * @ops		: the operation to control devfreq-event device.
>   *
>   * Each devfreq-event device is described with a this structure.
>   * This structure contains the various data for devfreq-event device.
> + * The data_type describes what is going to be counted in the register.
> + * It might choose to count e.g. read requests, write data in bytes, etc.
> + * The full supported list of types is present in specyfic header in:
> + * include/dt-bindings/pmu/.

Why did you make the path name as the 'pmu' instead of 'ppmu'?

It might have some confusion because 'pmu' has
the two meaning in linux kernel.
- PMU, Power Management Unit
- PMU, Performance Monitoring Unit

>   */
>  struct devfreq_event_desc {
>  	const char *name;
> +	u32 data_type;
>  	void *driver_data;
>  
>  	const struct devfreq_event_ops *ops;
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
