Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A67C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96052084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfDBXHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:07:06 -0400
Received: from smtp-out-no.shaw.ca ([64.59.134.12]:35384 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDBXHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:07:06 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Apr 2019 19:07:06 EDT
Received: from tethys.mmayer.net ([70.68.144.247])
        by shaw.ca with ESMTP
        id BSQ7hVnFUldkPBSQ8hKtfe; Tue, 02 Apr 2019 17:02:20 -0600
X-Authority-Analysis: v=2.3 cv=Ko4zJleN c=1 sm=1 tr=0
 a=5Vvn7CJLxh9yo+qVPaC6cg==:117 a=5Vvn7CJLxh9yo+qVPaC6cg==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=oexKYjalfGEA:10 a=Q-fNiiVtAAAA:8
 a=T1uYfcNGi3NWnhI_G7IA:9 a=Fp8MccfUoT0GBdDC_Lng:22
Received: by tethys.mmayer.net (Postfix, from userid 501)
        id 606923010142F4; Tue,  2 Apr 2019 16:02:19 -0700 (PDT)
From:   Markus Mayer <code@mmayer.net>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/6] memory: brcmstb: dpfe: report firmware loading error
Date:   Tue,  2 Apr 2019 16:00:59 -0700
Message-Id: <20190402230103.25491-3-code@mmayer.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402230103.25491-1-code@mmayer.net>
References: <20190402230103.25491-1-code@mmayer.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfG7BBBcP6EjPFGkZJ6NnQ/UxDUhNvoY4NFmA/YPwJ4gUw/YQC4y3ON5UH6lMQZyE4Yd7hoKvPacF2dwCk1PQE/BhSxh1zG6AWatNJ/03BhzG103wTtCg
 /TzyInFWeJiB1dQkp72N8YByWOtKXR6niUuLPEo6cbpP3vIVzLnPTUspW2CdngkU2IvAZcdmt1PqZdGAUCtp2mxmzNXVelNFFAk8WBdBGu9MVVf3w8QIGpV8
 BCVZs5IJkCzGiePsRGmFCkqlNw17EKBHDozn7zftH9WkW41St+vYT++oKlTJIYzd9ZQbPHhzFbSrzNLoN9WZcP6Tqb4wGRQGwmyoOiyCH9J2/gwfnCmvI4Hl
 yLG4l2UZk8QKgooDiCixEQMPfpNgYL0V0yI7Vz+tMU9OihVGvpaRwbJkZPSwXjBI94SomFCLkZjNYqowlVdCbFxNWc2EAw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

Print an error message if the DCPU firmware couldn't be downloaded.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index f143e40e528b..c67774a4fe8b 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -703,8 +703,10 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
 	}
 
 	ret = brcmstb_dpfe_download_firmware(pdev, &init);
-	if (ret)
+	if (ret) {
+		dev_err(dev, "Couldn't download firmware -- %d\n", ret);
 		return ret;
+	}
 
 	ret = sysfs_create_groups(&pdev->dev.kobj, dpfe_groups);
 	if (!ret)
-- 
2.17.1

