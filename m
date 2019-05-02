Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE52C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3052133F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmvS/53N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfEBHL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:11:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38662 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfEBHL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:11:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so684941pfo.5;
        Thu, 02 May 2019 00:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T5zzGU7rkqKqabRdTGdBNCQkm0jH6dpMGvRhTLzc/tM=;
        b=pmvS/53N0Segq831SAWXTbjtPWaCKskdZrcg6sAOFpTuDJhvmQxfAUbwVKmDHUawf0
         ZilZfWpdAdXcNnCeNh4lvegmVt3IU2e8zh9wVozMDAeRueikafVQpzdbdyBN7HfZIhhn
         EGIKqGDbozGn1ymgQ6E8aWfm9kxk2VqSs+BSGcRfYMx9eETzIhCYXd5vdsgVwUcLQMur
         j1BhCxQxsXis3vgK3do4BaMHKAQ56BuwmRaI5dVQ1syoKSd//LDLBA5rpnrCi2vE/Kuh
         U8CBtCvqdYsx9Z34Huh5nJ4/6WgJ6H+1qyCXcT3dI2qm0tBzGEzux0j2xXR90LQc8jOE
         3otw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T5zzGU7rkqKqabRdTGdBNCQkm0jH6dpMGvRhTLzc/tM=;
        b=tYN32nE+QTjZPCo4a6ROKlZscYBVOxafF5S+f0AfIVS3anm0S3bnBBR26GrE108dI2
         M22z3IhK0KFKSPYhWbBPlKy4KO1zyEYW6j+ckY8d62vD7Syjm4Co3QsXB3kiM5TlQz7R
         RqZGKY1tdM9IkbGcld2Wq8W5gVnRtc1buBt2baaRlQlIvVeFwY6sOVGfLpumMg6HrB6V
         hzOVjVmRFHnuWHLKyz/gznVqoT8qA5jKhRdCzP7wcpFqtuaLdFvpe1ODK4ngGnL5fPfd
         /IgU7od6hJxoaAXgDJWXPLCUx2m2DJ9yzneKPPvDxykM3wMaRlYg5rkIpaC61aTXcraP
         9hPA==
X-Gm-Message-State: APjAAAVisTOg9yZ5uBosO9BOuHtokVk1HzFnIcfiXyLp/mYys7R4BQKd
        pRo4T5PlggM7UBFRzUzRX68=
X-Google-Smtp-Source: APXvYqxEwVO6wdDsRnTA5uxvl/JEH5tlmxKixjMsSHK21FG5S+kiA1pmhaG5rSyF4hOnIEIAkcxT3w==
X-Received: by 2002:a62:e101:: with SMTP id q1mr2517681pfh.160.1556781116826;
        Thu, 02 May 2019 00:11:56 -0700 (PDT)
Received: from laptop.DHCP ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id u24sm4686976pfh.91.2019.05.02.00.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 00:11:56 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v2 25/27] Documentation: x86: convert x86_64/fake-numa-for-cpusets to reST
Date:   Thu,  2 May 2019 15:06:31 +0800
Message-Id: <20190502070633.9809-26-changbin.du@gmail.com>
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

