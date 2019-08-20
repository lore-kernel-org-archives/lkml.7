Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEE4C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5610D22CF9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NbJjUgl4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbfHTJ4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:56:21 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40929 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729374AbfHTJ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:56:20 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190820095618euoutp01921b1c1e151ede50c22f37e6134e799f~8mPwFUqjW2723127231euoutp01Q
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 09:56:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190820095618euoutp01921b1c1e151ede50c22f37e6134e799f~8mPwFUqjW2723127231euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566294978;
        bh=/k7UolWm42rFLgzc1nD6W9ByqFjCzGOE0sIVZj7FLpY=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=NbJjUgl4UIL7JKTbDAm515Xlwt1yC95rBVMauOm82nn567UxmRQeMTRbtrdL/1KI1
         YviUCPnPw8q95aghEnCJcQyoiYGw0wPi4TafREwj2Eg9CICWm25kNtTYVoCZNFQUxu
         yFvkbm0fVYVoXIzjtMe2m7eCVEBYW9JZP+TLewiA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190820095618eucas1p153388d106ed34efe40372616068ec9db~8mPvmM-fs2216722167eucas1p1E;
        Tue, 20 Aug 2019 09:56:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 14.36.04309.1C3CB5D5; Tue, 20
        Aug 2019 10:56:17 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190820095616eucas1p190bd9e5388103e26bcdd395061c9e7f7~8mPuk0X7-2216122161eucas1p1_;
        Tue, 20 Aug 2019 09:56:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190820095616eusmtrp14f5160e042e3f1d3582be0e86bf4bf80~8mPuWqHjW3034030340eusmtrp1p;
        Tue, 20 Aug 2019 09:56:16 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-b4-5d5bc3c108d2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 43.F8.04166.0C3CB5D5; Tue, 20
        Aug 2019 10:56:16 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190820095616eusmtip1238b7051c38cad50ff5074f907212452~8mPuFLHeJ0081300813eusmtip1D;
        Tue, 20 Aug 2019 09:56:16 +0000 (GMT)
Subject: Re: [PATCH 2/3] video: fbdev: mmp: add COMPILE_TEST support
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <28d91688-6df2-9207-7d88-34d024baf727@samsung.com>
Date:   Tue, 20 Aug 2019 11:56:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:69.0) Gecko/20100101
        Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <d21a19ea-8c18-80df-ae79-76de7c5ee67c@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djP87oHD0fHGjxrNbDYOGM9q8WVr+/Z
        LE70fWC1uLxrDpsDi8f97uNMHn1bVjF6fN4kF8AcxWWTkpqTWZZapG+XwJXR0/uTsWAnb8Xk
        r/dYGhjncncxcnJICJhIbLpxk7WLkYtDSGAFo8SyJ6sZIZwvjBK7N/5jhnA+M0oc+PCQEabl
        3KwPTBCJ5YwS8/rnskA4bxkl5i4+xgpSJSzgIjG3fw8bSEJEYAajxK95e1hAEmwCmhJ/N99k
        A7F5Bewk1l3/DhZnEVCVWLN8BZgtKhAmsXbhZhaIGkGJkzOfgNmcAvYSe9a9AVvALCAv0bx1
        NjOELS5x68l8sJMkBH6zSRy+/pUN4lYXidv996BsYYlXx7ewQ9gyEqcn97BA2PUS91e0MEM0
        dzBKbN2wkxkiYS1x+PhFoG0cQBs0Jdbv0ocIO0rsvraRCSQsIcAnceOtIMQNfBKTtk1nhgjz
        SnS0CUFUK0rcP7sVaqC4xNILMJd5SOzomsYygVFxFpIvZyH5bBaSz2Yh3LCAkWUVo3hqaXFu
        emqxUV5quV5xYm5xaV66XnJ+7iZGYFI5/e/4lx2Mu/4kHWIU4GBU4uH1mBYVK8SaWFZcmXuI
        UYKDWUmEt2IOUIg3JbGyKrUoP76oNCe1+BCjNAeLkjhvNcODaCGB9MSS1OzU1ILUIpgsEwen
        VAOj/tn8xXFZgcLLo77pzrJq5moKXWHFE2VvKfktsrTw8JVSI++zVtOLHJ5ONg5lucnFedbV
        esblB/MX2cgZpfbPl1lZ6/V0/sHory99wpobJUKL9r1abLmT2SA7d8Eby7N3+ifOXnlJ46xZ
        gRSbqHuLs/IR7bsW+Z+/R1Vk7/EJzF+fIHecdboSS3FGoqEWc1FxIgBL6ahqJgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xu7oHDkfHGsw/o2WxccZ6VosrX9+z
        WZzo+8BqcXnXHDYHFo/73ceZPPq2rGL0+LxJLoA5Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLP
        yMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS+jp/cnY8FO3orJX++xNDDO5e5i5OSQEDCRODfr
        A1MXIxeHkMBSRomZU24zQiTEJXbPf8sMYQtL/LnWxQZiCwm8ZpS4sBjMFhZwkZjbv4cNpFlE
        YAajxMPzC1khiiYxSty95gZiswloSvzdfBOsgVfATmLd9e8sIDaLgKrEmuUrwGxRgTCJG/fu
        MULUCEqcnPkELM4pYC+xZ90bsJnMAuoSf+ZdYoaw5SWat86GssUlbj2ZzzSBUXAWkvZZSFpm
        IWmZhaRlASPLKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMBY2Xbs5+YdjJc2Bh9iFOBgVOLh
        9ZgWFSvEmlhWXJl7iFGCg1lJhLdiDlCINyWxsiq1KD++qDQntfgQoynQcxOZpUST84FxnFcS
        b2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgZFPu3lDsgpXcixTzV3Z
        pKrfKxXW/anqr1XfbH6yfUvpnMWlxjbMeuo9vA3BW/fmWu5Tu/wj/PDEiB/PHp1z5biePU8y
        aPnvzfFrrZq2nVyr5y/Wu1itRuf85cdxuo2T33V3bUiMSDoeICz/xdz4C8dBJamr35lELdN4
        t8426V2yJ3yT6IUn+kosxRmJhlrMRcWJANtS6LerAgAA
X-CMS-MailID: 20190820095616eucas1p190bd9e5388103e26bcdd395061c9e7f7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190627140744eucas1p1eb91c6c21ae36105f38dbf5e42259a7c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190627140744eucas1p1eb91c6c21ae36105f38dbf5e42259a7c
References: <CGME20190627140744eucas1p1eb91c6c21ae36105f38dbf5e42259a7c@eucas1p1.samsung.com>
        <d21a19ea-8c18-80df-ae79-76de7c5ee67c@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.06.2019 16:07, Bartlomiej Zolnierkiewicz wrote:
> Add COMPILE_TEST support to mmp display subsystem for better compile
> testing coverage.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>


Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej


> ---
>  drivers/video/fbdev/mmp/Kconfig    |    2 +-
>  drivers/video/fbdev/mmp/hw/Kconfig |    3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> Index: b/drivers/video/fbdev/mmp/Kconfig
> ===================================================================
> --- a/drivers/video/fbdev/mmp/Kconfig
> +++ b/drivers/video/fbdev/mmp/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  menuconfig MMP_DISP
>  	tristate "Marvell MMP Display Subsystem support"
> -	depends on CPU_PXA910 || CPU_MMP2
> +	depends on CPU_PXA910 || CPU_MMP2 || COMPILE_TEST
>  	help
>  	  Marvell Display Subsystem support.
>  
> Index: b/drivers/video/fbdev/mmp/hw/Kconfig
> ===================================================================
> --- a/drivers/video/fbdev/mmp/hw/Kconfig
> +++ b/drivers/video/fbdev/mmp/hw/Kconfig
> @@ -1,7 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config MMP_DISP_CONTROLLER
>  	bool "mmp display controller hw support"
> -	depends on CPU_PXA910 || CPU_MMP2
> +	depends on HAVE_CLK && HAS_IOMEM
> +	depends on CPU_PXA910 || CPU_MMP2 || COMPILE_TEST
>  	help
>  		Marvell MMP display hw controller support
>  		this controller is used on Marvell PXA910 and
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


