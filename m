Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0402BC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C338D2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqMTh4Ij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfEBHMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:12:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45865 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfEBHMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:12:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id i21so631472pgi.12;
        Thu, 02 May 2019 00:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YaNnLqU9o2lpY1nR/3WwmAgKR0IVYxRkeI3qUXiAw/Y=;
        b=QqMTh4IjiuCKjE+ZXpNCaPibFnWWmDjJLBu9GCvAalwli10RsMnTFi9cTdQgKKooQY
         8QVkPA0UnVk+YRWACLFtTIIw5qUibNjIPqhO8LFQgBzZZ2zmmejt83gJGy3m/vBaHefs
         3KQ86O6s5Q4agajUQgxd8ICMIBeumAgpDOAjygvb8mbj2JXT32KBD4HHxticNiYMrYxN
         s+7XUSE7KaHknapfG8q1zEcpypN2s7iKg5JQM5EwCLyXkQNene9h/l+PjDHW6jypQH8b
         wn6Fe6bdMpJkF70u27FkS911N4jjHTX9PWoz+LFQNdHryZJxPY5iRlhhGkuJ/miIST8S
         d4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YaNnLqU9o2lpY1nR/3WwmAgKR0IVYxRkeI3qUXiAw/Y=;
        b=e+IJKJQnJK/7hmTRpKArr1g8uLJ8hIe240QvWFAiKEETGtOnHtN9XUGAgEEwizy7dj
         O7vvNyjuKCAzW/gP+ARKCzT955Lww4L7L3kYHpKBrsLsdy2Q9iXTKfve3+QY3luoMFCj
         0Cx2bJSSVuJ+/pnQ90Sn0VMNV7Rn7I1jnXBRyersC6u93qgTnAbZpIcRRCliR888EuT4
         jP/uQ/5EfIUfeQZsNDraVDJtP8SxbRB6EkcsZvl7QfPbPXBE+6SsVtZ/OG9wZabuETIT
         LGViTkAEAOxbd68kQeRVebkA+VM+rgqMz3Kicp2ciLttRonY4YnGb2xi6E7bKrDoLXZx
         i5HA==
X-Gm-Message-State: APjAAAWHRKGnT865sRTWGsNJ/r2VGz+j5EFeD/f8RylQRV75sUV6rRQ2
        iJ9NvlixbHMQsTgT4PuiaaQ=
X-Google-Smtp-Source: APXvYqxNcOufLKQ1FgALFEGNWwmWDEakWbES4s56JUN0KpSWcfLerd1IPflwOE2uHoEnjFk9HY8rTg==
X-Received: by 2002:a63:1b04:: with SMTP id b4mr2359807pgb.305.1556781127085;
        Thu, 02 May 2019 00:12:07 -0700 (PDT)
Received: from laptop.DHCP ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id u24sm4686976pfh.91.2019.05.02.00.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 00:12:06 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v2 27/27] Documentation: x86: convert x86_64/machinecheck to reST
Date:   Thu,  2 May 2019 15:06:33 +0800
Message-Id: <20190502070633.9809-28-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502070633.9809-1-changbin.du@gmail.com>
References: <20190502070633.9809-1-changbin.du@gmail.com>
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

