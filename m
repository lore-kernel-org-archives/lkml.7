Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520A1C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8402166E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557770362;
	bh=l/tmxHaB6g3bmcfsuX4ry3/EbQQi7feeh6ge4SLvYBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=bUNeB28nOga8bgISTFw99vTOgqIV2zyn0MrN2lr//yLdaIRN4SMFrOK9ug0+p6abC
	 GbWbRVF4nv9HIru79PubCKqqh24QBpxjlHA4n/Y/dkX/dz8eTSt1AJ4NbTL3EHCEd1
	 5COMR7arJRb+o+GW9UWtcrysy0I3pElsEUbZ7ALs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbfEMR7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:59:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32837 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732015AbfEMR7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:59:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id h17so7167659pgv.0;
        Mon, 13 May 2019 10:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=BK2WmqeIaTnF7dVEhLC6AktVLWES0Us9v9VW0JdEI+Q=;
        b=LwgdPKNnJu5f/hrj2fjtiMo2UUY3WLqOaa/9j31VeG4FPeZh1EVd6cgHARZ2fQrfjy
         sQeLZp3+gNDD/uAbRyYTA5CYQpO9ogCLIMp1WoonLu/Oxmy7gn6lb/BsJBYvNOnab0eo
         Ndv8sYu9zEagpa/+CCTK1RUGucmwUDrht0yDEQFWetmpMD8w2I/QlXy8Xb+7Y5raG/jy
         GNB6dp2EYgWFYnw+hEPqjT0Up/zXmEaeg+ToupIYWu36ayE+XlL9mDSpajpcCJ8LqMvk
         T+sXNTgX7pyM/gMVc4Tkv6v8hhLhMruUnsw34G4M3h8lgnTr6dmDEbUPnefbP8RKVpI+
         bJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=BK2WmqeIaTnF7dVEhLC6AktVLWES0Us9v9VW0JdEI+Q=;
        b=Rw1Ie8LDz4vJIZvlFs2f+RbsyEVh7MKdjqiAVhOt4QsGZen+xcvYLB1astF2rTV2sU
         ezipBcnWbbdMSoX0BzHPwkeshzn5Z9P4lVXUl6VFDcjKA5rthIhDqU6R62N8oq8gB6yR
         9KfHX+WeGOjweXAGbxLem5/2OhIIjzQbCYKJlxv+r4aCK8O4aKHW1/46lzo4lwPQU3uj
         3YP5EOjgrL3wmIPKDZN784+ZNajNmZmmxyaTTG01WVqiNc5SZ2QVUsGZ4VQhzRV/elbX
         0svdqhCMvpf/gwNMbaPhNf9Lu6s6AjcebE/ktozolrXq35QZdsKB+xcsbXI4Y3//xlLE
         dVyg==
X-Gm-Message-State: APjAAAXxdeCTG76LnfsCIAipP1bV/uV6LWMsd7CNCbfbDv0W3uxwbIDE
        SjohkJHkmF+Y+38VBNG7Nf8=
X-Google-Smtp-Source: APXvYqzJoMn/c3biu55dwvU8DgrJokCwjsNcQwkgOmpuXE35TNDoPIUlTp+wH8A07peJ+722DD6efg==
X-Received: by 2002:aa7:8083:: with SMTP id v3mr36301445pff.135.1557770359598;
        Mon, 13 May 2019 10:59:19 -0700 (PDT)
Received: from localhost.localdomain ([96.79.124.202])
        by smtp.gmail.com with ESMTPSA id s12sm9536266pfd.152.2019.05.13.10.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:59:18 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH 03/19] cpu topology: Export die_id
Date:   Mon, 13 May 2019 13:58:47 -0400
Message-Id: <e7d1caaf4fbd24ee40db6d557ab28d7d83298900.1557769318.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
References: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
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

