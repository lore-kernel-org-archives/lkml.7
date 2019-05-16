Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E152C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D46920815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="paTihldv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfEPQFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:05:44 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36813 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfEPQFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:05:42 -0400
Received: by mail-qk1-f194.google.com with SMTP id c14so2608753qke.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zAUITjpKKLROuX37hMbdqPFlWmaHToD076fNZLb8xfM=;
        b=paTihldvOejMhzU/pjmy6cxi8/gHfncg9BvJEgw2jZdu7GTTbC6dOi2N34C/kPD+Xe
         llzWo0lUVN5/gH0xigfPAuVxfctO5acb6uM491mjwy+kalcRZrNptGYgtffAGrQm9xKD
         z7cMdKXJJ63VeJ7S62XKUCWg+IJtnA/MuoC0yG1jQRxUMfjTvjsouU6GeU1UhoLOpUy4
         O6jaxq5Vx3jRm2UgvJs0jhTxt1tfjYW5uy/RR5+JF5zvEl0wMsgK+PEzcCVYX5Ml6OgS
         CWMiUYVZvGJpz30FdN/Uvc6ui0RhJyX+CoWvDh4wvgFBWaqBSYRetGUz7xlHg0r4k5NR
         ODlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zAUITjpKKLROuX37hMbdqPFlWmaHToD076fNZLb8xfM=;
        b=iU1AxRTNLS5awPPldKB2w7/MpVzmkInwG42XQnmagAj9EP7so4seNYRkm8wsAntqsK
         qdgNDfYDNpaCZtxSpqpVaeDCJaKMcMfANAvqOFjv6ciYt4ZD2DTopQpCXl/lwTRP9QGQ
         0ecUdAgnijz29dwSxXqKH/jMCH/7JIgz6sMx+Jbv2R9LzRwAdy3ujVIVgDUvY4WdnXeZ
         iUTSRK90RyZ1zMh1BlksrtvJKlJYWd/8NAga3dSGNFH3aKEPGeoZ0gh9/Z6jfBZHjlJ6
         a99Lt6+ZTztKnvsPdnitW5Yc3UT/w54eE1BRyGEk8sl+WRFEWsKFIDdxAQNuzkqtUgR4
         8X6w==
X-Gm-Message-State: APjAAAVdodZcvHNcFtsAgG22wvDzkzBkctciL2BCe8IhAXjRpApvLWAQ
        7FKLOiKHjmyB1GOQ2RaezheiCA==
X-Google-Smtp-Source: APXvYqw/JHD28fUlPb8lI2g8to9VAAo+dI6jsWFcrAF1ACiFIBSxV5uVdFEIpYrHZwfcWMG0OgWwTw==
X-Received: by 2002:a37:684a:: with SMTP id d71mr13791295qkc.25.1558022741627;
        Thu, 16 May 2019 09:05:41 -0700 (PDT)
Received: from qcai.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z29sm2569186qkg.19.2019.05.16.09.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 09:05:40 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     dan.j.williams@intel.com
Cc:     akpm@linux-foundation.org, vishal.l.verma@intel.com,
        dave.jiang@intel.com, keith.busch@intel.com, ira.weiny@intel.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] nvdimm: fix compilation warnings with W=1
Date:   Thu, 16 May 2019 12:04:53 -0400
Message-Id: <1558022693-9631-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/nvdimm/bus.c   | 4 ++--
 drivers/nvdimm/label.c | 2 ++
 drivers/nvdimm/label.h | 2 --
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 7ff684159f29..2eb6a6cfe9e4 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -642,7 +642,7 @@ static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
 	NULL,
 };
 
-/**
+/*
  * nd_device_attribute_group - generic attributes for all devices on an nd bus
  */
 struct attribute_group nd_device_attribute_group = {
@@ -671,7 +671,7 @@ static umode_t nd_numa_attr_visible(struct kobject *kobj, struct attribute *a,
 	return a->mode;
 }
 
-/**
+/*
  * nd_numa_attribute_group - NUMA attributes for all devices on an nd bus
  */
 struct attribute_group nd_numa_attribute_group = {
diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index 2030805aa216..edf278067e72 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -25,6 +25,8 @@
 static guid_t nvdimm_pfn_guid;
 static guid_t nvdimm_dax_guid;
 
+static const char NSINDEX_SIGNATURE[] = "NAMESPACE_INDEX\0";
+
 static u32 best_seq(u32 a, u32 b)
 {
 	a &= NSINDEX_SEQ_MASK;
diff --git a/drivers/nvdimm/label.h b/drivers/nvdimm/label.h
index e9a2ad3c2150..4bb7add39580 100644
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
1.8.3.1

