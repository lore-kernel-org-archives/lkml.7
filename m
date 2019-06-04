Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0EBC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B2120863
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559690693;
	bh=I212B/5pEnGe7qLGUACZrpzS5s/YXwUN2RlArjnRAXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZxebJO04mkGtv71p3pFVVo2HzihPlMMtaJ+BTsFZOtXwApzUGbB20dbEgNjJZ7TdD
	 PtDx1PjhXvbQYGVAwkp2uMXs5IEd5+7dnw3to0L1iyK/PIF3JjE0ciRPukM5uDAkow
	 cdEFBPXQ3CwgPm98BRivGcrC1VeMaEH47Le7+XsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfFDXYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:24:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727776AbfFDXYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:24:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C69A8206C1;
        Tue,  4 Jun 2019 23:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559690690;
        bh=I212B/5pEnGe7qLGUACZrpzS5s/YXwUN2RlArjnRAXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=twYzhTQgChfDsSh/tL+cZXGUzOzxg/GNH68SberhPt4CMEOzKeKzU6ZoGZFX3cw5L
         faDhnf4O+YWWlm/GRUl1smiIc61cJnSuPloqQtOBQH5dg5c94U3oYX1nSyiUEtZoNi
         5P362RM67YKu77Y7OO2LFrBea/A7+oF1PkIWo1EE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>, Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org
Subject: [PATCH AUTOSEL 4.14 19/24] libnvdimm: Fix compilation warnings with W=1
Date:   Tue,  4 Jun 2019 19:24:10 -0400
Message-Id: <20190604232416.7479-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604232416.7479-1-sashal@kernel.org>
References: <20190604232416.7479-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@lca.pw>

[ Upstream commit c01dafad77fea8d64c4fdca0a6031c980842ad65 ]

Several places (dimm_devs.c, core.c etc) include label.h but only
label.c uses NSINDEX_SIGNATURE, so move its definition to label.c
instead.

In file included from drivers/nvdimm/dimm_devs.c:23:
drivers/nvdimm/label.h:41:19: warning: 'NSINDEX_SIGNATURE' defined but
not used [-Wunused-const-variable=]

Also, some places abuse "/**" which is only reserved for the kernel-doc.

drivers/nvdimm/bus.c:648: warning: cannot understand function prototype:
'struct attribute_group nd_device_attribute_group = '
drivers/nvdimm/bus.c:677: warning: cannot understand function prototype:
'struct attribute_group nd_numa_attribute_group = '

Those are just some member assignments for the "struct attribute_group"
instances and it can't be expressed in the kernel-doc.

Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/bus.c   | 4 ++--
 drivers/nvdimm/label.c | 2 ++
 drivers/nvdimm/label.h | 2 --
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index a6746a1f20ae..2f1b54fab399 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -608,7 +608,7 @@ static struct attribute *nd_device_attributes[] = {
 	NULL,
 };
 
-/**
+/*
  * nd_device_attribute_group - generic attributes for all devices on an nd bus
  */
 struct attribute_group nd_device_attribute_group = {
@@ -637,7 +637,7 @@ static umode_t nd_numa_attr_visible(struct kobject *kobj, struct attribute *a,
 	return a->mode;
 }
 
-/**
+/*
  * nd_numa_attribute_group - NUMA attributes for all devices on an nd bus
  */
 struct attribute_group nd_numa_attribute_group = {
diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index 6a16017cc0d9..1fb3a2491131 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -25,6 +25,8 @@ static guid_t nvdimm_btt2_guid;
 static guid_t nvdimm_pfn_guid;
 static guid_t nvdimm_dax_guid;
 
+static const char NSINDEX_SIGNATURE[] = "NAMESPACE_INDEX\0";
+
 static u32 best_seq(u32 a, u32 b)
 {
 	a &= NSINDEX_SEQ_MASK;
diff --git a/drivers/nvdimm/label.h b/drivers/nvdimm/label.h
index 1ebf4d3d01ba..9ed772db6900 100644
--- a/drivers/nvdimm/label.h
+++ b/drivers/nvdimm/label.h
@@ -38,8 +38,6 @@ enum {
 	ND_NSINDEX_INIT = 0x1,
 };
 
-static const char NSINDEX_SIGNATURE[] = "NAMESPACE_INDEX\0";
-
 /**
  * struct nd_namespace_index - label set superblock
  * @sig: NAMESPACE_INDEX\0
-- 
2.20.1

