Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC36AC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B62C208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWiWMfB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfD0GnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:43:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44006 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfD0GnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:43:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id e67so2741608pfe.10;
        Fri, 26 Apr 2019 23:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CLKl6NZzJuOK2yM4IgvyVy0XzBWA5gDBiZYSHfLNQ00=;
        b=LWiWMfB1NCPlUWHzx7KNU9QCQPe3RdgA8qCNPze1WHQjmMq2EnzDsMlPceyPd+MHEm
         QMnqsza7hwGkI6ZFGgTOeRjeOEfXCrRJYup1t+tZNnEBvqMdc01pTHEj2bJKvz7BRo7K
         E/q3JXY24fjwRSyZU/Tw4XNKZ1nfyh4euDeX0+jZD8/F9QgFlj4BNpu6QQplyXiEhS74
         PVZ8Bi1kj7P4bpKFaIDD7kzaPwPpjBstpFpZumGDsgFZsa4oA3jDKygoO8TIjMEYq1h+
         8j/kDmbTP0+sW4oBzq9jDl4H2CBcWV2hkh9XtxTKhVDjbhF8cy7tl1t7BO8Iros2slYv
         iP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CLKl6NZzJuOK2yM4IgvyVy0XzBWA5gDBiZYSHfLNQ00=;
        b=lI+mvh/uuXJUbpWZjmK7o5G+JDl5zlSN1dPZXPc5jHKYv9uqb2YZtH4g8H1lVX5zoO
         ssDRG8enaXxGjHII4qKuJHOOLP3UBGTFruxuajjDaEzAN3SSp+PpMz4z5k7aqTEd5OYM
         BVxqSEfyXbLj/SYbBF6EVkcivLJVMLIhjQY59QuRWi8cJ2d1QNz9njg6OJRj+Ylcm3wc
         VjhTfsd2EuVUCvGh+/nD0AcaaAx1qOWW8Xu6foGL+EML3ud6cki3Q2fXHuFTyKoUIFfk
         X43kVEE/s++RuR5BIB5qWzZQXZE40feSFCbavrHG2h7AaamQucZz3hHsH1k+C7BvzKPl
         DWtA==
X-Gm-Message-State: APjAAAWriFohq44B0F7Gk1qnO8TjjZ7N/nZcxrhgLYE8U0gWcI86Yjdp
        giaz6Jtyjru8xoJdfCrXuwM=
X-Google-Smtp-Source: APXvYqx8IDeCvv7F4Tl+g2zi6Qtjw6+CBIajqUbAMvc7uvXy5z6A8pYUXx0y0vJXO744BzKTEFFO2g==
X-Received: by 2002:aa7:91d6:: with SMTP id z22mr42068121pfa.242.1556347399283;
        Fri, 26 Apr 2019 23:43:19 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j22sm36460145pfn.129.2019.04.26.23.43.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 23:43:18 -0700 (PDT)
From:   nadav.amit@gmail.com
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v6 10/24] x86/ftrace: Set trampoline pages as executable
Date:   Fri, 26 Apr 2019 16:22:49 -0700
Message-Id: <20190426232303.28381-11-nadav.amit@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426232303.28381-1-nadav.amit@gmail.com>
References: <20190426232303.28381-1-nadav.amit@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Since alloc_module() will not set the pages as executable soon, set
ftrace trampoline pages as executable after they are allocated.

For the time being, do not change ftrace to use the text_poke()
interface. As a result, ftrace still breaks W^X.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/ftrace.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index ef49517f6bb2..53ba1aa3a01f 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -730,6 +730,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	unsigned long end_offset;
 	unsigned long op_offset;
 	unsigned long offset;
+	unsigned long npages;
 	unsigned long size;
 	unsigned long retq;
 	unsigned long *ptr;
@@ -762,6 +763,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 		return 0;
 
 	*tramp_size = size + RET_SIZE + sizeof(void *);
+	npages = DIV_ROUND_UP(*tramp_size, PAGE_SIZE);
 
 	/* Copy ftrace_caller onto the trampoline memory */
 	ret = probe_kernel_read(trampoline, (void *)start_offset, size);
@@ -806,6 +808,12 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	/* ALLOC_TRAMP flags lets us know we created it */
 	ops->flags |= FTRACE_OPS_FL_ALLOC_TRAMP;
 
+	/*
+	 * Module allocation needs to be completed by making the page
+	 * executable. The page is still writable, which is a security hazard,
+	 * but anyhow ftrace breaks W^X completely.
+	 */
+	set_memory_x((unsigned long)trampoline, npages);
 	return (unsigned long)trampoline;
 fail:
 	tramp_free(trampoline, *tramp_size);
-- 
2.17.1

