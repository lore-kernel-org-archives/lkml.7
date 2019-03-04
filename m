Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E7BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1BE206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="B19AmqvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfCDXJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 18:09:09 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:46582 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCDXJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 18:09:08 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 32205BE7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2019 23:09:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id l-GpNOqPvUxp for <linux-kernel@vger.kernel.org>;
        Mon,  4 Mar 2019 17:09:07 -0600 (CST)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 03A69647
        for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2019 17:09:07 -0600 (CST)
Received: by mail-it1-f198.google.com with SMTP id 127so765863itk.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 15:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QgiRH+bwasnq8S89y1TnNvLzWpqAnH8hIj1GFot68GA=;
        b=B19AmqvERObGICHkqcXoJNFqtZDaWerRF/ff6l+kUidDrgSANqvDmZTZ37/wUH2uTZ
         wmrybH5wR6cFlodfxmtN/6FwKyDbBtQ9P37h7E3bAFOLjbhpM/IE36CZJ+5nIP7Z4Ll2
         x8RsUUSsYxf3jGgSPzIEzliQzS+M4nHNR18WcbAEPlPT8uFMHZ5GgKVn85YMUlr1NJvf
         WrxL1K0olTalrMCMRnzFp8j63KPpZ+XKvuD+aOCkHuhxy2pzrfYv3VaTcLU1xN+tk9hS
         cSSGP5Ba0rJmaNXZPqwUm+ChA6ygL7JFsbhDwArjVg1h7LEP4Gjfd5cr+Z/YpEGTPuSd
         a6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QgiRH+bwasnq8S89y1TnNvLzWpqAnH8hIj1GFot68GA=;
        b=SMDGg7dWMkrHiB+xKZFFhJhgOg+UO25UFaG8rJ/SWmeNDVg+Whu34xAcdGB1veOXvD
         U6gJH0wMlBDnZBOUXGKAu7GFOmgD3rt5Ktf1lIMYI2O/3vv8AMLgZSWMpTzp7Nj7oUI5
         /2l5RiiVZx9aYyxpK4loe8xcfIg+/FMTrbkEwawD9OMZ72YYX8Y49Uox05N+oGGBeZC5
         s+fcOpnHTfUsO+cGEeiNs+nasa66o4Gx/kEfMdG1CfIn7f2R80g5NMow8HQU54PJXbW0
         jttFFIK/A7aBQ333j21tyeMVU4gZ2YDGQUs5EgGUuwfWSz5wbP243TjP3X9lSkB59hHs
         UpQg==
X-Gm-Message-State: APjAAAV3xcHOP6u+NwVG2iyJeUTl2MwwUoD83kivYrj3vaMsyuZ1j7U8
        2B+X6BuunvTKEztQHtjFK90yU93vrj+lrbigmM4yTtYyRsNgR2/qTzOpi/jTkZITV6GRI062Deo
        UBBjYG/+nXkLrVOTSGGBPF9THeQyh
X-Received: by 2002:a5d:8190:: with SMTP id u16mr12093669ion.238.1551740946659;
        Mon, 04 Mar 2019 15:09:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqxPbTYwnnguoudGC59w/SL74xoKOGa4a8O54OPKUNCcM+S29iKRcabax6lUsGDOyVz5N7Gwng==
X-Received: by 2002:a5d:8190:: with SMTP id u16mr12093658ion.238.1551740946467;
        Mon, 04 Mar 2019 15:09:06 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id c97sm3417477itd.3.2019.03.04.15.09.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 15:09:05 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ata: dwc_460ex: Avoid potential NULL pointer dereference
Date:   Mon,  4 Mar 2019 17:08:57 -0600
Message-Id: <20190304230858.13387-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_async_tx_descriptor can contain a NULL variable and using
it in dmaengine_submit without checking can crash the process.
This patch avoids such a scenario.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/ata/sata_dwc_460ex.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 6f142aa54f5f..44a0d7a1ef54 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1052,8 +1052,10 @@ static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag)
 					SATA_DWC_DMACR_RXCHEN);
 
 		/* Enable AHB DMA transfer on the specified channel */
-		dmaengine_submit(desc);
-		dma_async_issue_pending(hsdevp->chan);
+		if (desc) {
+			dmaengine_submit(desc);
+			dma_async_issue_pending(hsdevp->chan);
+		}
 	}
 }
 
-- 
2.17.1

