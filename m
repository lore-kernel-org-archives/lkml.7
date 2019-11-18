Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155F8C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5693206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="MAggSs6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfKRIe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 03:34:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39526 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfKRIe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:34:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id l7so18303595wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 00:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BAi3R24nZM1QLKzpsKxjwCLlCCJTW9E3eZPofZiXsD4=;
        b=MAggSs6lIF1JEMJN/ikjKq6YjU/z+RqN4nWfn70JoeVXuPgOJnnf5XZSWWJ+uBuVde
         SxhHnSz8w9hYL+4RsE3ebUBvqAkSnx8oHfi16f4BHDc4PBSQpzO2WdPyw5Sv4lTebrZU
         JYpnypnKW2QZCFjmZ3FFnDZjnaQ66fsSTyYvZEaF+P0qe9j3VHi+Gi0LiqPAMFLjt3+7
         aAVFuRiZAVlXhIPlfVvB6EubKqq2EmAvinC32wmptECM6SspQ9aCRGzQ4OEKcAmA75x7
         UYfN51Axn+tiTwKct3Mu1snwmsl9WvNfpyVuEXMonecuAdHeN4KJLGRfbUGsHe+J1CPL
         XrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BAi3R24nZM1QLKzpsKxjwCLlCCJTW9E3eZPofZiXsD4=;
        b=S8Zee8nvbQIud35udjhGFCp15eNDGIvkYvC0QoolKK4WgYHJq0z0Yap/B77z6t5GDC
         f2yFPrnZ5GEiPafcCIT10+X9cLI+jUiEC+c9hsPRx6/XU+Xz3n1zndpKrMOuDUqv1xy4
         +ZFvXokxJMs1/xwlHWVw+o8qO4scr8vZmgK5wMxJHRfxere8c3EiW7sLmPH1Xn3jqFVS
         nqPYP2uo4JujG5Q0KX77vgOaObeHRhPqSpo6yoH1dTluTMqvRLWFbcU4D0WLi+VpZItF
         rdSDKSPW3EXc/XPwm6+LrznK32Z1R/OpPxaZCyqg3QgBJjon+Pd3dqmRdbfjGWW4fCDE
         BtKw==
X-Gm-Message-State: APjAAAUCHt6BMEZmeS4drpVz4L+7ezL7hHOSLj/dqEbzkPtel7/JTds7
        VBCKpVcsFMoisDAFMjNGcePfk+G+EiElqMXj
X-Google-Smtp-Source: APXvYqy7o1uIgUaV4SlbY7VC3+F5BL2ylJ9pv91rt5qJ9p4WpXPyPFj/5p+WGpTecicY/ELxGyQx2Q==
X-Received: by 2002:adf:e58f:: with SMTP id l15mr5500849wrm.1.1574066094671;
        Mon, 18 Nov 2019 00:34:54 -0800 (PST)
Received: from rudolphp.9e.network (b2b-78-94-0-50.unitymedia.biz. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id v184sm20219711wme.31.2019.11.18.00.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 00:34:54 -0800 (PST)
From:   patrick.rudolph@9elements.com
To:     linux-kernel@vger.kernel.org
Cc:     coreboot@coreboot.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arthur Heymans <arthur@aheymans.xyz>
Subject: [PATCH v2 0/3] firmware: google: Fix minor bugs
Date:   Mon, 18 Nov 2019 09:32:35 +0100
Message-Id: <20191118083241.18894-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

This patch series fixes 3 independent bugs in the google firmware
drivers.

Patch 1-2 do proper cleanup at kernel module unloading.

Patch 3 adds a check if the optional GSMI SMM handler is actually
present in the firmware and responses to the driver.

Changes in v2:
 - Add missing return statement
 - Add s-o-b on GSMI patches
 - Add define for reserved GSMI command

Arthur Heymans (2):
  firmware: google: Unregister driver_info on failure and exit in gsmi
  firmware: google: Probe for a GSMI handler in firmware

Patrick Rudolph (1):
  firmware: google: Release devices before unregistering the bus

 drivers/firmware/google/coreboot_table.c |  7 +++++++
 drivers/firmware/google/gsmi.c           | 24 ++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

-- 
2.21.0

