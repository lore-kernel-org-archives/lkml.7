Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F61CC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B3C20989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eK47TDSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfEHPYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:24:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33496 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfEHPYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:24:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id z28so10683950pfk.0;
        Wed, 08 May 2019 08:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YaNnLqU9o2lpY1nR/3WwmAgKR0IVYxRkeI3qUXiAw/Y=;
        b=eK47TDSBmmLfOM2SKT/6s+RUvjRuOlQUK+GUZSwHo6k1qQ28eUx0gRlBbnbHhwnxmw
         NUk5g+dnBuNcSpzMteLb91QH7bSc8uGjwVl+YG8XwRdrz4WUpT5wEyQqFygqmq52Ot/k
         /uL4e0jzspdtXAO0/LMtvlRErLnTHqb5MQeP95p7pzvS0Kpsh/lpsWpHzA7cBfX2nUbL
         6Sz7ljPZwAkl80Q/rFaJ0rV44rKD9DhueJ75fOfjg/e6X4j1FEZ5hx+1kYOex+V0jXFf
         oImWaPivjsT8efG7bbESFkiThW3Lgox/V8COsbY9SNSpR8kR+wFW8V+1yQqBdAzXByfR
         d+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YaNnLqU9o2lpY1nR/3WwmAgKR0IVYxRkeI3qUXiAw/Y=;
        b=Yf4WJvI3L4V1alI8ekvgh5teN6i9/Jfi/TKn9C+GtyrAD+q223tKIJ+oQSU15n6RHA
         0taeOpeYcELNST+5JniSVgOapkQZ0odo8bl4nMqdVHZ7y2efpsWDhIiH3+mHyJNp47io
         efL8KrW++SY8rPfUNdOejmmlr9ec3IuknfSRF4EO5fOMTPts/h/hjvLwcCSlWg90/HSR
         luSZy9RAVnORN9JlgYAHZeSPKtZLnk+RfmGGrBHvZwPng5/9vIUD9rzbUiZBxQmWQqiV
         ZHlF6B3rDXy8HhmCuoU4ndugxY69anROFax7RVWuyuDrvzYxNWYvfRV9nlPvO0O2ARKO
         2ZUA==
X-Gm-Message-State: APjAAAViJaH44GZckXIQ3gaadhXw11b1tMwWa9NgQ5HNi03ZTZWi7Oal
        Ob72nzsUhFJj8+ZzpGVPJ7c=
X-Google-Smtp-Source: APXvYqxz7m6tnp8iH5lg1OEJjeMm7t2YshZ72xQhX6AjLHNkdLZqu+IJCb6tlbI0bHgIO9qkkAdYxw==
X-Received: by 2002:aa7:8384:: with SMTP id u4mr48374052pfm.214.1557329092431;
        Wed, 08 May 2019 08:24:52 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id o73sm7459360pfi.137.2019.05.08.08.24.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 08:24:51 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v4 27/27] Documentation: x86: convert x86_64/machinecheck to reST
Date:   Wed,  8 May 2019 23:21:41 +0800
Message-Id: <20190508152141.8740-28-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190508152141.8740-1-changbin.du@gmail.com>
References: <20190508152141.8740-1-changbin.du@gmail.com>
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

