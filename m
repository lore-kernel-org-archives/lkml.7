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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B92C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBB42796F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="persvPum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfFBQAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:00:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40205 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfFBQAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 12:00:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id p11so4822887wre.7
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 09:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=QGKB1WOziohOdgSZNkbM6sC/IUkFSUfseafra2vm7rY=;
        b=persvPumb883YcjBbuGme266xzDS0MZ4FKYzAMORy4d8LCT9Bsl5vTH7OUceGNkPJA
         VIRzHArE0zyqAVQ5YuKxyBSdM64tJaofzQ+fKmP+oOkuaBlF+cQbfOkASVt7CHtQgDCA
         nOG2j4rXy/dOwCzM5Y5FdhuMNzWr8uzn85IgNNVzVa+GEYtRyMxlc+xoZQlCk2x348+Q
         ppLPTH7d8O+dkwd+VnIUrn5cP2PhL4k4iWGpKKp0CTxahAYKnYEqDmDywWkKpsEofcIK
         clSVb4fRe1LYFzFaym/l1iUKyL0zGKpUyCLQ7LH4EsIsDfT0vLg0kuWEitvg6XA4ZBi2
         MYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=QGKB1WOziohOdgSZNkbM6sC/IUkFSUfseafra2vm7rY=;
        b=ndnAqktFhFwN58MrEjh4qJ4wvtBpHukGbEZCdJkZhkUt1hpotyjPeX7MxNTUY8UfYA
         fpVMPL+mRiex1v/Uf3KQQ0ocyf3xlt4oRBlRSm8dAXxKTY9xRJvqaw6n/a2Tpb8yw8c7
         dJvAopWohO3dk2zbY0Or5E4vxTflmSD2SVy2KPzq1yNFvSzIV15M/x4TF5Cq1TsGkyIX
         t0PTYw3NfgiOD+6LH7BFsjuXQL8encAp6YWH1KGViIOI+9GmgJp2Cmo4kJAs3hBEK5dU
         Zvtw8JAmfLz616IXw6duRCZnRp2JLGwRxekhObTYctsUQbnzAH38R8ZX3maS5YfFPlQG
         5Jcg==
X-Gm-Message-State: APjAAAXDdk2F9rT1Mk6vWo9xPfZkKBJwU8GyNBlmaxKvXzmuCI1TIOMg
        edaIrHktmW1ShiYxcDDV8JMf3Gvp65eALg==
X-Google-Smtp-Source: APXvYqzecdbSyIx/xDu6/Ll+CabRxN8wFI5bEHJEcTvHFF3BaoIc7CLeq1VedFD4KgY9mdKXAh38Lw==
X-Received: by 2002:a5d:6190:: with SMTP id j16mr13543601wru.49.1559491209376;
        Sun, 02 Jun 2019 09:00:09 -0700 (PDT)
Received: from p200300EEEE2F.fritz.box (p200300C98712670014A3D3D52C57F0B4.dip0.t-ipconnect.de. [2003:c9:8712:6700:14a3:d3d5:2c57:f0b4])
        by smtp.gmail.com with ESMTPSA id i13sm2861962wrw.65.2019.06.02.09.00.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 09:00:08 -0700 (PDT)
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] pci: hotplug: ibmphp: Add white space to Debug Message
Date:   Sun,  2 Jun 2019 18:00:05 +0200
Message-Id: <20190602160007.24684-1-benniciemanuel78@gmail.com>
X-Mailer: git-send-email 2.19.1
Reply-To: benniciemanuel78@gmail.com
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a Whitespace between '-' and 'Exit' to keep the log messages consistent

Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
---
 drivers/pci/hotplug/ibmphp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
index 59840a094973..cd73bea12bc7 100644
--- a/drivers/pci/hotplug/ibmphp_core.c
+++ b/drivers/pci/hotplug/ibmphp_core.c
@@ -890,7 +890,7 @@ static int set_bus(struct slot *slot_cur)
 	/* This is for x440, once Brandon fixes the firmware,
 	will not need this delay */
 	msleep(1000);
-	debug("%s -Exit\n", __func__);
+	debug("%s - Exit\n", __func__);
 	return 0;
 }

--
2.19.1

