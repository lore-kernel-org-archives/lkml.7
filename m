Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894CFC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2182F21019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Vb6ydFvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbfEUNoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 09:44:46 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58383 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbfEUNop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:44:45 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190521134443euoutp0205c6cb20ca56868ddf63eea39ba68de9~gtqNgpj541359213592euoutp02f
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 13:44:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190521134443euoutp0205c6cb20ca56868ddf63eea39ba68de9~gtqNgpj541359213592euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558446283;
        bh=RLKuvBEG6Mny/Pi7NLR0Nbvy2HIvFuNlpcTPZlMZBXk=;
        h=To:Cc:From:Subject:Date:References:From;
        b=Vb6ydFvKm9z1RR1Gb0tMkhE9r7REcltW89yYJLNHhCIzVRDFLCyOcsB8eTCRxIYcB
         uSSxxREujTovpQu+wX7rhZwgTUJzFjW1wkeKD2EHIJm2tk0MOSwqTiWThVTXdkZ3JZ
         tlHT1QwdSq/I+IF5f8U51gzvmoPLTIoFNCTjW480=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190521134443eucas1p2a0361c7efc2c3d4dee8fcee519c6addc~gtqM0XIxT3113031130eucas1p2Z;
        Tue, 21 May 2019 13:44:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3B.80.04325.AC004EC5; Tue, 21
        May 2019 14:44:42 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190521134442eucas1p2bf6236c3af24bb023f11f8d119a822be~gtqL9Aldk1363313633eucas1p2s;
        Tue, 21 May 2019 13:44:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190521134441eusmtrp1c9cddd818c93cd6503e93b5e28897d74~gtqLtfH792230522305eusmtrp1P;
        Tue, 21 May 2019 13:44:41 +0000 (GMT)
X-AuditID: cbfec7f5-fbbf09c0000010e5-f4-5ce400ca0d61
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E0.9D.04140.9C004EC5; Tue, 21
        May 2019 14:44:41 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190521134441eusmtip172871ea8af1b007e36dc816b66719ebe~gtqLcK_Z72907329073eusmtip1e;
        Tue, 21 May 2019 13:44:41 +0000 (GMT)
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] video: fbdev: cyber2000fb: remove superfluous CONFIG_PCI
 ifdef
Message-ID: <214f05e0-a448-b1cf-7475-4fa7eeaa9949@samsung.com>
Date:   Tue, 21 May 2019 15:44:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj281w8Skc+N8MXraxBkZGaTWFlDLOQEXTxV5FGW3lSy03ZvOYP
        L4HKErHUtINUxMoU75nzkhKazktq6hCzwkwLEyQvWSg1cjta/nve58L3PPAxhIin3JloTTyn
        1ahiJLQT2di9OuTdZzcTfsjyQCozr3ynZfXTY5SsJ2+Bko22lNKyjqI2FEQpRseGCcXkbZO9
        4rkhTbFcv+scedHpWAQXE53IaX3lSqeopcFOh7hSJnl6pIlORx9pPXJkAPuDOXuW0iMnRoSf
        IZjNaEXC8QOB8Va5g3AsI5h61fYv8rPXQghCGYLiiq+kVRDheQQNr5VW7Ir3Q13JGm01ETgL
        wRfeTFkFGh+FO9kVyIrFOBQ6C7vWeYZhsRyqJxgrTeK90DXH2yzb8QWY7K61RVnsAr33Z2xv
        EdgNJmYe2gvYE4zzpbZCgLMd4H3eO0poehKW+XxCwGKYMzU4CHgH9BfkkkKgGsGfnNmNtBFB
        WYFlY2cgdJqGbe0I7AU1Lb4CfRzGB4doKw3YGcbnXYQSznC3sZgQaBZyskSCex/UPq2lN5/V
        N5dvWBSQ8ZLJR3v4Lcv4Lcv4Lcv4/xUeIbICuXEJOnUkp5NquCQfnUqtS9BE+lyNVdej9R/T
        bzGtNKH231c6EGaQZBsrm5oOF1GqRF2KugMBQ0hc2f6+z+EiNkKVcpPTxl7WJsRwug7kwZAS
        NzbV7lOYCEeq4rkbHBfHaTdVe8bRPR0N0eLStD7lG2mhPDSgpO7skV+c40LvZIO7X/7a+Rov
        887M00vNEcEfikPj7wUODOx+kco/YvWFwVUGsW97S9C1PPKUsrKy0cMQkpyzKO45POI5yvp7
        n3kcUNX6tjJpVeost4taPfHtYBTbTdbl8rGZ1QH+RYvy634GY0jik7BLElIXpfI7QGh1qr8d
        ZThcLQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsVy+t/xu7onGZ7EGPT9M7e48vU9m8Wmx9dY
        LU70fWC1uLxrDpvFoal7GR1YPS5fu8jscb/7OJPH5iX1Hp83yQWwROnZFOWXlqQqZOQXl9gq
        RRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlfDp3mL1gDkfF40s72BoY77J1
        MXJySAiYSHw7+Y+5i5GLQ0hgKaPE3KaZTF2MHEAJGYnj68sgaoQl/lzrAqsXEnjNKHFuIzeI
        LSKgIbFxxi82kF5mgTZGiQMzTzODJNgErCQmtq9iBLGFBQIlDk85ygoyk1fATmLdLQ6QMIuA
        qsTRV7PASkQFIiTOvF/BAmLzCghKnJz5BMxmFlCX+DPvEjOELS5x68l8JghbXmL72znMExgF
        ZiFpmYWkZRaSlllIWhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjJBtx35u2cHY9S74
        EKMAB6MSD++De49jhFgTy4orcw8xSnAwK4nwnj71KEaINyWxsiq1KD++qDQntfgQoynQQxOZ
        pUST84HRm1cSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgVH8SFWb
        GF9gzut5NRcaUpKeHk1Z33knMXfTlSYfNeX4cxyatjVPrMrLwj02GvudcV8hJPa2oJKhIqXA
        6ZwWg3he+u6Je6x9mLu/39fZeOpOZ4XfrIbXPjk75mYd33GlcieXbbaqn/NJN63s495v3rNH
        qW74sK3v46n4yekxX443yZw2OGarr8RSnJFoqMVcVJwIANdnKJ2mAgAA
X-CMS-MailID: 20190521134442eucas1p2bf6236c3af24bb023f11f8d119a822be
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190521134442eucas1p2bf6236c3af24bb023f11f8d119a822be
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190521134442eucas1p2bf6236c3af24bb023f11f8d119a822be
References: <CGME20190521134442eucas1p2bf6236c3af24bb023f11f8d119a822be@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a PCI driver and FB_CYBER2000 depends on PCI in Kconfig so
there is no need to check for PCI inside the driver code.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/cyber2000fb.c |    5 -----
 1 file changed, 5 deletions(-)

Index: b/drivers/video/fbdev/cyber2000fb.c
===================================================================
--- a/drivers/video/fbdev/cyber2000fb.c
+++ b/drivers/video/fbdev/cyber2000fb.c
@@ -1642,10 +1642,6 @@ static void cyberpro_common_resume(struc
 }
 
 /*
- * PCI specific support.
- */
-#ifdef CONFIG_PCI
-/*
  * We need to wake up the CyberPro, and make sure its in linear memory
  * mode.  Unfortunately, this is specific to the platform and card that
  * we are running on.
@@ -1861,7 +1857,6 @@ static struct pci_driver cyberpro_driver
 	.resume		= cyberpro_pci_resume,
 	.id_table	= cyberpro_pci_table
 };
-#endif
 
 /*
  * I don't think we can use the "module_init" stuff here because
