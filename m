Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FCBC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7353020652
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556657797;
	bh=ygipzWeQ1byKWB/YPZTgoJrIBgR3UXCrn0SjxPKqC9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=BBoVT8aT2wvBIUIM1BglY51HG0jx+NfworcBkaxNRM1gHcDeBpn18nw/QcbtugAIm
	 HsAaRyiTHSfsOqzMYZFdMW+EBRX8ftxRo+r8rI1fK7mp6ejp+8Ui36pXbtnyc2MlYQ
	 2zQ+ybwfBCITqHPmq9ZEiv9pbScRRWV4x7AdmUk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfD3U4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 16:56:36 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37393 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfD3U4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 16:56:31 -0400
Received: by mail-it1-f195.google.com with SMTP id r85so7094257itc.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 13:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=UOf8CohNJSfUCbdQ2Jk27KrUJ13p865bPg08L86Q5ss=;
        b=QXhmghZp4duMsA72NmE28Nr3/Uo2HSprB4WUckxpb4SwVlxghe9II35ZHvI0cIBFX9
         NZzU5n/+NPKnIdAjP9veXNT8i/NCDhWiTf2VfPxKtST2u40ha4hJ87KUDfJ6Ig9vVdCO
         w7AXBRuWULPnYKT+WyBtTF5OCUFHJzyMvQMx7WmEPW5DirOPD2mHaZdP240EK69JAK4Q
         IOja35PSKJmXh3Q0hFGYDGazRTsAsS0Lnm4JTF7Qso+4tB9EZWIDT16OBKK6EdQaa7T8
         PmCNHzpL2BoaOkpwKkIrvpyH2xxvTdcCuAuPGIgxZ321WxGNZUgfxikQ/cnfD/DIbyjO
         Q7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=UOf8CohNJSfUCbdQ2Jk27KrUJ13p865bPg08L86Q5ss=;
        b=t03/ZtVLNWhJ9CcqlP7vCcV/6haiZAysONtl6FS/gJdY9B8UuwjeKYRVSnR/D6AcYo
         3s+VqEvM3ZfLyS1Y6x4sov/nn23SjjUj/D7EgHDycAhdZEOw0uXcGb8Le0zsIxH5dRwA
         xIFLvCi4bytA+I64NeOwYCscE97VgoJjd9PE1GYkVjYWE4CwOwM2G4h52n+0sMLlIF0x
         fKFhRuP3ugq11v3O13FbJI8u6a3PmZ439/CqNKvXsx6PXjxpvEZortf9o6AZUBrmdWUH
         vXPn1DyB63D3bWX7jUZSJ2PoGkAbEy64c5WGUVB1Oullq+CrHXLLLZWCf8k16bDWcApm
         p7VQ==
X-Gm-Message-State: APjAAAXo1WtRDkU6WupCxYJarZxrGYrg/ptOngXUQ5nXbfAEIW4ewS4P
        ZSCFt0PX4aMGTK34/CYhZyA=
X-Google-Smtp-Source: APXvYqzz5FZkFajayX+OjZkRFayMsUtYjyFqCAtvasn+ieDWwlmPRTnechSXjjsveYNMj6ZwdeKyBA==
X-Received: by 2002:a05:660c:288:: with SMTP id s8mr5224409itl.36.1556657790929;
        Tue, 30 Apr 2019 13:56:30 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id s7sm9799349ioo.17.2019.04.30.13.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 13:56:30 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH 13/14] topology: Create package_threads sysfs attribute
Date:   Tue, 30 Apr 2019 16:55:58 -0400
Message-Id: <ac7179ecead6c8619859a727f75b645723a9bade.1553624867.git.len.brown@intel.com>
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

The sysfs cpu/topology/core_siblings (and core_siblings_list)
attributes are documented, implemented, and used by programs to
represent set of logical CPU threads sharing the same package.

This makes sense if the next topology level above a core
is always a package.  But on systems where there is a die
topology level between a core and a package, the name
no longer makese sense.

So without changing its function, add a name for this map
that describes what it actually is -- package threads --
the set of logical CPU threads that share the same package.

This new name will be immune to changes in topology, since
it describes threads at the current level, not siblings
at a contained level.

Signed-off-by: Len Brown <len.brown@intel.com>
Suggested-by: Brice Goglin <Brice.Goglin@inria.fr>
---
 Documentation/cputopology.txt | 8 ++++----
 drivers/base/topology.c       | 6 ++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/cputopology.txt b/Documentation/cputopology.txt
index 2ff8a1e9a2db..a500e25476f4 100644
--- a/Documentation/cputopology.txt
+++ b/Documentation/cputopology.txt
@@ -46,15 +46,15 @@ thread_siblings_list:
 	human-readable list of cpuX's hardware threads within the same
 	core as cpuX.
 
-core_siblings:
+package_threads:
 
 	internal kernel map of cpuX's hardware threads within the same
-	physical_package_id.
+	physical_package_id. (deprecated name: "core_siblings")
 
-core_siblings_list:
+package_threads_list:
 
 	human-readable list of cpuX's hardware threads within the same
-	physical_package_id.
+	physical_package_id. (deprecated name: "core_siblings_list")
 
 book_siblings:
 
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 50352cf96f85..5f4405a08c6e 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -57,6 +57,10 @@ define_siblings_show_func(core_siblings, core_cpumask);
 static DEVICE_ATTR_RO(core_siblings);
 static DEVICE_ATTR_RO(core_siblings_list);
 
+define_siblings_show_func(package_threads, core_cpumask);
+static DEVICE_ATTR_RO(package_threads);
+static DEVICE_ATTR_RO(package_threads_list);
+
 #ifdef CONFIG_SCHED_BOOK
 define_id_show_func(book_id);
 static DEVICE_ATTR_RO(book_id);
@@ -81,6 +85,8 @@ static struct attribute *default_attrs[] = {
 	&dev_attr_thread_siblings_list.attr,
 	&dev_attr_core_siblings.attr,
 	&dev_attr_core_siblings_list.attr,
+	&dev_attr_package_threads.attr,
+	&dev_attr_package_threads_list.attr,
 #ifdef CONFIG_SCHED_BOOK
 	&dev_attr_book_id.attr,
 	&dev_attr_book_siblings.attr,
-- 
2.18.0-rc0

