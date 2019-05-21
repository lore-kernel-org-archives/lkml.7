Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5BDC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B74216B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K9qcd+B4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfEUKuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:50:04 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57979 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfEUKuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:50:03 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190521105000euoutp01d25ae0a95f44c59f5604827ab28ba069~grRqh4vGe2274522745euoutp01-
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 10:50:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190521105000euoutp01d25ae0a95f44c59f5604827ab28ba069~grRqh4vGe2274522745euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558435801;
        bh=dVrDy17Ux0GSIhBmM0IvoBwOz6MznLg3cinUw4GbxOo=;
        h=From:Subject:To:Date:References:From;
        b=K9qcd+B4uliM1SdbWUU9xgYfyrmXde/mkuP9wKRyrViUnCcSlEwfRpMS1jSOYQ1tW
         RV3j/OQU5Qc7z7f/Y/+WN1egpIum3nTyFAHPjPZlwvdTYfYgcS/8BoeHRX8yrcrIbx
         M00YzUeVDMLUqH6yxnxvfm2VZhyK3GLpgxUVm8Lo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190521105000eucas1p2de8daa7b95a6cb95f22c55b0aa3017a0~grRqJEwjG2901629016eucas1p2t;
        Tue, 21 May 2019 10:50:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 7C.B4.04298.8D7D3EC5; Tue, 21
        May 2019 11:50:00 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190521104959eucas1p14de9d183967e7f50bfede732d3fd8764~grRpWSfWJ0449704497eucas1p17;
        Tue, 21 May 2019 10:49:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190521104959eusmtrp1125d2801ddbdde695f772d7737f1f3a5~grRpVQ2wS1426514265eusmtrp1n;
        Tue, 21 May 2019 10:49:59 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-e4-5ce3d7d898ab
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FA.A4.04140.7D7D3EC5; Tue, 21
        May 2019 11:49:59 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190521104959eusmtip19adb8d743f0d05719dbe628d27bb5007~grRpIn8l22509625096eusmtip1C;
        Tue, 21 May 2019 10:49:59 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2] video: fbdev: pxa168fb: add COMPILE_TEST support
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-ID: <1059f924-7bbb-37b1-42ee-52cad878f572@samsung.com>
Date:   Tue, 21 May 2019 12:49:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduznOd0b1x/HGPz8JmBx5et7NosTfR9Y
        LS7vmsPmwOxxv/s4k8fnTXIBTFFcNimpOZllqUX6dglcGQ2njzEXrGer2Nwa08C4nrWLkZND
        QsBE4urvCyxdjFwcQgIrGCXOnTwJ5XxhlNi66i0bhPOZUeLonfMsMC27Hk2CqlrOKNH4fB0j
        hPMWqP/YS0aQKjYBK4mJ7auAbA4OYQEXiSVPKkHCIgIJEiumzwAr4RWwk7j59wPYHSwCqhKf
        N+xkB7FFBSIk7h/bwApRIyhxcuYTsMXMAuISt57MZ4Kw5SW2v53DDLJXQuA6m8SHX9cYIa5z
        kVh+5xzUpcISr45vYYewZSROT+5hgWhYxyjxt+MFVPd2Ronlk/+xQVRZSxw+fpEV5GpmAU2J
        9bv0IcKOEk1PNzGBhCUE+CRuvBWEOIJPYtK26cwQYV6JjjYhiGo1iQ3LNrDBrO3auZIZwvaQ
        +Hr2GgtIuZBArMTJKwETGBVmIflyFpIvZyH5chbCOQsYWVYxiqeWFuempxYb5qWW6xUn5haX
        5qXrJefnbmIEpo7T/45/2sH49VLSIUYBDkYlHt6MKY9ihFgTy4orcw8xSnAwK4nwnj4FFOJN
        SaysSi3Kjy8qzUktPsQozcGiJM5bzfAgWkggPbEkNTs1tSC1CCbLxMEp1cDI2hR19F3fMeWe
        OLkFJbEus97eV5yirCBeY7r3T+WkmVmSZUqZqz/Neiu41c0n5UbQ7uJ5WSG7mO/82jUrm4cr
        /mmCsq7c0oDySvVDmvNWRK39rPXnaNIGx9q3M+d9MV0rMeWI1JQ0xYOh0krLdCMK+xLEv+73
        f1ny7Unh+Xlzf9/4eL7nUckEJZbijERDLeai4kQAzCkFnRkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsVy+t/xu7rXrz+OMXj7Qt3iytf3bBYn+j6w
        WlzeNYfNgdnjfvdxJo/Pm+QCmKL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxM
        lfTtbFJSczLLUov07RL0MhpOH2MuWM9Wsbk1poFxPWsXIyeHhICJxK5Hk1i6GLk4hASWMkr0
        3t7H3MXIAZSQkTi+vgyiRljiz7UuNoia14wSc8+dAmtmE7CSmNi+ihGkXljARWLJk0qQsIhA
        gsTT1/PZQGxeATuJm38/gJWzCKhKfN6wkx3EFhWIkDjzfgULRI2gxMmZT8BsZgF1iT/zLjFD
        2OISt57MZ4Kw5SW2v53DPIGRfxaSlllIWmYhaZmFpGUBI8sqRpHU0uLc9NxiI73ixNzi0rx0
        veT83E2MwADfduznlh2MXe+CDzEKcDAq8fBmTHkUI8SaWFZcmXuIUYKDWUmE9/QpoBBvSmJl
        VWpRfnxRaU5q8SFGU6CHJjJLiSbnA6MvryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2
        ampBahFMHxMHp1QD4xUTfv5ZD86lykWaX96y6azDO74daxd/9DdiOM+0+q/VgoacG/mMaUeX
        f5Gv3TjPTP13f2rpJPlF6hFBZVxsJ3M/p4kcna7hcfCM0TLjME47nulv7/5Z1e/ae1ft8ALX
        e7b/9CTknohy6XxZ3/wk+ogkA+/r+wvETzt9TPzLdc6/c2/JaZUnN5VYijMSDbWYi4oTAXSw
        6R+GAgAA
X-CMS-MailID: 20190521104959eucas1p14de9d183967e7f50bfede732d3fd8764
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190521104959eucas1p14de9d183967e7f50bfede732d3fd8764
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190521104959eucas1p14de9d183967e7f50bfede732d3fd8764
References: <CGME20190521104959eucas1p14de9d183967e7f50bfede732d3fd8764@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add COMPILE_TEST support to pxa168fb driver for better compile
testing coverage.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2: add missing HAVE_CLK && HAS IOMEM dependencies

 drivers/video/fbdev/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/drivers/video/fbdev/Kconfig
===================================================================
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1729,7 +1729,8 @@ config FB_68328
 
 config FB_PXA168
 	tristate "PXA168/910 LCD framebuffer support"
-	depends on FB && (CPU_PXA168 || CPU_PXA910)
+	depends on FB && HAVE_CLK && HAS_IOMEM
+	depends on CPU_PXA168 || CPU_PXA910 || COMPILE_TEST
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
