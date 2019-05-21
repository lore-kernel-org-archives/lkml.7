Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E036C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381EE21773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TXOP0h+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfEUKx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:53:29 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48695 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbfEUKx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:53:28 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190521105327euoutp02bb671bf81d4193ac5b10a05db4a275b8~grUqcQGqp1480314803euoutp02D
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 10:53:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190521105327euoutp02bb671bf81d4193ac5b10a05db4a275b8~grUqcQGqp1480314803euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558436007;
        bh=stp1eF22evOzaYs842QuDkmDZgGFtH7ykSzcPoTOKWM=;
        h=From:Subject:To:Date:References:From;
        b=TXOP0h+0sTbxfyL3LgMFNX9VMQz+CU0oMdMqiex43HtCsCbTUwzx3UyG/49r1AMlN
         TS2Y4ygtGqUgcxIr+5aD5yIlZ/14X12FXq4L4CWd5mBwfcB1WB8pqbQ7pJKwjg8f9s
         VNVT/gF97C+9eJf3r7UDQ4jRuvTUQsxmnuQA8/EE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190521105326eucas1p152e5f185848fb01c3bb7e60943fb0da0~grUqFqK9-0211502115eucas1p1H;
        Tue, 21 May 2019 10:53:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B1.35.04298.6A8D3EC5; Tue, 21
        May 2019 11:53:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190521105325eucas1p2df66ee0fd67d652cc26200701e4275da~grUpB0iYa1262912629eucas1p25;
        Tue, 21 May 2019 10:53:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190521105325eusmtrp1e5be1b92fa81b91aa4663864c0c0b3b0~grUoyY0R01645916459eusmtrp1U;
        Tue, 21 May 2019 10:53:25 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-37-5ce3d8a6a406
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AA.15.04140.5A8D3EC5; Tue, 21
        May 2019 11:53:25 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190521105325eusmtip253c2ec007ceb2162f92ee06c418a76dc~grUoktqdI2718927189eusmtip2E;
        Tue, 21 May 2019 10:53:24 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2] video: fbdev: da8xx-fb: add COMPILE_TEST support
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-ID: <fe534641-82b7-c3f7-4296-db4ba4ff30e6@samsung.com>
Date:   Tue, 21 May 2019 12:53:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZduznOd1lNx7HGBx6I2Jx5et7NosTfR9Y
        LS7vmsPmwOxxv/s4k8fnTXIBTFFcNimpOZllqUX6dglcGR96F7MUHGer6J98lKWB8QRrFyMn
        h4SAicTnu4cYuxi5OIQEVjBKNB+9COV8YZS4/PoyM4TzmVHiV9NlNpiW9TMfsEEkljNKPH+3
        hwXCecso8fT+LrAqNgEriYntq4BmcXAIC7hIbNwuBRIWEUiQWDF9BiOIzStgJ3HyRj9YOYuA
        qsTMffOZQGxRgQiJ+8c2sELUCEqcnPmEBcRmFhCXuPUEooZZQF5i+9s5YNdJCFxnk2g/9JIR
        4joXiRX3PkDZwhKvjm9hh7BlJE5P7mGBaFjHKPG34wVU93ZGieWT/0H9Zi1x+PhFVpCrmQU0
        Jdbv0ocIO0psvruDDSQsIcAnceOtIMQRfBKTtk1nhgjzSnS0CUFUq0lsWLaBDWZt186VzBC2
        h8STuYfAThMSiJX4uWc+0wRGhVlI3pyF5M1ZSN6chXDPAkaWVYziqaXFuempxYZ5qeV6xYm5
        xaV56XrJ+bmbGIHp4/S/4592MH69lHSIUYCDUYmHN2PKoxgh1sSy4srcQ4wSHMxKIrynTwGF
        eFMSK6tSi/Lji0pzUosPMUpzsCiJ81YzPIgWEkhPLEnNTk0tSC2CyTJxcEo1MBrf6jtcz/H4
        +DFdddfQu0yVDLyLnVWZZ8mesDy78PZndrUexWSv7Q5y66/sd3Pmm+D/tWm7e8i3xPB3XRPa
        PGLnRRcdSOlVvOiRxBR27YT927k2L71+q2VU6U2QSbsi+uKJTbr/et5osbm/3Hw9z5elLst+
        NFknIMWkwu7j9peL0sLcZO9OVWIpzkg01GIuKk4EAETg9xMbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsVy+t/xe7pLbzyOMdh4g8fiytf3bBYn+j6w
        WlzeNYfNgdnjfvdxJo/Pm+QCmKL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxM
        lfTtbFJSczLLUov07RL0Mj70LmYpOM5W0T/5KEsD4wnWLkZODgkBE4n1Mx+wdTFycQgJLGWU
        mPn6PpDDAZSQkTi+vgyiRljiz7UuqJrXjBKrJ15nAUmwCVhJTGxfxQhSLyzgIrFxuxRIWEQg
        QeLp6/lsIDavgJ3EyRv9YDaLgKrEzH3zmUBsUYEIiTPvV7BA1AhKnJz5BMxmFlCX+DPvEjOE
        LS5x6wlEPbOAvMT2t3OYJzDyz0LSMgtJyywkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeu
        l5yfu4kRGOLbjv3csoOx613wIUYBDkYlHt6MKY9ihFgTy4orcw8xSnAwK4nwnj4FFOJNSays
        Si3Kjy8qzUktPsRoCvTQRGYp0eR8YPzllcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1O
        TS1ILYLpY+LglGpgPPzEPMS9R6H4gOjuLQevzZG+aLb4ftw/XoY9PbqXlsulZ2asdPd/t3LR
        JP7lzE6ey/aJhRxlvZmgn7XG+tbRu60zapb9P2jCLui+k195A/O5ucemP3yVoOJVLjJTTf0h
        88fiyEd+nlfYNhbq/GOMknazlT2rJnw0UYXzxopLiZa+q+JWfnSwUWIpzkg01GIuKk4EAAJr
        AMiHAgAA
X-CMS-MailID: 20190521105325eucas1p2df66ee0fd67d652cc26200701e4275da
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190521105325eucas1p2df66ee0fd67d652cc26200701e4275da
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190521105325eucas1p2df66ee0fd67d652cc26200701e4275da
References: <CGME20190521105325eucas1p2df66ee0fd67d652cc26200701e4275da@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add COMPILE_TEST support to da8xx-fb driver for better compile
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
@@ -2057,7 +2057,8 @@ config FB_SH7760
 
 config FB_DA8XX
 	tristate "DA8xx/OMAP-L1xx/AM335x Framebuffer support"
-	depends on FB && (ARCH_DAVINCI_DA8XX || SOC_AM33XX)
+	depends on FB && HAVE_CLK && HAS_IOMEM
+	depends on ARCH_DAVINCI_DA8XX || SOC_AM33XX || COMPILE_TEST
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
