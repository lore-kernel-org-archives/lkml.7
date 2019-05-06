Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72949C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4230E21479
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbhLjJC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfEFRMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:12:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41367 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfEFRMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:12:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id d9so6682095pls.8;
        Mon, 06 May 2019 10:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YaNnLqU9o2lpY1nR/3WwmAgKR0IVYxRkeI3qUXiAw/Y=;
        b=HbhLjJC8LFnPmOLID1sNlMNWwgmi/mqvze6SF86s6VVJoSgSecXo6yyXvyMjwoh617
         cZeYp2Pb5C1C9hpjlqWa5KnDw84EUeTPwtOzbqbtijt3EfDIof/gx77ehYQIB0sIV6cg
         i3/BMKt17F6j3V/YRUkXF65BBnPdGxg/yWmkFrOAd/5f8lrFk5I1jz/RTveByLdNte5l
         gVr4zUPJX/AlT+ECAlq1nvD3OjWx/4IMrXQPmCKBwAFAFC/MNmETad5opUTWO6n/JPRH
         tHbAM5neO+lCmlttQNau4liZG1+9/+5ytHokHVKCJb96eNOTgv0IpzY5GiQKXFQC56v5
         ZIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YaNnLqU9o2lpY1nR/3WwmAgKR0IVYxRkeI3qUXiAw/Y=;
        b=g+CvtxZOZ//tjpkJOt57Fnk56yGbjzBJ20GqFVCy8G+VyxA/oxIHiLrsIXxIkeRS0r
         Rv5HLjD8ylrJ5KBhqAgcUbi2lkSgPtkndIsTzvg4/HII/VoiuA8bC3tlQBVYOfCCxV+K
         LguFU4EbfWDchPu7BobmxQmcrdOf54gVKM9ZSETyWMy94oDvRvNMdWFv4dc3y28i6aCD
         fTAkbEVDQAPTkklIG7We8uymJyErD1MVBQpaPQjTuOwVSapSKSx6llDyqdG4GXaEMi/0
         Aq/SONL51dD3Bddy88P0uLC+WAp8zZBzpoFPXn2V3LSZdJnZxr6KGwdjumoZSlrdkFHf
         5ikQ==
X-Gm-Message-State: APjAAAWusSuLSEOzYKWYdPYAhF14RkwsQliDfZi1I9T6EuW64ZFD7eJM
        8rEyKZ3UN7v7HVsAMQyj3Wo=
X-Google-Smtp-Source: APXvYqxZIUDk5OqDdjWEloO+8U12RC6IIdrfQ9bD4vKEgecCErpXS0sMvNF/eXSwSMSA5eBXOV9Adg==
X-Received: by 2002:a17:902:9693:: with SMTP id n19mr33356286plp.92.1557162734908;
        Mon, 06 May 2019 10:12:14 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id h13sm11045680pgk.55.2019.05.06.10.12.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 10:12:14 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v3 27/27] Documentation: x86: convert x86_64/machinecheck to reST
Date:   Tue,  7 May 2019 01:09:23 +0800
Message-Id: <20190506170923.7117-28-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506170923.7117-1-changbin.du@gmail.com>
References: <20190506170923.7117-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/x86/x86_64/index.rst                   |  1 +
 .../x86/x86_64/{machinecheck => machinecheck.rst}    | 12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)
 rename Documentation/x86/x86_64/{machinecheck => machinecheck.rst} (92%)

diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/x86/x86_64/index.rst
index c04b6eab3c76..d6eaaa5a35fc 100644
--- a/Documentation/x86/x86_64/index.rst
+++ b/Documentation/x86/x86_64/index.rst
@@ -13,3 +13,4 @@ x86_64 Support
    5level-paging
    fake-numa-for-cpusets
    cpu-hotplug-spec
+   machinecheck
diff --git a/Documentation/x86/x86_64/machinecheck b/Documentation/x86/x86_64/machinecheck.rst
similarity index 92%
rename from Documentation/x86/x86_64/machinecheck
rename to Documentation/x86/x86_64/machinecheck.rst
index d0648a74fceb..e189168406fa 100644
--- a/Documentation/x86/x86_64/machinecheck
+++ b/Documentation/x86/x86_64/machinecheck.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
 
-Configurable sysfs parameters for the x86-64 machine check code.
+===============================================================
+Configurable sysfs parameters for the x86-64 machine check code
+===============================================================
 
 Machine checks report internal hardware error conditions detected
 by the CPU. Uncorrected errors typically cause a machine check
@@ -16,14 +19,13 @@ log then mcelog should run to collect and decode machine check entries
 from /dev/mcelog. Normally mcelog should be run regularly from a cronjob.
 
 Each CPU has a directory in /sys/devices/system/machinecheck/machinecheckN
-(N = CPU number)
+(N = CPU number).
 
 The directory contains some configurable entries:
 
-Entries:
-
 bankNctl
-(N bank number)
+	(N bank number)
+
 	64bit Hex bitmask enabling/disabling specific subevents for bank N
 	When a bit in the bitmask is zero then the respective
 	subevent will not be reported.
-- 
2.20.1

