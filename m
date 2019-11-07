Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64880C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E68C2075C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="aBKIauAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfKGTpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:45:31 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:50094 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfKGTpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:45:31 -0500
X-Greylist: delayed 511 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Nov 2019 14:45:30 EST
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 9563DE82
        for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2019 19:36:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FsBEupsVr2RS for <linux-kernel@vger.kernel.org>;
        Thu,  7 Nov 2019 13:36:58 -0600 (CST)
Received: from mail-yw1-f70.google.com (mail-yw1-f70.google.com [209.85.161.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 69160E93
        for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2019 13:36:58 -0600 (CST)
Received: by mail-yw1-f70.google.com with SMTP id z202so2580177ywa.22
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 11:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZkFXlMbFFaZPtqR0WrXt6SqN0ExODCqAxzlbvcCImE8=;
        b=aBKIauAVzlqz4mdJxa4Z3Gbk90VcsQAebmyCkrdBhdlulJOUVuykO9nz+/Rc8jmLPZ
         wUnDVRs1Ab2qmqF2tHtOIUrhy83x3zioKmw4fSUlGfmg5aMnRbhy2xxBayTAHDqIH2MI
         o8OdiRdDx+IW6Yo9cUGLrbKCfCIH+ct8LU8vyJdKPg/qQQABuZGdwfW1MPWYq2+SVo4d
         jvftGC5d0A1yhgAgwdrOMLJKyfTBqpVWYTmpfvGdl9bokWLJm6/DTKibgzAtkDe3eV+T
         iPbC4l98Om1r3MLibf48FFMAEO5l7k8QUauqLo4qx0sHMIuA0oUpRzZwcJ5elw6Ofrtr
         Zf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZkFXlMbFFaZPtqR0WrXt6SqN0ExODCqAxzlbvcCImE8=;
        b=ITDSP9NDK17xUC9sKl8lbdOsWnSQbhm2PnH3K1twE6CzwL8UtKwIEwCRMALsdlC7qH
         mmBbbRiTecg/dUx4zQ/lsZlKix47PDS1i5v8AKaEnbLauyOTBu4PECc4hfoBpY0gqEg/
         Z7CL5UfddjPPzbNs6D/u6mzm0IGSkz7FNudu2SM5ZTrakq5VNWUKJHcXU3Zwn7JCDsO5
         qFtyF64TbJcw4tIMYUzca4iHVYoeE2hBZBMqmJIxGylbMs1d6vuC480SPfd50qCGz9wM
         jQ2QciUVCUUQcP3PCOKaV2pKw7GZwphE2l+XLazXLVdElkHwhLdJylW0rfAq50dGMS2h
         /5SQ==
X-Gm-Message-State: APjAAAUWcnjfHPVjPDRwTfrP9uCbnAn9Bz2gzDu2cVMz+qWbrS6QI3NO
        ioBtQnkgybDssnNVoaR2R7RTe+uQearewAsninwxWOx9UeWtdWtFplVrvxvurJnWfzfFiYwg51p
        bIv5aYtPNz22GoOuFfqOcTe01e+dg
X-Received: by 2002:a25:c748:: with SMTP id w69mr5382236ybe.54.1573155417715;
        Thu, 07 Nov 2019 11:36:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzRIq/jzzrFLOi6NJm2pE0Vvwkym6f6XQ+sRPp91hPUWH2n4/ch6bDJTSH382r4MOtRApiyrA==
X-Received: by 2002:a25:c748:: with SMTP id w69mr5382172ybe.54.1573155417114;
        Thu, 07 Nov 2019 11:36:57 -0800 (PST)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id t76sm1725113ywf.39.2019.11.07.11.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 11:36:56 -0800 (PST)
From:   wu000273@umn.edu
To:     airlied@linux.ie
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, wu000273@umn.edu
Subject: [PATCH] drivers: fix a memory leak
Date:   Thu,  7 Nov 2019 13:36:47 -0600
Message-Id: <20191107193647.1944-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

In intel_gtt_setup_scratch_page(), "page" is not released if
pci_dma_mapping_error() return errors. This will lead to memory leak.
Fix this issue by freeing "page" before return.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/char/agp/intel-gtt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/agp/intel-gtt.c b/drivers/char/agp/intel-gtt.c
index c6271ce250b3..bd38b179157c 100644
--- a/drivers/char/agp/intel-gtt.c
+++ b/drivers/char/agp/intel-gtt.c
@@ -304,8 +304,10 @@ static int intel_gtt_setup_scratch_page(void)
 	if (intel_private.needs_dmar) {
 		dma_addr = pci_map_page(intel_private.pcidev, page, 0,
 				    PAGE_SIZE, PCI_DMA_BIDIRECTIONAL);
-		if (pci_dma_mapping_error(intel_private.pcidev, dma_addr))
+		if (pci_dma_mapping_error(intel_private.pcidev, dma_addr)) {
+			__free_pages(page);
 			return -EINVAL;
+		}
 
 		intel_private.scratch_page_dma = dma_addr;
 	} else
-- 
2.17.1

