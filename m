Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F00C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5DA2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TS7kM82q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfFNOqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:46:37 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44082 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbfFNOqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:46:37 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190614144635euoutp015e4037920fad48c1f7751242db9226a5~oF-E4Z-EL3159931599euoutp01M
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 14:46:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190614144635euoutp015e4037920fad48c1f7751242db9226a5~oF-E4Z-EL3159931599euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560523595;
        bh=edGrKerInuyqgGn3ETDAt2iEy82hinQGhNb+6fYCtcU=;
        h=From:Subject:To:Cc:Date:References:From;
        b=TS7kM82q6hQJjJbje5WzdFCxB8dwooDceDWlvxgUuqAdll7hFzqQlGsEH0o90K3ZF
         FSlxvnha6ucuQBMK8j8rsZq8HfXmlD5V09Nkz0Ysld0g0SyegFbfJ4jML4VtoTmld0
         1CVNqt2BRG6+po6wxSUYRNDEKxwnN16F0FvqY34s=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190614144635eucas1p28ee07a5d9cdfdaad65acfe24a5ebeead~oF-EYApa_1628416284eucas1p2D;
        Fri, 14 Jun 2019 14:46:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id FB.B4.04377.A43B30D5; Fri, 14
        Jun 2019 15:46:34 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190614144634eucas1p1b04dcfcc040c3c886d2b33592c501d3b~oF-DiByud2594525945eucas1p1i;
        Fri, 14 Jun 2019 14:46:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190614144633eusmtrp125c1f4b0e707a8b9c37c4f82f4ea609f~oF-DShgZ32478124781eusmtrp1l;
        Fri, 14 Jun 2019 14:46:33 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-56-5d03b34aff7d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 63.7E.04140.943B30D5; Fri, 14
        Jun 2019 15:46:33 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190614144633eusmtip2c1e4bdf527f13540f414f141abcab773~oF-DDsfl72665126651eusmtip2b;
        Fri, 14 Jun 2019 14:46:33 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] video: fbdev: s3c-fb: add COMPILE_TEST support
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Jingoo Han <jingoohan1@gmail.com>
Message-ID: <e771b89b-0e38-a712-b635-8d53cbf95a8e@samsung.com>
Date:   Fri, 14 Jun 2019 16:46:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djP87pem5ljDX716Ftc+fqezWLFl5ns
        Fif6PrBaXN41h82BxWPnrLvsHve7jzN5fN4kF8AcxWWTkpqTWZZapG+XwJWx7VcXa8EytooP
        j04yNzCuYe1i5OSQEDCReD7zHUsXIxeHkMAKRom/y5ayQjhfGCVOne+Gcj4zSvxumsMO07Jk
        4zVmiMRyRomD8y4yQThvgVrW/2cCqWITsJKY2L6KEcQWFrCXOPfxMjOILSKQILFi+gywOLOA
        qsSu5qVgNq+AnUTjhwtgG1iA4icn/mABsUUFIiTuH9vAClEjKHFy5hMWiF5xiVtP5jNB2PIS
        29/OAbtIQuAzm8Smr8vYIE51kWi7cwHKFpZ4dXwL1AsyEqcn97BANKwD+rrjBVT3dkaJ5ZP/
        QXVYSxw+fhFoNQfQCk2J9bv0IcKOEpsmfWYDCUsI8EnceCsIcQSfxKRt05khwrwSHW1CENVq
        EhuWbWCDWdu1cyUzhO0hcfzCbdYJjIqzkLw2C8lrs5C8NgvhhgWMLKsYxVNLi3PTU4uN8lLL
        9YoTc4tL89L1kvNzNzECk8rpf8e/7GDc9SfpEKMAB6MSD++MPuZYIdbEsuLK3EOMEhzMSiK8
        86yBQrwpiZVVqUX58UWlOanFhxilOViUxHmrGR5ECwmkJ5akZqemFqQWwWSZODilGhiLpTi8
        qrir9/U7cxRcWZwjJlWimii+8M3dC4vDFpyz582uLDTcJPPI3qcjUtV7x/3qGQYnJZWCCgIy
        TBJfFJ0+nL/Lb2bBteInV5qanre9SX8n6RNb3jh5w2THWvVH55J+O/zedyJr7aLfopONA0p8
        9W1YFd8o/SjI/ZubUBFf5j5hww6HJ0osxRmJhlrMRcWJAADZtJMmAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42I5/e/4PV3PzcyxBvuPW1lc+fqezWLFl5ns
        Fif6PrBaXN41h82BxWPnrLvsHve7jzN5fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJex7VcXa8EytooPj04yNzCuYe1i5OSQEDCRWLLx
        GnMXIxeHkMBSRonFEx4BORxACRmJ4+vLIGqEJf5c62KDqHnNKPFl8UEmkASbgJXExPZVjCC2
        sIC9xLmPl5lBbBGBBImnr+ezgdjMAqoSu5qXgtXwCthJNH64wA5iswDFT078wQJiiwpESJx5
        v4IFokZQ4uTMJywQveoSf+ZdYoawxSVuPZnPBGHLS2x/O4d5AqPALCQts5C0zELSMgtJywJG
        llWMIqmlxbnpucVGesWJucWleel6yfm5mxiBEbHt2M8tOxi73gUfYhTgYFTi4Z3RxxwrxJpY
        VlyZe4hRgoNZSYR3njVQiDclsbIqtSg/vqg0J7X4EKMp0EMTmaVEk/OB0ZpXEm9oamhuYWlo
        bmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoHxclSB3XpJjtALbt42StKZha8srRab
        5jY7dHO5Cx86Fv339P+0GULvLZ+ZLPOO3SwSsHTRNnFnYaMJBpb32G9Nk78rudtYKqrmef6t
        Xy4tG1ccDfjCXuPCcPTDRBbRF0H1b1Yyv9H8GO5x0ujtyakr697t8+U85/pud8qaKzP9vuj8
        Eety/BirxFKckWioxVxUnAgA5gf4Y54CAAA=
X-CMS-MailID: 20190614144634eucas1p1b04dcfcc040c3c886d2b33592c501d3b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190614144634eucas1p1b04dcfcc040c3c886d2b33592c501d3b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190614144634eucas1p1b04dcfcc040c3c886d2b33592c501d3b
References: <CGME20190614144634eucas1p1b04dcfcc040c3c886d2b33592c501d3b@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add COMPILE_TEST support to s3c-fb driver for better compile
testing coverage.

Cc: Jingoo Han <jingoohan1@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/drivers/video/fbdev/Kconfig
===================================================================
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1877,7 +1877,8 @@ config FB_TMIO_ACCELL
 
 config FB_S3C
 	tristate "Samsung S3C framebuffer support"
-	depends on FB && (CPU_S3C2416 || ARCH_S3C64XX)
+	depends on FB && HAVE_CLK && HAS_IOMEM
+	depends on (CPU_S3C2416 || ARCH_S3C64XX) || COMPILE_TEST
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
