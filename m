Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4007C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4D02070D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="cooBi1O9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfCNOG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:06:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36188 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfCNOGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:06:25 -0400
Received: by mail-lf1-f68.google.com with SMTP id d18so4346394lfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 07:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UHnd0hct8liVtoLOqhy+KENhjcgBv7mOrxnEdeUm9fc=;
        b=cooBi1O93wAo53iti6ZdGEDLKj/89KRabrITwEW9UOn7bP7wePu6Cn4GJtXU4Oa1e4
         yBWnZyW2h9RVvwjJqNyiGba/tzL8mxPV0/1uiPOIYZmNjKDRddyuBS9emEMIJEqfn/b8
         qDtmJ2TASyp6vvPA0lHGzzYtGSCXQj5aGmMqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UHnd0hct8liVtoLOqhy+KENhjcgBv7mOrxnEdeUm9fc=;
        b=huWgwxvehYvCPIvTZUxrbwcCKWrR5BVkfYRj/tg2G5I3iDZdLI1rOQKp8B3+M5eMWB
         EhYyuMXHILve0wgcNUg13GGxGwEuc1JK3FxBfYPf9qfPuHZnu4x59hrLBq5FbVyu/vKl
         QyDvgg7kNjRu3jNOrhium2ic90Nyhkq7prBH06ZTX8n5fXjq7ENMMimGFOyEAikSEZbt
         2Hs8GJjVe7ZBIZsKXe71hIyysikL08RyVmMtIA7Bc/qqAAUeGRlqBVfEYmlpGOSzIgIY
         TEFzdrZH9vZEElxGz/houxmxsLnUnOxPVmpo3dEppi5GkKD/bPDnsaN3w0DNKMRNMery
         TmLg==
X-Gm-Message-State: APjAAAV8fy9ZuIRS6sLetuw1iOJMm2sM4UQCq5C2BNrnM44oNT+S4U5v
        BlRA6y/vCF/wfcxxUgW8meaXPBlZAFm0plr5
X-Google-Smtp-Source: APXvYqwVdABY4s/WAvfJTnyPgM66zcKOu4LuSXcKj+nubDBCcrOyCf3L9vcZLHDUcq2c9CZWiYjIng==
X-Received: by 2002:ac2:4474:: with SMTP id y20mr5687761lfl.42.1552572383610;
        Thu, 14 Mar 2019 07:06:23 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t14sm2733709lfe.51.2019.03.14.07.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 07:06:22 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 0/6] leds: netdev trigger: allow setting initial values in device tree
Date:   Thu, 14 Mar 2019 15:06:13 +0100
Message-Id: <20190314140619.3309-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313202615.22883-1-linux@rasmusvillemoes.dk>
References: <20190313202615.22883-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a reroll of the attempt to allow initializing led_netdev_data
from DT, fixing minor bugs and inconsistensies I found while digging
into the code.

Changes in v2:

* use 0 instead of '\0' for consistency with existing code [Pavel]
* name the helper netdev_trig_set_device [Uwe]
* add a patch allowing echoing 15-character names to device_name 
* ensure the length checking is done in one place [Uwe]
* drop hunk from CAN Kconfig file for now [Uwe]
* don't mention CONFIG_CAN_LEDS in device tree binding [Uwe]
* guard netdev_trig_of_init by LED_INIT_DEFAULT_TRIGGER bit [Jacek]

Rasmus Villemoes (6):
  leds: netdev trigger: use memcpy in device_name_store
  leds: netdev trigger: factor out middle part of device_name_store
  leds: netdev trigger: move newline handling back to device_name_store
  leds: netdev trigger: move name length checking to
    netdev_trig_set_device
  leds: netdev trigger: add documentation to leds/common.txt
  leds: netdev trigger: allow setting initial values in device tree

 .../devicetree/bindings/leds/common.txt       | 14 ++++
 drivers/leds/trigger/ledtrig-netdev.c         | 68 +++++++++++++++----
 2 files changed, 69 insertions(+), 13 deletions(-)

-- 
2.20.1

