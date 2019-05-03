Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746CEC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 04:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FCD52070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 04:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fredlawl-com.20150623.gappssmtp.com header.i=@fredlawl-com.20150623.gappssmtp.com header.b="GZEujWwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfECEAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 00:00:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44442 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfECEAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 00:00:20 -0400
Received: by mail-oi1-f194.google.com with SMTP id t184so3394738oie.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 21:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YuWHqWyJ+JP06RXp87S+GiXSAUWX7Ks5BQw57gh+tGk=;
        b=GZEujWwhMRJwFtd80IdNNMcGZhrNHvNaZZX7gTaAYqA3YN/E9W5VGiG7UdlCXH2b3s
         eIqNC/5wk26Sy41WqEUjReocbGnnF4GkX7sUhB2N953PxtkkrOg1J1YrDWOXtrmk3nYV
         YrlPd3nDA5SarFrVu5rYW0UsB4pMQ1DB0kvTaBX5ntuG/6X5+d1eC6/QplkFX67qzWxj
         1zguJx34e765vbj7p1PK8rzTaLpxAEM3jjaa8Cpt0SzaXWl6gavE6/PDwbCVIsuB8I4g
         TVL0/v6WLpZE3W/FbdjzOjGICqVlNBHOgViO5drxoTtFf0d+n04lE79mpiErWvi88LFZ
         98Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YuWHqWyJ+JP06RXp87S+GiXSAUWX7Ks5BQw57gh+tGk=;
        b=YnH6E+4Kf+837K/uruSy5OEj5gj6dCrmkXb1YH1+H1xmpmRp/Mg7tmlSM3iVzdsVI/
         DRqtIZNEoYpuXbjVRl0Dd/5YiZ+gVJvtXyvHhNSEK5l+OxKN5uEsM8q5rra4XysFD1xV
         ot2Z34X8p7MEp9QF2QyZYnj7wU/BLNAN0/kk3qY6Xp013rylgcBPt4WDO5+lTQsqme4d
         uGqu7kOuz69jHrzQ+//sc+A12Ik68cFP2eFbTd71/ms/4LoZJUnGsKV3jk+1HpguceHX
         LBRgq1RMsbZrJoEntZ2/3ImT7YPJSx8QDvc89/+a5rFSJyHTHZETEKLx3jEzdr54fBlI
         uaTw==
X-Gm-Message-State: APjAAAWYrFve7sZnFk6DyMcg16plOynu5LY8/g3/MtdE4FK6SrSbf81x
        k7ib5hQ9/qs9jWTBZI8izpKydw==
X-Google-Smtp-Source: APXvYqwqTuUqK/SIef1FttxAcfu0BMnkig8NswvTmUvCK3eoCUT0mnuD/C5o1hlRS51mBDBpdWVnNg==
X-Received: by 2002:aca:5203:: with SMTP id g3mr4886547oib.142.1556856019443;
        Thu, 02 May 2019 21:00:19 -0700 (PDT)
Received: from linux.fredlawl.com ([2600:1700:18a0:11d0:5518:38b8:ef25:393a])
        by smtp.gmail.com with ESMTPSA id e9sm758897otf.48.2019.05.02.21.00.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 21:00:18 -0700 (PDT)
From:   Frederick Lawler <fred@fredlawl.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com,
        Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH v2 3/9] PCI/PME: Prefix dmesg logs with PCIe service name
Date:   Thu,  2 May 2019 22:59:40 -0500
Message-Id: <20190503035946.23608-4-fred@fredlawl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503035946.23608-1-fred@fredlawl.com>
References: <20190503035946.23608-1-fred@fredlawl.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefix dmesg logs with PCIe service name.

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 drivers/pci/pcie/pme.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 54d593d10396..d6698423a6d6 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -7,6 +7,8 @@
  * Copyright (C) 2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
  */
 
+#define dev_fmt(fmt) "PME: " fmt
+
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
-- 
2.17.1

