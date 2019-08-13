Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAA4C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0A82084D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O8D9k3hO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfHMNaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:30:35 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42658 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbfHMNaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:30:35 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190813133033euoutp016faeeb82d19aa37a0dd8f0742c2837ac~6fpz05_7s2029820298euoutp01c
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 13:30:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190813133033euoutp016faeeb82d19aa37a0dd8f0742c2837ac~6fpz05_7s2029820298euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565703033;
        bh=jHLfqOUF0tHmhW0YtJIRsW8aaDK4tyJuMECOn3sKdck=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=O8D9k3hOLGAhh5eQS3fY6v1csmE52fobX7YmVh+WH5nwLMOCV86OINI0dmj0w2T0X
         9RhR4V8ZG3q4WHdi94kyvTjwF9X8fDt02a/Acd0/JDHNLcWI1tLH/yu+v+XD6J4SAJ
         2LKcke0f/YOxsWkSLudDpWkO6joMX89a7YTdQl1M=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190813133032eucas1p23eec325b72a4db20801126d9312b19fb~6fpzGl_3S1030310303eucas1p2g;
        Tue, 13 Aug 2019 13:30:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F0.DF.04469.77BB25D5; Tue, 13
        Aug 2019 14:30:31 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190813133031eucas1p18e366022ea9fffdfcbf46ef861e32042~6fpyR-aZ63121731217eucas1p1q;
        Tue, 13 Aug 2019 13:30:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190813133031eusmtrp2177d46a66897df044aae036871f2f4ec~6fpyCfj2i1093610936eusmtrp2K;
        Tue, 13 Aug 2019 13:30:31 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-5b-5d52bb77c772
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E3.37.04166.77BB25D5; Tue, 13
        Aug 2019 14:30:31 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190813133030eusmtip189c92098638cc37e3935c84922b8c942~6fpxxPojJ2926929269eusmtip1d;
        Tue, 13 Aug 2019 13:30:30 +0000 (GMT)
Subject: Re: [PATCH 09/16] fbdev: remove w90x900/nuc900 platform drivers
To:     Arnd Bergmann <arnd@arndb.de>, soc@kernel.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <cc732000-a147-bec2-1082-7bf58ee8f309@samsung.com>
Date:   Tue, 13 Aug 2019 15:30:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190809202749.742267-10-arnd@arndb.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djPc7rlu4NiDY48tbL4O+kYu8WVr+/Z
        LE70fWC1uLxrDpvF4+t/2BxYPX7/msTosWlVJ5vH/e7jTB6fN8kFsERx2aSk5mSWpRbp2yVw
        Zfxa18xaMI+rYtbExWwNjD/Zuxg5OSQETCSmbLnHCGILCaxglLi1Q7SLkQvI/sIoMf3KaTYI
        5zOjxM79L1hgOr5faWaESCxnlFh+YiorhPOWUWLyr1tAGQ4OYQEPifal4iCmiIChROdMfhCT
        WSBBYvciM5AxbAJWEhPbV4Et5hWwk3i8+iLYQSwCqhLTfp4Hs0UFIiTuH9vAClEjKHFy5hMW
        kDGcAqYSk8+Ig4SZBcQlbj2ZzwRhy0tsfzuHGeQYCYF57BKLlh5hhjjZRaLp2XEmCFtY4tXx
        LVDPy0j83wnSDNKwjlHib8cLqO7tQH9N/scGUWUtcfj4RVaIBzQl1u/Shwg7Stz8NJkZJCwh
        wCdx460gxBF8EpO2TYcK80p0tAlBVKtJbFi2gQ1mbdfOlcwTGJVmIflsFpJ3ZiF5ZxbC3gWM
        LKsYxVNLi3PTU4sN81LL9YoTc4tL89L1kvNzNzEC08vpf8c/7WD8einpEKMAB6MSD2/AlqBY
        IdbEsuLK3EOMEhzMSiK8l0yAQrwpiZVVqUX58UWlOanFhxilOViUxHmrGR5ECwmkJ5akZqem
        FqQWwWSZODilGhidcsWdNy5nTVD5lX19KuOGLxVbZouvWtt5afaRpMDiplNK5f3HPn5cNWvP
        sbKDMy7/vPpOa8KzY7IOv5Y2lRzZ/Y8vaeY06zP7Q7JS3yYflVnwea1FXt5Z3UgBkVdPpy1W
        WRZc5CIas+Dmw20rlz2dmze7W/RS1aX6HNtTl72PbPvTOsH//eWSWUosxRmJhlrMRcWJAN+u
        PQ8rAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsVy+t/xu7rlu4NiDdpesVr8nXSM3eLK1/ds
        Fif6PrBaXN41h83i8fU/bA6sHr9/TWL02LSqk83jfvdxJo/Pm+QCWKL0bIryS0tSFTLyi0ts
        laINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mn6ta2YtmMdVMWviYrYGxp/s
        XYycHBICJhLfrzQzdjFycQgJLGWUuHBgNnMXIwdQQkbi+PoyiBphiT/Xutggal4zSuy6NY8F
        pEZYwEOifak4iCkiYCjROZMfpJxZIEFixdt2VojyTYwS9ycuZwFJsAlYSUxsX8UIYvMK2Ek8
        Xn0R7AYWAVWJaT/Pg9miAhESZ96vYIGoEZQ4OfMJ2CpOAVOJyWfEIearS/yZd4kZwhaXuPVk
        PhOELS+x/e0c5gmMQrOQdM9C0jILScssJC0LGFlWMYqklhbnpucWG+oVJ+YWl+al6yXn525i
        BEbUtmM/N+9gvLQx+BCjAAejEg9vwJagWCHWxLLiytxDjBIczEoivJdMgEK8KYmVValF+fFF
        pTmpxYcYTYF+m8gsJZqcD4z2vJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUw
        fUwcnFINjJzuv1KPlL8PVCjzXn/2a8/nNUenWud/ebXr/Y3FBfPS3RQDH/xNianMMeQNe9H5
        18rlBtNNMb/0nwdMp300yQx4tVja/kxTS4TRhF1ds55cWjXDyXj3zL9pV4zln8pPiyr7caDv
        9/MP19ljG6/tzWoVzNCdpHJskYb7N4HzPj4SUuEyNn3rriqxFGckGmoxFxUnAgDaMNmZvgIA
        AA==
X-CMS-MailID: 20190813133031eucas1p18e366022ea9fffdfcbf46ef861e32042
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190809202857epcas2p14ab10d8ce2e50647671ab8c0ded385a8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190809202857epcas2p14ab10d8ce2e50647671ab8c0ded385a8
References: <20190809202749.742267-1-arnd@arndb.de>
        <CGME20190809202857epcas2p14ab10d8ce2e50647671ab8c0ded385a8@epcas2p1.samsung.com>
        <20190809202749.742267-10-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/9/19 10:27 PM, Arnd Bergmann wrote:
> The ARM w90x900 platform is getting removed, so this driver is obsolete.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

BTW there is a very minor issue with internal bisectability of
this patch series (non-issue in reality because it affects only
configs with ARCH_W90X900=y and such are now gone, just FYI):

arch/arm/mach-w90x900/dev.c (which stays in tree until patch #16
("ARM: remove w90x900 platform") uses include/linux/platform_data/
files removed in patches #7 (spi), #9 (fbdev) and #10 (keyboard).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

>  drivers/video/fbdev/Kconfig                  |  14 -
>  drivers/video/fbdev/Makefile                 |   1 -
>  drivers/video/fbdev/nuc900fb.c               | 760 -------------------
>  drivers/video/fbdev/nuc900fb.h               |  51 --
>  include/Kbuild                               |   1 -
>  include/linux/platform_data/video-nuc900fb.h |  79 --
>  6 files changed, 906 deletions(-)
>  delete mode 100644 drivers/video/fbdev/nuc900fb.c
>  delete mode 100644 drivers/video/fbdev/nuc900fb.h
>  delete mode 100644 include/linux/platform_data/video-nuc900fb.h
