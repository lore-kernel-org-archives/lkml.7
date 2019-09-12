Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C053ECDE20
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 05:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DD921479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 05:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FRbBT6xd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfILF7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 01:59:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46884 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfILF7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 01:59:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id q5so15230147pfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 22:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9duNwvJ16wl6i9JK0JxmwLCbqMy/YOSDsatt/Ugxhh0=;
        b=FRbBT6xdaywYm1Eq4QN4D3bijixSYoPo3VEn4SC9G8XRTVtx2IkVj9TcOA0JSqYwGl
         TZhqsDfWYc/B6ydJEVo85YRRqO0oBLCkTVGABfLCd3Yw0QbYOivmnkXkchJlRi5w05QU
         cf7Mr1+lci9lrE1CT9JzMyKmO2hXvEAZt1d9KCFMO1vEiq7HQs8wF8P1cWcwyLkFkizJ
         kcvzVym1tbRJ2YW7GPmoOmaaomsJZDqyMOere0qiKofATuSvBD2jm092/SbxUyDChRrl
         p7niPQNlxz8L7+QJv/3dbYqXZSh1Rb6TpIuA6UdXL2JcyE4kjkMZ8RLIJAG85VMQm1tC
         6NlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9duNwvJ16wl6i9JK0JxmwLCbqMy/YOSDsatt/Ugxhh0=;
        b=FOP6XYVR06Je1+kIvdxBttZXFPLQzaP61UlQ/sx71boNJIbX+E/24G3sBxXlkidUot
         2S3nu5A+hDu/+d7b3uPeOtdCgutnfIw4WJP1vL/czgeNkPYEKU6McQQ1Zrj6PBRI7M/C
         a/AKAUEgwf7FgOBNwKbx6ZwIrmCycm6QJRLEnst0dp+Y3ZqB/lzdEwKAn5VzLQFZle+r
         oOCnax6lX+5vW8XurFoWL2nZfipIfdsD4YZHLRVlWv2AkWs2tVNFSFyr9TNs7augHrfh
         npNqyu/3zSUlBTWSFGVjIugTzESZICtN3uuqJevrwb5QHhouftpXe1cELk/fhVHqzhHc
         7WhQ==
X-Gm-Message-State: APjAAAWtV/GGwvn9oTW6UgFBQtK+V9Nqc7WXDlq++YMh6yUA1ktbfK9K
        dqb6uaZY6nPZL7GqgE2nZCT7KA==
X-Google-Smtp-Source: APXvYqwRT/QyokAzKYSkNXb9bPY58QTKW/gzk7wHl7wSKXMyR2OixJVa29yltPDRmZGoDv813RK/bA==
X-Received: by 2002:a62:e10a:: with SMTP id q10mr47211817pfh.236.1568267982763;
        Wed, 11 Sep 2019 22:59:42 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id z12sm4461135pjp.11.2019.09.11.22.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 22:59:42 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     james.morse@arm.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 2/3] libfdt: include fdt_addresses.c
Date:   Thu, 12 Sep 2019 15:01:49 +0900
Message-Id: <20190912060150.10818-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190912060150.10818-1-takahiro.akashi@linaro.org>
References: <20190912060150.10818-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of kexec_file_loaded-based kdump for arm64,
fdt_appendprop_addrrange() will be needed.

So include fdt_addresses.c in making libfdt.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
---
 lib/Makefile        | 2 +-
 lib/fdt_addresses.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)
 create mode 100644 lib/fdt_addresses.c

diff --git a/lib/Makefile b/lib/Makefile
index 29c02a924973..59f082727503 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -224,7 +224,7 @@ KASAN_SANITIZE_stackdepot.o := n
 KCOV_INSTRUMENT_stackdepot.o := n
 
 libfdt_files = fdt.o fdt_ro.o fdt_wip.o fdt_rw.o fdt_sw.o fdt_strerror.o \
-	       fdt_empty_tree.o
+	       fdt_empty_tree.o fdt_addresses.o
 $(foreach file, $(libfdt_files), \
 	$(eval CFLAGS_$(file) = -I $(srctree)/scripts/dtc/libfdt))
 lib-$(CONFIG_LIBFDT) += $(libfdt_files)
diff --git a/lib/fdt_addresses.c b/lib/fdt_addresses.c
new file mode 100644
index 000000000000..23610bcf390b
--- /dev/null
+++ b/lib/fdt_addresses.c
@@ -0,0 +1,2 @@
+#include <linux/libfdt_env.h>
+#include "../scripts/dtc/libfdt/fdt_addresses.c"
-- 
2.21.0

