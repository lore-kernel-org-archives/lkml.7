Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BF3C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D3121783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SZUPYHr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390491AbfGROQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 10:16:16 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47432 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbfGROQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:16:15 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190718141613euoutp029b685bc0e9a18739d4d01ed959b09ad5~yhgRO_8hw2440524405euoutp02P
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 14:16:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190718141613euoutp029b685bc0e9a18739d4d01ed959b09ad5~yhgRO_8hw2440524405euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563459373;
        bh=wLENZPNH5/PowzkgyxZdtUEKoTWkuWsrgFeMFf+/LHQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SZUPYHr7ijZFVTNNFzGuqDJ4RGYKOEtJRzBnkAEaflGi8sqyKmqk5p2Ri/Fn3NJTu
         NX3x8R+351BIFjsG0ywy3U/lu6ZGTBFYe4GXHwkBfx0wbfHGlXY0ywJTo6Sh37i0np
         KDX06Vh5ecJeKUXzECLnwLrU2tnWTAW7TGZyq3fw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190718141612eucas1p21bdd98468e25aa732aa23f92cc99989d~yhgQbzXDF2613026130eucas1p2Q;
        Thu, 18 Jul 2019 14:16:12 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 49.3E.04325.C2F703D5; Thu, 18
        Jul 2019 15:16:12 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190718141612eucas1p19040faed910e9308277cb3af2e49b674~yhgPptBZU2337623376eucas1p1o;
        Thu, 18 Jul 2019 14:16:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190718141611eusmtrp2685c8d5863909732b0b13c5089f40a1e~yhgPbovAr2627226272eusmtrp20;
        Thu, 18 Jul 2019 14:16:11 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-f5-5d307f2cda74
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F9.C4.04140.B2F703D5; Thu, 18
        Jul 2019 15:16:11 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190718141611eusmtip1e153ebe5450f9ced53f167105366c1e2~yhgO9tqqx0874808748eusmtip1f;
        Thu, 18 Jul 2019 14:16:11 +0000 (GMT)
Subject: Re: [PATCH] drm/bridge: fix RC_CORE dependency
To:     Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     =?UTF-8?Q?Ronald_Tschal=c3=a4r?= <ronald@innovation.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <ea59751e-7391-e3e9-bb46-00e86b25f1a8@samsung.com>
Date:   Thu, 18 Jul 2019 16:16:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190718134240.2265724-1-arnd@arndb.de>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj2O+ds52w5+5yaL10MR/0oSo3SDnShSOhIFBrYj2rUypNabsmO
        WnahISXOsLx0czMvaWQmKea9krzgvKBkRd7SWSwodRWYopWZ8yj573ne53m/93ngY0hli2Q5
        E6mL4fU6TZRKKqcqm6c6N2644qf2S0j3ZlM6Wwl2Or2ZZmcq00i28cEXxL4b/y5ljWkFNPu2
        NkvKfhm0E+xARhPaJeN+/0pH3MuJXIqrMQ3QnDkpU8LdMgJXNTEk4azXLQRnqe2jubEyr2DZ
        Yfn2MD4qMo7X++48Lo+wWRup6Dbn849LpigDeiFPRjIG8BYwPLmGkpGcUeJCBPdMZkokPxHc
        N9dLRTKGIOFxHbGwYrRlkaLwCEGTrZAWiR2BPbVV6nC54a1Qa/4kSUYM4455SJwIdnhIbCAg
        r+SVxOGR4nUw/ax3zq/AO2Gke5h2YAqvhbbnk6QDe+BDMJVrnPe4QmumjXJgGfYH+9uCuUQk
        Xg1V9ixSxJ7QZ8shHMcAD9LQ9zkLibEDoam6RSJiNxi2lNMiXgkzNTnz1a6AtfAqKS4nIago
        rSFFYRs0Wrrm2pCzqUtqfcXxbugYKKYcY8Au0GN3FTO4QHrlXVIcKyApUSm6vcHaUTH/oCc8
        fD0uTUUq06JmpkVtTIvamP7fzUVUEfLkYwVtOC9s1vHnfASNVojVhfucPKstQ7P/q/2vZbwa
        1f050YAwg1TOimCtn1op0cQJ8doGBAypclf0f/VVKxVhmvgLvP7sMX1sFC80oBUMpfJUXHQa
        OqLE4ZoY/gzPR/P6BZVgZMsN6GmhuZ9YMtZTtPto3jT/LWL/aCItLZ1xGknJWRZ/4NLB8tuT
        +o3WqAT1vq69RN1So64pI+bmjRP+W0dx2kh0QH7gjj1Fb2Rj3dlerQFu9ZG4J6z4TqW60+jC
        f+gVToe2Z0d3GULyHvalBEHuquHQUx75gxWXP5Kl73+YQuLX4CAVJURoNq0n9YLmH+3NLINb
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xu7ra9QaxBidnalr0njvJZPF30jF2
        i//bJjJbHF70gtHiytf3bBadE5ewW1zeNYfN4sW9t0wWdycfYXTg9Pj9axKjx95vC1g8ds66
        y+4xu2Mmq8eUTgmP7d8esHrc7z7O5HF81y12j8+b5AI4o/RsivJLS1IVMvKLS2yVog0tjPQM
        LS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyntw/zFJwiqdi5fqfLA2Me7i6GDk5JARM
        JDqfzGHuYuTiEBJYyihx/mcDO0RCXGL3/LfMELawxJ9rXWwQRa8ZJR5MeMAGkhAWMJfYNfsR
        K4gtIpAqsfXiW0aQImaBJiaJ1x8es0B0dDBK3F+7DayKTUBT4u/mm2DdvAJ2Eq+vvwJbxyKg
        KnFq9w+gdRwcogJhEkdP5EGUCEqcnPmEBcTmFDCVeHt5CROIzSygLvFn3iVmCFteYvvbOVC2
        uMStJ/OZJjAKzULSPgtJyywkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRGLHb
        jv3csoOx613wIUYBDkYlHt6AXINYIdbEsuLK3EOMEhzMSiK8t1/qxwrxpiRWVqUW5ccXleak
        Fh9iNAX6bSKzlGhyPjCZ5JXEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi
        4JRqYJzOJZaR/oGX597390lTeGZJxN6zUJjjGxmbFTWVWX+lGEO4t9DTfdq9G5zjD34I652R
        muQ6ZV7+i4hrs/5Eu2pvE/x4pXZvwZMfRparsw2e7Gu+6faTZ29p5ZIDRUUngytkP55pjt7a
        sVF/0hO5VwYNXOJWWZa7LnVsu8ha/T978R7hu01RX5RYijMSDbWYi4oTASEF853uAgAA
X-CMS-MailID: 20190718141612eucas1p19040faed910e9308277cb3af2e49b674
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

Hi Arnd,

On 18.07.2019 15:42, Arnd Bergmann wrote:
> Using 'imply' causes a new problem, as it allows the case of
> CONFIG_INPUT=m with RC_CORE=y, which fails to link:
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


Proper solution has been already merged via input tree[1].


[1]:
https://lore.kernel.org/lkml/CAKdAkRTGXNbUsuKASNGLfwUwC7Asod9K5baYLPWPU7EX-42-yA@mail.gmail.com/


Regards

Andrzej


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


