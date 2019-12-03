Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40472C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0523520675
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9DiFTyL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfLCJyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:54:05 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39240 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCJyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 04:54:04 -0500
Received: by mail-pf1-f193.google.com with SMTP id x28so1591827pfo.6;
        Tue, 03 Dec 2019 01:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WsogWlyRgThoQhfF9sTWa0YBUYovc2qudSPT4FE8HIs=;
        b=b9DiFTyLNhlWFfjwPn7KUH/y0rtt2bnC5zKhRkW/qWDMrwUeKA8IsVuh5Nc3arFyAK
         TSCLJBpes5qA3zvzis8N0h63YIASy96x9v4ynwWp+B6bTnv5ekw0wQmZxkLW0Cs1/nUJ
         T4CMiV/oEAwIa7JBXNp53VlI1m3mp2NliAXksqvwVTy+q2uZMoGrxcrtBVB79krGGYNV
         vv1zH2afnxbwtjCeMlB3c8/NLtussF0Vi7HnfkgxMbRifnpKwrmzoOBPDkyrXOP6N2EW
         IGkLMyDwi+mihA26f648eo0KZYTuodhjcNWuBAbKMPOhJclCbA5VVIEIqHbcEkxihsuG
         mGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WsogWlyRgThoQhfF9sTWa0YBUYovc2qudSPT4FE8HIs=;
        b=RFGORwbC54S4lQUURA0V+fSsRSKKjNIkoqq2CZ8P8jVdYQcY50APrN0VmCZ5nbM6Kr
         O7+4kYJoluQZreeNFSCWtN/ANIws63Hgx9prBcgxCfSCiRV5joT/62QnB0EGxyt3xUU+
         hGDfHmTOzu6DE8H+wkz0IivXYtayWiHLhktSOzawF9VVhgI3WpN7Kt+olNxHP86skXsN
         2WkzxszvOACxrolWOkc1qOxc02aVmJCPmDXhl+B3An0AxzlHs2M07TJu11TMYMLBYwi/
         5sZokOcQX7b7Yekugr093wYaNDSSLWk2HK8kKG//kTWkS5qVJbAKBTXtFY0ofosy+Bf/
         U38A==
X-Gm-Message-State: APjAAAVU8DoXdbmZHBflzg+VEFuDnfV6hiKIm9GCs3UOiVSDXhAfY/hq
        LzBsfig2db6Z/ri0O7LJ7sRCKVPCTZY=
X-Google-Smtp-Source: APXvYqysxS/CRZThyJEBcrJNZgOHb7f3bBwnrOwAKmlWS19dAA3LWod93LjSAX4s3tVPC+TNBJmpGw==
X-Received: by 2002:a62:e709:: with SMTP id s9mr3776830pfh.190.1575366844118;
        Tue, 03 Dec 2019 01:54:04 -0800 (PST)
Received: from localhost.localdomain ([103.231.91.74])
        by smtp.gmail.com with ESMTPSA id b7sm2305739pjo.3.2019.12.03.01.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 01:54:03 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        rdunlap@infradead.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 2/2] fix the SPDX syntax and bash interprester pointer
Date:   Tue,  3 Dec 2019 15:23:39 +0530
Message-Id: <20191203095339.615774-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPDX syntax was complining by checkpatch fixed it,added space before it.
And add bash interpreter to find by the env .

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 scripts/kernel_modules_info.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/kernel_modules_info.sh b/scripts/kernel_modules_info.sh
index f005c47a3aa6..3a9b00988ed3 100755
--- a/scripts/kernel_modules_info.sh
+++ b/scripts/kernel_modules_info.sh
@@ -1,5 +1,5 @@
-#!/bin/bash - 
-#SPDX-License-Identifier: GPL-2.0
+#!/usr/bin/env bash 
+# SPDX-License-Identifier: GPL-2.0
 #===============================================================================
 #
 #          FILE: kernel_modules_info.sh
-- 
2.24.0

