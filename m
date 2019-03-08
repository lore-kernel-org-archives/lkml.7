Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9F5C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4379920851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkxMAgis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfCHMds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:33:48 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34158 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCHMds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:33:48 -0500
Received: by mail-pg1-f193.google.com with SMTP id i130so14083995pgd.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 04:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Df5cRbrwJq3leZC5CjI//bKXTRG4DObW5gdAgTes3Xw=;
        b=JkxMAgisiLW+M2Bm03CSomouHBn5jXNhKbRNdeTASOZvC3wQvsaqJXIvxj2gyuBPFc
         j22MGl4tGF/Xs3brz5hCXi5sefVpKYdirdcO6sykqGFIayLFQiOrbuI7DzF9KYDI4xsX
         5dxfQsGz9qJOj/OcLglQpry22EsBKdFWU9O61+HFlheMO0YumFqAa8/Uh+w3WoUv0W7m
         8PUJuk4oiEsGU4TrL3kCB5s9y1HQ7PQbJ4tU6IvMUkcMH8a8D8YXh4JVWA+Wkqcqyf6X
         qQEKKtg87F50J57u4gPANeWD/oCnTC9G7Qw3Vh5qY+5Qfqiq13/3mSA9gXcFv0HWR6BD
         GvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Df5cRbrwJq3leZC5CjI//bKXTRG4DObW5gdAgTes3Xw=;
        b=LBwvU8ToVvCUGiBWh2GvhAb2fcZCoIvB8qh5eXi997NRDwWmjFvirc8wCOxUvpV876
         wIyPFqAI46U7oZjVzf/i6jO4LLryVXWRq2TYW0KtFoSLYkT6dMjAE8wZD5OBtveCKfy3
         IIywSyDiAIjUT9epb+fm9/77gOI1v9nU1cAs92HziTmV1rwy3xTy+Yjehu9jw8ZhY6QH
         h5UOshMBorBJ8j7xeh01ECKvqHJJolVJi0p6+GbSP0CDrWvOm3AacrTE6B1loXhUqL0v
         4YL5ujsARVn14uUaW26fcRvwj3KitsK/4jXwoOOjOF61Ox1yuZRIj8r400YgbNSbeyRQ
         VBVQ==
X-Gm-Message-State: APjAAAWdV0USb+yFzPYLt0Dx+sLPi2QKhj5mM3vD9cJhk5boWPjwuGRp
        VP3MSC0KRdZaOnPDxnmiRI0=
X-Google-Smtp-Source: APXvYqz4jSLRAUAEyzGJEZowgIu/k+w9SRxcqxZCHuq2Gc3ujzhwrZbQP64N7Fot3zdu3XwgvG0GoA==
X-Received: by 2002:a65:63c2:: with SMTP id n2mr16430822pgv.439.1552048427299;
        Fri, 08 Mar 2019 04:33:47 -0800 (PST)
Received: from test-System-Product-Name.sunix.com.tw (114-36-243-101.dynamic-ip.hinet.net. [114.36.243.101])
        by smtp.gmail.com with ESMTPSA id e14sm25960483pga.61.2019.03.08.04.33.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 04:33:46 -0800 (PST)
From:   Morris Ku <saumah@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     morris_ku@sunix.com, linux-kernel@vger.kernel.org, arnd@arndb.de,
        Morris Ku <saumah@gmail.com>
Subject: [PATCH 1/4] Add support for SUNIX Multi-I/O card
Date:   Fri,  8 Mar 2019 20:33:22 +0800
Message-Id: <20190308123322.20467-1-saumah@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Kconfig and Makefile entry.

Signed-off-by: Morris Ku <saumah@gmail.com>
---
 Kconfig  | 2 ++
 Makefile | 1 +
 2 files changed, 3 insertions(+)

diff --git a/Kconfig b/Kconfig
index 4f9f9905..645dcc85 100644
--- a/Kconfig
+++ b/Kconfig
@@ -228,4 +228,6 @@ source "drivers/siox/Kconfig"
 
 source "drivers/slimbus/Kconfig"
 
+source "drivers/char/snx/Kconfig"
+
 endmenu
diff --git a/Makefile b/Makefile
index e1ce029d..c9393c75 100644
--- a/Makefile
+++ b/Makefile
@@ -186,3 +186,4 @@ obj-$(CONFIG_MULTIPLEXER)	+= mux/
 obj-$(CONFIG_UNISYS_VISORBUS)	+= visorbus/
 obj-$(CONFIG_SIOX)		+= siox/
 obj-$(CONFIG_GNSS)		+= gnss/
+obj-$(CONFIG_SNX)		+= snx/
--
2.17.1

