Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF05FC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF82205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="ZJpcX7CF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfDOSTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:19:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44396 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbfDOSTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:19:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id g12so8952041pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 11:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+9Ht1OHIulmBLnDv7fAGUcF+vOqeIANUhm3itrm+sZ4=;
        b=ZJpcX7CFaA/SzdYQArwo16RrEwT6AmVLiurkUxOtihCx42136OHaeIeVrBbMd7tXDT
         QJoA5ns0gViTJCSYZ7/N7v1TDbwgNH4SYlXiBBDCfXmOq8ks11Hr6aJU3cixQiqHAMo2
         H62cjKpODBovqRczfNr/t04uWmodnBt7yT7AJ4gaPh0BVz8McXHfy+XcGmpm9FwdZAqk
         odqTZ/QDitN0cVRSd8gpAY9BuiOglECS9zzDxJIqv+h66Bk4NFO7pw1a1CqFHpM7+trp
         A7aPwxu3ftxSwhJHTFTIAYKMtqKQvrZ92r26psduusyim7SQw9Xm6A30kspqTj3aR2kv
         /NaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+9Ht1OHIulmBLnDv7fAGUcF+vOqeIANUhm3itrm+sZ4=;
        b=ntfFTLTu2vYfvuXb9io5UKjbaw51eXq/JgjRDhp48BsF8it4DuEDKGf0pXsJrxFoVO
         9CbWlwqCT8yBbBkuFKAWXFSheT44WlUGhHF2wX28MoStfqpbrftQXsVN4Zzn9iivzYvt
         fx3JYjBzQgUAqAtMx1CuWwmbe4uw7jsop/B+ly7gsm0tTRF9KeFd/8NHI27GskRwD+Ct
         Fk0fZJIMUS+Wv5sJp2v9/bhVtAssTc6nOA25dEFFES8U/qSi3MmXqd4wXb8qQNGPuTID
         Xf48oOfUpUQcVyE3zMjb60GRqFyCEHSLKDZnlTDsbg9tod+KwCEI8Fjdol8OzMqdju3C
         jHzA==
X-Gm-Message-State: APjAAAVxhW0O1HAAxXVCUseGm+VZNUhZBDjoNwtNfyYSiZYQjlABGB9b
        U3VffL9iYD7utqny9xdaI/H3hQ==
X-Google-Smtp-Source: APXvYqzic8cbbXK5yK4cvKOPKGfd0ZBC6paV7mqvYOErTUK5I3H8jQtDeHnxH3vhHnOw5FQzDS5Eaw==
X-Received: by 2002:a17:902:703:: with SMTP id 3mr77828574pli.224.1555352356491;
        Mon, 15 Apr 2019 11:19:16 -0700 (PDT)
Received: from trong0.mtv.corp.google.com ([2620:0:1000:1601:c43f:8c1b:f6ef:3dce])
        by smtp.gmail.com with ESMTPSA id r87sm110873788pfa.71.2019.04.15.11.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 11:19:15 -0700 (PDT)
From:   Tri Vo <trong@android.com>
To:     jeyu@kernel.org
Cc:     ndesaulniers@google.com, ghackmann@android.com, linux-mm@kvack.org,
        kbuild-all@01.org, rdunlap@infradead.org, lkp@intel.com,
        linux-kernel@vger.kernel.org, pgynther@google.com,
        willy@infradead.org, oberpar@linux.ibm.com,
        akpm@linux-foundation.org, Tri Vo <trong@android.com>
Subject: [PATCH v2] module: add stubs for within_module functions
Date:   Mon, 15 Apr 2019 11:18:33 -0700
Message-Id: <20190415181833.101222-1-trong@android.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190415142229.GA14330@linux-8ccs>
References: <20190415142229.GA14330@linux-8ccs>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide stubs for within_module_core(), within_module_init(), and
within_module() to prevent build errors when !CONFIG_MODULES.

v2:
- Generalized commit message, as per Jessica.
- Stubs for within_module_core() and within_module_init(), as per Nick.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kbuild test robot <lkp@intel.com>
Link: https://marc.info/?l=linux-mm&m=155384681109231&w=2
Signed-off-by: Tri Vo <trong@android.com>
---
 include/linux/module.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 5bf5dcd91009..35d83765bfbd 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -709,6 +709,23 @@ static inline bool is_module_text_address(unsigned long addr)
 	return false;
 }
 
+static inline bool within_module_core(unsigned long addr,
+				      const struct module *mod)
+{
+	return false;
+}
+
+static inline bool within_module_init(unsigned long addr,
+				      const struct module *mod)
+{
+	return false;
+}
+
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

