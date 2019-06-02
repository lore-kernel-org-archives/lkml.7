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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AFAC282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 15:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A2627957
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 15:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkaWIRjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfFBPEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 11:04:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37686 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfFBPEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 11:04:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id h1so9606918wro.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 08:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=vHjadsq2SmHKIIDi66BdXBr4HfecgU1lyBQr8KyLXzg=;
        b=IkaWIRjd589JaVtRKzkjt7NCBSGtuWoo+EDldWeay10DJWIi5/p0t/nMAXnCrsZS/H
         jY5FR/xyvLkVzS8n26eDC0kiLFpiu3koA6n4UDFq92n/teLUCPrsBCXZ7qoBnxCrHss2
         NwfsRp0Om/HptRyyMhRYHVq/ybHbblr2iXjZ6ePUJHQG6jzaZISUQEdHZ7K+ldzI58kr
         h0oscnkxc3f+FcVdSYako3LDaEjPvDF/MyWiZ1AvLoFdSlxrZ/h869oPzB2XFTpITtTW
         Hz4TrnJq50BaIewGWVjjTOAiCLeFFvFIv67ZLvIycT47eBT3CW4N37GHqvFPyP2t3Hip
         6ECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=vHjadsq2SmHKIIDi66BdXBr4HfecgU1lyBQr8KyLXzg=;
        b=ebX5whkbs3i8cr4wIk9GLdtOQc6S6U8qui/qupaLlhpdkC1lk5PiN8uYFgeq3MVlEO
         igurYOIJvh4B9SHDlIIkzhZ95S5O+8EP6j18PXXnqobwMRj+QoPGoy8cbvi5z+CMKu8U
         /XB284lYQ9JMsYdKkAYI4a+1h4KmYQjmqXWp7mJiz/e+EyfCYcLOJ8ALq0GLDNqazX0g
         VciUzhduMxUa2aCE156U1dBBdTCbdYYYm3Ix/CpYeheweWIDQ2tXbNw04rQNFUEVMZKQ
         Ih5wNZn1v6GR/P1Q37iu47fnZ9HqsinRGbhFA93ehIAIUOnF3PSRR4Xo9mGSi6/m3S5B
         3tFQ==
X-Gm-Message-State: APjAAAW9vSotKxqxBBl976YWukHMZzOBkkbee2mObwQgq953e7AOZruM
        9BWO+5N0IiqYuz/hmwEhPFPXaJAgX6E=
X-Google-Smtp-Source: APXvYqzazP79W0E1lpEn5TinOne34Mrq//u4U5vcFB+/eA8laFzZuKcyMMi1tpuGTswUXDGry43WsA==
X-Received: by 2002:adf:f544:: with SMTP id j4mr6219388wrp.150.1559487860378;
        Sun, 02 Jun 2019 08:04:20 -0700 (PDT)
Received: from p200300EEEE2F.fritz.box (p200300C98712670014A3D3D52C57F0B4.dip0.t-ipconnect.de. [2003:c9:8712:6700:14a3:d3d5:2c57:f0b4])
        by smtp.gmail.com with ESMTPSA id u19sm31346627wmu.41.2019.06.02.08.04.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 08:04:19 -0700 (PDT)
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Joe Perches <joe@perches.com>
Subject: [PATCH 1/2] pci: shpchp: Remove unused callback get_mode1_ECC_cap
Date:   Sun,  2 Jun 2019 17:04:12 +0200
Message-Id: <20190602150418.31723-1-benniciemanuel78@gmail.com>
X-Mailer: git-send-email 2.19.1
Reply-To: benniciemanuel78@gmail.com
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This callback is never invoked/ used in this driver.
Removing this callback does not affect the driver.

Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
---
 drivers/pci/hotplug/shpchp_hpc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
index db047284c291..59f75e567c63 100644
--- a/drivers/pci/hotplug/shpchp_hpc.c
+++ b/drivers/pci/hotplug/shpchp_hpc.c
@@ -905,7 +905,6 @@ static const struct hpc_ops shpchp_hpc_ops = {
 	.get_adapter_status		= hpc_get_adapter_status,

 	.get_adapter_speed		= hpc_get_adapter_speed,
-	.get_mode1_ECC_cap		= hpc_get_mode1_ECC_cap,
 	.get_prog_int			= hpc_get_prog_int,

 	.query_power_fault		= hpc_query_power_fault,
--
2.19.1

