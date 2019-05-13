Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1AEC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC66208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557770417;
	bh=GuAWVPYojUo1qALE4tEBG0R4gGm3PyPTOjkMC+Mf9uM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=dTQn8tXqWzgjg1gtfNoJnfAyvCdxkEJEkqIkW00HW51Q4RPT0it4vjtenshgVo9vl
	 9eqHFv8YFjbGp/wguyG7mqN+/02atShJzwgBJ6GfZhm0vIahPkJxFMbLYB1U6Qd/X/
	 sJLYkoEN1S2BYLzF89VgaabNMPync65Uh7gpFSjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732126AbfEMR7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:59:37 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34046 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfEMR7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:59:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id w7so6867488plz.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 10:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=aNQB0qvtiJDPOekMEIWJdUXL8B2EPHtpWXUL22B7EP0=;
        b=EDWeZdRQ4APPef2t/EAB4C+buWvmsO9JTHrs1OKJg8xMJaPLVkrmdkjyX9MM9xv259
         G3heh5V+uJSxwOFff9o+7WbKVFcMw9gToRuCORPjJAcKUwhpsGwzsc0Un81w5sFXTsB3
         8NCdD8d6Yd5N7s7vDEvEekPfKX7Uq4JPaKFb+AHcZJqv2fW7Vo8a4kT+VahX3Tx+aNfh
         zRe1CID9V2p29lN9Q5vpkE+P2m2SvMlfNwTd++pjKeWQZYZx4fwcGV3IUFgSMblEdo+c
         c8n2LujtsT7SsVW64fQZwMhcVbFSI31BU8muWLbKob0n40WwvgVspxHN8R/tl7Crfp3k
         wt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=aNQB0qvtiJDPOekMEIWJdUXL8B2EPHtpWXUL22B7EP0=;
        b=InAPhoEmmkWQwA+IfSR8QYSWT14sgfXL0F/DJGlXeX4PbKuHsRg94gilimtjg9POvo
         BhDSPdWTT/jNc819BrzWFXgXah+o6qMGFuZZ5FLCjdm6+KCfZIrlErsA/7s49bu6Wr9D
         C5YVU0bsFRr0r6xA8PI1oXMyE1koPFdudmcWl7drA8KuuDOk9yagz7RtWDaDgRI5P4V9
         mkp7qtQSOF5sBEwPFdJxpW4GXY0LVgfgPA49xakscgVhBVr3iaN6iB0e/b81TdEEnbaf
         Rvqia0+IrFDjxFrYJwFVib+KIM1o6pMfr/Y52ZE+v6qaxkxqgGzdPM1EzSgslhouZkVz
         UStQ==
X-Gm-Message-State: APjAAAVXPMhBe5hp3EORyFd1nKNoO6bF+xMXURdBywXqj3EeafbpEE6R
        w/U10orfmokH9hsNqLDdxdQ=
X-Google-Smtp-Source: APXvYqzHZC/iohzaPiPJD7ya4OXgF2nmaSBhdbVjlDJsbNDm8ag9uP80neDHg6wx+lLKfjzvKjJkyQ==
X-Received: by 2002:a17:902:6b:: with SMTP id 98mr32859598pla.271.1557770371423;
        Mon, 13 May 2019 10:59:31 -0700 (PDT)
Received: from localhost.localdomain ([96.79.124.202])
        by smtp.gmail.com with ESMTPSA id s12sm9536266pfd.152.2019.05.13.10.59.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:59:30 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH 11/19] topology: Create package_cpus sysfs attribute
Date:   Mon, 13 May 2019 13:58:55 -0400
Message-Id: <d9d3228b82fb5665e6f93a0ccd033fe022558521.1557769318.git.len.brown@intel.com>
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

The existing sysfs cpu/topology/core_siblings (and core_siblings_list)
attributes are documented, implemented, and used by programs to
represent set of logical CPUs sharing the same package.

This makes sense if the next topology level above a core
is always a package.  But on systems where there is a die
topology level between a core and a package, the name
and its definition become inconsistent.

So without changing its function, add a name for this map
that describes what it actually is -- package CPUs --
the set of CPUs that share the same package.

This new name will be immune to changes in topology, since
it describes threads at the current level, not siblings
at a contained level.

Signed-off-by: Len Brown <len.brown@intel.com>
Suggested-by: Brice Goglin <Brice.Goglin@inria.fr>
---
 Documentation/cputopology.txt | 12 ++++++------
 drivers/base/topology.c       |  6 ++++++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/cputopology.txt b/Documentation/cputopology.txt
index 2ff8a1e9a2db..48af5c290e20 100644
--- a/Documentation/cputopology.txt
+++ b/Documentation/cputopology.txt
@@ -46,15 +46,15 @@ thread_siblings_list:
 	human-readable list of cpuX's hardware threads within the same
 	core as cpuX.
 
-core_siblings:
+package_cpus:
 
-	internal kernel map of cpuX's hardware threads within the same
-	physical_package_id.
+	internal kernel map of the CPUs sharing the same physical_package_id.
+	(deprecated name: "core_siblings")
 
-core_siblings_list:
+package_cpus_list:
 
-	human-readable list of cpuX's hardware threads within the same
-	physical_package_id.
+	human-readable list of CPUs sharing the same physical_package_id.
+	(deprecated name: "core_siblings_list")
 
 book_siblings:
 
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 50352cf96f85..dc3c19b482f3 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -57,6 +57,10 @@ define_siblings_show_func(core_siblings, core_cpumask);
 static DEVICE_ATTR_RO(core_siblings);
 static DEVICE_ATTR_RO(core_siblings_list);
 
+define_siblings_show_func(package_cpus, core_cpumask);
+static DEVICE_ATTR_RO(package_cpus);
+static DEVICE_ATTR_RO(package_cpus_list);
+
 #ifdef CONFIG_SCHED_BOOK
 define_id_show_func(book_id);
 static DEVICE_ATTR_RO(book_id);
@@ -81,6 +85,8 @@ static struct attribute *default_attrs[] = {
 	&dev_attr_thread_siblings_list.attr,
 	&dev_attr_core_siblings.attr,
 	&dev_attr_core_siblings_list.attr,
+	&dev_attr_package_cpus.attr,
+	&dev_attr_package_cpus_list.attr,
 #ifdef CONFIG_SCHED_BOOK
 	&dev_attr_book_id.attr,
 	&dev_attr_book_siblings.attr,
-- 
2.18.0-rc0

