Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A26DC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4386C2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="u17c7vkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfFNOs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:48:27 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44502 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728219AbfFNOs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:48:26 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190614144825euoutp01a5c73a1c9b2e474ad607b8ddb7718ff2~oGAq-0z9q0194201942euoutp01a
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 14:48:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190614144825euoutp01a5c73a1c9b2e474ad607b8ddb7718ff2~oGAq-0z9q0194201942euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560523705;
        bh=KbnWEYsgqMns3fL1M6bl1WXvL0vvlacarWBlX2so54A=;
        h=From:Subject:To:Cc:Date:References:From;
        b=u17c7vknApsshx78VtoHa92DcoTtt2IZwmtq/UlDVTUB5kYKwl4mVkZRgWJJ5aUL4
         EOv2RAeXCPaF3ojqnEMDNU79R8O9bbkpW2bApSvydSIpl7xfgvne6Rs+5CAd5qrHxY
         nWCPZcMo4C2dEEs4r2IhRM2fiM5uZ9DSbHVg/q5w=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190614144824eucas1p28ce4a766238335181118b38c84e7adf9~oGAqZwRvZ1842218422eucas1p2w;
        Fri, 14 Jun 2019 14:48:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 74.96.04325.8B3B30D5; Fri, 14
        Jun 2019 15:48:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190614144823eucas1p1f6d5ed1905350e9933f4d7fec0a3419f~oGApS6j7R3210832108eucas1p1V;
        Fri, 14 Jun 2019 14:48:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190614144823eusmtrp175a283449c6243ce6a6c4150a43377d9~oGApDaKRT2548325483eusmtrp1J;
        Fri, 14 Jun 2019 14:48:23 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-d8-5d03b3b8da7f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 32.AE.04140.7B3B30D5; Fri, 14
        Jun 2019 15:48:23 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190614144822eusmtip18c6f39ce9009c2c74240f5194e9a9ae9~oGAoz5tG92907529075eusmtip1F;
        Fri, 14 Jun 2019 14:48:22 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 2/3] video: fbdev: intelfb: return -ENOMEM on
 framebuffer_alloc() failure
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Maik Broemme <mbroemme@libmpq.org>
Message-ID: <a659cb04-b16c-a3a0-30f4-b2f90b0d7196@samsung.com>
Date:   Fri, 14 Jun 2019 16:48:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZduznOd0dm5ljDSY+Fra48vU9m8WJvg+s
        Fpd3zWGz+HWSyYHF4/rPG0we97uPM3l83iQXwBzFZZOSmpNZllqkb5fAlXHv4lzGghNsFU86
        DzI1MF5g7WLk5JAQMJG4/6+FrYuRi0NIYAWjRPvTPewQzhdGiUlrJrJAOJ8ZJaY0LmCEaXm/
        +QJU1XJGiY/H77GBJIQE3jJKrG5TArHZBKwkJravAmrg4BAWiJb4N8cLJCwikCCxYvoMsDCz
        gJrE9UXVIGFeATuJQ12XmEBsFgFVid6v25lBbFGBCIn7xzawQtQISpyc+YQFxGYWEJe49WQ+
        E4QtL7H97RxmkHMkBD6zSez60soCcaeLxK2tPUwQtrDEq+Nb2CFsGYnTk3tYIBrWMUr87XgB
        1b2dUWL55H9sEFXWEoePX2SFuFRTYv0ufYiwo8S5I5tZQMISAnwSN94KQhzBJzFp23RmiDCv
        REebEES1msSGZRvYYNZ27VzJDGF7SFy+OZdlAqPiLCSvzULy2iwkr81CuGEBI8sqRvHU0uLc
        9NRi47zUcr3ixNzi0rx0veT83E2MwGRy+t/xrzsY9/1JOsQowMGoxMM7o485Vog1say4MvcQ
        owQHs5II7zxroBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeaoYH0UIC6YklqdmpqQWpRTBZJg5O
        qQZGP+dFx87cVe/2Ln99m/ekmJrOF4N7OxslI+xk/E/Puh5w9RGXy4x3VX01bHM3+GuWqdzb
        KDv1mekKRZ9nZ11fsqYemR2gyC0rsv2Ki9X66VpNZ5qZNQJEek3OHCt5ffHMVf7Op/KbNmXn
        tZZpNcU/SiivTA+O2TUtcON2xRl3zhxPYQtv+eytxFKckWioxVxUnAgAk1mLPiIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42I5/e/4Xd3tm5ljDRrbeSyufH3PZnGi7wOr
        xeVdc9gsfp1kcmDxuP7zBpPH/e7jTB6fN8kFMEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZ
        WOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZdy7OJex4ARbxZPOg0wNjBdYuxg5OSQETCTeb77A
        3sXIxSEksJRR4suzjyxdjBxACRmJ4+vLIGqEJf5c62KDqHnNKPH7YAdYM5uAlcTE9lWMIPXC
        AtES/+Z4gYRFBBIknr6ezwYSZhZQk7i+qBokzCtgJ3Go6xITiM0ioCrR+3U7M4gtKhAhceb9
        ChaIGkGJkzOfgNnMAuoSf+ZdYoawxSVuPZnPBGHLS2x/O4d5AqPALCQts5C0zELSMgtJywJG
        llWMIqmlxbnpucVGesWJucWleel6yfm5mxiBsbDt2M8tOxi73gUfYhTgYFTi4Z3RxxwrxJpY
        VlyZe4hRgoNZSYR3njVQiDclsbIqtSg/vqg0J7X4EKMp0EMTmaVEk/OBcZpXEm9oamhuYWlo
        bmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoFxB8cOpog0E0+OuM4p4q6yL70c+zo+
        LdTaueT+6QlqyqICa7nYHZgn6a59v9IlbevEOf0PmH4eN39wdp7OjLbf5z8U7xFY5vp+8/3H
        4VN29Oo8KPM49OaF+dIzB/a9m/Ln65S0Hcv0bfIfmiip83pG6+0MWsRSyp+gUpoz14ax58/K
        RWbcF//bKbEUZyQaajEXFScCALvnrPmbAgAA
X-CMS-MailID: 20190614144823eucas1p1f6d5ed1905350e9933f4d7fec0a3419f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190614144823eucas1p1f6d5ed1905350e9933f4d7fec0a3419f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190614144823eucas1p1f6d5ed1905350e9933f4d7fec0a3419f
References: <CGME20190614144823eucas1p1f6d5ed1905350e9933f4d7fec0a3419f@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix error code from -ENODEV to -ENOMEM.

Cc: Maik Broemme <mbroemme@libmpq.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/intelfb/intelfbdrv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/video/fbdev/intelfb/intelfbdrv.c
===================================================================
--- a/drivers/video/fbdev/intelfb/intelfbdrv.c
+++ b/drivers/video/fbdev/intelfb/intelfbdrv.c
@@ -493,7 +493,7 @@ static int intelfb_pci_register(struct p
 	info = framebuffer_alloc(sizeof(struct intelfb_info), &pdev->dev);
 	if (!info) {
 		ERR_MSG("Could not allocate memory for intelfb_info.\n");
-		return -ENODEV;
+		return -ENOMEM;
 	}
 	if (fb_alloc_cmap(&info->cmap, 256, 1) < 0) {
 		ERR_MSG("Could not allocate cmap for intelfb_info.\n");
