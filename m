Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A93C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1ED2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="lh76zgbc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfCSAaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 20:30:46 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:50278 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbfCSAap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 20:30:45 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 25D2FAB3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 00:30:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Lz_8fJ2Nh-ym for <linux-kernel@vger.kernel.org>;
        Mon, 18 Mar 2019 19:30:44 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id E074D92C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:30:43 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id z190so6100085itc.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 17:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ooq4r/ebCnnXAe3/oQpav9WVOiGj8D+f04S8WUhRVzw=;
        b=lh76zgbc0mav3MUfU+qFag4uNnA8mal1nx7+n9/EsuuPXr/aAcS9wq0/+3v1QNUbkl
         LNxxgqG/XDhxhHlcNksIkw3YCSnMoKLDBTm4Or++aKyDZBaXlv0D0XtSvYqREbPdUtgt
         LB7QpDPQroOeUv1yop1n2TaocKgyTotypcN3urISSaoF3IRdgOPTyJ81XjBKzF+3G0sY
         wTAuvMU40b0pOQBwkPUqxHwZbaCTWV9EMlBmBvkG1ROOLomI03qax+8wyvKsV8/8aC4h
         Bw/Fp05uPwPCLYDg2I9sw9rWl4PcfJbe0lykzv0nVfWAMK8i47fLj9/mIILXtoVf8NEi
         5WkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ooq4r/ebCnnXAe3/oQpav9WVOiGj8D+f04S8WUhRVzw=;
        b=HjxeMVWxFcVeBcgP94pP/53s1NCjoRg/G8oidJuT965Mq6ClW+EX/Ghw0k/1D89B9g
         yc1JU0KlvtFjH5IZ1WsrjOSo6YKat4gz72Qfg9SvSOtcWulkrIkY03a4THBjjpDAXYug
         hxuzk1GIzF8vquUtirXenNRvGLyAK8ceeiehDtxSSSqOrnbZqxSQXt4WjGqXkfwusOvU
         uWjdS/JqDw4sygiSOgFpmJ8ctn5KbQd2P04Ev0nIm9nll/F0kISre22XkdjsnFYPBk5b
         BmIkclVcCZFClHPI4MsGiUCTagLGDl6mk50KgIWawzpNNlRGmJM9X7kqCT8yHtHkmArf
         UlXQ==
X-Gm-Message-State: APjAAAUBLy6p+bnd3uoN/0dCG55pHlNk6q2IjnU4rQiIPVlTFnCYdctJ
        krtcgx2KZ8Dtvxji8jAnHmxXngaJOQ/pfzoVu2PYwHb/KFN+HzgpceNT6ODp+y1qKc/KZfrgXlb
        IIS3nP/YlQlFGndDCIytt5J/DUlCS
X-Received: by 2002:a24:e502:: with SMTP id g2mr969845iti.78.1552955443538;
        Mon, 18 Mar 2019 17:30:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwcIHFoZRgcNpgUZVwSaoHsKrh63C/yYMg3hbRGXhPoRErNIDkoD2D8T5qL1TvnvPqK3HIsHQ==
X-Received: by 2002:a24:e502:: with SMTP id g2mr969834iti.78.1552955443357;
        Mon, 18 Mar 2019 17:30:43 -0700 (PDT)
Received: from lenovo-1.hsd1.mn.comcast.net (c-73-242-25-233.hsd1.mn.comcast.net. [73.242.25.233])
        by smtp.googlemail.com with ESMTPSA id r2sm456894itk.5.2019.03.18.17.30.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 17:30:42 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Pedro Sousa <pedrom.sousa@synopsys.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: ufs: Fix to avoid a potential NULL pointer dereference
Date:   Mon, 18 Mar 2019 19:30:38 -0500
Message-Id: <20190319003038.12896-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tc_dwc_g210_pltfm_probe, of_match_node can return a NULL pointer
in case of failure. The patch avoids a potential NULL pointer dereference
in such scenarios.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/scsi/ufs/tc-dwc-g210-pltfrm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/ufs/tc-dwc-g210-pltfrm.c b/drivers/scsi/ufs/tc-dwc-g210-pltfrm.c
index 6dfe5a9206e9..2b5bc6bd715e 100644
--- a/drivers/scsi/ufs/tc-dwc-g210-pltfrm.c
+++ b/drivers/scsi/ufs/tc-dwc-g210-pltfrm.c
@@ -61,6 +61,8 @@ static int tc_dwc_g210_pltfm_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 
 	of_id = of_match_node(tc_dwc_g210_pltfm_match, dev->of_node);
+	if (!of_id)
+		return -ENXIO;
 	vops = (struct ufs_hba_variant_ops *)of_id->data;
 
 	/* Perform generic probe */
-- 
2.17.1

