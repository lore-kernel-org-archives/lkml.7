Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98C4C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 12:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59C820651
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 12:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B4x01Tv1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbfGPMKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 08:10:51 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:32457 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730754AbfGPMKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 08:10:51 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190716121048epoutp03be8afc69ba1f917ea52cbead27d69952~x4gL-wFJ60130301303epoutp03a
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 12:10:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190716121048epoutp03be8afc69ba1f917ea52cbead27d69952~x4gL-wFJ60130301303epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563279048;
        bh=UhIpDuoNpwBNNWUZEzDOA7ji6Ax3wSdsuDAfE43HpJY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=B4x01Tv1fHiHXD5s6ljp51Q9g6oKqvI33hBXImdi1bSBWnYQMBL1eR8Mq9UQOkkIs
         8e3dVlHrKBtBNjNP0lUk+xMrffE5nff++Yit9nqNGFRyWoBAns1OhIQiLvQiV0Q5nV
         FSJ6IKE8b6GXFEgjcWstuhnW/NkYbqqDsXOGkLp0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190716121047epcas1p3386397ef78583d4da7ea99894486133b~x4gLsDK7s1825718257epcas1p3R;
        Tue, 16 Jul 2019 12:10:47 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.152]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 45nzkZ457fzMqYkV; Tue, 16 Jul
        2019 12:10:46 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.20.04066.6CEBD2D5; Tue, 16 Jul 2019 21:10:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190716121045epcas1p17794ccb550d3584b059b342b4fcb8494~x4gJxshvk3078130781epcas1p10;
        Tue, 16 Jul 2019 12:10:45 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190716121045epsmtrp292e3f0547ecff91ea4631bd931d39a12~x4gJxCpjY1878118781epsmtrp20;
        Tue, 16 Jul 2019 12:10:45 +0000 (GMT)
X-AuditID: b6c32a37-e27ff70000000fe2-10-5d2dbec6733a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        49.0E.03638.5CEBD2D5; Tue, 16 Jul 2019 21:10:45 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190716121045epsmtip2c6b169baed27a718b0f2643fbdc18e57~x4gJlynHu3108531085epsmtip2Z;
        Tue, 16 Jul 2019 12:10:45 +0000 (GMT)
Subject: Re: [PATCH v4 09/24] PM / devfreq: tegra30: Reset boosting on
 startup
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <caed4a78-ad8a-5bee-adc4-4a342e2898c3@samsung.com>
Date:   Tue, 16 Jul 2019 21:13:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707223303.6755-10-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAJsWRmVeSWpSXmKPExsWy7bCmru6xfbqxBt8XK1qs/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRmXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoq
        ufgE6Lpl5gAdpKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpsCzQK07MLS7NS9dL
        zs+1MjQwMDIFKkzIztiz5R5LwTvOig0T5rI3MHZydDFyckgImEic2nqAtYuRi0NIYAejxMoZ
        vUwQzidGiXOfNkA53xgl3p/5zdjFyAHWcqFNACK+l1Fiw9upbBDOe6D234sYQeYKCwRIfPu9
        E2yuiMA/RonOn81sIAlmgUiJwztXM4HYbAJaEvtf3ACL8wsoSlz98RismVfATmJK8ysWEJtF
        QFVi1odDYLaoQITEqSPzWCBqBCVOznwCZnMKmEnMapnFCjFfXOLWk/lMELa8RPPW2cwgR0gI
        /GeTODfhESvE1y4S3693skDYwhKvjm9hh7ClJD6/28sGYVdLrDx5hA2iuYNRYsv+C1DNxhL7
        l05mAoUFs4CmxPpd+hBhRYmdv+cyQizmk3j3tYcVEly8Eh1tQhAlyhKXH9xlgrAlJRa3d7JN
        YFSaheSdWUhemIXkhVkIyxYwsqxiFEstKM5NTy02LDBGju5NjODUqmW+g3HDOZ9DjAIcjEo8
        vCf26MQKsSaWFVfmHmKU4GBWEuG1/aodK8SbklhZlVqUH19UmpNafIjRFBjaE5mlRJPzgWk/
        ryTe0NTI2NjYwsTQzNTQUEmcd94fzVghgfTEktTs1NSC1CKYPiYOTqkGRq2TE+8UFE+z4ZU9
        +eD09yUX506vnOa4/dDtNceckmtmBhy/EitoXWC268f1+UmhYrJqR9mqPCad/L8rcFKFjJTy
        qSxzlvuOFx7VOfG/VH3g1Zs6j2HW077g7fe+rezPF8mbfyVjJUPhj2tpXUVCWflJ++0Evm6Z
        uPxvwI2DNgkKbPN3mygdfqjEUpyRaKjFXFScCAAodT6jwwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSvO7RfbqxBr0r9SxWf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgy9my5x1LwjrNiw4S57A2MnRxdjBwcEgImEhfa
        BLoYuTiEBHYzSsyaOZu5i5ETKC4pMe3iUWaIGmGJw4eLIWreMkr0PnnKAhIXFvCTmDfbHCQu
        ItDEJLGp9wI7SC+zQKREz9wtbBANWxglTs5pAkuwCWhJ7H9xgw3E5hdQlLj64zEjiM0rYCcx
        pfkVC4jNIqAqMevDITBbVCBCYtK1nSwQNYISJ2c+AbM5BcwkZrXMYoVYpi7xZ94lZghbXOLW
        k/lMELa8RPPW2cwTGIVnIWmfhaRlFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L
        10vOz93ECI4wLa0djCdOxB9iFOBgVOLhPbFHJ1aINbGsuDL3EKMEB7OSCK/tV+1YId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rzy+ccihQTSE0tSs1NTC1KLYLJMHJxSDYwyKxmlVOaf8bT8UyT7
        46bETCuNrwEbpPfMNAmMusgud/mAYqNO+IF647Vidl+65r8rXcYvFpHEsmrXdIaT5o7abWXl
        QvNe/no113ue20uXIx4Bczq/M7alKNVX/1YWyrHrPztLQV22/B1nbETh9ltheay722JjHwmn
        x+vc+fD97EmfJZOEjyqxFGckGmoxFxUnAgCU24rArAIAAA==
X-CMS-MailID: 20190716121045epcas1p17794ccb550d3584b059b342b4fcb8494
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223639epcas4p392300747244905ec06f580394d579eb4
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223639epcas4p392300747244905ec06f580394d579eb4@epcas4p3.samsung.com>
        <20190707223303.6755-10-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
> Governor could be stopped while boosting is active. We have assumption
> that everything is reset on governor's restart, including the boosting
> value, which was missed.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index d5d04c25023b..32fe95458ee7 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -536,6 +536,9 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>  {
>  	u32 val = 0, target_freq;
>  
> +	/* we don't want boosting on restart */

nitpick.
I think that following comment is proper in my case.
In my case, I think 'we' expression is not good

	/* Reset the boost frequency on restart */

> +	dev->boost_freq = 0;
> +
>  	target_freq = clk_get_rate(tegra->emc_clock) / KHZ;
>  	dev->avg_count = target_freq * ACTMON_SAMPLING_PERIOD;
>  	device_writel(dev, dev->avg_count, ACTMON_DEV_INIT_AVG);
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
