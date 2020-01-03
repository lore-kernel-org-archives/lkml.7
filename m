Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4D1C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 12:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6E6222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 12:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ufh+Haet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbgACM00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 07:26:26 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58057 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbgACM00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 07:26:26 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200103122624euoutp02330eb29cc21b96a98bd1148c30080153~mYBohGaHl2721927219euoutp02G
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jan 2020 12:26:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200103122624euoutp02330eb29cc21b96a98bd1148c30080153~mYBohGaHl2721927219euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578054384;
        bh=+aCWclvV0rZhCCMyxhCs/miKoxo1AiEONhSNOqnKW3Y=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ufh+HaetG8cs6xZc6zKailLfF/azjvScuRKvVD78/cc7hpGoxsm5JRgLu+vyxxx1W
         e+HCquA4SSxRnBr2AJ85Dtt2I0j0AbYwBpeS5uarHzgXD7vZQvCyTNzbhxWZQv0CQP
         N5JZ2tuQExaIJxwburfWz2o9gZ9nlmzyHOLdAlLE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200103122624eucas1p14bbc0d86fcf9074ffec58297f47327c1~mYBn9KEVv2385723857eucas1p1G;
        Fri,  3 Jan 2020 12:26:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 20.67.60679.0F23F0E5; Fri,  3
        Jan 2020 12:26:24 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200103122623eucas1p234b0f5ab28dd95a5cdd1e508e3542e4d~mYBniTinB1703917039eucas1p24;
        Fri,  3 Jan 2020 12:26:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200103122623eusmtrp25a2ad23ba86f7ad47bce1a860f74eafc~mYBnhsR740071200712eusmtrp2f;
        Fri,  3 Jan 2020 12:26:23 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-a3-5e0f32f018f8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7C.C4.08375.FE23F0E5; Fri,  3
        Jan 2020 12:26:23 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200103122623eusmtip23b61d1584b98ff40c75942da64c2fed8~mYBnMMbFl0940109401eusmtip2F;
        Fri,  3 Jan 2020 12:26:23 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev: fsl-diu-fb: mark expected switch
 fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Timur Tabi <timur@kernel.org>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <3cc20993-1f45-ba6d-78b8-32be92b4853d@samsung.com>
Date:   Fri, 3 Jan 2020 13:26:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911113604.GA31512@embeddedor>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djP87ofjPjjDBZ+ZLa48vU9m8XWPaoW
        J/o+sFpc3jWHzeLEb3UHVo91B1U9Nq3qZPO4332cyePzJrkAligum5TUnMyy1CJ9uwSujMvv
        +tgLDotULFj3g72B8aZAFyMnh4SAicTBo2fZuhi5OIQEVjBKXDxxngXC+cIo0b77AxtIlZDA
        Z0aJxXOtYDruzrnBBFG0nFGi90kjM4TzllHi2aNGRpAqYYFgidZfy5lBbBEBI4nZM7pZQWxm
        gXqJD3t6wWrYBKwkJravArN5BewkFt7tB6rh4GARUJE4/0wYJCwqECHx6cFhVogSQYmTM5+w
        gNicAgYSG1YvgRopLnHryXwmCFteonnrbLB7JAQms0s82L2NCeJqF4ln35cyQtjCEq+Ob2GH
        sGUk/u+czwTRsI5R4m/HC6ju7YwSyyf/Y4Oospa4c+4XG8h1zAKaEut36UOEHSXeNrcygYQl
        BPgkbrwVhDiCT2LStunMEGFeiY42IYhqNYkNyzawwazt2rmSeQKj0iwkr81C8s4sJO/MQti7
        gJFlFaN4amlxbnpqsVFearlecWJucWleul5yfu4mRmB6Of3v+JcdjLv+JB1iFOBgVOLhTVDm
        jxNiTSwrrsw9xCjBwawkwlseyBsnxJuSWFmVWpQfX1Sak1p8iFGag0VJnNd40ctYIYH0xJLU
        7NTUgtQimCwTB6dUA6N9mtH0WfZzZ9888tvrdoa4UEj8u+INy3bJBnSJ3vR44F1V2XnhudzJ
        ezUG5m79/46f8P5olfXbfZHCuWjRPofDdzo50/Yu4Jw+U9WZf/aSmtCAJTX//afLGguIX951
        T7Fmirr2Tvevc7+Z3Ws9VanFEiN+qWDrhLimpi9HxDmnbk8S4unJX6PEUpyRaKjFXFScCACl
        Hwq8KwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsVy+t/xe7rvjfjjDKbfUre48vU9m8XWPaoW
        J/o+sFpc3jWHzeLEb3UHVo91B1U9Nq3qZPO4332cyePzJrkAlig9m6L80pJUhYz84hJbpWhD
        CyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jMvv+tgLDotULFj3g72B8aZAFyMn
        h4SAicTdOTeYuhi5OIQEljJKLDzVCeRwACVkJI6vL4OoEZb4c62LDaLmNaPEj+YTbCAJYYFg
        idZfy5lBbBEBI4nZM7pZQWxmgXqJ2Rv3Qw1tZpQ4cqWFESTBJmAlMbF9FZjNK2AnsfBuPyvI
        MhYBFYnzz4RBwqICERKHd8yCKhGUODnzCQuIzSlgILFh9RKo+eoSf+ZdYoawxSVuPZnPBGHL
        SzRvnc08gVFoFpL2WUhaZiFpmYWkZQEjyypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAeNp2
        7OfmHYyXNgYfYhTgYFTi4U1Q5o8TYk0sK67MPcQowcGsJMJbHsgbJ8SbklhZlVqUH19UmpNa
        fIjRFOi3icxSosn5wFjPK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TB
        KdXA6NWm7qfLoWk188IW7y9NK9Is9X6Kzfs4Q9GaOzzPNlPdXDXgkndiypb9k1fEFKzi/Hxw
        1udLbK+cTDvnHHlx6OgD/UvPL7RJzHmhHKE7X90727SgxuPMlJ0+9j23FzY+k1navjXhxNLX
        O30/xztPqLKOKtmwzz5z9Ryt1t+9XBO/V/Evurh4mRJLcUaioRZzUXEiAMHvSr69AgAA
X-CMS-MailID: 20200103122623eucas1p234b0f5ab28dd95a5cdd1e508e3542e4d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190911053645epcas3p36e689569e847f94ea42f1692c7aba22b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190911053645epcas3p36e689569e847f94ea42f1692c7aba22b
References: <CGME20190911053645epcas3p36e689569e847f94ea42f1692c7aba22b@epcas3p3.samsung.com>
        <20190911113604.GA31512@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/11/19 1:36 PM, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> Fix the following warnings (Building: mpc512x_defconfig powerpc):
> 
> drivers/video/fbdev/fsl-diu-fb.c: In function ‘fsl_diu_ioctl’:
> ./include/linux/device.h:1750:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   _dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/video/fbdev/fsl-diu-fb.c:1287:3: note: in expansion of macro ‘dev_warn’
>    dev_warn(info->dev,
>    ^~~~~~~~
> drivers/video/fbdev/fsl-diu-fb.c:1290:2: note: here
>   case MFB_SET_PIXFMT:
>   ^~~~
> In file included from ./include/linux/acpi.h:15:0,
>                  from ./include/linux/i2c.h:13,
>                  from ./include/uapi/linux/fb.h:6,
>                  from ./include/linux/fb.h:6,
>                  from drivers/video/fbdev/fsl-diu-fb.c:20:
> ./include/linux/device.h:1750:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   _dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/video/fbdev/fsl-diu-fb.c:1296:3: note: in expansion of macro ‘dev_warn’
>    dev_warn(info->dev,
>    ^~~~~~~~
> drivers/video/fbdev/fsl-diu-fb.c:1299:2: note: here
>   case MFB_GET_PIXFMT:
>   ^~~~
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks, patch queued for v5.6 (also sorry for the delay).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/fsl-diu-fb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
> index d19f58263b4e..3e410b9eb272 100644
> --- a/drivers/video/fbdev/fsl-diu-fb.c
> +++ b/drivers/video/fbdev/fsl-diu-fb.c
> @@ -1287,6 +1287,7 @@ static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
>  		dev_warn(info->dev,
>  			 "MFB_SET_PIXFMT value of 0x%08x is deprecated.\n",
>  			 MFB_SET_PIXFMT_OLD);
> +		/* fall through */
>  	case MFB_SET_PIXFMT:
>  		if (copy_from_user(&pix_fmt, buf, sizeof(pix_fmt)))
>  			return -EFAULT;
> @@ -1296,6 +1297,7 @@ static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
>  		dev_warn(info->dev,
>  			 "MFB_GET_PIXFMT value of 0x%08x is deprecated.\n",
>  			 MFB_GET_PIXFMT_OLD);
> +		/* fall through */
>  	case MFB_GET_PIXFMT:
>  		pix_fmt = ad->pix_fmt;
>  		if (copy_to_user(buf, &pix_fmt, sizeof(pix_fmt)))
> 
