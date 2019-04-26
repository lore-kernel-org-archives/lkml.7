Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B66C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0652084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNzKym1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfDZPes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:34:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37323 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDZPeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:34:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so1807998pgc.4;
        Fri, 26 Apr 2019 08:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kf9ixwlamGCo6rqFj9rx+UIAO8SMHMWm68PEXOw5I1k=;
        b=rNzKym1lZ66ZW5lsGjGf/GohzG4Pkhhf9rdqdvuI/gtmLqKS67O28dKvYWK1zltHuf
         sLIWswFK6a6WoUBrLE4XSvMMkIK35Jrqlz+pjaEXOqdv0IAgLTrQSwuZa0uFXzOjec+K
         IrSdPAdZIwMEV37zfJfT+ITqAZOS/slTnzL6wmBLlZfsQ4w/TA1otmYyZ2Qn0Qk9ho9B
         tEMQ+bmkj1/FeMbPWJqmMIOhmMtmnPiGJmPqk0nB3z/vbIhDiFVmkqJL9nwIZSOe3+2T
         8BVPcP/9quCa5NRtC80DEP2HQnu6UpK5B2/0xYsTkPKcYaGqlmLJZ97KzFj0sBm+gFcI
         HjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kf9ixwlamGCo6rqFj9rx+UIAO8SMHMWm68PEXOw5I1k=;
        b=OPyxkY/tSU5EQrtlfjmD4b92ZfpybraexY3YzUiBSFXVpXGd13xfz3mYeucz7RsWfZ
         5klm3JqpUV+c/5g2mhjf7tGLzmHwQDRhT889XuXpOZ0DuCYcLyCuRjUGl9JLz/HATwhB
         3rjsJ96KWYT7Ir/V5bOWH19zohVGBUSEIb5hHpPpDG3SQ4x1JhAV0IJm/r2qtdPANC0c
         Mwf3HhqIeN5zhUAS1/S4CTT9D7iFXl+/CY9aexpWfdFa+fo544jNtIoU4igqo3lSXwL7
         ugk0CmJ3sAwALryZbJ18pEHNNSk38RYkZiLQ4gg7q1hbFZjQPUnknx/OI5espYkKNwdU
         L1Kw==
X-Gm-Message-State: APjAAAVudU2QHaAdH08N+vu6alNcTgzx8t/fv+MDXw+QYGadFOwqsbxK
        CbHVlFlXhKHgT9Pql2cKlzY=
X-Google-Smtp-Source: APXvYqwTaO6hHImULiIhZjWVhrcewz2xP2sImhSoBL6dDXz66l5qbd+j3HpTIZNFN1BNRZRHxnUZew==
X-Received: by 2002:a63:fb4d:: with SMTP id w13mr44735497pgj.397.1556292885921;
        Fri, 26 Apr 2019 08:34:45 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b1sm29024833pgq.15.2019.04.26.08.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 08:34:44 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 25/27] Documentation: x86: convert x86_64/fake-numa-for-cpusets to reST
Date:   Fri, 26 Apr 2019 23:31:48 +0800
Message-Id: <20190426153150.21228-26-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426153150.21228-1-changbin.du@gmail.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
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

