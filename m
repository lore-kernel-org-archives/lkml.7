Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E89C3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 01:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC03214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 01:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Lq6MoiTu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394580AbfITBQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 21:16:04 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:36985 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389082AbfITBQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 21:16:04 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190920011602epoutp017e249ae4f770310488d5fd5e4619c5a4~GAJWN8XL50339703397epoutp01Z
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 01:16:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190920011602epoutp017e249ae4f770310488d5fd5e4619c5a4~GAJWN8XL50339703397epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568942162;
        bh=yUi3faNWq/j7BtYkzFLf+Z3wZ+tkO28XTs6YXtU4Gek=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Lq6MoiTuEANQYkFCcZev2neMyNP+3dL0nxiOFE5xcRnCw3AEUA6kqrM7+JCPMk6KO
         OFj15acm0qFNlSW5w8VzCsZAMpVzUwH1cgu7BaJp3kRIM+TW5ZOq7l+sL+LfaeVbO9
         4sagxVeSwW7DHHT7+32TFULD1K3SZANnJ5V04Sm4=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190920011602epcas1p4c86e3ae773391d7af45a87f8fce0c4a8~GAJV4YmqU1412914129epcas1p4T;
        Fri, 20 Sep 2019 01:16:02 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 46ZG4b5SyjzMqYkb; Fri, 20 Sep
        2019 01:15:59 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.73.04066.848248D5; Fri, 20 Sep 2019 10:15:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190920011552epcas1p2b8c9b2f13d1d52f6012f4e1e6906877d~GAJMy-nUI2797427974epcas1p24;
        Fri, 20 Sep 2019 01:15:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190920011552epsmtrp27200b5265b178bf6a22c8f2627aac372~GAJMyO2RE1189211892epsmtrp21;
        Fri, 20 Sep 2019 01:15:52 +0000 (GMT)
X-AuditID: b6c32a37-e3fff70000000fe2-8a-5d842848ff60
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C2.5E.03706.848248D5; Fri, 20 Sep 2019 10:15:52 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190920011552epsmtip1832b65b8b798d8e0c8151bd2a7c68fd1~GAJMmH2hO3196531965epsmtip1Z;
        Fri, 20 Sep 2019 01:15:52 +0000 (GMT)
Subject: Re: [PATCH] devfreq: Make log message more explicit when devfreq
 device already exists
To:     Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <82e57b34-93f6-cd70-a2f6-32b13648df09@samsung.com>
Date:   Fri, 20 Sep 2019 10:20:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919000946.158454-1-mka@chromium.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTX9dDoyXW4OslA4uzTW/YLS7vmsNm
        8bn3CKPF5w2PGS1uN65gc2D1mN1wkcWjb8sqRo/Pm+QCmKOybTJSE1NSixRS85LzUzLz0m2V
        vIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAVioplCXmlAKFAhKLi5X07WyK8ktLUhUy
        8otLbJVSC1JyCiwL9IoTc4tL89L1kvNzrQwNDIxMgQoTsjMmHn3NUjCPt+JB/x2mBsY1XF2M
        nBwSAiYSEyctZeti5OIQEtjBKNHZ1MoM4XxilJj39x0LSJWQwDdGiXNvZWE6Xnw8wgJRtJdR
        4suHq1DOe0aJC5vfsIFUCQskSuy9uAVoFAeHiECdxIov9SBhZgEridcfu9lBbDYBLYn9L26A
        lfMLKEpc/fGYEaScV8BOYtPUKJAwi4CqxMrudrAbRAUiJD49OMwKYvMKCEqcnPkELM4pYC6x
        vfUMM8R4cYlbT+YzQdjyEs1bZ4M9IyFwnU1i64LVbBAPuEg83fGYHcIWlnh1fAuULSXx+d1e
        qJpqiZUnj7BBNHcwSmzZf4EVImEssX/pZCaQQ5kFNCXW79KHCCtK7Pw9lxFiMZ/Eu689rCAl
        EgK8Eh1tQhAlyhKXH9xlgrAlJRa3d7JNYFSaheSdWUhemIXkhVkIyxYwsqxiFEstKM5NTy02
        LDBGjutNjODEqGW+g3HDOZ9DjAIcjEo8vArlzbFCrIllxZW5hxglOJiVRHjnmDbFCvGmJFZW
        pRblxxeV5qQWH2I0BYb2RGYp0eR8YNLOK4k3NDUyNja2MDE0MzU0VBLn9UhviBUSSE8sSc1O
        TS1ILYLpY+LglGpg9M2Pr1n4xK/N4S9zKauD74Zp9elpsr1ta54WmxaKl8axOLHET+/+VrK2
        K4fj+7SJva5dp3X2LLjh8she+bhrk9axGQuKvp7vY1ga+LfuacoP09qreVEzj2fpK8soOO/Z
        WysvtyWy+4nxkohf/8yu/J+u+j+A+db1a9ExTm5rXbUehq99LyGsxFKckWioxVxUnAgA4876
        zqIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSnK6HRkuswe/pYhZnm96wW1zeNYfN
        4nPvEUaLzxseM1rcblzB5sDqMbvhIotH35ZVjB6fN8kFMEdx2aSk5mSWpRbp2yVwZUw8+pql
        YB5vxYP+O0wNjGu4uhg5OSQETCRefDzC0sXIxSEksJtRYv657SwQCUmJaRePMncxcgDZwhKH
        DxdD1LxllFgyZx8jSI2wQKLE3otbmEESIgINjBKNr2azgSSYBawkXn/sZofo6GKU2HynjQkk
        wSagJbH/xQ2wIn4BRYmrPx4zgmzgFbCT2DQ1CiTMIqAqsbK7HewIUYEIicM7ZoEt4xUQlDg5
        8wlYnFPAXGJ76xlmiF3qEn/mXYKyxSVuPZnPBGHLSzRvnc08gVF4FpL2WUhaZiFpmYWkZQEj
        yypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOA40dLcwXh5SfwhRgEORiUeXoXy5lgh
        1sSy4srcQ4wSHMxKIrxzTJtihXhTEiurUovy44tKc1KLDzFKc7AoifM+zTsWKSSQnliSmp2a
        WpBaBJNl4uCUamAsiQwLsNcScIzOnsJzkDFwXVvI4boLZj/Se/8rpMyf8+em01GpPiEBxhoO
        Fb5Tp0QSwyy3pundu/c2gEHyzFofPqZ3jCt/n5YOtrnhLnk6I1lMnefO3ETRsol/dglMfT3F
        JWPHhNi74juuKvQoFwYavdjys6D9gMjDI7e+1jw/WLNMh223r7wSS3FGoqEWc1FxIgD66x2P
        jwIAAA==
X-CMS-MailID: 20190920011552epcas1p2b8c9b2f13d1d52f6012f4e1e6906877d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190919000958epcas2p1a5e0e9046a1520c8204251c52649ea65
References: <CGME20190919000958epcas2p1a5e0e9046a1520c8204251c52649ea65@epcas2p1.samsung.com>
        <20190919000946.158454-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 9. 19. 오전 9:09, Matthias Kaehlcke wrote:
> Before creating a new devfreq device devfreq_add_device() checks
> if there is already a devfreq dev associated with the requesting
> device (parent). If that's the case the function rejects to create
> another devfreq dev for that parent and logs an error. The error
> message is very unspecific, make it a bit more explicit.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index ab22bf8a12d6..0e2dd734ab58 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -625,7 +625,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	devfreq = find_device_devfreq(dev);
>  	mutex_unlock(&devfreq_list_lock);
>  	if (!IS_ERR(devfreq)) {
> -		dev_err(dev, "%s: Unable to create devfreq for the device.\n",
> +		dev_err(dev, "%s: devfreq device already exists!\n",

Looks good to me. But After edited the log message, you can make
it on one line because the length is not over 80 char.
You can change it for the readability as following:

        if (!IS_ERR(devfreq)) {
-               dev_err(dev, "%s: Unable to create devfreq for the device.\n",
-                       __func__);
+               dev_err(dev, "%s: devfreq device already exists.\n", __func__);

If you agree my comment, you can feel free to add my tag:
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>


>  			__func__);
>  		err = -EINVAL;
>  		goto err_out;
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
