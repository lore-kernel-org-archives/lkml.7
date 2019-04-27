Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD84C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 03:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FB2206BF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 03:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="J/U3Jr4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfD0DTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 23:19:50 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46802 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfD0DTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 23:19:50 -0400
Received: by mail-qk1-f194.google.com with SMTP id w73so3061525qkb.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 20:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OGtSkbrfqyBgtc4rP22xBZIRFEyicKx1tiObNiky77o=;
        b=J/U3Jr4XTmDoTCfwjj+FuI8FhH3qpuq+DSKEb2NW/Zokzz/0oK76BaLNNr7a49D+Oc
         zTv9hRlSoJ1nWizLTiPq6QZOgJv0TMTcwzgKiKX09+5vSHSlSDqN0WBlM4I3PVX2/NDq
         5Ewni8LqnIg4ODj1AjBCRm4+JQXCPhWmwg1gevEXj7K8iwYUn4IT2nj9pQUiuCFPpoa2
         KqfXwPU2r72Nxl/ySPBOoIRWjF5GFyVCGvnHd90XgB4SQOCkGTJvHWn4fRrAHRcx/Wmw
         H45JwXpsaQ4nZW5PadgHmOrsYNe5T/cTKYPxaV6iuLAxKhR28RDPwM+ZRyoeGjys1Hl/
         cO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OGtSkbrfqyBgtc4rP22xBZIRFEyicKx1tiObNiky77o=;
        b=cckKp2i43lFtDDK2bX+hxFhZi87nJkuNuT1JKF8V6/zfBNwFk5dpETgcLz62Bf0tWI
         R0igt5GJjDBn8VrgnUmEXPyFdeBoIPQmyDZUeyaej7Aii0DIlROyV2p1PNOHPVgGQA7T
         udae6VCbgJJP1v73WBEMJ30Ihek6ioK4WZjyua+FNfjV4WwCV/Vk/WqEAlujhzBB3R+t
         o7kohWUqZ/MMPRO31SiSUFOyz9sEhTMFpjElQ0PALdCXiwMtrjv/A0iT3aZElnZiV7ZL
         KqzYgwouEFVdoBB1vJ5/UE1KCK4ucRKLDFjzWQaMiRkqgAEyD0Js82XXrkwq7BD2Oczr
         o5hw==
X-Gm-Message-State: APjAAAXTlzYdkZ+7sl/Eqg8CtlAhlbDDpheqYfRa0Qnw2NEFxrMsUEtt
        JTaTCCg3KwP2U0P7i7Ekxu2XKtFD1YE=
X-Google-Smtp-Source: APXvYqxynUMrBPzOVGDq1hikUPyqFmBF4yXkxtPoiNxcYWHUu/4MY+kMUFIf6Qm0G99pR4jVmckSlw==
X-Received: by 2002:a05:620a:34b:: with SMTP id t11mr26134494qkm.279.1556335189081;
        Fri, 26 Apr 2019 20:19:49 -0700 (PDT)
Received: from ovpn-121-162.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s55sm16478685qte.17.2019.04.26.20.19.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 20:19:48 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, keith.busch@intel.com, ira.weiny@intel.com
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] nvdimm: fix some compilation warnings
Date:   Fri, 26 Apr 2019 23:19:34 -0400
Message-Id: <20190427031934.94947-1-cai@lca.pw>
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

