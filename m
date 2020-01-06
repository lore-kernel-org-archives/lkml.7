Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E570C33C9A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7565A21734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnpcRc2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgAFBez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:34:55 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45999 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbgAFBet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:34:49 -0500
Received: by mail-lj1-f193.google.com with SMTP id j26so49278864ljc.12;
        Sun, 05 Jan 2020 17:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d+M+D7s06jXgSbN4ZI5MC1X7Q1YDI/iTue4S1s8hLAk=;
        b=mnpcRc2A1gfrgNJaoDcUskw3FIkQhKyqH0uO1xhvrCt8ttyysBW0WeLGOmBzDoD6if
         hKwHN8Rb0yq2YrFOeehF8t56LcgP1Erqc8hrvNgp1atT0h3/0QnK4ZU3a2aln2mfkQ9G
         Oh/3H3b5A1SfkYsU83SoeVZY77fmCH0B18qQQDR7QE0EXhZB4rGfdIQz7J1J8BrxDKYx
         4k8b2l7x0k83wwl/T1YO1boUM9RE4C7EVCApSGr87zKv2Eix96O5ErkhYIQzz+yYxvy8
         +YAzZEDZMg3JlRDPRumiNssoWxbR+BLIDwkzjs0DUr/jSD8bV69BO55aTgPsQUJq7uc/
         8lcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d+M+D7s06jXgSbN4ZI5MC1X7Q1YDI/iTue4S1s8hLAk=;
        b=jXduwq1Y0M8KzfqKJGtglANhKl0W6bGp0/xYAuCiZFXUWCoBOd4Uyh3LjRBwYD/Ncz
         Y2SgGq4AFHIA2gdS0Tq4tgEUoMkSLpgcLh6l5KiIS2bndOUhzHcu9EYZznrZVFbF/J/9
         XRy7PHDpLX+PiSAuI4mT24bk5mAnvtCD718VzXqm6jHh4KCGiKh2a0FiIGz63HAexOcW
         oHsxpKe2wlMMlUsnHM1KYe94JCRYKVX+kkieNi1tA43/KDKotJTVP0smNwmc8uX+A3E3
         QoaGTYiDWZUH2aWgQ6szr+1s2zfRbQckKF3j6bY/5lBHvtPS3zjNkImJs8pg+XSx/PK8
         ciOg==
X-Gm-Message-State: APjAAAXkvh9SvvSlpwMDhnMsTdZmvHxdFud4iTyNtihij0ZPO147Iaru
        qOpWbo9IQxS6kqqHhM1B9bI=
X-Google-Smtp-Source: APXvYqxNisSENks7sCdkMmDVjD1IWcirOI/Rk+sIrVJNy8oOywjSiwcn4bfBn6SwKR6SUsbns/x8WA==
X-Received: by 2002:a2e:88c4:: with SMTP id a4mr10684183ljk.174.1578274487319;
        Sun, 05 Jan 2020 17:34:47 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id h10sm28235739ljc.39.2020.01.05.17.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:34:46 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/20] usb: phy: tegra: Clean up included headers
Date:   Mon,  6 Jan 2020 04:34:03 +0300
Message-Id: <20200106013416.9604-8-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106013416.9604-1-digetx@gmail.com>
References: <20200106013416.9604-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "spinlock.h", which was included indirectly, and sort includes in
alphabet order.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/phy/phy-tegra-usb.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index c045f44ea964..aca1413db0ed 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -9,24 +9,26 @@
  *	Venu Byravarasu <vbyravarasu@nvidia.com>
  */
 
-#include <linux/resource.h>
 #include <linux/delay.h>
-#include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/export.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/iopoll.h>
 #include <linux/gpio.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
-#include <linux/usb/otg.h>
-#include <linux/usb/ulpi.h>
-#include <linux/usb/of.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include <linux/regulator/consumer.h>
+
 #include <linux/usb/ehci_def.h>
+#include <linux/usb/of.h>
 #include <linux/usb/tegra_usb_phy.h>
-#include <linux/regulator/consumer.h>
+#include <linux/usb/ulpi.h>
 
 #define ULPI_VIEWPORT				0x170
 
-- 
2.24.0

