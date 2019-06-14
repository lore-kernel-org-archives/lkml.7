Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194CCC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA61621473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VoRH75Gl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfFNLx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 07:53:56 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46306 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbfFNLxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 07:53:54 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190614115352euoutp01ca08eea8d5406fd70aa57f82aab029ce~oDoRKya-W0750707507euoutp01M
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 11:53:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190614115352euoutp01ca08eea8d5406fd70aa57f82aab029ce~oDoRKya-W0750707507euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560513232;
        bh=KHTiRK+Do903GTePR+8iFRbvLoOOlqVUQSYPbURGrlg=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=VoRH75GljoPBi+/Bm7asKD9clEjqdYvw1ijfSZCWXNpYIFMHxnUl8mnBMV7rS4MFM
         BiZ2f1C1X5lAdAeFhmxLZ8DrU07mwoqxA7B0ujUcye0iYMZRKR9wsgZM/ZpPQNKw74
         45Q3CUuv1l/1yJ2/+rwke+WrgDVJ1Kj1f3fd/jQA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190614115351eucas1p14fc730d70b7cf2eef754ab66a726322f~oDoQaNJ0S2595825958eucas1p11;
        Fri, 14 Jun 2019 11:53:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 43.0F.04377.FCA830D5; Fri, 14
        Jun 2019 12:53:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190614115350eucas1p282c9670fc70fad90d3406013e9105106~oDoPt7VgC2104921049eucas1p2n;
        Fri, 14 Jun 2019 11:53:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190614115350eusmtrp102cde45164532f7ca26702f66788680a~oDoPeQfLu1827218272eusmtrp1k;
        Fri, 14 Jun 2019 11:53:50 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-06-5d038acf965d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 98.B9.04140.ECA830D5; Fri, 14
        Jun 2019 12:53:50 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190614115349eusmtip1a88bda5808c4fa198655701f9bc9625b~oDoO8goMx2619626196eusmtip10;
        Fri, 14 Jun 2019 11:53:49 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] video: fbdev: imxfb: fix sparse warnings about using
 incorrect types
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        kbuild test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <8520d744-cebc-c76a-e51a-ff6a471af57d@samsung.com>
Date:   Fri, 14 Jun 2019 13:53:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <33fc4837-599d-0d5c-c530-58b283c4c095@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djPc7rnu5hjDVo+c1hc+fqezeLhVX+L
        VVN3slhsenyN1eJE3wdWi65fK5ktLu+aw2bxqvkRm8Xf7ZtYLF5sEbe4PXEyowO3x85Zd9k9
        Fu95yeSxaVUnm8f97uNMHpuX1HtsfLeDyaP/r4HH501yARxRXDYpqTmZZalF+nYJXBlNLxoY
        C7byVxx7t5uxgXEibxcjJ4eEgIlEw6LFrF2MXBxCAisYJXa9WcwC4XxhlFj5+BcThPOZUWLv
        5TNsMC2fdzxhhkgsZ5R4PvEJVP9bRon527aygFSxCVhJTGxfxQhiCwuES/w5dYQVxBYRcJCY
        cmMCO0gDs8APJonubevAingF7CSmvN8EVsQioCpx5eZ5sLioQITE/WMbWCFqBCVOznwCtoBT
        wF7i7aX5zCA2s4C4xK0n85kgbHmJ5q2zwc6TEHjELnFlSh/U3S4S+xpuQNnCEq+Ob2GHsGUk
        Tk/uYYFoWMco8bfjBVT3dkaJ5ZP/QXVYSxw+fhHoDA6gFZoS63fpQ4QdJS7M/s0OEpYQ4JO4
        8VYQ4gg+iUnbpjNDhHklOtqEIKrVJDYs28AGs7Zr50rmCYxKs5C8NgvJO7OQvDMLYe8CRpZV
        jOKppcW56anFRnmp5XrFibnFpXnpesn5uZsYgWns9L/jX3Yw7vqTdIhRgINRiYf3gBVTrBBr
        YllxZe4hRgkOZiUR3nnWzLFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeasZHkQLCaQnlqRmp6YW
        pBbBZJk4OKUaGJlfWXKr3ctMeyK2+6mI9aI9lS3RFxc/zdtmVWHo0rV/Q1jpuaxOr+c611oX
        e/2YmdOzx2FveueCuPCVfrceaSel160NnLL+aXDE1VopXc2vC6z2z78s0vX4Xs9t6RsbCnbv
        Zvh4cErUj+tvuv1qOlaolW//6dTbwj7jo+fHCZtNOi0sUng+1ymxFGckGmoxFxUnAgCCp3mq
        XwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsVy+t/xu7rnuphjDb4fEra48vU9m8XDq/4W
        q6buZLHY9Pgaq8WJvg+sFl2/VjJbXN41h83iVfMjNou/2zexWLzYIm5xe+JkRgduj52z7rJ7
        LN7zkslj06pONo/73ceZPDYvqffY+G4Hk0f/XwOPz5vkAjii9GyK8ktLUhUy8otLbJWiDS2M
        9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DKaXjQwFmzlrzj2bjdjA+NE3i5GTg4J
        AROJzzueMHcxcnEICSxllOi9cZyti5EDKCEjcXx9GUSNsMSfa11sEDWvGSVudb1hAUmwCVhJ
        TGxfxQhiCwuES/w5dYQVxBYRcJCYcmMCO0gDs8APJomlc/6BJYQE7CQ239zBDmLzAtlT3m8C
        i7MIqEpcuXkebJCoQITEmfcrWCBqBCVOznwCZnMK2Eu8vTSfGcRmFlCX+DPvEpQtLnHryXwm
        CFteonnrbOYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTG
        7LZjP7fsYOx6F3yIUYCDUYmH94AVU6wQa2JZcWXuIUYJDmYlEd551syxQrwpiZVVqUX58UWl
        OanFhxhNgZ6byCwlmpwPTCd5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6
        mDg4pRoY+/bMbHn9+YRmYPDc2j7vY4snCEXctRcwKWg7WvhIeU7tH91ZbFyZH2P+tIT/y/Z1
        MD5TZ9Y7saHQoO1DoOj5iFs7g1i7Lm99kKKy94NfiXby+/bJ7a3S+ZFRlk2vj+RF5DLNr7hW
        Xv8xx3z93q0Hl3Des3NU/CVvGPv8GkfPj58b5Db9Z7qlxFKckWioxVxUnAgA5xKiIu8CAAA=
X-CMS-MailID: 20190614115350eucas1p282c9670fc70fad90d3406013e9105106
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190614115350eucas1p282c9670fc70fad90d3406013e9105106
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190614115350eucas1p282c9670fc70fad90d3406013e9105106
References: <33fc4837-599d-0d5c-c530-58b283c4c095@samsung.com>
        <CGME20190614115350eucas1p282c9670fc70fad90d3406013e9105106@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ->screen_buffer instead of ->screen_base to fix sparse warnings.

[ Please see commit 17a7b0b4d974 ("fb.h: Provide alternate screen_base
  pointer") for details. ]

Reported-by: kbuild test robot <lkp@intel.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/imxfb.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Index: b/drivers/video/fbdev/imxfb.c
===================================================================
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -974,9 +974,8 @@ static int imxfb_probe(struct platform_d
 	}
 
 	fbi->map_size = PAGE_ALIGN(info->fix.smem_len);
-	info->screen_base = dma_alloc_wc(&pdev->dev, fbi->map_size,
-					 &fbi->map_dma, GFP_KERNEL);
-
+	info->screen_buffer = dma_alloc_wc(&pdev->dev, fbi->map_size,
+					   &fbi->map_dma, GFP_KERNEL);
 	if (!info->screen_base) {
 		dev_err(&pdev->dev, "Failed to allocate video RAM: %d\n", ret);
 		ret = -ENOMEM;
@@ -1046,7 +1045,7 @@ failed_cmap:
 	if (pdata && pdata->exit)
 		pdata->exit(fbi->pdev);
 failed_platform_init:
-	dma_free_wc(&pdev->dev, fbi->map_size, info->screen_base,
+	dma_free_wc(&pdev->dev, fbi->map_size, info->screen_buffer,
 		    fbi->map_dma);
 failed_map:
 	iounmap(fbi->regs);
@@ -1077,7 +1076,7 @@ static int imxfb_remove(struct platform_
 	pdata = dev_get_platdata(&pdev->dev);
 	if (pdata && pdata->exit)
 		pdata->exit(fbi->pdev);
-	dma_free_wc(&pdev->dev, fbi->map_size, info->screen_base,
+	dma_free_wc(&pdev->dev, fbi->map_size, info->screen_buffer,
 		    fbi->map_dma);
 	iounmap(fbi->regs);
 	release_mem_region(res->start, resource_size(res));

