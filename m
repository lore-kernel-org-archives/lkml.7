Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A56C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0882085A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="FuNs4AlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfENPIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 11:08:40 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37446 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfENPIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 11:08:40 -0400
Received: by mail-qt1-f194.google.com with SMTP id o7so19406605qtp.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 08:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7kZvhpKITp7GpY2UYW4YcAvoZ7pH6PjHdqS7w9gr3cw=;
        b=FuNs4AlL6ZoplYtEJAQPOUNR/irdssflBkI+WQYPo1k/Wp9qb40VYJ1S/iMw+nVr0Z
         4W4KadJrj7s3iAuyCBi8kLa3aqKQxyjzYo7fAC8lYvsILAF4pYUFEVOvOOhlTV4tyOG8
         JSmJJuF+v9bt7JN7AIJ7VGwKBNTBusf8T15Nwptam76/E/bo8Vlk4vb5QhKdKqRMpced
         Ke2C12ECJhs+pKHO4zwcieQTkqMX58OBTmeeO7l1iAcqgKYimyU921AyV77UcNGmNsfn
         Y5kfuxZg6vtXDRNqV7zxGzPkon5jAyrfhclfTkPWY0mMc7p7B0eCrm0cRmZ/7CiNimR7
         wczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7kZvhpKITp7GpY2UYW4YcAvoZ7pH6PjHdqS7w9gr3cw=;
        b=j5aOw5AF1zlgH8t3tHc/J8KAg6WuX9m5wFVsIevgvvs2DjPyFzJLT4EFLR7mnTtnb9
         PrbeXWaRjnaBK+kRDra14CwsH+gDFqL1GVujPljNEmZtKZTin44T/aRgQPNPixt3wwZ4
         Vl0W9kEIo/nDqOZ0qL/n7JEZvFRW0KYHG/hBFtOnXKx6v9dyH2vnkFhxjETX7XPT/JKS
         FtmaqwlcJ9ORxoKTMas0k1vlAItlyBnwiyoC5AkzKWdATFOv5AZK0P2/Lpa9X6p1JqOm
         WymUS4FOeHy/fjiDR9IeDR0nEYzsFy0JqvS9BQGVejH9rxPu3684uwVdNZ970pJ0EHks
         3nQQ==
X-Gm-Message-State: APjAAAX7GJXMihbI7nyeN9eSO++Cih7Z0JdGjBYRQdsnixlro06iVsXF
        Y0jybfR6YZov9Cp8JmlpwC/7jMXsmME=
X-Google-Smtp-Source: APXvYqyJLWdC5h+BGz6LDsPy3eLEj1lu0rQj66IlbHa/gB1z6dYmdFdVXyCb+ij3Jws+g//usPep4g==
X-Received: by 2002:ac8:2924:: with SMTP id y33mr29791366qty.212.1557846519358;
        Tue, 14 May 2019 08:08:39 -0700 (PDT)
Received: from ovpn-120-85.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b19sm8577242qkk.51.2019.05.14.08.08.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 08:08:38 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, keith.busch@intel.com, ira.weiny@intel.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [RESEND PATCH] nvdimm: fix some compilation warnings
Date:   Tue, 14 May 2019 11:07:35 -0400
Message-Id: <20190514150735.39625-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The commit d9b83c756953 ("libnvdimm, btt: rework error clearing") left
an unused variable.
drivers/nvdimm/btt.c: In function 'btt_read_pg':
drivers/nvdimm/btt.c:1272:8: warning: variable 'rc' set but not used
[-Wunused-but-set-variable]

Last, some places abuse "/**" which is only reserved for the kernel-doc.
drivers/nvdimm/bus.c:648: warning: cannot understand function prototype:
'struct attribute_group nd_device_attribute_group = '
drivers/nvdimm/bus.c:677: warning: cannot understand function prototype:
'struct attribute_group nd_numa_attribute_group = '

Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/nvdimm/btt.c   | 6 ++----
 drivers/nvdimm/bus.c   | 4 ++--
 drivers/nvdimm/label.c | 2 ++
 drivers/nvdimm/label.h | 2 --
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 4671776f5623..9f02a99cfac0 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1269,11 +1269,9 @@ static int btt_read_pg(struct btt *btt, struct bio_integrity_payload *bip,
 
 		ret = btt_data_read(arena, page, off, postmap, cur_len);
 		if (ret) {
-			int rc;
-
 			/* Media error - set the e_flag */
-			rc = btt_map_write(arena, premap, postmap, 0, 1,
-				NVDIMM_IO_ATOMIC);
+			btt_map_write(arena, premap, postmap, 0, 1,
+				      NVDIMM_IO_ATOMIC);
 			goto out_rtt;
 		}
 
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 7ff684159f29..2eb6a6cfe9e4 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -642,7 +642,7 @@ static struct attribute *nd_device_attributes[] = {
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
index f3d753d3169c..02a51b7775e1 100644
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
2.20.1 (Apple Git-117)

