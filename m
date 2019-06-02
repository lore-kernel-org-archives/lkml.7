Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD13BC282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4EC72797D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGagF19o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfFBQfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:35:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50933 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfFBQfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 12:35:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id f204so4960172wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 09:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=hXRaRyTkvJJsioc4WPPsWium9XCHIfD1KCToEtjOIPk=;
        b=mGagF19o9GZQ3c37OrzhCHf5yqSQcX3oxPfzSKPcVfZ4j84pwVu57aQxp2i1qGgU7B
         Fq58TQJxTinSPo23+W3Pd3puM31J2YuS7eJatytp5HN32Qv3x1J7jvOB8tN9Q6ZvzODd
         j/T7Vd4BHnMm6A0pcQocdQJ9OKddT8o+g0Nj8KC+xhoXFc34aP6SjUVEaY4HV2b25NFh
         Kkmj6mQNN0cssPmB+CFDiYmJd2xpaPvAnlat/0O+ZFgOTsA091JEjfQOwg1JkrQVcYnG
         Q493ILNwoEXBQ8BPE6UYzJFeDF0IcNPtiTvF3at+xaX0CDEUuM1xIa9feeQ8DuP0Asuk
         NpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=hXRaRyTkvJJsioc4WPPsWium9XCHIfD1KCToEtjOIPk=;
        b=PdJojoTTlcccoHUozL4nqNRIRnku893h3jrfanziK0PazvaC7nL0FXr8O4YKTSsMvE
         3QuMMZbnp7Q/yc3XmBzM4ET6GDFSRslbbLE3MkGJVhkGnpDwXSNCYS/KZsTnw9x3QMMf
         P77XoTT6rQ74dsjK1eXFzZsTiSi66S4huCc6jJrL5lFG+Z04T3y+ndPw35bj8yXId5ZB
         l5a/PFgV5VgA5J2/rT22m/S/U4LyeZAecsl176grAGXGmZXCvkbs2lganWi3V9Er8to9
         tzqQ0YaWIalm1OuTXcBqLd5szr0uAbWURTO2MWA76TvpDtxqyDX6drWWfoKFS3NW/rji
         uBLw==
X-Gm-Message-State: APjAAAXuK7h1iJbAgT74eQwrmUVppnR4+ztjSDOlOm1RwvMR6/0kc5ai
        2Odazg2A7HliLxnzcLQArXQQCNG/CqaOBQ==
X-Google-Smtp-Source: APXvYqySzcEO0kHHyTKLrSwe9OVMZXejkKvakyWJnoukpbU317JTou9t+IqqOeEL5Tdj6mGcwYJ8cQ==
X-Received: by 2002:a1c:3d41:: with SMTP id k62mr10771399wma.61.1559493343526;
        Sun, 02 Jun 2019 09:35:43 -0700 (PDT)
Received: from p200300EEEE2F.fritz.box (p200300C98712670014A3D3D52C57F0B4.dip0.t-ipconnect.de. [2003:c9:8712:6700:14a3:d3d5:2c57:f0b4])
        by smtp.gmail.com with ESMTPSA id l18sm28902282wrh.54.2019.06.02.09.35.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 09:35:42 -0700 (PDT)
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2] pci: hotplug: ibmphp: Remove superfluous debug message
Date:   Sun,  2 Jun 2019 18:35:39 +0200
Message-Id: <20190602163541.8842-1-benniciemanuel78@gmail.com>
X-Mailer: git-send-email 2.19.1
Reply-To: benniciemanuel78@gmail.com
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'Exit' Debug message is superfluous ftrace can be used instead.

Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
---
 drivers/pci/hotplug/ibmphp_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
index cd73bea12bc7..a2ea1ff6cfbc 100644
--- a/drivers/pci/hotplug/ibmphp_core.c
+++ b/drivers/pci/hotplug/ibmphp_core.c
@@ -890,7 +890,6 @@ static int set_bus(struct slot *slot_cur)
 	/* This is for x440, once Brandon fixes the firmware,
 	will not need this delay */
 	msleep(1000);
-	debug("%s - Exit\n", __func__);
 	return 0;
 }

--
2.19.1

