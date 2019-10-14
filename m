Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB77C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68FC20873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVyG1ovb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387605AbfJNPgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:36:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40164 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730828AbfJNPgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:36:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so10600384pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 08:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/yjgZhJlzmYmxj7+A0FInNB+01Y4Ffyd19ePmcPESes=;
        b=CVyG1ovbA8RGQ16T8ML7L8LxbGahjwShjcdQlTH3lmTzTAJ0nwEn02/iyJpBhuIa40
         QSMgqet7U40/IYTyqdpf2v8oonnIGq+4pYocfb2XiIC/XjHbzlxnUqmuH7+2PzjEHh4H
         mlecS7R/xoy4e5pJd6IniOpI2cI9PP4FIlnHzpIop4Q1ix+Q6Z6ybDk/BESizhnPWHJ8
         E3sbjbz08X+suDdzP+K5z3VHMarROko3ztjrl4EVjlkmBXEP0i+qZ/S3f1+N/k8puu8H
         PjKRiHVumJRCTerVRRTpxzRGW5nJliDpIHPEUOZHxMSjeyG60K3yktU9U8kpwavBuSEo
         rIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/yjgZhJlzmYmxj7+A0FInNB+01Y4Ffyd19ePmcPESes=;
        b=jBK+XfeNVCMpdKL+zIpP7wP9WU/k8ZlemUKNVc5cLvFnBC/S3X1jTtHqyFRQATzcQi
         2UZG3N+coGe24f/B3nEusd/Ce36j9ByJGrgns0vgxiKDObNW0YkQw2SrDH3W6S/OseRT
         bmYVmD2KMHHb0vHEhvakNXcFDXHO29E0y3w7RahDOErTtwcfStKNApDUrc772/TRP5eG
         vHY+wrCLOcGE9xk4pDUsyrrUqAoThonMp5mPEIgKoHdF/58fydNXAjEKv2BF2NCugSyt
         z2q/0CpzXw8SfgUemQF4+8+r3sdoOpLtOqti2wwGhLDHzCyyliJtzRWih5itP2Jsy0dR
         eOeQ==
X-Gm-Message-State: APjAAAXH4qCV8n9HvX1gvZZxZnr+VPw7LTtPHQiPm6v0Dh/EClytWEiJ
        /9HDNu7i2/rvziGMu/FAuj8=
X-Google-Smtp-Source: APXvYqxyZmsDru8Wwba7bFjE9IMY/SwryjQcDZdhSqry9+5Ap2Hn5lQl3Gkf6865K3CcZpAPyPBKYQ==
X-Received: by 2002:a17:90a:6302:: with SMTP id e2mr36003590pjj.20.1571067382494;
        Mon, 14 Oct 2019 08:36:22 -0700 (PDT)
Received: from localhost.localdomain (155-97-232-235.usahousing.utah.edu. [155.97.232.235])
        by smtp.googlemail.com with ESMTPSA id q76sm41142648pfc.86.2019.10.14.08.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 08:36:22 -0700 (PDT)
From:   Tuowen Zhao <ztuowen@gmail.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     Tuowen Zhao <ztuowen@gmail.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 2/2] mfd: intel-lpss: use devm_ioremap_uc for MMIO
Date:   Mon, 14 Oct 2019 09:33:44 -0600
Message-Id: <20191014153344.8996-2-ztuowen@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191014153344.8996-1-ztuowen@gmail.com>
References: <20191014153344.8996-1-ztuowen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some BIOS erroneously specifies write-combining BAR for intel-lpss-pci
in MTRR. This will cause the system to hang during boot. If possible,
this bug could be corrected with a firmware update.

This patch use devm_ioremap_uc to overwrite/ignore the MTRR settings
by forcing the use of strongly uncachable pages for intel-lpss.

The BIOS bug is present on Dell XPS 13 7390 2-in-1:

[    0.001734]   5 base 4000000000 mask 6000000000 write-combining

4000000000-7fffffffff : PCI Bus 0000:00
  4000000000-400fffffff : 0000:00:02.0 (i915)
  4010000000-4010000fff : 0000:00:15.0 (intel-lpss-pci)

Link: https://bugzilla.kernel.org/show_bug.cgi?id=203485
Cc: <stable@vger.kernel.org>
Tested-by: AceLan Kao <acelan.kao@canonical.com>
Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/intel-lpss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index bfe4ff337581..b0f0781a6b9c 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -384,7 +384,7 @@ int intel_lpss_probe(struct device *dev,
 	if (!lpss)
 		return -ENOMEM;
 
-	lpss->priv = devm_ioremap(dev, info->mem->start + LPSS_PRIV_OFFSET,
+	lpss->priv = devm_ioremap_uc(dev, info->mem->start + LPSS_PRIV_OFFSET,
 				  LPSS_PRIV_SIZE);
 	if (!lpss->priv)
 		return -ENOMEM;
-- 
2.23.0

