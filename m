Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29671C606AF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC05620665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbfGHMkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 08:40:00 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:39187 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfGHMkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 08:40:00 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M4aA4-1hl1Qt3yXm-001fJc; Mon, 08 Jul 2019 14:39:54 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Oded Gabbay <oded.gabbay@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tomer Tayar <ttayar@habana.ai>, Mike Rapoport <rppt@linux.ibm.com>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Dalit Ben Zoor <dbenzoor@habana.ai>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] habanalabs: use %pad for printing a dma_addr_t
Date:   Mon,  8 Jul 2019 14:39:32 +0200
Message-Id: <20190708123952.3341920-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9KNFd67BZo1dqHvppWZBvDSpSYm3pm8KWs3mfIsotE8h1IyJq1I
 G0D/8p8NiJyBhKa0O7acqodqZOo1a6SpxuWHZ/pqJ0nTfbFYOE10Sv5O42/BvsRdUdjPH6X
 wsaEVl5xvFS1X/5YJtRqDN+ZQU9iNMIrNH+nSA5UKMx5A79FterfXlPOHG14d3a3BVRl8Qv
 JFw2H4VoEZ59O8TUy9kSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ovUOMzlveHI=:6C6A4+y9pT7C8oErjMlWNT
 pvgsyWaPCsLtZsvs5Wu3aMh2o6n+1puYBqeV3iP3ziw28SIV8heGDpwa/hXsmUEWkmMHjY76w
 h7Pt4Ej/qH26y1zVf0svxyvg535A7A6inHoNIvUcE0/UOczrXqqqCU6+nKrgsxWad458oYIJr
 4uq41gFGF3a0M308yv/yw4LsQAW3GOpp+qnOuEkQ8mIFDwPHUaVIgFW9LCOoW0UhmaC3UQWdF
 3wkT54WfyESH4WYQAzLaWne/w1PsMPponKxK0mGcQnrVaf2nXbpQGxkyndrD16cLJTIR4BXHi
 QkPayR01Lja03eCDSsqcQjmWOcj11AyTWbuxxyOY/JbNVRh9GC6sGPqjio38g1p0FC27n9bP9
 3suad9uDlF0a7BeYjnI8qFkq5GpCtSHyHQuYdlOQnnGPa+zzdKF67NtLMWgYq46t/0dL+RJ1G
 pt7m/sclO4DKO7zfLOTh5/iSnF26gJxsVRVQRRaDhD9DzYdx96tD9uZN2+JGQ7zB7cRy48nNM
 eaa/fYnKGrS9SH4NjCV7q7Q605bWPiSpkDgZm/eTPyAG/zFh8DPXvO5wnHLK6fs1grY9QeMVb
 DEhKs3uo1KUjjaJABwD7LQeuCPCyrYczjMHSxrY4VXLkShHRGyK8vBe1pTWAxt9hRdzrHGAcw
 UwZQ7mCYgwbp3cBv/JAofd4b8LJmT+mcJkO6pl9K2NjhMQTrJ5vfjjzhpRJsSIRo0HdeSV/xj
 AwM47spIvazAwNaAUN+0zBTt/59QE9yR/vtu+w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_addr_t might be different sizes depending on the configuration,
so we cannot print it as %llx:

drivers/misc/habanalabs/goya/goya.c: In function 'goya_sw_init':
drivers/misc/habanalabs/goya/goya.c:698:21: error: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'dma_addr_t' {aka 'unsigned int'} [-Werror=format=]

Use the special %pad format string. This requires passing the
argument by reference.

Fixes: 2a51558c8c7f ("habanalabs: remove DMA mask hack for Goya")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/habanalabs/goya/goya.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 75294ec65257..60e509f64051 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -695,8 +695,8 @@ static int goya_sw_init(struct hl_device *hdev)
 		goto free_dma_pool;
 	}
 
-	dev_dbg(hdev->dev, "cpu accessible memory at bus address 0x%llx\n",
-		hdev->cpu_accessible_dma_address);
+	dev_dbg(hdev->dev, "cpu accessible memory at bus address %pad\n",
+		&hdev->cpu_accessible_dma_address);
 
 	hdev->cpu_accessible_dma_pool = gen_pool_create(ilog2(32), -1);
 	if (!hdev->cpu_accessible_dma_pool) {
-- 
2.20.0

