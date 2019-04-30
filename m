Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC79C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD6621783
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556657837;
	bh=l/tmxHaB6g3bmcfsuX4ry3/EbQQi7feeh6ge4SLvYBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=sxqayZ8DDATSIM+HKzVXI92mYtcmnDzcnurGMEBrX6ZBsy4ABzDUgu/eeGL/c5xJe
	 JueKn/iRS5deko353GSIFLTmupAUO6EXrXJxv5AmxVJkspT0MJ23j0vSXNoEa2y2sw
	 OMhXl9SM8GGvZ+gK6/4FRhw4VeUI9Uzq76Nru+hk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfD3U5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 16:57:15 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40227 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfD3U4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 16:56:22 -0400
Received: by mail-io1-f66.google.com with SMTP id m9so7076604iok.7;
        Tue, 30 Apr 2019 13:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=BK2WmqeIaTnF7dVEhLC6AktVLWES0Us9v9VW0JdEI+Q=;
        b=sx1jElAQZ29WNtRkuMnVsrsZudAkoddtoEJJQY/TMx0hOr+iiDptPyS97Kdg2BvqvI
         ZR+JLd/t0ncbfEDjnlIh6zMzzIH7ixCzOg4PqKAmci37JSbfGB61G4UlMDivaXvMvN3Z
         9sr0aY5lwriLcmZkqmmPuhQyHjUlq2lqtRransqQSJQDLbOqXf5xMyuMp2Jrl1ZuOPlj
         W9/TZP9TCvUuvcpAbAtI4Uo8B42TWsc3aKu2UrUraMxkolywZLhDWM+FMkh+BjWPW1oW
         m50RHX0Vt722LDHbmiMZnLfgjw2HRUPaaN3Xhp5us/OOPO74aBUau7JkWBUKc1EPQsvW
         ik3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=BK2WmqeIaTnF7dVEhLC6AktVLWES0Us9v9VW0JdEI+Q=;
        b=F9G0+n+lmg/xJ+lIWAOcJYr6A9WlcQKC8KkV8Vvo9K8kc+g3yxX1VoJrPVuCVWxnjj
         XhXV5UhHrQKzRLm1UHE7CsKo476CskVWRgWjRxYPy9r5xhMYvyw+2qsF7ikvSDDleA2H
         2m89kNoV1Dpp+0oYeeZke2X8p+93T8ipV4yZsl3Ter0dyX+j+6Ptte/xENNV/DXPG2Uv
         kjBjZJBOnjdpy9pZdvkl0NOlV4JfgGaSh3lSjIKAIcwMiAc/9YltQLdhwITvsna5YQBZ
         gEQqfurVN+957zGm0CWL62b1g7MxeOST0ny2AVWdgc8SqV7Y3XcaJtxrcfeqMD+PVSLM
         70JA==
X-Gm-Message-State: APjAAAXjGNGwuQJsD0l86GVd5rYPdns+L4KtxtDTgDheizk7/6NeRgaL
        EWcOl8V+VSLlrPfs790336Y=
X-Google-Smtp-Source: APXvYqxg8OHQv3/E3UPknaszRy2x4SiRWw1YquRLaDEojEvbCpxSI6H4p0zf4HVnBt/Rgy38DJ8XfQ==
X-Received: by 2002:a6b:93d7:: with SMTP id v206mr4485360iod.200.1556657781220;
        Tue, 30 Apr 2019 13:56:21 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id s7sm9799349ioo.17.2019.04.30.13.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 13:56:20 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH 05/14] cpu topology: Export die_id
Date:   Tue, 30 Apr 2019 16:55:50 -0400
Message-Id: <425994cdcd48297aaeacc086766f39503556c0ac.1553624867.git.len.brown@intel.com>
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

Export die_id in cpu topology, for the benefit of hardware that
has multiple-die/package.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: linux-doc@vger.kernel.org
---
 Documentation/cputopology.txt | 15 ++++++++++++---
 drivers/base/topology.c       |  4 ++++
 include/linux/topology.h      |  3 +++
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/cputopology.txt b/Documentation/cputopology.txt
index cb61277e2308..2ff8a1e9a2db 100644
--- a/Documentation/cputopology.txt
+++ b/Documentation/cputopology.txt
@@ -12,6 +12,12 @@ physical_package_id:
 	socket number, but the actual value is architecture and platform
 	dependent.
 
+die_id:
+
+	the CPU die ID of cpuX. Typically it is the hardware platform's
+	identifier (rather than the kernel's).  The actual value is
+	architecture and platform dependent.
+
 core_id:
 
 	the CPU core ID of cpuX. Typically it is the hardware platform's
@@ -81,6 +87,7 @@ For an architecture to support this feature, it must define some of
 these macros in include/asm-XXX/topology.h::
 
 	#define topology_physical_package_id(cpu)
+	#define topology_die_id(cpu)
 	#define topology_core_id(cpu)
 	#define topology_book_id(cpu)
 	#define topology_drawer_id(cpu)
@@ -99,9 +106,11 @@ provides default definitions for any of the above macros that are
 not defined by include/asm-XXX/topology.h:
 
 1) topology_physical_package_id: -1
-2) topology_core_id: 0
-3) topology_sibling_cpumask: just the given CPU
-4) topology_core_cpumask: just the given CPU
+2) topology_die_id: -1
+3) topology_core_id: 0
+4) topology_sibling_cpumask: just the given CPU
+5) topology_core_cpumask: just the given CPU
+6) topology_die_cpumask: just the given CPU
 
 For architectures that don't support books (CONFIG_SCHED_BOOK) there are no
 default definitions for topology_book_id() and topology_book_cpumask().
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 5fd9f167ecc1..50352cf96f85 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -43,6 +43,9 @@ static ssize_t name##_list_show(struct device *dev,			\
 define_id_show_func(physical_package_id);
 static DEVICE_ATTR_RO(physical_package_id);
 
+define_id_show_func(die_id);
+static DEVICE_ATTR_RO(die_id);
+
 define_id_show_func(core_id);
 static DEVICE_ATTR_RO(core_id);
 
@@ -72,6 +75,7 @@ static DEVICE_ATTR_RO(drawer_siblings_list);
 
 static struct attribute *default_attrs[] = {
 	&dev_attr_physical_package_id.attr,
+	&dev_attr_die_id.attr,
 	&dev_attr_core_id.attr,
 	&dev_attr_thread_siblings.attr,
 	&dev_attr_thread_siblings_list.attr,
diff --git a/include/linux/topology.h b/include/linux/topology.h
index cb0775e1ee4b..5cc8595dd0e4 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -184,6 +184,9 @@ static inline int cpu_to_mem(int cpu)
 #ifndef topology_physical_package_id
 #define topology_physical_package_id(cpu)	((void)(cpu), -1)
 #endif
+#ifndef topology_die_id
+#define topology_die_id(cpu)			((void)(cpu), -1)
+#endif
 #ifndef topology_core_id
 #define topology_core_id(cpu)			((void)(cpu), 0)
 #endif
-- 
2.18.0-rc0

