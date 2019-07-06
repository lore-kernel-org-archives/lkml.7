Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,GAPPY_SUBJECT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2958BC0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D483A21670
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5QOWWJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfGFKz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 06:55:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40438 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfGFKzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 06:55:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so5914008wrl.7;
        Sat, 06 Jul 2019 03:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HMLlUTvH7NymWaOjPDDSuVqGYq2w/v7gPHlts+YCCcY=;
        b=K5QOWWJF4uULt5fhx/WTlCd03sw83j2/BUkVXgohygderzW3Yt/f6QRhLm2eLDTQR3
         xl+1XbsuQqiJAk4SXGU6K0j5eIrmywleN3fQ6cHF5HfkUqWwu1jZhobuDMpeV45Ffk6A
         vaZ1MOkxmFNd5+GEc+kizOsk+IvmkjVSn1xU+C4usl+oMLtBR1O1BuMEEPSsXl9sX6Rk
         FhwQMcRdiGIs38g45n1NmlKmC69JLrl7SoJBdFoN99AUiviKYx27dWS0XlOoqXpmSULf
         TLxKu1OgktRPTQAgODy06VNXmQ9MyDej9YHpgbswqpGwsZAATTgyXBskdkA4DXCQJ1sZ
         d8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HMLlUTvH7NymWaOjPDDSuVqGYq2w/v7gPHlts+YCCcY=;
        b=LHTv9S5Uznu3q5Ibn4ceYPK630vhrBWAfrdrAigcywiNQ6fhx0hu9zTAJyJNF1u5rP
         EZwqs0dbQZbJRpUF7qUjZBxwl0WnU++nNhenH7tgVksjydPYEvhk9wjuWcW9MoQamZ8B
         slZGXAVKIBVQwBn0xrkgq6drgLP5DNy5lZcfVyG10LoJbC+1ztAPjXmjhIkvk00/J0lB
         Wk7lkNIRu0DBnIVX7mYC/gPEGIAgX0U4Jo3kHCWXSNOIMgaFZCcDQAHzga/epkYmfiss
         yl4HhLnrLxawkAGXbt/X9hHXGVVSdhQaH3MB71PbotrQyAXdwPREvo6tB1R0tjTylYEg
         jEXQ==
X-Gm-Message-State: APjAAAVghfNp4MqBR8c850nH/X3QwxvTmdVsPBarjaGiTmWxvM5/UMf0
        ePWA2kHsbl68H9Yb6XeLBaDttZmBdnch9A==
X-Google-Smtp-Source: APXvYqxjW7TL1355+CnHJ4vlClfGDq4A6u03xqUecwa9PCLIfnLUO69I+8Q4hEKf748yiZXv3SX3UA==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr8982680wru.179.1562410515966;
        Sat, 06 Jul 2019 03:55:15 -0700 (PDT)
Received: from localhost (net-93-71-3-102.cust.vodafonedsl.it. [93.71.3.102])
        by smtp.gmail.com with ESMTPSA id h11sm12578794wrx.93.2019.07.06.03.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jul 2019 03:55:15 -0700 (PDT)
From:   Salvatore Mesoraca <s.mesoraca16@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Brad Spengler <spender@grsecurity.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@infradead.org>,
        James Morris <james.l.morris@oracle.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v5 04/12] S.A.R.A.: generic DFA for string matching
Date:   Sat,  6 Jul 2019 12:54:45 +0200
Message-Id: <1562410493-8661-5-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creation of a generic Discrete Finite Automata implementation
for string matching. The transition tables have to be produced
in user-space.
This allows us to possibly support advanced string matching
patterns like regular expressions, but they need to be supported
by user-space tools.

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---
 security/sara/Kconfig            |  22 +++
 security/sara/Makefile           |   3 +-
 security/sara/dfa.c              | 335 +++++++++++++++++++++++++++++++++++++++
 security/sara/dfa_test.c         | 135 ++++++++++++++++
 security/sara/include/dfa.h      |  52 ++++++
 security/sara/include/dfa_test.h |  29 ++++
 security/sara/main.c             |   6 +
 7 files changed, 581 insertions(+), 1 deletion(-)
 create mode 100644 security/sara/dfa.c
 create mode 100644 security/sara/dfa_test.c
 create mode 100644 security/sara/include/dfa.h
 create mode 100644 security/sara/include/dfa_test.h

diff --git a/security/sara/Kconfig b/security/sara/Kconfig
index 0456220..b98cf27 100644
--- a/security/sara/Kconfig
+++ b/security/sara/Kconfig
@@ -13,6 +13,28 @@ menuconfig SECURITY_SARA
 
 	  If unsure, answer N.
 
+config SECURITY_SARA_DFA_32BIT
+	bool "Use 32 bits instead of 16 bits for DFA states' id"
+	depends on SECURITY_SARA
+	default n
+	help
+	  If you say Y here S.A.R.A. will use more memory, but you will be
+	  able to configure more rules.
+	  See Documentation/admin-guide/LSM/SARA.rst. for further information.
+
+	  If unsure, answer N.
+
+config SECURITY_SARA_DFA_TEST
+	bool "Enable test interface for the internal DFA engine"
+	depends on SECURITY_SARA
+	default n
+	help
+	  If you say Y here S.A.R.A. will enable a user-space interface
+	  that can be used to test the DFA engine (e.g. via `saractl test`).
+	  See Documentation/admin-guide/LSM/SARA.rst. for further information.
+
+	  If unsure, answer N.
+
 config SECURITY_SARA_DEFAULT_DISABLED
 	bool "S.A.R.A. will be disabled at boot."
 	depends on SECURITY_SARA
diff --git a/security/sara/Makefile b/security/sara/Makefile
index 14bf7a8..ffa1be1 100644
--- a/security/sara/Makefile
+++ b/security/sara/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_SECURITY_SARA) := sara.o
 
-sara-y := main.o securityfs.o utils.o sara_data.o
+sara-y := main.o securityfs.o utils.o sara_data.o dfa.o
+sara-$(CONFIG_SECURITY_SARA_DFA_TEST) += dfa_test.o
diff --git a/security/sara/dfa.c b/security/sara/dfa.c
new file mode 100644
index 0000000..e39b27e
--- /dev/null
+++ b/security/sara/dfa.c
@@ -0,0 +1,335 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * S.A.R.A. Linux Security Module
+ *
+ * Copyright (C) 2017 Salvatore Mesoraca <s.mesoraca16@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/mm.h>
+#include <linux/printk.h>
+#include <linux/ratelimit.h>
+#include <linux/slab.h>
+
+#include "include/sara.h"
+#include "include/dfa.h"
+#include "include/securityfs.h"
+
+#define DFA_MAGIC_SIZE 8
+#define DFA_MAGIC "SARADFAT"
+
+#define DFA_INPUTS 255
+
+#ifndef CONFIG_SECURITY_SARA_DFA_32BIT
+#define pr_err_dfa_size() \
+	pr_err_ratelimited("DFA: too many states. Recompile kernel with CONFIG_SARA_DFA_32BIT.\n")
+#else
+#define pr_err_dfa_size() pr_err_ratelimited("DFA: too many states.\n")
+#endif
+
+void sara_dfa_free_tables(struct sara_dfa_tables *dfa)
+{
+	if (dfa) {
+		kvfree(dfa->output);
+		kvfree(dfa->def);
+		kvfree(dfa->base);
+		kvfree(dfa->next);
+		kvfree(dfa->check);
+		kvfree(dfa);
+	}
+}
+
+static struct sara_dfa_tables *sara_dfa_alloc_tables(sara_dfa_state states,
+						     sara_dfa_state cmp_states)
+{
+	struct sara_dfa_tables *tmp = NULL;
+
+	tmp = kvzalloc(sizeof(*tmp), GFP_KERNEL_ACCOUNT);
+	if (!tmp)
+		goto err;
+	tmp->output = kvcalloc(states,
+			       sizeof(*tmp->output),
+			       GFP_KERNEL_ACCOUNT);
+	if (!tmp->output)
+		goto err;
+	tmp->def = kvcalloc(states,
+			    sizeof(*tmp->def),
+			    GFP_KERNEL_ACCOUNT);
+	if (!tmp->def)
+		goto err;
+	tmp->base = kvcalloc(states,
+			     sizeof(*tmp->base),
+			     GFP_KERNEL_ACCOUNT);
+	if (!tmp->base)
+		goto err;
+	tmp->next = kvcalloc(cmp_states,
+			     sizeof(*tmp->next) * DFA_INPUTS,
+			     GFP_KERNEL_ACCOUNT);
+	if (!tmp->next)
+		goto err;
+	tmp->check = kvcalloc(cmp_states,
+			      sizeof(*tmp->check) * DFA_INPUTS,
+			      GFP_KERNEL_ACCOUNT);
+	if (!tmp->check)
+		goto err;
+	tmp->states = states;
+	tmp->cmp_states = cmp_states;
+	return tmp;
+
+err:
+	sara_dfa_free_tables(tmp);
+	return ERR_PTR(-ENOMEM);
+}
+
+int sara_dfa_match(struct sara_dfa_tables *dfa,
+		   const unsigned char *s,
+		   sara_dfa_output *output)
+{
+	sara_dfa_state i, j;
+	sara_dfa_state c_state = 0;
+
+	/* Max s[x] value must be == DFA_INPUTS */
+	BUILD_BUG_ON((((1ULL << (sizeof(*s) * 8)) - 1) != DFA_INPUTS));
+
+	/*
+	 * The DFA transition table is compressed using 5 linear arrays
+	 * as shown in the Dragon Book.
+	 * These arrays are: default, base, next, check and output.
+	 * default, base and output have the same size and are indexed by
+	 * state number.
+	 * next and check tables have the same size and are indexed by
+	 * the value from base for a given state and the input symbol.
+	 * To match a string against this set of arrays we need to:
+	 * - Use the base arrays to recover the index to use
+	 *   with check and next arrays for the current state and symbol.
+	 * - If the value in the check array matches the current state
+	 *   number the next state should be retrieved from the next array,
+	 *   otherwise we take it from the default array.
+	 * - If the next state is not valid we should return immediately
+	 * - If the input sequence is over and the value in the output array
+	 *   is valid, the string matches, and we should return the output
+	 *   value.
+	 */
+
+	for (i = 0; s[i]; i++) {
+		j = (dfa->base[c_state] * DFA_INPUTS) + s[i] - 1;
+		if (dfa->check[j] != c_state)
+			c_state = dfa->def[c_state];
+		else
+			c_state = dfa->next[j];
+		if (c_state == SARA_INVALID_DFA_VALUE)
+			return 0;
+	}
+
+	if (dfa->output[c_state] != SARA_INVALID_DFA_VALUE) {
+		*output = dfa->output[c_state];
+		return 1;
+	}
+	return 0;
+}
+
+struct sara_dfa_tables *sara_dfa_make_null(void)
+{
+	int i;
+	struct sara_dfa_tables *dfa = NULL;
+
+	dfa = sara_dfa_alloc_tables(1, 1);
+	if (unlikely(IS_ERR_OR_NULL(dfa)))
+		return NULL;
+	dfa->output[0] = SARA_INVALID_DFA_VALUE;
+	dfa->def[0] = SARA_INVALID_DFA_VALUE;
+	dfa->base[0] = 0;
+	for (i = 0; i < DFA_INPUTS; ++i)
+		dfa->next[i] = SARA_INVALID_DFA_VALUE;
+	for (i = 0; i < DFA_INPUTS; ++i)
+		dfa->check[i] = 0;
+	memset(dfa->hash, 0, SARA_CONFIG_HASH_LEN);
+	return dfa;
+}
+
+struct binary_dfa_header {
+	char magic[DFA_MAGIC_SIZE];
+	__le32 version;
+	__le32 states;
+	__le32 cmp_states;
+	char hash[SARA_CONFIG_HASH_LEN];
+} __packed;
+
+#define SARA_INVALID_DFA_VALUE_LOAD 0xffffffffu
+
+struct sara_dfa_tables *sara_dfa_load(const char *buf,
+				      size_t buf_len,
+				      bool (*is_valid)(sara_dfa_output))
+{
+	int ret;
+	struct sara_dfa_tables *dfa = NULL;
+	struct binary_dfa_header *h = (struct binary_dfa_header *) buf;
+	__le32 *p;
+	uint64_t i;
+	u32 version, states, cmp_states, tmp;
+
+	ret = -EINVAL;
+	if (unlikely(buf_len < sizeof(*h)))
+		goto out;
+
+	ret = -EINVAL;
+	if (unlikely(memcmp(h->magic, DFA_MAGIC, DFA_MAGIC_SIZE) != 0))
+		goto out;
+	version = le32_to_cpu(h->version);
+	states = le32_to_cpu(h->states);
+	cmp_states = le32_to_cpu(h->cmp_states);
+	if (unlikely(version != SARA_DFA_VERSION)) {
+		pr_err_ratelimited("DFA: unsupported version\n");
+		goto out;
+	}
+	if (unlikely(states >= SARA_INVALID_DFA_VALUE ||
+		     cmp_states >= SARA_INVALID_DFA_VALUE)) {
+		pr_err_dfa_size();
+		goto out;
+	}
+	if (unlikely(states == 0 ||
+		     cmp_states == 0))
+		goto out;
+	if (unlikely(((states * sizeof(u32) * 3) +
+		      (cmp_states * sizeof(u32) * 2 * DFA_INPUTS) +
+		      sizeof(*h)) != buf_len))
+		goto out;
+
+	ret = -ENOMEM;
+	dfa = sara_dfa_alloc_tables(h->states, h->cmp_states);
+	if (unlikely(IS_ERR_OR_NULL(dfa)))
+		goto out;
+
+	dfa->states = states;
+	dfa->cmp_states = cmp_states;
+
+	ret = -EINVAL;
+	p = (__le32 *) (buf + sizeof(*h));
+	for (i = 0; i < dfa->states; i++) {
+		tmp = le32_to_cpu(*p);
+		if (unlikely(tmp != SARA_INVALID_DFA_VALUE_LOAD &&
+			     tmp >= dfa->states))
+			goto out_alloc;
+		dfa->def[i] = (sara_dfa_state) tmp;
+		++p;
+	}
+	for (i = 0; i < dfa->states; i++) {
+		tmp = le32_to_cpu(*p);
+		if (unlikely(tmp >= dfa->cmp_states))
+			goto out_alloc;
+		dfa->base[i] = (sara_dfa_state) tmp;
+		++p;
+	}
+	for (i = 0; i < (dfa->cmp_states * DFA_INPUTS); i++) {
+		tmp = le32_to_cpu(*p);
+		if (unlikely(tmp != SARA_INVALID_DFA_VALUE_LOAD &&
+			     tmp >= dfa->states))
+			goto out_alloc;
+		dfa->next[i] = (sara_dfa_state) tmp;
+		++p;
+	}
+	for (i = 0; i < (dfa->cmp_states * DFA_INPUTS); i++) {
+		tmp = le32_to_cpu(*p);
+		if (unlikely(tmp != SARA_INVALID_DFA_VALUE_LOAD &&
+			     tmp >= dfa->states))
+			goto out_alloc;
+		dfa->check[i] = (sara_dfa_state) tmp;
+		++p;
+	}
+	for (i = 0; i < dfa->states; i++) {
+		tmp = le32_to_cpu(*p);
+		if (unlikely(tmp != SARA_INVALID_DFA_VALUE_LOAD &&
+			     !is_valid(tmp)))
+			goto out_alloc;
+		dfa->output[i] = (sara_dfa_state) tmp;
+		++p;
+	}
+	if (unlikely((void *) p != (void *) (buf + buf_len)))
+		goto out_alloc;
+
+	BUILD_BUG_ON(sizeof(dfa->hash) != sizeof(h->hash));
+	memcpy(dfa->hash, h->hash, sizeof(dfa->hash));
+
+	return dfa;
+out_alloc:
+	sara_dfa_free_tables(dfa);
+out:
+	pr_err_ratelimited("DFA: invalid load\n");
+	return ERR_PTR(ret);
+}
+
+ssize_t sara_dfa_dump(const struct sara_dfa_tables *dfa, char **buffer)
+{
+	char *buf;
+	size_t buf_len = 0;
+	struct binary_dfa_header *h;
+	__le32 *p;
+	int i;
+
+	buf_len = sizeof(*h) +
+		  dfa->states * sizeof(__le32) * 3 +
+		  dfa->cmp_states * sizeof(__le32) * DFA_INPUTS * 2;
+	buf = kvmalloc(buf_len, GFP_KERNEL_ACCOUNT);
+	if (unlikely(!buf))
+		return -ENOMEM;
+
+	h = (struct binary_dfa_header *) buf;
+	memcpy(h->magic, DFA_MAGIC, DFA_MAGIC_SIZE);
+	h->version = cpu_to_le32(SARA_DFA_VERSION);
+	h->states = cpu_to_le32(dfa->states);
+	h->cmp_states = cpu_to_le32(dfa->cmp_states);
+	BUILD_BUG_ON(sizeof(dfa->hash) != sizeof(h->hash));
+	memcpy(h->hash, dfa->hash, sizeof(dfa->hash));
+
+	p = (__le32 *) (buf + sizeof(*h));
+	for (i = 0; i < dfa->states; i++) {
+		if (dfa->def[i] == SARA_INVALID_DFA_VALUE)
+			*p++ = cpu_to_le32(SARA_INVALID_DFA_VALUE_LOAD);
+		else
+			*p++ = cpu_to_le32(dfa->def[i]);
+	}
+	for (i = 0; i < dfa->states; i++) {
+		if (dfa->base[i] == SARA_INVALID_DFA_VALUE)
+			*p++ = cpu_to_le32(SARA_INVALID_DFA_VALUE_LOAD);
+		else
+			*p++ = cpu_to_le32(dfa->base[i]);
+	}
+	for (i = 0; i < (dfa->cmp_states * DFA_INPUTS); i++) {
+		if (dfa->next[i] == SARA_INVALID_DFA_VALUE)
+			*p++ = cpu_to_le32(SARA_INVALID_DFA_VALUE_LOAD);
+		else
+			*p++ = cpu_to_le32(dfa->next[i]);
+	}
+	for (i = 0; i < (dfa->cmp_states * DFA_INPUTS); i++) {
+		if (dfa->check[i] == SARA_INVALID_DFA_VALUE)
+			*p++ = cpu_to_le32(SARA_INVALID_DFA_VALUE_LOAD);
+		else
+			*p++ = cpu_to_le32(dfa->check[i]);
+	}
+	for (i = 0; i < dfa->states; i++) {
+		if (dfa->output[i] == SARA_INVALID_DFA_VALUE)
+			*p++ = cpu_to_le32(SARA_INVALID_DFA_VALUE_LOAD);
+		else
+			*p++ = cpu_to_le32(dfa->output[i]);
+	}
+
+	if (unlikely((void *) p != (void *) (buf + buf_len))) {
+		/*
+		 * We can calculate the correct buffer size upfront.
+		 * This should never happen.
+		 */
+		kvfree(buf);
+		pr_crit("memory corruption in %s\n", __func__);
+		return 0;
+	}
+
+	*buffer = buf;
+	return buf_len;
+}
+
+#undef SARA_INVALID_DFA_VALUE_LOAD
diff --git a/security/sara/dfa_test.c b/security/sara/dfa_test.c
new file mode 100644
index 0000000..9c06414
--- /dev/null
+++ b/security/sara/dfa_test.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * S.A.R.A. Linux Security Module
+ *
+ * Copyright (C) 2017 Salvatore Mesoraca <s.mesoraca16@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include "include/dfa.h"
+#include "include/securityfs.h"
+#include <linux/lsm_hooks.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+
+#define SARA_DFA_MAX_RES_SIZE 20
+
+struct sara_dfa_tables *table;
+
+static DEFINE_MUTEX(test_lock);
+static sara_dfa_output result;
+
+static bool is_valid_output(sara_dfa_output output)
+{
+	return true;
+}
+
+static int config_load(const char *buf, size_t buf_len)
+{
+	struct sara_dfa_tables *dfa, *tmp;
+
+	dfa = sara_dfa_load(buf, buf_len, is_valid_output);
+	if (unlikely(IS_ERR_OR_NULL(dfa))) {
+		if (unlikely(dfa == NULL))
+			return -EINVAL;
+		else
+			return PTR_ERR(dfa);
+	}
+	mutex_lock(&test_lock);
+	tmp = table;
+	table = dfa;
+	mutex_unlock(&test_lock);
+	sara_dfa_free_tables(tmp);
+	return 0;
+}
+
+static int config_load_str(const char *buf, size_t buf_len)
+{
+	char *s;
+
+	s = kmalloc(buf_len+1, GFP_KERNEL_ACCOUNT);
+	if (unlikely(s == NULL))
+		return -ENOMEM;
+	s[buf_len] = '\0';
+	memcpy(s, buf, buf_len);
+
+	mutex_lock(&test_lock);
+	result = SARA_INVALID_DFA_VALUE;
+	sara_dfa_match(table, s, &result);
+	mutex_unlock(&test_lock);
+
+	kfree(s);
+
+	return 0;
+}
+
+static ssize_t config_dump_result(char **buf)
+{
+	char *s;
+
+	s = kzalloc(SARA_DFA_MAX_RES_SIZE, GFP_KERNEL_ACCOUNT);
+	if (unlikely(s == NULL))
+		return -ENOMEM;
+	mutex_lock(&test_lock);
+	if (result == SARA_INVALID_DFA_VALUE)
+		snprintf(s, SARA_DFA_MAX_RES_SIZE, "%u\n", 0xffffffff);
+	else
+		snprintf(s,
+			 SARA_DFA_MAX_RES_SIZE,
+			 "%u\n",
+			 (unsigned int) result);
+	mutex_unlock(&test_lock);
+	*buf = s;
+	return strlen(s);
+}
+
+static struct sara_secfs_fptrs fptrs __lsm_ro_after_init = {
+	.load = config_load,
+};
+
+static struct sara_secfs_fptrs teststr __lsm_ro_after_init = {
+	.load = config_load_str,
+	.dump = config_dump_result,
+};
+
+static const struct sara_secfs_node dfa_test_fs[] __initconst = {
+	{
+		.name = ".load",
+		.type = SARA_SECFS_CONFIG_LOAD,
+		.data = &fptrs,
+	},
+	{
+		.name = "test",
+		.type = SARA_SECFS_CONFIG_LOAD,
+		.data = &teststr,
+	},
+	{
+		.name = "result",
+		.type = SARA_SECFS_CONFIG_DUMP,
+		.data = &teststr,
+	},
+};
+
+int __init sara_dfa_test_init(void)
+{
+	int ret;
+
+	table = sara_dfa_make_null();
+	if (unlikely(!table))
+		return -ENOMEM;
+	ret = sara_secfs_subtree_register("dfa_test",
+					  dfa_test_fs,
+					  ARRAY_SIZE(dfa_test_fs));
+	if (unlikely(ret))
+		goto out_fail;
+	return 0;
+
+out_fail:
+	sara_dfa_free_tables(table);
+	return ret;
+}
diff --git a/security/sara/include/dfa.h b/security/sara/include/dfa.h
new file mode 100644
index 0000000..a536b60
--- /dev/null
+++ b/security/sara/include/dfa.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * S.A.R.A. Linux Security Module
+ *
+ * Copyright (C) 2017 Salvatore Mesoraca <s.mesoraca16@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __SARA_DFA_H
+#define __SARA_DFA_H
+
+#include "securityfs.h"
+
+#ifdef CONFIG_SARA_DFA_32BIT
+typedef uint32_t sara_dfa_state;
+typedef uint32_t sara_dfa_output;
+#define SARA_INVALID_DFA_VALUE 0xffffffffu
+#else
+typedef uint16_t sara_dfa_state;
+typedef uint16_t sara_dfa_output;
+#define SARA_INVALID_DFA_VALUE 0xffffu
+#endif
+
+#define SARA_DFA_VERSION 2
+
+struct sara_dfa_tables {
+	sara_dfa_state states;
+	sara_dfa_state cmp_states;
+	sara_dfa_output *output;
+	sara_dfa_state *def;
+	sara_dfa_state *base;
+	sara_dfa_state *next;
+	sara_dfa_state *check;
+	char hash[SARA_CONFIG_HASH_LEN];
+};
+
+int sara_dfa_match(struct sara_dfa_tables *dfa,
+		   const unsigned char *s,
+		   sara_dfa_output *output);
+struct sara_dfa_tables *sara_dfa_make_null(void);
+struct sara_dfa_tables *sara_dfa_load(const char *buf,
+				      size_t buf_len,
+				      bool (*is_valid)(sara_dfa_output));
+ssize_t sara_dfa_dump(const struct sara_dfa_tables *dfa, char **buffer);
+void sara_dfa_free_tables(struct sara_dfa_tables *dfa);
+
+#endif /* __SARA_DFA_H */
diff --git a/security/sara/include/dfa_test.h b/security/sara/include/dfa_test.h
new file mode 100644
index 0000000..f10f78a
--- /dev/null
+++ b/security/sara/include/dfa_test.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * S.A.R.A. Linux Security Module
+ *
+ * Copyright (C) 2017 Salvatore Mesoraca <s.mesoraca16@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __SARA_DFA_TEST_H
+#define __SARA_DFA_TEST_H
+
+#ifdef CONFIG_SECURITY_SARA_DFA_TEST
+
+#include <linux/init.h>
+int sara_dfa_test_init(void) __init;
+
+#else /* CONFIG_SECURITY_SARA_DFA_TEST */
+inline int sara_dfa_test_init(void)
+{
+	return 0;
+}
+#endif /* CONFIG_SECURITY_SARA_DFA_TEST */
+
+#endif /* __SARA_DFA_TEST_H */
diff --git a/security/sara/main.c b/security/sara/main.c
index dc5dda4..6b09500 100644
--- a/security/sara/main.c
+++ b/security/sara/main.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/printk.h>
 
+#include "include/dfa_test.h"
 #include "include/sara.h"
 #include "include/sara_data.h"
 #include "include/securityfs.h"
@@ -99,6 +100,11 @@ static int __init sara_init(void)
 		goto error;
 	}
 
+	if (sara_dfa_test_init()) {
+		pr_crit("impossible to initialize DFA test interface.\n");
+		goto error;
+	}
+
 	pr_debug("initialized.\n");
 
 	if (sara_enabled)
-- 
1.9.1

