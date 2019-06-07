Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9EAC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 13:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACF7208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 13:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K5DlyyTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfFGNPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 09:15:22 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44917 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfFGNPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:15:22 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190607131520euoutp028ecb04f922d27dde09b1ce3f0cef14f5~l7OZzuf182516725167euoutp02g
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2019 13:15:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190607131520euoutp028ecb04f922d27dde09b1ce3f0cef14f5~l7OZzuf182516725167euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559913320;
        bh=XBMlqySQQ/GP/+OsC9coRem3GJuHR0Nx5AZ2FV6C2fk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=K5DlyyTPhfbwtpAcb3xboVmdOO19TPkUwVSd1KqMfVVEnlEMK9D+v0qIE3ZVRCix/
         St6fRrViJ3xihnIacXnCWCBzOCbN99btj3xWhlFFKmiR6EPmxhHGJSZALu6rH519zv
         o8tPl/x8W0G/xTZVacxntpnJqtwOfuG2/0vDCBWs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190607131519eucas1p21c3579210dd84a3d998a8544d021882c~l7OZJ0M180937409374eucas1p2O;
        Fri,  7 Jun 2019 13:15:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3D.A7.04325.7636AFC5; Fri,  7
        Jun 2019 14:15:19 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190607131518eucas1p11476b07d3c463eab67b1a5f5c6e20b86~l7OYZ052M1824118241eucas1p1R;
        Fri,  7 Jun 2019 13:15:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190607131518eusmtrp1363324c6af5429506a9180f1a7ae434a~l7OYKNikg2955529555eusmtrp1y;
        Fri,  7 Jun 2019 13:15:18 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-85-5cfa6367887e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C9.D7.04140.6636AFC5; Fri,  7
        Jun 2019 14:15:18 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190607131518eusmtip27b7618c46ea9277f6221c0a34ae603a6~l7OXuiCSc1422014220eusmtip2g;
        Fri,  7 Jun 2019 13:15:18 +0000 (GMT)
Subject: Re: [PATCH][next] drm/bridge: sii902x: fix comparision of u32 with
 less than zero
To:     Colin King <colin.king@canonical.com>, Jyri Sarha <jsarha@ti.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <4454a547-d8f9-2df8-d3fa-2026860a14a9@samsung.com>
Date:   Fri, 7 Jun 2019 15:15:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603142102.27191-1-colin.king@canonical.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsWy7djPc7rpyb9iDM40yFv0njvJZPF7dS+b
        xf9tE5ktrnx9z2bR3dnBarH1lrRF58Ql7BaXd81hc+DwmNXQy+ax99sCFo/ZHTNZPbZ/e8Dq
        cb/7OJPH8RvbmTw+b5ILYI/isklJzcksSy3St0vgyrj0oJO5YBJnxfIzZ9gbGA+zdzFyckgI
        mEi8uPYTyObiEBJYwSgxqfMHG4TzhVHi6t4mZgjnM6PEy6Y5bDAtbyYsg0osZ5R4cqcPquUt
        o8S3Ff/AqoQFYiT+f+tjAkmICDxhlDh7ZSczSIJZwFFi3fw7LCA2m4CmxN/NN8EaeAXsJLrP
        dDKB2CwCKhLLG2YygtiiAhESX3ZuYoSoEZQ4OfMJWC8nUP3bC5egZspLbH87B8oWl7j1ZD7Y
        YgmBQ+wSx75fAGrmAHJcJC78d4Z4QVji1fEt0BCQkTg9uYcFwq6XuL+ihRmit4NRYusGiKMl
        BKwlDh+/yAoyhxno6PW79CHCjhILPmxngRjPJ3HjrSDECXwSk7ZNZ4YI80p0tAlBVCtK3D+7
        FWqguMTSC1/ZJjAqzULy2Cwkz8xC8swshL0LGFlWMYqnlhbnpqcWG+ellusVJ+YWl+al6yXn
        525iBCao0/+Of93BuO9P0iFGAQ5GJR5eD/afMUKsiWXFlbmHGCU4mJVEeMsu/IgR4k1JrKxK
        LcqPLyrNSS0+xCjNwaIkzlvN8CBaSCA9sSQ1OzW1ILUIJsvEwSnVwFgVMl+rOf9WSI1qxl8F
        8cXa7/u3n23hzGAtTmLPfF7HvqPVhvmqc+/mn6q9rteX6HKoTmXS21X3lpO33vFNltfc/x2n
        o3dPnHps8/L+Bw4rX8xrtT6+PUpc1jhIgGfa7vqfMQ0RzZma380+/tadqvA4a4bC8z3GpWUf
        ZUTfrdgqk57Iz/BpuRJLcUaioRZzUXEiAGN5mktMAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7ppyb9iDB6s07LoPXeSyeL36l42
        i//bJjJbXPn6ns2iu7OD1WLrLWmLzolL2C0u75rD5sDhMauhl81j77cFLB6zO2ayemz/9oDV
        4373cSaP4ze2M3l83iQXwB6lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRv
        Z5OSmpNZllqkb5egl3HpQSdzwSTOiuVnzrA3MB5m72Lk5JAQMJF4M2EZcxcjF4eQwFJGiQUt
        61ghEuISu+e/ZYawhSX+XOtigyh6zSjRsfoEWLewQIzE/299TCAJEYEnjBJXV/9lAkkwCzhK
        rJt/hwXEFhKYyCixuUsWxGYT0JT4u/kmG4jNK2An0X2mE6yeRUBFYnnDTEYQW1QgQmL2rgYW
        iBpBiZMzn4DZnED1by9cYoaYry7xZx6MLS+x/e0cKFtc4taT+UwTGIVmIWmfhaRlFpKWWUha
        FjCyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMyW3Hfm7Zwdj1LvgQowAHoxIP7wymnzFC
        rIllxZW5hxglOJiVRHjLLvyIEeJNSaysSi3Kjy8qzUktPsRoCvTcRGYp0eR8YLrIK4k3NDU0
        t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAWD1B6/ULseOfAhVmLZrc3y0m
        voL7aEe8r4XcR5G69nOBz9LWnl8UKuOaZKS62uz54XeNMsZHrCXNfr85vf9i+5e/G1bnL3GP
        LM3gqGx+y3vw7fQ+o5d5MTeaCkQW8BaoyXjfftyQzXv1x6XGyZmH07K5JKtclkpq5RnJHRaz
        9974L0Na7HmPEktxRqKhFnNRcSIANqgxjt8CAAA=
X-CMS-MailID: 20190607131518eucas1p11476b07d3c463eab67b1a5f5c6e20b86
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190603142108epcas2p4625777c1aaea18257804ca86bcb64454
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190603142108epcas2p4625777c1aaea18257804ca86bcb64454
References: <CGME20190603142108epcas2p4625777c1aaea18257804ca86bcb64454@epcas2p4.samsung.com>
        <20190603142102.27191-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.06.2019 16:21, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The less than check for the variable num_lanes is always going to be
> false because the variable is a u32.  Fix this by making num_lanes an
> int and also make loop index i an int too.
>
> Addresses-Coverity: ("Unsigned compared against 0")
> Fixes: ff5781634c41 ("drm/bridge: sii902x: Implement HDMI audio support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/bridge/sii902x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index d6f98d388ac2..21a947603c88 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -719,7 +719,7 @@ static int sii902x_audio_codec_init(struct sii902x *sii902x,
>  		.max_i2s_channels = 0,
>  	};
>  	u8 lanes[4];
> -	u32 num_lanes, i;
> +	int num_lanes, i;
>  
>  	if (!of_property_read_bool(dev->of_node, "#sound-dai-cells")) {
>  		dev_dbg(dev, "%s: No \"#sound-dai-cells\", no audio\n",

Queued to drm-misc-next.

--
Regards
Andrzej

