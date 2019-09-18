Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414CEC4CED5
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 04:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13726214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 04:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRTMoTPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfIREXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 00:23:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39436 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfIREXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 00:23:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so5298686wrj.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 21:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rIq1JW2tJfg0PLRUSRfWmLD8aLaxDS+5OXqW5mJJ9Ks=;
        b=fRTMoTPj0TY3IwpoEkLUTYo895YGKUjTwvCKWHbiP8HcHOZ2h2ukSQou4QFkChl9lQ
         gtpSK/+spGlce6w9CW6cLFbWC6alnYhM4bAwzF/dwFSEEaFZSJpO7acxUVnEhjYNmFej
         IjQhel4fxJU78vDmVkabsvbgh4SyqZRYQ7QXHdi/OYrVsN6k3odmuxkZXaYPaFQi1D0X
         6bEz+C725Dk/h5smiBjDCFNxQyfxebQj5jYeQXRWt2MSrLDoLevqn+MgzbwgVbO2/6p2
         7VqlNknsWZr3jGKSjEXDNJ+iH9S6EmVOiXi3wgeiz/SWpkk33ip8WCt3LLP2URK2FLN5
         AXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rIq1JW2tJfg0PLRUSRfWmLD8aLaxDS+5OXqW5mJJ9Ks=;
        b=kN1Ayg9qRL2D2ZhBxe3zP0NhGT2NsKjsCL0WjzJQbsduh+FzJuaEBCArSBZp4qbf4R
         Vf4AvarJRw8SoNXsFM9RkpTUXFdPNRncn3RgdkWIyj0HPCLQz7GP87uCY7C6tVeJonEB
         TcNPRTMSMfZOsxW1RqcpzCcmdxKRgBzvRBnAsI/SakoT7EF3wVXJ2VDaovxv2txeGxV8
         44rsTWkShqFQ3DmL9xd+Qa5xHrWS0JlXaMHdB6CRs+k9bdRBv2YSXCZFPy+ilvcNudR5
         9+sZWCfonmCwyrSs0K2PqKTRTOOA/G9f7lLCjVrREFEimVTddVbYLPjztY+KSvzXL2ei
         vIyw==
X-Gm-Message-State: APjAAAUN+TG0u1zwNJ0j5pFdyU/KBD/P95GqFwqPpqK9blAIfU2g7dih
        FAFkFLa1JERdcRCioMnZK1nFm1kc87xDYw==
X-Google-Smtp-Source: APXvYqxmmEkIqD0/D/VTb3sYHmywgdZ2V8y+kabvMCfN2nD9OEBNHZNyZSUL+o0wBNWiQzizYbi7RA==
X-Received: by 2002:adf:f502:: with SMTP id q2mr1179861wro.186.1568780586216;
        Tue, 17 Sep 2019 21:23:06 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id b184sm1025464wmg.47.2019.09.17.21.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 21:23:05 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] libnvdimm/nfit_test: Fix acpi_handle redefinition
Date:   Tue, 17 Sep 2019 21:21:49 -0700
Message-Id: <20190918042148.77553-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 62974fc389b3 ("libnvdimm: Enable unit test infrastructure
compile checks"), clang warns:

In file included from
../drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:15:
../drivers/nvdimm/../../tools/testing/nvdimm/test/nfit_test.h:206:15:
warning: redefinition of typedef 'acpi_handle' is a C11 feature
[-Wtypedef-redefinition]
typedef void *acpi_handle;
              ^
../include/acpi/actypes.h:424:15: note: previous definition is here
typedef void *acpi_handle;      /* Actually a ptr to a NS Node */
              ^
1 warning generated.

The include chain:

iomap.c ->
    linux/acpi.h ->
        acpi/acpi.h ->
            acpi/actypes.h
    nfit_test.h

Avoid this by including linux/acpi.h in nfit_test.h, which allows us to
remove both the typedef and the forward declaration of acpi_object.

Link: https://github.com/ClangBuiltLinux/linux/issues/660
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

I know that every maintainer has their own thing with the number of
includes in each header file; this issue can be solved in a various
number of ways, I went with the smallest diff stat. Please solve it in a
different way if you see fit :)

 tools/testing/nvdimm/test/nfit_test.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/nvdimm/test/nfit_test.h b/tools/testing/nvdimm/test/nfit_test.h
index 448d686da8b1..0bf5640f1f07 100644
--- a/tools/testing/nvdimm/test/nfit_test.h
+++ b/tools/testing/nvdimm/test/nfit_test.h
@@ -4,6 +4,7 @@
  */
 #ifndef __NFIT_TEST_H__
 #define __NFIT_TEST_H__
+#include <linux/acpi.h>
 #include <linux/list.h>
 #include <linux/uuid.h>
 #include <linux/ioport.h>
@@ -202,9 +203,6 @@ struct nd_intel_lss {
 	__u32 status;
 } __packed;
 
-union acpi_object;
-typedef void *acpi_handle;
-
 typedef struct nfit_test_resource *(*nfit_test_lookup_fn)(resource_size_t);
 typedef union acpi_object *(*nfit_test_evaluate_dsm_fn)(acpi_handle handle,
 		 const guid_t *guid, u64 rev, u64 func,
-- 
2.23.0

