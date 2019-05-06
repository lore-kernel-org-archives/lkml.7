Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EA8C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6348C2053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557178062;
	bh=GuAWVPYojUo1qALE4tEBG0R4gGm3PyPTOjkMC+Mf9uM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=BHWq3mrz+SfFi4u8tEw2J9jIYpjo9YNy9Uzef3uXLSQpx5ZBrF2suvG4ykJtgW9o+
	 +DWeHaFykGBJidEDYI+u6X/AQTsgqVPjl8OP0ydndURX+YS1NIra7ZJyEpIEdm5eDs
	 FgAYE+PbFH4etQx+vBPRmnL9gvvOD/OCGsuKcK1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfEFV1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:27:41 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36813 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfEFV0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:26:43 -0400
Received: by mail-it1-f193.google.com with SMTP id o190so5226727itc.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 14:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=aNQB0qvtiJDPOekMEIWJdUXL8B2EPHtpWXUL22B7EP0=;
        b=h6IdtkqhYcafRAYS+YtQLPEbvhnMYZTW0xZ/0AEgyOPpvNi4zn45O/KXEmlsHqIRMM
         Rpu49KF4HnS2vbhdL85UGu7GgGOjyr5+v/troZvGwJ2toW25rzPsltUOiH59G7kb0fMG
         iv1aWk+fqmscbVuHdM3cG2+0rB4VP5IuasABZlG16GvNyBJcaroz6QBlMiIF/YGUDYfw
         ZSAECgrb/9Grt74rD5+ga46hbY4A5yDiVgAPfwEqCaiRb4xhkvBmgAzhW8nVWGRLEY/Q
         2ld6u0xu3Fmx9w/+mv6XPDgtBrVSXj/NY3qWJNZXnb0P90fDDZw1qL2Oue0KJINzekvy
         NIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=aNQB0qvtiJDPOekMEIWJdUXL8B2EPHtpWXUL22B7EP0=;
        b=cllzKC0jUxkFhERTlMfennleh6Xifs0uScVCThu4Udw9TXINHSBpB/GKR1VHVr0v8N
         eh/gbw9qE/Phh5T6QbO48TvIxtJkHK9r6Wuz35TAGHqDvR5eZc0mHOEtWuHw0KID/1R+
         UkZpUB9IG896fPzWWHw0mbUJgB8cPWGrSTjpdKYgRiPvg4lZ+qn+dEUO79NLqtrntsVn
         jo/MOTRmzg0yk7rghKEU8Cz3pRRtysjoagLae6lemyHldsyr0GgwmdDQytNo6MO/hz5x
         lrDxYc9FbZWpz8sG+8IfBfbWU9tgqosM64FXTQdsBLeOPHCapIrItVF8Ix3DvrzxvQXo
         +ihQ==
X-Gm-Message-State: APjAAAWH0Hh8dcvCKrOVGNYpCDweXk/Jm1qbBCdnjMnHE737K2GRH5cb
        5DtUxknBzi66HsORsnCT9sU=
X-Google-Smtp-Source: APXvYqzaKyQLQv/pTIiGe9mGRIEFAF8I8etrJewYAgCBn5AyZnsBBQo70fBC+g/6xoP/Nb33z9/OWA==
X-Received: by 2002:a24:8207:: with SMTP id t7mr21759465itd.78.1557178003004;
        Mon, 06 May 2019 14:26:43 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id v25sm4268009ioh.81.2019.05.06.14.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 14:26:42 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH 14/22] topology: Create package_cpus sysfs attribute
Date:   Mon,  6 May 2019 17:26:09 -0400
Message-Id: <f73bf7714fd1e19c32bc5bec0237f7b15c388684.1557177585.git.len.brown@intel.com>
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

