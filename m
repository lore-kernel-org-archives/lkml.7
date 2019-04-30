Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53BEC04AA8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BAE32081C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556657842;
	bh=dkIhAle8qX76xmaTiBwFHb7qvyHAQhRDuefdwArOvsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=GYiBrXcV4YxCbOeEm0a6Dv+cCHXvfELmQV1R1EvzjuJ5QlYZqw5O6+sCuYile75Dv
	 NVEzBCDyLgEnCszbg1uf5ODqgKm1yzSFxKZi5xdih3cCv9ryOS0VUzJ6egfXmuqFwR
	 Q9sklR7mLYZJ2PFRE3sFB5pNwqagCTXDyC6yvmIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfD3U5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 16:57:21 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45648 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfD3U4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 16:56:18 -0400
Received: by mail-io1-f68.google.com with SMTP id e8so13426495ioe.12;
        Tue, 30 Apr 2019 13:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=J4b7TkIYUMmkQjs+CQkshNUOKz4889qj9fmJ7q/gBYo=;
        b=Jb40JJhYltOEpMcVv9WDpX50V3++aDjxjdtwfySKFPk1aAa1Hl9iTQ/YdI7ULV/S3X
         zciUrLHo5FZrSuJr2rv13Zzk8cd42Tr0yn23DjPfsZLgnTO1teXsLmhRl7KP1MvlmEdg
         FRqqcZqkr6CVIZskWbx9qbkgfJCV2WjswR93VKtA0BatAYqhBvdQGdQwGduWkDiLJgYB
         Vx/bzOKWLokY0dACNLCPH8rW+39RHZS/oMLfZ//Un6fAEr0WPYb/or2mjn9MAKSc4KYa
         GqX8RFnmWuK7169qeY7xG9PkJCoxLmB1ptczmjAVE61gOWSqro1eSC1rIqV1Z0rhJbBj
         50Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=J4b7TkIYUMmkQjs+CQkshNUOKz4889qj9fmJ7q/gBYo=;
        b=lQnqAxcZyMQJzOwFv49zNPoXohU4LTxR+HOdkdreQv4aZrP/lvViZ6i6Nql4E7LfAV
         DQmmWNOCT926Aw4CBmSKRTfNxSN+IFMdFAKzqvquy+297/+KIi8w1g3JgQS/OeDOsYYZ
         oiIiMIo5jb8t0QCVZYCspKPQ1YNW1UcQKpdW9dS7au2cHNgg+JNZtWcGbCprD2f6GeBe
         esoXdP84YhBgl+2gRQZ5iCy9laxKjn/ZYPMYvqV1iAZJm/FUeR9xvprehXjmv6xSe0d0
         L2xdcsQhuv0eTxnoETknkzAIYiAsip2c4MR8kapo+Tn2giedNE/weyCjmm0EavFni97w
         QGfA==
X-Gm-Message-State: APjAAAUk5XihlaU4T/BhRaeZ1SwVrJq+J8pSVtoEUdIxFw4oSn3CTKgJ
        gToP0iZp9hO4luskUasqU0U=
X-Google-Smtp-Source: APXvYqxMCsVK0NkgdUUKWWel0wgI7AqaCh3enXbxBLYLpsBrS9cwNHB5IjSctfECi3MkHgdpwA3J5A==
X-Received: by 2002:a6b:190:: with SMTP id 138mr2332134iob.162.1556657777475;
        Tue, 30 Apr 2019 13:56:17 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id s7sm9799349ioo.17.2019.04.30.13.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 13:56:16 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH 02/14] topolgy: Simplify cputopology.txt formatting and wording
Date:   Tue, 30 Apr 2019 16:55:47 -0400
Message-Id: <83c4eb6a04c53684cdb3539272f964611abde73f.1553624867.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <75386dff62ee869eb7357dff1e60dfd9b3e68023.1553624867.git.len.brown@intel.com>
References: <75386dff62ee869eb7357dff1e60dfd9b3e68023.1553624867.git.len.brown@intel.com>
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

