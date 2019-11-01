Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72496CA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437842067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fipki4Ji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbfKADG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 23:06:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52445 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfKADG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 23:06:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id c17so646439wmk.2;
        Thu, 31 Oct 2019 20:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ABoCwU9PP9ddyUwXERXcCZdYWkmzW6JWRZWKZZduMb8=;
        b=fipki4JiNUGyDzM+Uhc6AJgfupy3T53fUwGXdyAPBips59hmCtphQspTnuEcGfG3aU
         fcWZQICG3N0MgtYCEPy3CVcxS1ogVjKr+kUtuISKj8JqU6SGRrucgJ6Yt/O13E6WA8LI
         M+4q5vFDs8Dfwqti3Ng+jhtVUG/H8A9nYazaBrk9MIrgk0k9zIcwrpt/cATyNpZsvRtx
         dIXCArYC0M6rwTQVrDAeYclcMV/slp98rLSJsJgFNKqTe+rjYhm2CHxZcKJ+IvLdpYFE
         a/j2O3elx9oo86L0xZ3X0uFvO7pzJYJnWJ3R2OSxuBeN95Mpsh/crlUZPmDy9gl87Lqn
         LzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ABoCwU9PP9ddyUwXERXcCZdYWkmzW6JWRZWKZZduMb8=;
        b=oUnIRhGlnwjKiKuGw+P1LXEz/28CW558HnUmGQmBtVqnA7ZUCJemoykdMfjVoV1Pct
         cvsDKcaD6A6rJm1NvN4byiogr1HRRhaKdWjR5vbH3keT1edgpG28zeQYRMa8oHcYDmIM
         E46SgLIm+9RM5UN9fpubmqtjbr15bHyj/RrQp+3uCpiz5E8lpQot7b/R6v0Vl2n9rKsw
         mPz3ks00WXxGPEJFVqhGrAd4Xt387Y+fJejTA1CNnGMnEyvWzzCE2q6Hms8Zlf51Q0qn
         LNdYAJq8+4qIUSPm4tGxGfgO08zDxeidwJrOfRbJxT6OobK3M7u1yGg6nsfPkgQSHOkv
         dRkg==
X-Gm-Message-State: APjAAAWBnpSBAHP8V3lGHg/sG8TnK2f92BAf5CP6Fbj3mf+4Vrfa8bED
        4CnlYStcjFoxNOsNUZ6eJgSTOwMq
X-Google-Smtp-Source: APXvYqxuscdYaOY+WQrYM+P8BeaEGx5d1Xq3998VHM+OFwKySzE77N586ldM9L8zBHAtJieEBn01vg==
X-Received: by 2002:a05:600c:20c7:: with SMTP id y7mr7292101wmm.34.1572577585137;
        Thu, 31 Oct 2019 20:06:25 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j11sm2625299wrq.26.2019.10.31.20.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 20:06:24 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] reset: brcmstb: Fix resource checks
Date:   Thu, 31 Oct 2019 20:06:15 -0700
Message-Id: <20191101030616.27372-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of IS_ALIGNED() is incorrect, the typical resource we pass looks
like this: start: 0x8404318, size: 0x30. When using IS_ALIGNED() we will
get the following 0x8404318 & (0x18 - 1) = 0x10 which is definitively
not equal to 0.

Replace this with an appropriate check on the start address and the
resource size to be a multiple of SW_INIT_BANK_SIZE.

Fixes: 77750bc089e4 ("reset: Add Broadcom STB SW_INIT reset controller driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/reset/reset-brcmstb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/reset-brcmstb.c b/drivers/reset/reset-brcmstb.c
index a608f445dad6..21ca6fa51365 100644
--- a/drivers/reset/reset-brcmstb.c
+++ b/drivers/reset/reset-brcmstb.c
@@ -91,8 +91,8 @@ static int brcmstb_reset_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!IS_ALIGNED(res->start, SW_INIT_BANK_SIZE) ||
-	    !IS_ALIGNED(resource_size(res), SW_INIT_BANK_SIZE)) {
+	if ((res->start & SW_INIT_BANK_SIZE) != SW_INIT_BANK_SIZE ||
+	    resource_size(res) % SW_INIT_BANK_SIZE) {
 		dev_err(kdev, "incorrect register range\n");
 		return -EINVAL;
 	}
-- 
2.17.1

