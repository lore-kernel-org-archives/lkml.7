Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7C1C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 12:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BA32085B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 12:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CyklM81Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbgACMeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 07:34:44 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60533 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbgACMeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 07:34:44 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200103123443euoutp02e7abbc61f7bc185b7e55351510cdc972~mYI4sVmwh0043200432euoutp02g
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jan 2020 12:34:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200103123443euoutp02e7abbc61f7bc185b7e55351510cdc972~mYI4sVmwh0043200432euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578054883;
        bh=rC1GrjnQK8bGwlNRTucuG4iqBzjnKlpZxvoAb2ODCKk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CyklM81ZEBYVg7trI0YfphFpxvErUza7VMYgKJ2gIrrsDvgk7nzmrOgO3/9gr3U8G
         MPFK5rrnw20QYSoN7qXIks6IYp/f4KSI1e1TGGpSwCcOaIdQWhTWD/AWjfQP6OLdO4
         ieyIec/Rjs3SJ0sEUUnVEGCZ1zl8wk28g1d26pjk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200103123442eucas1p25721f18b36920002bfe20ce56dac39df~mYI4U50Ky1427814278eucas1p2Q;
        Fri,  3 Jan 2020 12:34:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3D.7B.61286.2E43F0E5; Fri,  3
        Jan 2020 12:34:42 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200103123442eucas1p173b7692e9d4392c09c0b1c36fda90382~mYI36Lpf-3001630016eucas1p1n;
        Fri,  3 Jan 2020 12:34:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200103123442eusmtrp198e08812ff176ec28aebb2120cf1e301~mYI35a7J60576405764eusmtrp1a;
        Fri,  3 Jan 2020 12:34:42 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-5a-5e0f34e293fc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 61.25.07950.2E43F0E5; Fri,  3
        Jan 2020 12:34:42 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200103123441eusmtip1fea78868dc4316851517fac1ec22c5cf~mYI3OYAoj1531215312eusmtip1R;
        Fri,  3 Jan 2020 12:34:41 +0000 (GMT)
Subject: Re: [PATCH] video: pxafb: Use devm_platform_ioremap_resource() in
 pxafb_probe()
To:     Markus Elfring <Markus.Elfring@web.de>,
        Daniel Mack <daniel@zonque.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <0d499b49-dc8c-de58-8268-36e3cced5ff0@samsung.com>
Date:   Fri, 3 Jan 2020 13:34:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a1b804b1-43c2-327a-d6d1-df49aebec680@web.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7djPc7qPTPjjDM6/1LH4MvcUi0XT31cs
        Fle+vmezmLamhdVi6y1pixN9H1gtLu+aw2bxf9ZzVov3nzqZLB6veMtusfGrh8Wdr89ZHHg8
        3t9oZffYOesuu0fLkbesHov3vGTy2LSqk83jzrU9bB73u48zeXzeJOdx+9k2Fo/tu5ezBHBF
        cdmkpOZklqUW6dslcGVsmXOcveA6T8XZPfdYGhgXc3UxcnJICJhIXNm3jb2LkYtDSGAFo8Sr
        n1OZIJwvjBKTfp5mhXA+M0rs3/eVuYuRA6xl8gJ3iPhyRomNC88ygowSEnjLKHH0ojuILSwQ
        JdHx8y47iC0i0Mwk0XjdHKSBWeAlo8SmPdeZQBJsAlYSE9tXgTXzCthJvL21lRnEZhFQkVh6
        /C0riC0qECHx6cFhVogaQYmTM5+wgBzBCdTbN58PJMwsIC5x68l8JghbXmL72znMILskBP6y
        SzR0zWCD+NNF4vTNXUwQtrDEq+Nb2CFsGYnTk3tYIBrWMUr87XgB1b2dUWL55H9Q3dYSd879
        YgPZzCygKbF+lz5E2FHixuZVbJBQ4ZO48VYQ4gg+iUnbpkMDi1eio00IolpNYsOyDWwwa7t2
        rmSewKg0C8lns5C8MwvJO7MQ9i5gZFnFKJ5aWpybnlpsmJdarlecmFtcmpeul5yfu4kRmOJO
        /zv+aQfj10tJhxgFOBiVeHgTlPnjhFgTy4orcw8xSnAwK4nwlgfyxgnxpiRWVqUW5ccXleak
        Fh9ilOZgURLnNV70MlZIID2xJDU7NbUgtQgmy8TBKdXAWCU7LXLZIff/82xvPzosFqWll1+e
        tfiow/erett21Nk1q+ZriX2UY8suzf2zN3Dfspc9S2XmWQeIHDV/pRKUWv6ay93woO77uXyT
        HwZ5f7tywvjA3UX9q7criP2cm/Z1T715tXDa9I/rnqwUqnTy+OHoqxiyrS5WNs6L6fyOlam5
        STMlqssslViKMxINtZiLihMBDiah6W0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsVy+t/xu7qPTPjjDBZc4bX4MvcUi0XT31cs
        Fle+vmezmLamhdVi6y1pixN9H1gtLu+aw2bxf9ZzVov3nzqZLB6veMtusfGrh8Wdr89ZHHg8
        3t9oZffYOesuu0fLkbesHov3vGTy2LSqk83jzrU9bB73u48zeXzeJOdx+9k2Fo/tu5ezBHBF
        6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GVsmXOc
        veA6T8XZPfdYGhgXc3UxcnBICJhITF7g3sXIxSEksJRR4taSTnaIuIzE8fVlXYycQKawxJ9r
        XWwQNa8ZJTaues0GkhAWiJLo+HmXHSQhItDMJNG4czsTiMMs8JJR4s6Xx8wQLb2MEv9vrgZr
        YROwkpjYvooRxOYVsJN4e2srM4jNIqAisfT4W1YQW1QgQuLwjllQNYISJ2c+YQE5iROot28+
        H0iYWUBd4s+8S8wQtrjErSfzmSBseYntb+cwT2AUmoWkexaSlllIWmYhaVnAyLKKUSS1tDg3
        PbfYSK84Mbe4NC9dLzk/dxMjMKq3Hfu5ZQdj17vgQ4wCHIxKPLwcivxxQqyJZcWVuYcYJTiY
        lUR4ywN544R4UxIrq1KL8uOLSnNSiw8xmgL9NpFZSjQ5H5hw8kriDU0NzS0sDc2NzY3NLJTE
        eTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MKo9PCK9RbPQM2VeZYe6ySbP3hllLf//9ExdvP91
        26SHKbNdElvulkoF3o8w2G3A2F2/u8HDMj/A99WbBeePGDJ/lOo7PbG5qLyDaW+KGb94z9Mw
        wd2vGa45zn19cYfl96TZlqyx81Zune4lKPvJLvKYnN3p0m/BLJdYzKw1f5o5Mn11iF12Qoml
        OCPRUIu5qDgRAFbAv3UAAwAA
X-CMS-MailID: 20200103123442eucas1p173b7692e9d4392c09c0b1c36fda90382
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190919150135epcas3p2bf5ab33712e12edd90af2766eeaaccda
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190919150135epcas3p2bf5ab33712e12edd90af2766eeaaccda
References: <CGME20190919150135epcas3p2bf5ab33712e12edd90af2766eeaaccda@epcas3p2.samsung.com>
        <a1b804b1-43c2-327a-d6d1-df49aebec680@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/19/19 5:01 PM, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 19 Sep 2019 16:51:38 +0200
> 
> Simplify this function implementation by using a known wrapper function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Thanks, patch queued for v5.6 (also sorry for the delay).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/pxafb.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
> index f70c9f79622e..237f8f436fdb 100644
> --- a/drivers/video/fbdev/pxafb.c
> +++ b/drivers/video/fbdev/pxafb.c
> @@ -2237,7 +2237,6 @@ static int pxafb_probe(struct platform_device *dev)
>  {
>  	struct pxafb_info *fbi;
>  	struct pxafb_mach_info *inf, *pdata;
> -	struct resource *r;
>  	int i, irq, ret;
> 
>  	dev_dbg(&dev->dev, "pxafb_probe\n");
> @@ -2303,14 +2302,7 @@ static int pxafb_probe(struct platform_device *dev)
>  		fbi->lcd_supply = NULL;
>  	}
> 
> -	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
> -	if (r == NULL) {
> -		dev_err(&dev->dev, "no I/O memory resource defined\n");
> -		ret = -ENODEV;
> -		goto failed;
> -	}
> -
> -	fbi->mmio_base = devm_ioremap_resource(&dev->dev, r);
> +	fbi->mmio_base = devm_platform_ioremap_resource(dev, 0);
>  	if (IS_ERR(fbi->mmio_base)) {
>  		dev_err(&dev->dev, "failed to get I/O memory\n");
>  		ret = -EBUSY;
> --
> 2.23.0
