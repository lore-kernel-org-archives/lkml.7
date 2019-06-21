Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DAEC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC2C208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Gku07hFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfFULPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:15:07 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34603 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfFULPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:15:07 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190621111505euoutp02677658eb12c0a4236e26ade1d1ccfb36~qMnaI8oDe2215822158euoutp02I
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 11:15:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190621111505euoutp02677658eb12c0a4236e26ade1d1ccfb36~qMnaI8oDe2215822158euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561115705;
        bh=s+UrBPQaVR3tcbqs3Ol/m34bGN/nZjeSUNnxd+RCh/w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Gku07hFQ9DkB9j5Dh9oBBcbRE57oOmbW8bmDePpXGZN8PrDzY8Zi9rarPD0B16Wy3
         fTgf3GhKDk2Z4rXuWMfDzHRcWWzu2sz5Cgs+uTbT0JMMeYicZ737vJ/zYhAIG5sZNB
         Jg7+rUJd9flCI2ciZWlLx2OQ4PDSwkIK4m/Vh89I=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190621111504eucas1p24f641ba01defb3d4090372c1cc47fc24~qMnZeAsNo3122131221eucas1p2j;
        Fri, 21 Jun 2019 11:15:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 2B.7C.04377.83CBC0D5; Fri, 21
        Jun 2019 12:15:04 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190621111503eucas1p2dfbd7cd8b9e3eb1a2f7f36f178fdf92d~qMnYohBvW0269402694eucas1p2p;
        Fri, 21 Jun 2019 11:15:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190621111503eusmtrp244fb004c79e5e18732496dd5c877925e~qMnYaeHtn0599205992eusmtrp2U;
        Fri, 21 Jun 2019 11:15:03 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-9e-5d0cbc38c3c4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8F.25.04140.73CBC0D5; Fri, 21
        Jun 2019 12:15:03 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190621111503eusmtip23118a0d64fb6a8e431a10b4eca01fb80~qMnYA7gST0528405284eusmtip2b;
        Fri, 21 Jun 2019 11:15:03 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev: pvr2fb: fix compile-testing as module
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mike Marshall <hubcap@omnibond.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <3ee91294-044d-9bcd-0c4c-3365c0c97604@samsung.com>
Date:   Fri, 21 Jun 2019 13:15:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190617124758.1252449-1-arnd@arndb.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRjtt7vd3c3NrtPYh0rDSYVWmj1gWZhF0P4MghBr1S0vajq1Xd/+
        Y2U+FolNLJziA0lLQecqzTHILJzOB6ZZpjaVli8SK52QpuW8Sv53vu87h3MOfAQmMfI8iei4
        RFoTR8XKcSG3qf1370GFWaQ6VJ/ro1jVtfMVHxzzuCLnSz5H8frbFFfRkf+DpxgwleKKUccU
        N5SvXFnWIWXWuzmesso8w1GO3bdwlMsjozzlgnH3eTxceDKCjo1OpjWBIdeEUVN5Njyh2yV1
        wj7Ez0RvBFokIIA8Cqu6So4WCQkJ+RRB5+zg5rCIoNBsQuywgMD0s4q7JSkbb+exhxoEVeOP
        +Owwh6B4pYzjZLmTShi0DmBO7EH6QNH0JOYkYWQ3ArPVukHCyWB4mFOLnFhMhoChro/vxFxy
        DxgNXRviXWQYjLUbeCzHDTqL7RsxBOQxeJL3EXdijJTCsL2cw2IZNM+VbpgB2cYHbUkTxuY+
        Cw1L85sd3GHW8oLPYm/421LOYQX1CFZzpzfVzQhqCtdwlnUC3lrer8cg1i38oMEUyK5PQ8Hz
        MuRcA+kKQ3NubAhX0DU9xti1GHKzJSx7LxiqDfiWrbblGVaA5Ppt1fTb6ui31dH/961A3Fok
        pZMYdSTNHI6jUwIYSs0kxUUG3IhXG9H6J3WtWRZfIdOf622IJJBcJG7Vu6gkPCqZSVO3ISAw
        uYdYFCtSScQRVFo6rYm/qkmKpZk25EVw5VJxxo7xSxIykkqkY2g6gdZsXTmEwDMTpc42CvJa
        9x2XfQ1zpJz7ZaOWxlJbLySEk7dtVN3MgZRAeV1lVmNJU0HJTf+ZBa3w1Ej/pEfvSHxRn+zy
        Wr/j85UHMcMd+1+GqpeCvncVtvjecmOU2T3edyfuSe/E+Pp52e1FWemq/DM7y0NmLpptE8EZ
        1iPNQv6nIFm1X4W0Z1LOZaKoIH9Mw1D/AO08n/pFAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsVy+t/xe7rme3hiDX7tUbL4O+kYu8WVr+/Z
        LNrv9jFZ7H/6nMXiRN8HVovLu+awWdz5+pzFgd3j969JjB4tR96yeize85LJ4373cSaPX7fv
        sHp83iQXwBalZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqk
        b5egl/G88x5bwRnuiodPbrA3MB7k7GLk5JAQMJGY9+AYaxcjF4eQwFJGieW/zgE5HEAJGYnj
        68sgaoQl/lzrYoOoec0o8WnTCTaQhLCAh8TVU5eZQWwRAUWJqS+eMYMUMQucYZR4uuIL1NQO
        Ron2SVNYQarYBKwkJravYgSxeQXsJDasvsAOYrMIqEps2nAabJKoQITEmfcrWCBqBCVOznwC
        ZnMKmEos7bwGtplZQF3iz7xLzBC2uMStJ/OZIGx5ie1v5zBPYBSahaR9FpKWWUhaZiFpWcDI
        sopRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwArcd+7llB2PXu+BDjAIcjEo8vAdmcccKsSaW
        FVfmHmKU4GBWEuHlyeGJFeJNSaysSi3Kjy8qzUktPsRoCvTcRGYp0eR8YHLIK4k3NDU0t7A0
        NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAWLznx8N116POSGTuynn2vzBkxs6f
        h17HVz6R3+t84S7Pt2VX2uvLO2aduNIVaH/e6umsW1cUT6ZdUJzUa/RjTqXLkcUvi3yPiZ6M
        vtT5VXZKRs/14MTEmhYDCYV47R9q17a3n9E7P2tZ47vXe/+mhVv8LfJt/1+9pcX5/ZOnBQe/
        hYs3hC20eqXEUpyRaKjFXFScCAAXu4PR1gIAAA==
X-CMS-MailID: 20190621111503eucas1p2dfbd7cd8b9e3eb1a2f7f36f178fdf92d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190617124822epcas2p2c93d6cec3b60d08d85f228945d5c7623
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190617124822epcas2p2c93d6cec3b60d08d85f228945d5c7623
References: <CGME20190617124822epcas2p2c93d6cec3b60d08d85f228945d5c7623@epcas2p2.samsung.com>
        <20190617124758.1252449-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/17/19 2:47 PM, Arnd Bergmann wrote:
> Building an allmodconfig kernel now produces a harmless warning:
> 
> drivers/video/fbdev/pvr2fb.c:726:12: error: unused function 'pvr2_get_param_val' [-Werror,-Wunused-function]
> 
> Shut this up the same way as we do for other unused functions
> in the same file, using the __maybe_unused attribute.
> 
> Fixes: 0f5a5712ad1e ("video: fbdev: pvr2fb: add COMPILE_TEST support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks but I've fixed it already by adding #ifndef MODULE (since other
functions in the same file using __maybe_unused depend on either PCI or
SH_DREAMCAST I've preferred not to use this attribute):

https://marc.info/?l=linux-fbdev&m=156050904010778&w=2

> ---
>  drivers/video/fbdev/pvr2fb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
> index 59c59b3a67cb..cf9cfdc5e685 100644
> --- a/drivers/video/fbdev/pvr2fb.c
> +++ b/drivers/video/fbdev/pvr2fb.c
> @@ -723,8 +723,8 @@ static struct fb_ops pvr2fb_ops = {
>  	.fb_imageblit	= cfb_imageblit,
>  };
>  
> -static int pvr2_get_param_val(const struct pvr2_params *p, const char *s,
> -			      int size)
> +static int __maybe_unused pvr2_get_param_val(const struct pvr2_params *p,
> +					     const char *s, int size)
>  {
>  	int i;

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
