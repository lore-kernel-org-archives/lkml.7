Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF76C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967C0205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Jnr33lW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfF0OHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 10:07:47 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35006 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfF0OHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:07:47 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190627140745euoutp025855bc0631f5a5b0b53fa7c834969830~sE14gnG1V2348123481euoutp02D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 14:07:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190627140745euoutp025855bc0631f5a5b0b53fa7c834969830~sE14gnG1V2348123481euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561644465;
        bh=wtMYutJk4G/BEWGw2w2IiAwGKBfNmaG+t5JjuWLikZY=;
        h=From:Subject:To:Date:References:From;
        b=Jnr33lW6/TCGOlaoPoTkVkD1xmIKnKqWGiLsrzWOoCA7FEWdUDiSPHyRST08fIQW4
         zcqQrmaDDpMOvLJ8Mr9LFT31qXj04PABjQsXuAE2TiW8/OH+H6nf8k0DI6RfREi3Ze
         059JxtVmzqA1R/CMlfn2puNronYEfOoZjcBsGNOw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190627140745eucas1p11b0a7d6c492a778e735bfcdcb3315e0d~sE14DV-b-1939219392eucas1p1e;
        Thu, 27 Jun 2019 14:07:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 85.F1.04298.0BDC41D5; Thu, 27
        Jun 2019 15:07:44 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190627140744eucas1p1eb91c6c21ae36105f38dbf5e42259a7c~sE13UtZ0v0868408684eucas1p1b;
        Thu, 27 Jun 2019 14:07:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190627140744eusmtrp2f308e03b19720ad74dba616f7ead0be0~sE13GopYg0769707697eusmtrp2P;
        Thu, 27 Jun 2019 14:07:44 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-4c-5d14cdb035cc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6E.B3.04146.0BDC41D5; Thu, 27
        Jun 2019 15:07:44 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190627140744eusmtip26e4cc91b9c381ef565f6d51ad49fdc1e~sE126Tn0q1699316993eusmtip2d;
        Thu, 27 Jun 2019 14:07:44 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 2/3] video: fbdev: mmp: add COMPILE_TEST support
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-ID: <d21a19ea-8c18-80df-ae79-76de7c5ee67c@samsung.com>
Date:   Thu, 27 Jun 2019 16:07:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZduzned0NZ0ViDR43WVlc+fqezeJE3wdW
        i8u75rA5MHvc7z7O5PF5k1wAUxSXTUpqTmZZapG+XQJXxq0fXxgLdnBVTLw+i7mB8Q1HFyMn
        h4SAicT12bcZuxi5OIQEVjBK7H6zkwkkISTwhVHiU38kROIzo8Tfi+0sMB175jUzQySWM0qc
        mt4P5bxllLjUc5kNpIpNwEpiYvsqRhBbWMBBYubsk6wgtohAgsSK6TPA4rwCdhIre1rB1rEI
        qErserKbHcQWFYiQuH9sAytEjaDEyZlPwDYzC4hL3HoynwnClpfY/nYO2GIJgdtsEs8a/jJB
        nOciceXoPWYIW1ji1fEt7BC2jMT/nSDNIA3rgP7peAHVvZ1RYvnkf2wQVdYSh49fBFrNAbRC
        U2L9Ln2IsKPE7msbmUDCEgJ8EjfeCkIcwScxadt0Zogwr0RHmxBEtZrEhmUb2GDWdu1cCXWO
        h8SOrmkskOCNldjev5xxAqPCLCRvzkLy5iwkb85CuGcBI8sqRvHU0uLc9NRiw7zUcr3ixNzi
        0rx0veT83E2MwPRx+t/xTzsYv15KOsQowMGoxMOrsFMkVog1say4MvcQowQHs5IIb34YUIg3
        JbGyKrUoP76oNCe1+BCjNAeLkjhvNcODaCGB9MSS1OzU1ILUIpgsEwenVAPjVoeyy4Ff0ifd
        131YfaXh6ZYW+Z6k/syNd+Nv5n1oUbApCdvx5GWt0Qr13aXH73JOWbOrVfDPlh1xdfI2QvEV
        jg7ffk/lPLys5bhVYl3XjykVby8cXadYeHXT5ZoQJsvzB+J0TQXFFbliw3MXRsr/3BpRdkq8
        X/4U18xJwjtC4lufyl/e5H9AiaU4I9FQi7moOBEAEzkjJRsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsVy+t/xe7obzorEGnzbzG9x5et7NosTfR9Y
        LS7vmsPmwOxxv/s4k8fnTXIBTFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkam
        Svp2NimpOZllqUX6dgl6Gbd+fGEs2MFVMfH6LOYGxjccXYycHBICJhJ75jUzdzFycQgJLGWU
        2Dn7DnsXIwdQQkbi+PoyiBphiT/Xutggal4zSizpm80OkmATsJKY2L6KEcQWFnCQmDn7JCuI
        LSKQIPH09Xw2EJtXwE5iZU8rE4jNIqAqsevJbrBeUYEIiTPvV7BA1AhKnJz5BMxmFlCX+DPv
        EjOELS5x68l8JghbXmL72znMExj5ZyFpmYWkZRaSlllIWhYwsqxiFEktLc5Nzy021CtOzC0u
        zUvXS87P3cQIDPJtx35u3sF4aWPwIUYBDkYlHl6FnSKxQqyJZcWVuYcYJTiYlUR488OAQrwp
        iZVVqUX58UWlOanFhxhNgR6ayCwlmpwPjMC8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6Ykl
        qdmpqQWpRTB9TBycUg2MNnMO1X+3fOy595/W0e97evqNGTRfp7JbdT81lY75Zvo3dcdBiZYN
        Gx46KR3Nq2SNbYrVmH1+13OZFxK6v+6bxAkd3HI0RbWn+UITKw9fgW7Uq70P83YuORFn1CYe
        MPFLO8PeyWo73d6VfGc435/vrC8TZKFQ1cj10085JG+66GbuWe75k9mUWIozEg21mIuKEwF9
        7/0uiAIAAA==
X-CMS-MailID: 20190627140744eucas1p1eb91c6c21ae36105f38dbf5e42259a7c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190627140744eucas1p1eb91c6c21ae36105f38dbf5e42259a7c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190627140744eucas1p1eb91c6c21ae36105f38dbf5e42259a7c
References: <CGME20190627140744eucas1p1eb91c6c21ae36105f38dbf5e42259a7c@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add COMPILE_TEST support to mmp display subsystem for better compile
testing coverage.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/mmp/Kconfig    |    2 +-
 drivers/video/fbdev/mmp/hw/Kconfig |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

Index: b/drivers/video/fbdev/mmp/Kconfig
===================================================================
--- a/drivers/video/fbdev/mmp/Kconfig
+++ b/drivers/video/fbdev/mmp/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig MMP_DISP
 	tristate "Marvell MMP Display Subsystem support"
-	depends on CPU_PXA910 || CPU_MMP2
+	depends on CPU_PXA910 || CPU_MMP2 || COMPILE_TEST
 	help
 	  Marvell Display Subsystem support.
 
Index: b/drivers/video/fbdev/mmp/hw/Kconfig
===================================================================
--- a/drivers/video/fbdev/mmp/hw/Kconfig
+++ b/drivers/video/fbdev/mmp/hw/Kconfig
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config MMP_DISP_CONTROLLER
 	bool "mmp display controller hw support"
-	depends on CPU_PXA910 || CPU_MMP2
+	depends on HAVE_CLK && HAS_IOMEM
+	depends on CPU_PXA910 || CPU_MMP2 || COMPILE_TEST
 	help
 		Marvell MMP display hw controller support
 		this controller is used on Marvell PXA910 and
