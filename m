Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E79C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AD721783
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556684686;
	bh=l/tmxHaB6g3bmcfsuX4ry3/EbQQi7feeh6ge4SLvYBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=RyzelHGGWlnpRNGrkZnYlonm98e6zhzS0iOo9sJ1HMpaLVtVmQmxTEPapjuWtPKEu
	 ljtVs81+/I6Yupr1dIuO6Hri75iojMZc5reQpKs9wzAZ5a8C0QLOyYwo6b2s2LGepL
	 hKWOIrO418iLvz6wPJtSW75Hs36qyYyemoMjFeZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfEAEYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 00:24:45 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40834 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfEAEYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 00:24:42 -0400
Received: by mail-it1-f194.google.com with SMTP id k64so8370085itb.5;
        Tue, 30 Apr 2019 21:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=BK2WmqeIaTnF7dVEhLC6AktVLWES0Us9v9VW0JdEI+Q=;
        b=ZflL5plyQPtPgeKSsPzaQzePVoXQSUqrXvuDP0S6eIdQWq+PzmznAETv8I1mLrvRkM
         /WYdDlE/D4BmVTd7bI6eYtZYCCDBymnkCnwzypsMRC4qW0RohyluF/EN2DuH4zjRJOun
         CNgorjZzU6+EKKjdtydGhGwbcn9Milh8Ox49mvjKE+hiSvME49xDNG+j9lDHjXRZv07R
         3UibTIj8PSzxrv3t0LtzMMbmL+mfLBEI/fpvRxhv/XogQUvZIg+XyoZYsDvanFIBvjh5
         ZnxhicHZAV1WMwqsJeRF5NkrbbDOh1LcWe3hPT9A+FG87K6TsVLiRtLFBksnkdMSQryd
         o+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=BK2WmqeIaTnF7dVEhLC6AktVLWES0Us9v9VW0JdEI+Q=;
        b=b2f1acpJK6I8YuoRHMblwHVU7J1Mi4WKzVKIlTURaGOICC4EgTcYztJ/kQxzTPd/hB
         VM/GreWosWfBFLeb0ZCgYKCHTN5iP5h9XckKFLjQTygdx3vMHU8oTYr/Z6Rw4fKcnAvB
         ScjFD1MhU1GEfTMkwAjRY0vvf/GFm2hbOmLMWwXdVO0tyXAPedFllUY9QnpzV9mjDxG8
         vTXfbIiZvCT+SNm3/PPFeWHejxEZZvwtScO1I6DpkgtYfeJ2VBxbB72CgJLYHHJ72aQ+
         8IUrB/r16dHCmbi0XZZhw4ZlNBAI8sEWLZtqHmH7EPRmpU8OazWOtCHfm0SeYSfLYOyI
         60Eg==
X-Gm-Message-State: APjAAAWlFB3OtxBNVShnasdjIR0jT1pti1Coh6kHB15g0Sw8sTVapu1s
        jK/EeiFS9zVfpiH6qolo9CU=
X-Google-Smtp-Source: APXvYqxLtBhlrjj9zIjZDj5qKFnsPbZyZh7PwDsCgXm/ZCGF4C1DVWcnAkSwK2ELUqlAsYhsuAHjKA==
X-Received: by 2002:a24:58c:: with SMTP id 134mr6397210itl.103.1556684681419;
        Tue, 30 Apr 2019 21:24:41 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id b8sm2569728itb.20.2019.04.30.21.24.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 21:24:40 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH 06/18] cpu topology: Export die_id
Date:   Wed,  1 May 2019 00:24:15 -0400
Message-Id: <a8c0475ef3ff1f026c31baa210daa280ce0aaf59.1556657368.git.len.brown@intel.com>
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

