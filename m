Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B58CECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CDE20872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jddw4T+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437422AbfJPVHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:07:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35086 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437412AbfJPVHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:07:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id p30so15027617pgl.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 14:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/yjgZhJlzmYmxj7+A0FInNB+01Y4Ffyd19ePmcPESes=;
        b=Jddw4T+X+HzroDym+MeSAk5gk5lWXCnojaKghw8XY6Z55upOq2W8SWVHhWznezoxXc
         hMoZyd8eWOmujsE+cyhRZ3zEg6fF9HVONioPaDT9czYgKkYQ9/bmWNlGQCDsjHX7teXz
         3VhxF1cFnBYNFRvFsNzEoF+RGB7hFgJ+DgBjh2T+jsdqo9kty/F9a25rIK9ket5saIgu
         dm5aad3yQ45ZhmBUzMA99/wGMLwk18bREjssFWvt2MKwhlseSYYGhQKdxhMcYvnR/HmS
         ApmuZpoKTNlblPtje+Nt8fO+bn0M+ibv5xcc0ifZVbw2VCTonaLOxfJNFpY6AfDU4/7q
         eZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/yjgZhJlzmYmxj7+A0FInNB+01Y4Ffyd19ePmcPESes=;
        b=ug3ZWnInPSgCO6oM3sdSHD/ojVDCbsLrm3DHZvlmWAFWC49RHaOKhWtzn4wGcmMs3Z
         hBhXz8LeMHuKB9MAnm5oWpsLmitEtFGrflY1ajiCjh6L+WNUbrIMWNGot4U3fluydOfT
         7kW2IXfc8g0h85nGSsUFpSJ0vU7K/QoRWk6TRr6Z6MdsPnjFfWzyrstPTwQcDy6snPVW
         cH+ZM/0AvJIQh1FneYJH15CbeIZdlUQfK3BZCau+UlV3MZQM6QxT7CAZlXrQJ8058K7F
         fFvgEJ+uBzlAwKfp8iQDncgWqDgqyuwjCHBJ/xIRbWESCYcHYLvhMdNEp6AvbGRqax2C
         cIfA==
X-Gm-Message-State: APjAAAWT8/3HGiC/n/Q/JX8WdT98VtM0cM1T6P6+ZXC8CedAPWLddb53
        E+tt2Fnfu84l2FZkaUk/DzI=
X-Google-Smtp-Source: APXvYqxTGgB1tAdNOAMVV89gukyNf/koCFfP18vt6MHgTuEtCGg/oCQI005TnfH2UZpnNep2az/4mg==
X-Received: by 2002:a63:dd17:: with SMTP id t23mr198930pgg.134.1571260060600;
        Wed, 16 Oct 2019 14:07:40 -0700 (PDT)
Received: from localhost.localdomain (155-97-232-235.usahousing.utah.edu. [155.97.232.235])
        by smtp.googlemail.com with ESMTPSA id x11sm11613226pja.3.2019.10.16.14.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 14:07:40 -0700 (PDT)
From:   Tuowen Zhao <ztuowen@gmail.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        acelan.kao@canonical.com, mcgrof@kernel.org, davem@davemloft.net,
        Tuowen Zhao <ztuowen@gmail.com>
Subject: [PATCH v5 3/4] mfd: intel-lpss: use devm_ioremap_uc for MMIO
Date:   Wed, 16 Oct 2019 15:06:29 -0600
Message-Id: <20191016210629.1005086-4-ztuowen@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016210629.1005086-1-ztuowen@gmail.com>
References: <20191016210629.1005086-1-ztuowen@gmail.com>
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

