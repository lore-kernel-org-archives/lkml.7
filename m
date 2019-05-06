Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B436CC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552242183E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRBEkic2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfEFRMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:12:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35696 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfEFRME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:12:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id h1so6773858pgs.2;
        Mon, 06 May 2019 10:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T5zzGU7rkqKqabRdTGdBNCQkm0jH6dpMGvRhTLzc/tM=;
        b=QRBEkic2qZzG0RSocvqyvc+xY4IpHADtYR9WsI+SdV4Fm08dr9WxgiNqoPhIlwMCl0
         Yuw+3DSk0ZuoaJv70UmI7gA5E+X0Lh90DRzHszIiQlYOBjMG98RfjvqjURApUdJILoS1
         EElNyNZoPp0NbwnXSKPea2bVUrKfsyXOW+08S/UXR7iZh8X7B/qpM5CqGzA7BDXrc2sM
         teDj2D+7JFG496DNL2Efmm3sASnk8gpFTPkZWwZ1FDg6URsSBT+LHIMvV3+3a0xUm87J
         nuuUO3qajlUkDFqb9D8lXch3el6RkLk2M9gI+JUPs+0npNWzJ4+8WlDmbiPkqIn9rllg
         3xGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T5zzGU7rkqKqabRdTGdBNCQkm0jH6dpMGvRhTLzc/tM=;
        b=kVNCw1VAOe67KQW2v6m5Hy/zMZDcKh5vJenYa7H+jENrbInpvNimyuzj/ZRRk2dW4N
         oPvh4nK/LmgvnnSqbWcMJUtn0117l7soY/fxh8TdfUgii8HSfpLBC29+XLIbQDdZwuxg
         HTyf99jCLEfZe8542fpOzhLekEDH3mH+AyvN+ZsGJbpt4a0LjYWJZ/MvMF28kcIgnkVn
         ZCyLI7rl66cGFzwORix9LpioujqR2kGGLuSXob6y7QqEf8LuxLUq5oHOGiOjBi/425DY
         VaYHiVMp+4o3NJWqoo9QbU8suDpZ+ebF1k0hkQq4t3yL7Rfo9Tefx42IzO9lV69ruZbc
         40MQ==
X-Gm-Message-State: APjAAAXUGbIMu0ox49IOERPiWBBeKlYP8DLU9MbRTN1ni4ME8livh4O9
        6/J1pDCD+jkLXtB5JQFVLQc=
X-Google-Smtp-Source: APXvYqw2hMtALNhvmnysvjikCaYW0MGca08pBGmmXo7y/L9ipZsEXNTgKGCrDrtIuW68MAt10jdm9Q==
X-Received: by 2002:a62:d286:: with SMTP id c128mr35441980pfg.159.1557162723420;
        Mon, 06 May 2019 10:12:03 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id h13sm11045680pgk.55.2019.05.06.10.11.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 10:12:02 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v3 25/27] Documentation: x86: convert x86_64/fake-numa-for-cpusets to reST
Date:   Tue,  7 May 2019 01:09:21 +0800
Message-Id: <20190506170923.7117-26-changbin.du@gmail.com>
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
 ...-for-cpusets => fake-numa-for-cpusets.rst} | 25 +++++++++++++------
 Documentation/x86/x86_64/index.rst            |  1 +
 2 files changed, 19 insertions(+), 7 deletions(-)
 rename Documentation/x86/x86_64/{fake-numa-for-cpusets => fake-numa-for-cpusets.rst} (85%)

diff --git a/Documentation/x86/x86_64/fake-numa-for-cpusets b/Documentation/x86/x86_64/fake-numa-for-cpusets.rst
similarity index 85%
rename from Documentation/x86/x86_64/fake-numa-for-cpusets
rename to Documentation/x86/x86_64/fake-numa-for-cpusets.rst
index 4b09f18831f8..74fbb78b3c67 100644
--- a/Documentation/x86/x86_64/fake-numa-for-cpusets
+++ b/Documentation/x86/x86_64/fake-numa-for-cpusets.rst
@@ -1,5 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+Fake NUMA For CPUSets
+=====================
+
+:Author: David Rientjes <rientjes@cs.washington.edu>
+
 Using numa=fake and CPUSets for Resource Management
-Written by David Rientjes <rientjes@cs.washington.edu>
 
 This document describes how the numa=fake x86_64 command-line option can be used
 in conjunction with cpusets for coarse memory management.  Using this feature,
@@ -20,7 +27,7 @@ you become more familiar with using this combination for resource control,
 you'll determine a better setup to minimize the number of nodes you have to deal
 with.
 
-A machine may be split as follows with "numa=fake=4*512," as reported by dmesg:
+A machine may be split as follows with "numa=fake=4*512," as reported by dmesg::
 
 	Faking node 0 at 0000000000000000-0000000020000000 (512MB)
 	Faking node 1 at 0000000020000000-0000000040000000 (512MB)
@@ -34,7 +41,7 @@ A machine may be split as follows with "numa=fake=4*512," as reported by dmesg:
 
 Now following the instructions for mounting the cpusets filesystem from
 Documentation/cgroup-v1/cpusets.txt, you can assign fake nodes (i.e. contiguous memory
-address spaces) to individual cpusets:
+address spaces) to individual cpusets::
 
 	[root@xroads /]# mkdir exampleset
 	[root@xroads /]# mount -t cpuset none exampleset
@@ -47,7 +54,7 @@ Now this cpuset, 'ddset', will only allowed access to fake nodes 0 and 1 for
 memory allocations (1G).
 
 You can now assign tasks to these cpusets to limit the memory resources
-available to them according to the fake nodes assigned as mems:
+available to them according to the fake nodes assigned as mems::
 
 	[root@xroads /exampleset/ddset]# echo $$ > tasks
 	[root@xroads /exampleset/ddset]# dd if=/dev/zero of=tmp bs=1024 count=1G
@@ -57,9 +64,13 @@ Notice the difference between the system memory usage as reported by
 /proc/meminfo between the restricted cpuset case above and the unrestricted
 case (i.e. running the same 'dd' command without assigning it to a fake NUMA
 cpuset):
-				Unrestricted	Restricted
-	MemTotal:		3091900 kB	3091900 kB
-	MemFree:		  42113 kB	1513236 kB
+
+	========	============	==========
+	Name		Unrestricted	Restricted
+	========	============	==========
+	MemTotal	3091900 kB	3091900 kB
+	MemFree		42113 kB	1513236 kB
+	========	============	==========
 
 This allows for coarse memory management for the tasks you assign to particular
 cpusets.  Since cpusets can form a hierarchy, you can create some pretty
diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/x86/x86_64/index.rst
index 7b8c82151358..e2a324cde671 100644
--- a/Documentation/x86/x86_64/index.rst
+++ b/Documentation/x86/x86_64/index.rst
@@ -11,3 +11,4 @@ x86_64 Support
    uefi
    mm
    5level-paging
+   fake-numa-for-cpusets
-- 
2.20.1

