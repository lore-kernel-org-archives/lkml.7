Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254ABC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D327F218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="I0w4dES0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbfDYMNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:13:51 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48148 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfDYMNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:13:50 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190425121348euoutp01499cedca6d35db0cb17a74d16fd96a74~YtpZ_SBbh0541905419euoutp01j
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:13:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190425121348euoutp01499cedca6d35db0cb17a74d16fd96a74~YtpZ_SBbh0541905419euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556194428;
        bh=3aAdMJccyc3yWAnTSQBFLhqMEp/4q3OXHPjhUvH42wI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=I0w4dES0ac9dDZq/lPTirD1x6SJ6/A+vGi48XvClPWEAQnQX+IKXONsZarlOf05GM
         FXQrxxEYCz5efGROE728DKYCe+bdmjQ4nWWltnuuydThYdYvyU3R6NJJXKQwj6mqaN
         6KvvHeqJmfkc9yLRYirLBVfjMPb5yVQKTw0gwY0o=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190425121348eucas1p2026d5395fbbfd2df4df4df4f4e9418dd~YtpZXymhD3056630566eucas1p2v;
        Thu, 25 Apr 2019 12:13:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 0E.88.04298.B74A1CC5; Thu, 25
        Apr 2019 13:13:47 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190425121346eucas1p102ec5519851a53ba5dc0381edbd59458~YtpYUDPB_2937229372eucas1p1-;
        Thu, 25 Apr 2019 12:13:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190425121346eusmtrp204673cc802a17f47aaf73d5a7866b9c0~YtpYFd40Z0176601766eusmtrp2D;
        Thu, 25 Apr 2019 12:13:46 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-71-5cc1a47b092b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7F.43.04146.A74A1CC5; Thu, 25
        Apr 2019 13:13:46 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190425121346eusmtip257d8956044e9e17bf38934e2e3f21b91~YtpXkymEM2629226292eusmtip2N;
        Thu, 25 Apr 2019 12:13:46 +0000 (GMT)
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: Don't blindly call
 post_disable
To:     Matt Redfearn <matt.redfearn@thinci.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Philippe Cornu <philippe.cornu@st.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Matthew Redfearn <matthew.redfearn@thinci.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Archit Taneja <architt@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <3da4c0a3-a77b-5128-63f7-9c8d6b012c68@samsung.com>
Date:   Thu, 25 Apr 2019 14:13:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424142148.25927-1-matt.redfearn@thinci.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsWy7djPc7rVSw7GGKydrG7Re+4kk0VTx1tW
        i//bJjJbXPn6ns3i/6PXrBadE5ewW1zeNYfNYtf9BUwW2+dtYLJY+vsdo8WDlhesDtwel/t6
        mTz2flvA4jG7Yyarx/ZvD1g97ncfZ/L4O2s/i8f2a/OYPZ7+2MvsMXvyI1aPz5vkAriiuGxS
        UnMyy1KL9O0SuDK2rG1lLOjiqmi4/oy9gXELRxcjJ4eEgInEqamzmEFsIYEVjBL3/9t0MXIB
        2V8YJf7vvsoI4XxmlGi8MZMdpuP7/T5WiMRyoI6D09kg2t8ySnTPjgSxhQUCJI6d7QYrEhHo
        YZToPXKDBcRhFvjGJLFj7j2whWwCmhJ/N98E6+YVsJPo3NjICmKzCKhKNC66BbZOVCBC4v6x
        DawQNYISJ2c+YQGxOYHqJ3ddA5vDLCAvsf3tHChbXOLWk/lMIMskBL6yS3zquMcIcbeLxMcF
        nSwQtrDEq+NboP6Rkfi/E6QBxK6XuL+ihRmiuYNRYuuGncwQCWuJw8cvAl3BAbRBU2L9Ln2I
        sKPEz5vH2EHCEgJ8EjfeCkLcwCcxadt0Zogwr0RHmxBEtaLE/bNboQaKSyy98JVtAqPSLCSf
        zULyzSwk38xC2LuAkWUVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYHo7/e/4px2MXy8l
        HWIU4GBU4uFtSDoQI8SaWFZcmXuIUYKDWUmEV930YIwQb0piZVVqUX58UWlOavEhRmkOFiVx
        3mqGB9FCAumJJanZqakFqUUwWSYOTqkGRp1tsW/qNEOEIjPy7hrFxWaGGdu6KV7Zwinh2uUl
        c+an45pl057vZllaLcQ2773VnY2aa2rv8PkwqGglxXUoffE3Y5CWlTw80ey6r101R9vk+rqq
        Gf+DuSRu2jxKaxfYYs/PpywfkPu8WriQQfiE8DvdxIrIY6sYC+NYzmtJu7h8X/+lu1yJpTgj
        0VCLuag4EQDBaBE2awMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsVy+t/xe7pVSw7GGDxbqGHRe+4kk0VTx1tW
        i//bJjJbXPn6ns3i/6PXrBadE5ewW1zeNYfNYtf9BUwW2+dtYLJY+vsdo8WDlhesDtwel/t6
        mTz2flvA4jG7Yyarx/ZvD1g97ncfZ/L4O2s/i8f2a/OYPZ7+2MvsMXvyI1aPz5vkArii9GyK
        8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DK2rG1lLOji
        qmi4/oy9gXELRxcjJ4eEgInE9/t9rF2MXBxCAksZJV79XsgOkRCX2D3/LTOELSzx51oXG0TR
        a0aJaSs3sHQxcnAIC/hJrLnBCRIXEehjlPi55h47iMMs8I1J4nHDR6ixExklJm2ZywYyik1A
        U+Lv5ptgNq+AnUTnxkZWEJtFQFWicdEtsNWiAhESZ96vYIGoEZQ4OfMJmM0JVD+56xrYScwC
        6hJ/5l2CsuUltr+dA2WLS9x6Mp9pAqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnpucWGesWJ
        ucWleel6yfm5mxiBMb3t2M/NOxgvbQw+xCjAwajEw3si7ECMEGtiWXFl7iFGCQ5mJRFeddOD
        MUK8KYmVValF+fFFpTmpxYcYTYGem8gsJZqcD0w3eSXxhqaG5haWhubG5sZmFkrivB0CQE0C
        6YklqdmpqQWpRTB9TBycUg2MZV51JgfebCvw6zk1U09noek1T45V987732WMuqQua9yoZj6N
        R449/dwrm6zKLI3/UZ73l3cfOvg8/MOS+MiNCYu745Yete9Pest6hf/y+mhNl4pby23zKjZ/
        sC54aJfcLTVhV1f4jrSo53y3eiQS57mVnfqzL+LmDJ+9WhyTRLZ2dDsbN3gpsRRnJBpqMRcV
        JwIA6cKJb/8CAAA=
X-CMS-MailID: 20190425121346eucas1p102ec5519851a53ba5dc0381edbd59458
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190424142210epcas3p403bd5159852ab4e90eca1be67800ecde
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190424142210epcas3p403bd5159852ab4e90eca1be67800ecde
References: <CGME20190424142210epcas3p403bd5159852ab4e90eca1be67800ecde@epcas3p4.samsung.com>
        <20190424142148.25927-1-matt.redfearn@thinci.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.04.2019 16:22, Matt Redfearn wrote:
> The DRM documentation states that post_disable is an optional callback.
> As such an implementing device may not populate it. To avoid panicing
> the kernel by calling a NULL function pointer, we should NULL check it
> before blindy calling it.
>
> Signed-off-by: Matt Redfearn <matt.redfearn@thinci.com>

> ---
>
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> index 38e88071363..0ee440216b8 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -805,7 +805,8 @@ static void dw_mipi_dsi_bridge_post_disable(struct drm_bridge *bridge)
>  	 * This needs to be fixed in the drm_bridge framework and the API
>  	 * needs to be updated to manage our own call chains...
>  	 */
> -	dsi->panel_bridge->funcs->post_disable(dsi->panel_bridge);
> +	if (dsi->panel_bridge->funcs->post_disable)
> +		dsi->panel_bridge->funcs->post_disable(dsi->panel_bridge);
>  

Why not drm_bridge_post_disable ?


Regards

Andrzej


>  	if (dsi->slave) {
>  		dw_mipi_dsi_disable(dsi->slave);


