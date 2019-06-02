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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D7EC282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C0327970
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ob/EwjWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfFBQct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:32:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39140 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfFBQcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 12:32:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so9703895wrt.6
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 09:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=hXRaRyTkvJJsioc4WPPsWium9XCHIfD1KCToEtjOIPk=;
        b=Ob/EwjWULzP69B+oWtqxXXhsLIYnsLv3gW4r3nLNcg99TcdSc1qNvCH0mikkdxj8bi
         3F5yyXP8jutNO6SmlVBEFcxbU6L/KgM2Hi9bLFSSEf9l5uQ67DENh/VLjhpz7lie4ZeX
         DC2mQ2cT5CJ0rdwn6KO8bodgzIiC0r5D3uOleit/VHp5wIf2zzRCAW+NWcC2trNQBJJs
         bTUVAoHtvpiA9l4hxfzb2ATmBtsOIvYaBTK1hIlYWAgyclD9PwtALmoW5J9iNTUt2ijm
         v2UWO8a5grToxhILrC3ID3pwrD0zoAl+dHfvn1L6JZC+/16Dz04hYHUH+75WVn+Dl2nz
         hD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=hXRaRyTkvJJsioc4WPPsWium9XCHIfD1KCToEtjOIPk=;
        b=lqoF/YXJ8qa0hj2UzdFWNLyQkAroNyH+cZXZCb84cPr34i++dqdOEzhJoL7InSCxxu
         O9AEi7e4FGupA0c+hHJNhfZleg/owUpz4bgbKyb38d1cnyfREgba3ENJgKSTHGsawae8
         ZG8sugH/TyZR4kMx1ydN+fIU+N7VosWRDBcZNQmqPlfndrLfmR23WjZQ6CTytNKQtfA9
         EfH64mgWq30SuYc6kVXsZMemNHB7rZ1xLJYAF/ElpKhlmPl+JnAIgTtGbH6NTzBAmyOo
         qkKDpxuWKfPZuG9Q7FB1EWAMSlRYg3SBM10t646AMChTAdua0eiS6XBLjgpIZ2bFiIpC
         62Fg==
X-Gm-Message-State: APjAAAXfYTJr4fU2FJlMFKsoZZPgzidZiWWh9obejRIEr75MAH503ixs
        Bott34Ptq+Sc25kImbeOg+T0rtAC3OnRNQ==
X-Google-Smtp-Source: APXvYqwOmltwwQi1aogH9gsTzw/b6utJQ/MMb3QzjQAx1fgRn4Eaql8AisRyuj7KH5CR6bf2lmGFwA==
X-Received: by 2002:adf:e591:: with SMTP id l17mr2894862wrm.231.1559493166846;
        Sun, 02 Jun 2019 09:32:46 -0700 (PDT)
Received: from p200300EEEE2F.fritz.box (p200300C98712670014A3D3D52C57F0B4.dip0.t-ipconnect.de. [2003:c9:8712:6700:14a3:d3d5:2c57:f0b4])
        by smtp.gmail.com with ESMTPSA id a139sm20420993wmd.18.2019.06.02.09.32.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 09:32:46 -0700 (PDT)
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Joe Perches <joe@perches.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] pci: hotplug: ibmphp: Remove superfluous debug message
Date:   Sun,  2 Jun 2019 18:32:39 +0200
Message-Id: <20190602163244.6937-1-benniciemanuel78@gmail.com>
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

