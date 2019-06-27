Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF0BC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650882086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kCN5M8+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfF0OHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 10:07:08 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34773 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfF0OHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:07:07 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190627140706euoutp020c56c4a599264c07d89945785301f4fa~sE1Tldatu2237622376euoutp02D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 14:07:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190627140706euoutp020c56c4a599264c07d89945785301f4fa~sE1Tldatu2237622376euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561644426;
        bh=BoDR/6hDAZqWyHMh5AaexlPeGMwWtQ0BBzLpqomvxMs=;
        h=From:Subject:To:Date:References:From;
        b=kCN5M8+lWqixxYpRA5Mc3uJkoEFbf/QmVtESNgWpri0Zg5YyH7IYEsBAUSoQoFb57
         cGw7emnBTxMWgMQ6ysHOgIUUCX4k1fVXHiM7YMXbdL+tiurVumH3WjZ7gJVeA0d/kC
         y8YZ0q8aaxUWQrMmV2FlAyQmAluiQfcC1KYwj7cM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190627140705eucas1p155a7549b3a5ecad192c62eea3edb1d64~sE1TF4dfO0763807638eucas1p1j;
        Thu, 27 Jun 2019 14:07:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 66.76.04377.98DC41D5; Thu, 27
        Jun 2019 15:07:05 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190627140704eucas1p10f9aca669beb24f5359a0e86f2b6d0ba~sE1SboCPb0767107671eucas1p1Q;
        Thu, 27 Jun 2019 14:07:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190627140704eusmtrp29d70373c3a726d2bd680aa30fd6ab995~sE1SNb7zA0769707697eusmtrp2G;
        Thu, 27 Jun 2019 14:07:04 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-e2-5d14cd8924f7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 67.A3.04146.88DC41D5; Thu, 27
        Jun 2019 15:07:04 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190627140704eusmtip2fa88c590dce5dd666721e8beed9eb74a~sE1SAIW5X1698616986eusmtip27;
        Thu, 27 Jun 2019 14:07:04 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/3] video: fbdev: mmp: remove duplicated MMP_DISP
 dependency
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-ID: <eb28587c-4f8f-f044-1b8b-317a8d7967aa@samsung.com>
Date:   Thu, 27 Jun 2019 16:07:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZduzned3OsyKxBu1/RSyufH3PZnGi7wOr
        xeVdc9gcmD3udx9n8vi8SS6AKYrLJiU1J7MstUjfLoEr48SeY+wF27kqnq54wNrA+JCji5GT
        Q0LARGLpg7dMXYxcHEICKxglPu95COV8YZS4OH8fO4TzmVHiyNfvrDAtNza/Z4FILGeUOPHv
        ExuE85ZR4ty6U2BVbAJWEhPbVzGC2MIC/hI9n86wg9giAgkSK6bPAIvzCthJtM15ywZiswio
        Ssxfv4sFxBYViJC4f2wDK0SNoMTJmU/A4swC4hK3nsxngrDlJba/ncMMslhC4DabxIvbIAs4
        gBwXiakv5CAuFZZ4dXwLO4QtI/F/53wmiPp1jBJ/O15ANW9nlFg++R8bRJW1xOHjF1lBBjEL
        aEqs36UPEXaUaLh8jwliPp/EjbeCEDfwSUzaNp0ZIswr0dEmBFGtJrFh2QY2mLVdO1cyQ9ge
        EtPPfwB7XUggVmLyql3sExgVZiH5chaSL2ch+XIWwj0LGFlWMYqnlhbnpqcWG+WllusVJ+YW
        l+al6yXn525iBKaP0/+Of9nBuOtP0iFGAQ5GJR5ehZ0isUKsiWXFlbmHGCU4mJVEePPDgEK8
        KYmVValF+fFFpTmpxYcYpTlYlMR5qxkeRAsJpCeWpGanphakFsFkmTg4pRoYcytu7M80OOf6
        peMYR6GZqlJhhs8Bn0N3SyOleR9oXI/YX3F9wy33y09/fLu2T+Vp94H7ba6xcQUbOj7oVF8p
        txE6e+Ct93fTRsZlxy+mmteJRHx7k1f8+Uzp9H9sEY6uUeo+SnO2qXG9LDyq4nLviTXP4bjK
        FY7FcwWz4z0ltnEv7yqNnfdZiaU4I9FQi7moOBEA7XZ87xsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsVy+t/xe7odZ0ViDfa3qFlc+fqezeJE3wdW
        i8u75rA5MHvc7z7O5PF5k1wAU5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGp
        kr6dTUpqTmZZapG+XYJexok9x9gLtnNVPF3xgLWB8SFHFyMnh4SAicSNze9ZQGwhgaWMEsf+
        S3UxcgDFZSSOry+DKBGW+HOti62LkQuo5DWjxPaP55lBEmwCVhIT21cxgtjCAr4Sk5vus4PY
        IgIJEk9fz2cDsXkF7CTa5rwFs1kEVCXmr98FtktUIELizPsVLBA1ghInZz4Bs5kF1CX+zLvE
        DGGLS9x6Mp8JwpaX2P52DvMERv5ZSFpmIWmZhaRlFpKWBYwsqxhFUkuLc9Nziw31ihNzi0vz
        0vWS83M3MQJDfNuxn5t3MF7aGHyIUYCDUYmHV2GnSKwQa2JZcWXuIUYJDmYlEd78MKAQb0pi
        ZVVqUX58UWlOavEhRlOghyYyS4km5wPjL68k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6Yklq
        dmpqQWoRTB8TB6dUA6PPRSbHS65xP6qfZmr+k9VYePLB3MYXvku5BU9x/TDpPZWju8rnz+/t
        J8VN/kV4vCtiXrr7jWT/j297M/J7/jQ62hslXy4/q8Gp0xwWcs6eIU//8rGlzZWzGG9HhOra
        fX65kdN7cf+v0/L8R8RnGLbpmLA1MJ0T4OthNDg9bdHCKZe/iR5weKDEUpyRaKjFXFScCAAF
        JL5nhwIAAA==
X-CMS-MailID: 20190627140704eucas1p10f9aca669beb24f5359a0e86f2b6d0ba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190627140704eucas1p10f9aca669beb24f5359a0e86f2b6d0ba
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190627140704eucas1p10f9aca669beb24f5359a0e86f2b6d0ba
References: <CGME20190627140704eucas1p10f9aca669beb24f5359a0e86f2b6d0ba@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This dependency is already present in higher level Kconfig file
(drivers/video/fbdev/mmp/Kconfig).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/mmp/fb/Kconfig |    4 ----
 drivers/video/fbdev/mmp/hw/Kconfig |    4 ----
 2 files changed, 8 deletions(-)

Index: b/drivers/video/fbdev/mmp/fb/Kconfig
===================================================================
--- a/drivers/video/fbdev/mmp/fb/Kconfig
+++ b/drivers/video/fbdev/mmp/fb/Kconfig
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-if MMP_DISP
-
 config MMP_FB
 	tristate "fb driver for Marvell MMP Display Subsystem"
 	depends on FB
@@ -10,5 +8,3 @@ config MMP_FB
 	default y
 	help
 		fb driver for Marvell MMP Display Subsystem
-
-endif
Index: b/drivers/video/fbdev/mmp/hw/Kconfig
===================================================================
--- a/drivers/video/fbdev/mmp/hw/Kconfig
+++ b/drivers/video/fbdev/mmp/hw/Kconfig
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-if MMP_DISP
-
 config MMP_DISP_CONTROLLER
 	bool "mmp display controller hw support"
 	depends on CPU_PXA910 || CPU_MMP2
@@ -16,5 +14,3 @@ config MMP_DISP_SPI
 	help
 		Marvell MMP display hw controller spi port support
 		will register as a spi master for panel usage
-
-endif
