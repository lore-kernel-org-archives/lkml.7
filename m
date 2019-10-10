Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA7EC47404
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 03:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAA221A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 03:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ct4Y3UHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbfJJDEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 23:04:40 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42843 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfJJDEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 23:04:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so2035671pls.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 20:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dgU04uG4KN8wZdkavzK+aDxHkuJpeE8Oudfx3JbWyc8=;
        b=Ct4Y3UHZAz/NbFWcyXwpmg1XzQ6JsCkrIxLwV5xxp+11zzK/YIyBX2xJ3ocA6XGF25
         fdxHimIoOZQ/CFJ3/hUH3rvBdQS36L8/Sa5ZY7F+EeHN2+O7/2DMhlOI3uo1yIBiXWaw
         Z+CcyPYapZriJPhLE/IA3kEZGAjcaQs4W3dn9VW0YJ0ZGU9Chw+pRQyxtpAoh6LDomTq
         duIn16L5ZmcMspUJgbypMNIniFP/CVivIRjBmnabkonrGEozhS9Xduecbb8B1rKPI/Tl
         wirqkXIrDpHVIuEx+AYhUw4iJaQfYq2NiRRGve/tV8Gn+bBplVeX+lp+rnoobprrC/Gz
         KkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dgU04uG4KN8wZdkavzK+aDxHkuJpeE8Oudfx3JbWyc8=;
        b=PflZuR9qPX7V6qqmPXm/EWpKC+kZeC0ehxujdjavIQJcnLsXVbII2Z1VGH2oV4g3LD
         JPHpzmYy02zyq+cgkaGw4pHbNBFmn000AvUUIgK5yXBYYnE4wl0D4yFMhByaDQGi3+3D
         RhCS9A38cbmgjZODlFpFu13k9ULxw6RSXOj3Zdh7UDd5GCLC8hjljRYOFFimM17yDJyw
         akYgihtZJ6g95cD9GvY6evq/E9AngecDgYNu5uEzktU0k4dL0jGRepRNEloxobOJYfgp
         OV4uqojChKRbi6OCcsSqwpftA1os1Gq8siPG6XcFLXwAF83wIgGwrDaZcQj45PdiDqqo
         s+Kg==
X-Gm-Message-State: APjAAAWA9cAgrKpHvOx4YEr0jhwRM7ylVksq5ZR+5h1jFPB6gylYyl7u
        WAJCvfKreU0xFCWboqxv9Mo=
X-Google-Smtp-Source: APXvYqyZ5Whx6ZdoVkrZFHrztti/DjC+HmK0Wf4SOi3r8UU7wSTa4+85ANes8vz1t5EEMjQaRfEZsw==
X-Received: by 2002:a17:902:9b85:: with SMTP id y5mr6712204plp.138.1570676678892;
        Wed, 09 Oct 2019 20:04:38 -0700 (PDT)
Received: from localhost.localdomain (155-97-232-235.usahousing.utah.edu. [155.97.232.235])
        by smtp.googlemail.com with ESMTPSA id l192sm6310379pga.92.2019.10.09.20.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 20:04:38 -0700 (PDT)
From:   Tuowen Zhao <ztuowen@gmail.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        acelan.kao@canonical.com, bhelgaas@google.com,
        kai.heng.feng@canonical.com, mcgrof@kernel.org,
        Tuowen Zhao <ztuowen@gmail.com>
Subject: [PATCH v3 2/2] mfd: intel-lpss: use devm_ioremap_uc for MMIO
Date:   Wed,  9 Oct 2019 21:03:35 -0600
Message-Id: <20191010030335.204974-2-ztuowen@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010030335.204974-1-ztuowen@gmail.com>
References: <20191010030335.204974-1-ztuowen@gmail.com>
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
Tested-by: AceLan Kao <acelan.kao@canonical.com>
Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

