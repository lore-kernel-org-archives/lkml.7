Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7283C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73ADB21849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DlQ8pR/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfGSHBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 03:01:32 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39752 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfGSHBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 03:01:31 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190719070128euoutp01833316ec0be7abad1dc17632cc089276~yvN93E3Po2129121291euoutp01E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 07:01:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190719070128euoutp01833316ec0be7abad1dc17632cc089276~yvN93E3Po2129121291euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563519688;
        bh=RuexnrsbXl/Hd9rIxzNwnxH6Jz4Zi31yO73QxVhe+aM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=DlQ8pR/TGnU/R3O3yHo8H/Vj8Wp4r2bzbntSd2ztZzfcJZlx2E0b/ay9YYVCdiQgV
         QRXmOrV941ewmdut6Zvfpvqsv5RodSHFY5AvWCj4DRcoKIcSj7oncHxMB2IX7aTRJ4
         51g/NEu4Df8k8pGirNedAnrSmme+yVs7EjgTnK70=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190719070127eucas1p25e71f261915ee58408c593f11dd32e73~yvN9P-tld0600706007eucas1p2g;
        Fri, 19 Jul 2019 07:01:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 04.BA.04325.7CA613D5; Fri, 19
        Jul 2019 08:01:27 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190719070126eucas1p19c19ef5d7ae3c150a7cdfb10d61a52fa~yvN8Sv3tL2823728237eucas1p1s;
        Fri, 19 Jul 2019 07:01:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190719070126eusmtrp24d941d8f70f2159b726e6a1a718c7a1c~yvN8I1Pp42079520795eusmtrp2e;
        Fri, 19 Jul 2019 07:01:26 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-ff-5d316ac7d2ae
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 65.6E.04140.6CA613D5; Fri, 19
        Jul 2019 08:01:26 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190719070126eusmtip244381f93620acd3ecb19e93c4d50f9e4~yvN7pLyYZ1961419614eusmtip2L;
        Fri, 19 Jul 2019 07:01:26 +0000 (GMT)
Subject: Re: [PATCH] drm/bridge: fix RC_CORE dependency
To:     Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     =?UTF-8?Q?Ronald_Tschal=c3=a4r?= <ronald@innovation.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <763005f0-fc66-51bc-fcfe-3ae4942a9c07@samsung.com>
Date:   Fri, 19 Jul 2019 09:01:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190718134240.2265724-1-arnd@arndb.de>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsWy7djPc7rHswxjDc7/V7HoPXeSyeLvpGPs
        Fv+3TWS2OLzoBaPFla/v2Sw6Jy5ht7i8aw6bxYt7b5ks7k4+wujA6fH71yRGj73fFrB47Jx1
        l91jdsdMVo8pnRIe2789YPW4332cyeP4rlvsHp83yQVwRnHZpKTmZJalFunbJXBlLHniXLCZ
        t+LF/hVMDYzN3F2MnBwSAiYSF+euZ+ti5OIQEljBKNF95yAjhPOFUeLDqs1MEM5nRol1P1cB
        ORxgLe9b7CDiyxkljlzqgyp6yygx+XwzE8hcYQFziV2zH7GCNIgIpEq0fQsAqWEWaGCSWLj+
        ACtIDZuApsTfzTfZQGxeATuJX/+Ps4DYLAKqEi1XbzCC2KICYRI/F3RC1QhKnJz5BKyGU8BU
        4u3lJWC7mAXkJba/ncMMYYtL3Hoynwnit0fsEh/6oGwXia6zt6BsYYlXx7ewQ9gyEv93wtTX
        S9xf0cIMcqiEQAejxNYNO5khEtYSh49fBHuGGejo9bv0IcKOEmfvrmGBBAqfxI23ghAn8ElM
        2jadGSLMK9HRJgRRrShx/+xWqIHiEksvfGWbwKg0C8ljs5A8MwvJM7MQ9i5gZFnFKJ5aWpyb
        nlpsnJdarlecmFtcmpeul5yfu4kRmLhO/zv+dQfjvj9JhxgFOBiVeHgDcg1ihVgTy4orcw8x
        SnAwK4nw3n6pHyvEm5JYWZValB9fVJqTWnyIUZqDRUmct5rhQbSQQHpiSWp2ampBahFMlomD
        U6qB8cjayywv7BfYxGV5H7mw4r+f1lvhbDGvBd/7G6fsVvLe+Hfp2/iyx+ocOzWnp1a3vOxd
        UmrfeqjL+fy7A2Hro+N/JKaYMVx1Smd+PFPOp12h1vnr9W8mBld2ml9KCA6avHpDi4S1WdmW
        U4HqP93vR59yMDnKrcYovMu4OPhUoXHE+5WNC9fwKbEUZyQaajEXFScCAEeClW5YAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xe7rHsgxjDeZ90rToPXeSyeLvpGPs
        Fv+3TWS2OLzoBaPFla/v2Sw6Jy5ht7i8aw6bxYt7b5ks7k4+wujA6fH71yRGj73fFrB47Jx1
        l91jdsdMVo8pnRIe2789YPW4332cyeP4rlvsHp83yQVwRunZFOWXlqQqZOQXl9gqRRtaGOkZ
        WlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlLHniXLCZt+LF/hVMDYzN3F2MHBwSAiYS
        71vsuhi5OIQEljJK7PzdyNbFyAkUF5fYPf8tM4QtLPHnWhdYXEjgNaPEj1WmILawgLnErtmP
        WEFsEYFUia0X3zKCDGIWaGKSeP3hMQvE1A5Giftrt4FVsQloSvzdfBNsEq+AncSv/8dZQGwW
        AVWJlqs3GEEuEhUIkzh6Ig+iRFDi5MwnYCWcAqYSby8vYQKxmQXUJf7Mu8QMYctLbH87B8oW
        l7j1ZD7TBEahWUjaZyFpmYWkZRaSlgWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECY3Xb
        sZ9bdjB2vQs+xCjAwajEwxuQaxArxJpYVlyZe4hRgoNZSYT39kv9WCHelMTKqtSi/Pii0pzU
        4kOMpkC/TWSWEk3OB6aRvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwc
        nFINjBM0j6lrNwdumGDqzxBcI+LGFNIfFzD925NGaRdhgyXec/7GRl66v7vg2JMVWux3jybf
        njJx4gJ1reSdBq6Pf3BNrDK9M8Hst/bDF79mpdns2P/U78JjhnwOyXuNb3+f2ew9s+Jvmscm
        /w+XdGMiBLSTVrEn35txL/C2hnZpVE/+P/ump2em3ldiKc5INNRiLipOBAA3M2+m6wIAAA==
X-CMS-MailID: 20190719070126eucas1p19c19ef5d7ae3c150a7cdfb10d61a52fa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190718134253epcas3p32a5afece52c47aaac0cd5795ff4cf022
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190718134253epcas3p32a5afece52c47aaac0cd5795ff4cf022
References: <CGME20190718134253epcas3p32a5afece52c47aaac0cd5795ff4cf022@epcas3p3.samsung.com>
        <20190718134240.2265724-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.07.2019 15:42, Arnd Bergmann wrote:
> Using 'imply' causes a new problem, as it allows the case of
> CONFIG_INPUT=m with RC_CORE=y, which fails to link:


I have reviewed dependencies and I wonder how such configuration is
possible at all.

RC_CORE depends on INPUT (at least on today's next branch) so if INPUT=m
then RC_CORE should be either n either m, am I right?

Arnd, are there unknown to me changes in RC/INPUT dependencies?


Regards

Andrzej


>
> drivers/media/rc/rc-main.o: In function `ir_do_keyup':
> rc-main.c:(.text+0x2b4): undefined reference to `input_event'
> drivers/media/rc/rc-main.o: In function `rc_repeat':
> rc-main.c:(.text+0x350): undefined reference to `input_event'
> drivers/media/rc/rc-main.o: In function `rc_allocate_device':
> rc-main.c:(.text+0x90c): undefined reference to `input_allocate_device'
>
> Add a 'depends on' that allows building both with and without
> CONFIG_RC_CORE, but disallows combinations that don't link.
>
> Fixes: 5023cf32210d ("drm/bridge: make remote control optional")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/bridge/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index f64c91defdc3..70a8ed2505aa 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -85,8 +85,8 @@ config DRM_SIL_SII8620
>  	tristate "Silicon Image SII8620 HDMI/MHL bridge"
>  	depends on OF
>  	select DRM_KMS_HELPER
> +	depends on RC_CORE || !RC_CORE
>  	imply EXTCON
> -	imply RC_CORE
>  	help
>  	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
>  


