Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B882AC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899D9206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j6TjZjdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfEPK2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 06:28:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33733 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfEPK2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 06:28:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id z28so1641295pfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 03:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zdJ9wOciRCFBg5OhP24ccEPW98TzZ5e0I9CMtzhtP7k=;
        b=j6TjZjdTvdf6CjCSc4yUwh0w3lHoZrsZkToyITUvilzaKO5fJ0vqwlISOAS2BDbhb6
         2VbC5h3lCINUHea8eLr5qB7bqHliBCV26+cZHkuc6/kN9BvyoxdDK0mVitXKri3MUivK
         IbYPCZMbdWKCRDRF9dlx5fQMu94ziC7y43FQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zdJ9wOciRCFBg5OhP24ccEPW98TzZ5e0I9CMtzhtP7k=;
        b=P/MuIIfSE7jF50r719BJifFRyUrQdZOZplzZxcswoWRN/CPhVdhs16Ps984OwDbgSr
         yYIGtYPnmhvn6+mEMVQdhcGuRrNxzQLSY8ooFAuyZDvOLeBhbyuuSX5u9c0EG3facmIi
         sp121RaRppzFPWlvGapwaP56ztUw/fvkACRlduwTNCGvTRyjFc0fy/eAllzS/jy32dsi
         evA2QcVMjaDS6lj3VgpLErD7kCwtuppR4fhRT8QPCjovVzg2o5lytNT6ePWyrT6/0wpa
         k8VsDSJxEzn1aZWLoOEYucNKHdBVa1chHsM99YyLta64K00WurMq1cVsRS8FMKp2SFJE
         8xng==
X-Gm-Message-State: APjAAAUj04UQos4Yjmzo1ZE6qRoVHUL/HY27us4NNiWnSnoYp7sEPpPS
        2+dNw/iADuaCQDWiCVGjJGs1Kg==
X-Google-Smtp-Source: APXvYqzPTskZH8eYovOCQmHUvgMMgQkqepD4OYCnKFG7nHyDLIhQaMeOn+J/Ld+Xt/Ggq8IM/7Zmkg==
X-Received: by 2002:a62:e00e:: with SMTP id f14mr52831963pfh.257.1558002515484;
        Thu, 16 May 2019 03:28:35 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id h123sm9338048pfe.80.2019.05.16.03.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 May 2019 03:28:34 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 1/3] include/of_fdt.h: add a weak arch hook to update fdt pgprot
Date:   Thu, 16 May 2019 18:28:15 +0800
Message-Id: <20190516102817.188519-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does nothing as default, arch can implement their function to map
fdt to RO/RW. This is convenient if arch map fdt to RO during init
but needs to write fdt in some special cases after that.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/of/fdt.c       | 13 +++++++++++++
 include/linux/of_fdt.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index de893c9616a1..e84971d1e9ea 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -30,6 +30,19 @@
 
 #include "of_private.h"
 
+/*
+ * update_fdt_pgprot - Arch hook for changing fdt pgprot
+ *
+ * @prot: page protection flags for fdt
+ *
+ * Architecture can implement this function if they want to chagne
+ * fdt page protection flags before or after doing modification and
+ * fixups to fdt.
+ *
+ * Default does nothing.
+ */
+__weak void update_fdt_pgprot(pgprot_t prot) {}
+
 /*
  * of_fdt_limit_memory - limit the number of regions in the /memory node
  * @limit: maximum entries
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index a713e5d156d8..406c3e7b2b75 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -109,5 +109,7 @@ static inline void unflatten_device_tree(void) {}
 static inline void unflatten_and_copy_device_tree(void) {}
 #endif /* CONFIG_OF_EARLY_FLATTREE */
 
+extern void update_fdt_pgprot(pgprot_t prot);
+
 #endif /* __ASSEMBLY__ */
 #endif /* _LINUX_OF_FDT_H */
-- 
2.20.1

