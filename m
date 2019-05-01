Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A470C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E0520866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556684681;
	bh=dkIhAle8qX76xmaTiBwFHb7qvyHAQhRDuefdwArOvsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=E8gRAO8oWKIpJzvcKfYO6RpZXVN8hkk+sRM04NBiVU1sZ5XRNDkzZlj5gjt7X9Ws0
	 Q2/RAswmx70EeJXWAhDiKHZn2s15IteFq9zMswcfocakGzPD01adb+yBhFXxWXyNTB
	 H92GpSZe9H4KTcIQ8lR/KMkmQDxt9X92UNyBzdyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfEAEYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 00:24:40 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45261 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfEAEYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 00:24:37 -0400
Received: by mail-io1-f66.google.com with SMTP id e8so14059011ioe.12;
        Tue, 30 Apr 2019 21:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=J4b7TkIYUMmkQjs+CQkshNUOKz4889qj9fmJ7q/gBYo=;
        b=HcWPvHDQ7xJf7yrnow7qP+NR98kxvIXAAv9JX7CGw8LUAI74bjKo1TtnDTG9MSZmQJ
         wqnUAQc5dRB2P49xgr1wFkL9b2VSvHnis5UlXJIsAsuCUsyjz/JIcbSnNMQg0RWV3YZp
         ncJsAeYZEZfQg2xQqsfflLRtog5X79HHFCqUYqQAbuDIsjZ2nuf+xSWOeYiNOdfW0+TI
         Ki0cI6C/IRb3v/odIWZOYWaVZjjYNgatGAdyiwp2dPnPxnKMyBmXzRjqFTsLmX040Uqk
         1IJHCz1je/4XxU/ZLg9aPXzuO1sBQRz/jn8esKAN+hGVAFRsGfHyhBGTDEDlt+oowgqz
         s8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=J4b7TkIYUMmkQjs+CQkshNUOKz4889qj9fmJ7q/gBYo=;
        b=BJ1SKBZvhOOld7VhqFqfoVZNL+3BI+UoBYjnds0apS+MjzRh0Rklq0Pk+JmZwj5VWP
         c47pkVFP8ngIFnTyFziQIoY40qI28esMc0Puy6gS54LaGKZ/0bY2wbLbqQ9LUh9C1Wff
         fIvzzU4/z1UcQ+OaMisBJDKXVVtd19bLpnyKRBfhVY/xxTy4aJnSMbEyS47504LgWUjm
         PW/deE2Llvcl2GQay4qXWDuUh3p59KUR0uUdCvq8t7RdLqCdNaGlC+zsVcDMmfwXjI06
         2NMW5tPdgY+dJMjSLZfxjtvjGlEiihWdQ0XCXXGSP5eJTRtyl7HMqWJ1YD6eSOSgYo3U
         WwZQ==
X-Gm-Message-State: APjAAAW1b6Q3+/ztAtblvIvADV3+WdAntHB11ny7c2GTHMi7XrIkutGh
        wiJYvk4eHq0xNkK/QvfXBRI=
X-Google-Smtp-Source: APXvYqxYIK7SiHNZSLVzElf26DCeHT4mspKGbdeq2UUaKvsLrRoasDxg7311ai+L3rrOBb+sXi3uAw==
X-Received: by 2002:a6b:5909:: with SMTP id n9mr34400029iob.42.1556684676714;
        Tue, 30 Apr 2019 21:24:36 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id b8sm2569728itb.20.2019.04.30.21.24.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 21:24:35 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH 02/18] topology: Simplify cputopology.txt formatting and wording
Date:   Wed,  1 May 2019 00:24:11 -0400
Message-Id: <1feeb124ad50bac8093e78240a6de6dbf5ff3456.1556657368.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Syntax only, no functional or semantic change.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: linux-doc@vger.kernel.org
---
 Documentation/cputopology.txt | 46 +++++++++++++++++------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/cputopology.txt b/Documentation/cputopology.txt
index c6e7e9196a8b..cb61277e2308 100644
--- a/Documentation/cputopology.txt
+++ b/Documentation/cputopology.txt
@@ -3,79 +3,79 @@ How CPU topology info is exported via sysfs
 ===========================================
 
 Export CPU topology info via sysfs. Items (attributes) are similar
-to /proc/cpuinfo output of some architectures:
+to /proc/cpuinfo output of some architectures.  They reside in
+/sys/devices/system/cpu/cpuX/topology/:
 
-1) /sys/devices/system/cpu/cpuX/topology/physical_package_id:
+physical_package_id:
 
 	physical package id of cpuX. Typically corresponds to a physical
 	socket number, but the actual value is architecture and platform
 	dependent.
 
-2) /sys/devices/system/cpu/cpuX/topology/core_id:
+core_id:
 
 	the CPU core ID of cpuX. Typically it is the hardware platform's
 	identifier (rather than the kernel's).  The actual value is
 	architecture and platform dependent.
 
-3) /sys/devices/system/cpu/cpuX/topology/book_id:
+book_id:
 
 	the book ID of cpuX. Typically it is the hardware platform's
 	identifier (rather than the kernel's).	The actual value is
 	architecture and platform dependent.
 
-4) /sys/devices/system/cpu/cpuX/topology/drawer_id:
+drawer_id:
 
 	the drawer ID of cpuX. Typically it is the hardware platform's
 	identifier (rather than the kernel's).	The actual value is
 	architecture and platform dependent.
 
-5) /sys/devices/system/cpu/cpuX/topology/thread_siblings:
+thread_siblings:
 
 	internal kernel map of cpuX's hardware threads within the same
 	core as cpuX.
 
-6) /sys/devices/system/cpu/cpuX/topology/thread_siblings_list:
+thread_siblings_list:
 
 	human-readable list of cpuX's hardware threads within the same
 	core as cpuX.
 
-7) /sys/devices/system/cpu/cpuX/topology/core_siblings:
+core_siblings:
 
 	internal kernel map of cpuX's hardware threads within the same
 	physical_package_id.
 
-8) /sys/devices/system/cpu/cpuX/topology/core_siblings_list:
+core_siblings_list:
 
 	human-readable list of cpuX's hardware threads within the same
 	physical_package_id.
 
-9) /sys/devices/system/cpu/cpuX/topology/book_siblings:
+book_siblings:
 
 	internal kernel map of cpuX's hardware threads within the same
 	book_id.
 
-10) /sys/devices/system/cpu/cpuX/topology/book_siblings_list:
+book_siblings_list:
 
 	human-readable list of cpuX's hardware threads within the same
 	book_id.
 
-11) /sys/devices/system/cpu/cpuX/topology/drawer_siblings:
+drawer_siblings:
 
 	internal kernel map of cpuX's hardware threads within the same
 	drawer_id.
 
-12) /sys/devices/system/cpu/cpuX/topology/drawer_siblings_list:
+drawer_siblings_list:
 
 	human-readable list of cpuX's hardware threads within the same
 	drawer_id.
 
-To implement it in an architecture-neutral way, a new source file,
-drivers/base/topology.c, is to export the 6 to 12 attributes. The book
-and drawer related sysfs files will only be created if CONFIG_SCHED_BOOK
-and CONFIG_SCHED_DRAWER are selected.
+Architecture-neutral, drivers/base/topology.c, exports these attributes.
+However, the book and drawer related sysfs files will only be created if
+CONFIG_SCHED_BOOK and CONFIG_SCHED_DRAWER are selected, respectively.
 
-CONFIG_SCHED_BOOK and CONFIG_DRAWER are currently only used on s390, where
-they reflect the cpu and cache hierarchy.
+CONFIG_SCHED_BOOK and CONFIG_SCHED_DRAWER are currently only used on s390,
+where they reflect the cpu and cache hierarchy.
 
 For an architecture to support this feature, it must define some of
 these macros in include/asm-XXX/topology.h::
@@ -98,10 +98,10 @@ To be consistent on all architectures, include/linux/topology.h
 provides default definitions for any of the above macros that are
 not defined by include/asm-XXX/topology.h:
 
-1) physical_package_id: -1
-2) core_id: 0
-3) sibling_cpumask: just the given CPU
-4) core_cpumask: just the given CPU
+1) topology_physical_package_id: -1
+2) topology_core_id: 0
+3) topology_sibling_cpumask: just the given CPU
+4) topology_core_cpumask: just the given CPU
 
 For architectures that don't support books (CONFIG_SCHED_BOOK) there are no
 default definitions for topology_book_id() and topology_book_cpumask().
-- 
2.18.0-rc0

