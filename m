Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8E0C282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 02:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3A4213A2
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 02:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="aJODF+9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfDGC0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 22:26:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33223 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfDGC0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 22:26:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id t16so5238590plo.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 19:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pbFiHEf1JRX3q/KJ7+SXhCuYiieeLaagT2MKIRh7feU=;
        b=aJODF+9GDwNrJJA3vaeBNXIQnT08LEI7aw7UDRbuPPI79BaOZ4n+enGT8hf4x02OtZ
         G1luMZfHQgAgy60D9Wr3P/aL2B1ZC338zJdc4itOVWJQd1JP1dLypwbunA0tDe9Cj/Go
         fpvR1swPTanzB1/oOMEN9SIKfnN+HCtu7yOgS6wnp/wXF95x73FHoJWJE7f5zYEoqvkj
         0cXUXYGoScwjZ8wnT1Kco1pZsDyxceVjlwOS1X7An01ljLPBKvJQGpDfSSN9n/BZod8r
         bE8qcH1dJAgmul0kS3lWgZql8YbHBtYOiFpA9eMj7SEwXObYqVHmad9HkXKC9CSEJNF7
         5UhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pbFiHEf1JRX3q/KJ7+SXhCuYiieeLaagT2MKIRh7feU=;
        b=YqsQmwfXE1MaOnOPog+Xd59/oWHHCP74ZVZVZSlQzY9SiPup3A8sXp5sjhN4J4s2jY
         w6jNq99B9Wd/EYkqPwwrZdxgRBbj96mCV1adlzJHEaSZrBjFyT3PtMP7LSk0jiDzA/zO
         lR+EeXoK3+tiCCVdvbrQ2/NEIBAuCWu3HLkD9l0t4HexlEOCSCXxUODN284VljMdsiqW
         u6qtcsMk7DbdJy1FwOgv1Sx5WP84YHAEH/iD2v9Flv8HXigk/63cBMdlatoPBp450z3n
         9MMJy94gzj18VnYiX4ZkQsk2TsubLrhi0rtp3vV6QL5WllTFtiJFaK+0fA9e/GFIoZ/O
         KZxg==
X-Gm-Message-State: APjAAAV+Bt/LEu3BgSpy3PwkWxU6C/FAhmUdUfR7bjffB0cKdmpIOo7L
        XYgt+f9/QhtSDDkfDl42Z5qoiQ==
X-Google-Smtp-Source: APXvYqww3A2dZzWPiMEkVXe7aXSilFWyt/z2WhIC6F9MpgLMGlwOH7TMwxuEo72meWiWoLGu5TQXLQ==
X-Received: by 2002:a17:902:ec0c:: with SMTP id cy12mr769plb.291.1554604009667;
        Sat, 06 Apr 2019 19:26:49 -0700 (PDT)
Received: from trong0.mtv.corp.google.com ([2620:0:1000:1601:c43f:8c1b:f6ef:3dce])
        by smtp.gmail.com with ESMTPSA id f7sm50240345pga.56.2019.04.06.19.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 19:26:48 -0700 (PDT)
From:   Tri Vo <trong@android.com>
To:     oberpar@linux.ibm.com, akpm@linux-foundation.org, jeyu@kernel.org
Cc:     ndesaulniers@google.com, ghackmann@android.com, linux-mm@kvack.org,
        kbuild-all@01.org, rdunlap@infradead.org, lkp@intel.com,
        linux-kernel@vger.kernel.org, pgynther@google.com,
        willy@infradead.org, Tri Vo <trong@android.com>
Subject: [PATCH] module: add stub for within_module
Date:   Sat,  6 Apr 2019 19:25:58 -0700
Message-Id: <20190407022558.65489-1-trong@android.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a stub for within_module() when CONFIG_MODULES is not set. This
is needed to build CONFIG_GCOV_KERNEL.

Fixes: 8c3d220cb6b5 ("gcov: clang support")
Suggested-by: Matthew Wilcox <willy@infradead.org>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kbuild test robot <lkp@intel.com>
Link: https://marc.info/?l=linux-mm&m=155384681109231&w=2
Signed-off-by: Tri Vo <trong@android.com>
---
 include/linux/module.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 5bf5dcd91009..47190ebb70bf 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -709,6 +709,11 @@ static inline bool is_module_text_address(unsigned long addr)
 	return false;
 }
 
+static inline bool within_module(unsigned long addr, const struct module *mod)
+{
+	return false;
+}
+
 /* Get/put a kernel symbol (calls should be symmetric) */
 #define symbol_get(x) ({ extern typeof(x) x __attribute__((weak)); &(x); })
 #define symbol_put(x) do { } while (0)
-- 
2.21.0.392.gf8f6787159e-goog

