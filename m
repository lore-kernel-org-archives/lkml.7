Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1B3C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E742053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557178104;
	bh=dkIhAle8qX76xmaTiBwFHb7qvyHAQhRDuefdwArOvsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=xjcoxQQ24ThUi15zukWjCS+7s4L5LQeP5yrfEOwOiNqTvMbSnFYCFpOO2AORosEk5
	 O8YGfjRFKCAOOjLhX1eWFzwjislmXLMEzsgyXjtTGc9ZfKpPlXK0l39xg9uTf8NwQQ
	 GFAd88JPipR/Bwdd8HRb9uE15o3lK6N/Npe7yeow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfEFV2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:28:23 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50833 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfEFV03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:26:29 -0400
Received: by mail-it1-f194.google.com with SMTP id q14so22926884itk.0;
        Mon, 06 May 2019 14:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=J4b7TkIYUMmkQjs+CQkshNUOKz4889qj9fmJ7q/gBYo=;
        b=TfnqLI/gfafDJAAfARIlMixQXHLS+dWQOrTiFQIiYeTYGcsSY4vi6Q8/Ac7AeAjEIB
         maQzFGEIT+hm1sLge7BtMVhs7Tl6a6lA6gMLLEl1tPh9h/H+wmeg48WI3QrY5QpbQD8F
         kI9Eu25zbMPNMOaAGCkt/gW7xqYpY02qyVEU9CPwoffVWi11yqx8BFixUjnW51LUd5Xb
         iGr/UOyy0iH3QzkZceOJaDEsjd9dyokBMV7Lhpn1wCcaweR826dGlQt1bo7uebivryIE
         DY6UwYOp9ehreKTYhcz9wClaHFwBw9q79mHD6b7XhjDclFwWZjxJInaG+7JnmR385JYi
         QNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=J4b7TkIYUMmkQjs+CQkshNUOKz4889qj9fmJ7q/gBYo=;
        b=NQd5ewNwLyfBvODFIApZ5AT7kB24Ucktd+Lvr7alZBKh6mwih06Zm6pQaJWFVL6LHQ
         zJQ4lwQY1TqterWp7isPHVw1L0S7umScx/66cRVXBrDHv+HDYSXCbE636JhCiFvo1K4v
         VtrtqmJURi44ie9Lgw0AUYCokSCh5wi/D2uek+3ObjCcDV1cctWdGkhny7qgjF0Nr4BY
         0LPkjB2WUFf7w1S/sFY8WIbDeLZG7jahMKOqwOn8uOnvfuWi0aAm/QRdwdfINmzH9+9t
         yTaQjK0njimEZdnReg+1ZGUwDlWe6oBxctKyvnQomV1B+Q6XrcUwUwk7i/d1yl+xAw3N
         YO4g==
X-Gm-Message-State: APjAAAX016KwbC93rY3wcv/dl3ulp8zcgq/V7GM08U2CCB676Dxc9a7p
        iLMLIcQCjwlZQhepxwI0j1E=
X-Google-Smtp-Source: APXvYqwmgiDt+klHUPw7qig/WhXplhqVJhOnEqzZ1jvEsKBFpyp9runxzvrwSk1E+OCDQ6NIc62kHg==
X-Received: by 2002:a05:6638:29a:: with SMTP id c26mr19070954jaq.140.1557177987475;
        Mon, 06 May 2019 14:26:27 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id v25sm4268009ioh.81.2019.05.06.14.26.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 14:26:26 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH 02/22] topology: Simplify cputopology.txt formatting and wording
Date:   Mon,  6 May 2019 17:25:57 -0400
Message-Id: <1feeb124ad50bac8093e78240a6de6dbf5ff3456.1557177585.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
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

