Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FA5C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 19:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B54021924
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 19:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LI5ozv1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfKITRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 14:17:55 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39755 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfKITRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 14:17:51 -0500
Received: by mail-pf1-f195.google.com with SMTP id x28so7382918pfo.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 11:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mXFzTIQULMmuTDmTZ6dVKohz/gl+dRtj6ccr6Op88KM=;
        b=LI5ozv1fTxbjr7x/dcDUh1mB2Iwxyf2fpfKuXvFQulIkd9YYm2IU8paiccu3EotNtk
         wDJqmbFshW43M/V4r+iGHGDG6uw/mJwvq0g2eyrCfenSMsNd3qcwuHmUVNq/PlOW7tvy
         1pLLqJgWNfjC/p5racDr1lFjxnY0r9jZw5HQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mXFzTIQULMmuTDmTZ6dVKohz/gl+dRtj6ccr6Op88KM=;
        b=PaEqFLodY4HruKJzaULC0CSG5rC8mag4GtrFxeQnhK1CZgrMwLo1gFK+BbX0z11aWE
         qar59IriJ3QGFpYIYMU/xCjOrlmihYXxUxMskReyzhu8pysRVaLtXTL8amE4KIJIjdvF
         4AB2756hzfxkBcExLaPQollVGEBFibBSQ+tlUOjtAP0r99hYEiExgo3Sq0N7jTMjZpLO
         3Hb7memwbZxKg8uJldJ/jaIF6Npki/t0DOtPkrcXqAS7EHLvpcbsMp3VcB/vpaK12n+I
         lZxjxO65E7szvgqGlYBX64nhnxhg2/2Mkn4ZdQrIQawYTWSCayynZ5L3nHksH0MeL67R
         fZvQ==
X-Gm-Message-State: APjAAAXdehiZAWy0eYHIorU5mnzTZpMXHA9hvHZHbeSAJALiR8X7p2WK
        l9sNs+AW+EqxoDuXQBRlT41pnA==
X-Google-Smtp-Source: APXvYqyJ/5A4gHEs+sAnhcIJcA/HukdqC84S1VJK0RNlrtJ8DJl9XngaqApx43e536fdHhCsG/SlEA==
X-Received: by 2002:a63:ec4b:: with SMTP id r11mr19367156pgj.147.1573327070394;
        Sat, 09 Nov 2019 11:17:50 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id i11sm9193577pgd.7.2019.11.09.11.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 11:17:49 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Paul Burton <paul.burton@mips.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     qiaochong@loongson.cn, kgdb-bugreport@lists.sourceforge.net,
        ralf@linux-mips.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 2/5] kdb: kdb_current_regs should be private
Date:   Sat,  9 Nov 2019 11:16:41 -0800
Message-Id: <20191109111623.2.Iadbfb484e90b557cc4b5ac9890bfca732cd99d77@changeid>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191109191644.191766-1-dianders@chromium.org>
References: <20191109191644.191766-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of the patch ("MIPS: kdb: Remove old workaround for backtracing on
other CPUs") there is no reason for kdb_current_regs to be in the
public "kdb.h".  Let's move it next to kdb_current_task.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 include/linux/kdb.h            | 2 --
 kernel/debug/kdb/kdb_private.h | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/kdb.h b/include/linux/kdb.h
index 68bd88223417..24cd447659e0 100644
--- a/include/linux/kdb.h
+++ b/include/linux/kdb.h
@@ -183,8 +183,6 @@ int kdb_process_cpu(const struct task_struct *p)
 	return cpu;
 }
 
-/* kdb access to register set for stack dumping */
-extern struct pt_regs *kdb_current_regs;
 #ifdef CONFIG_KALLSYMS
 extern const char *kdb_walk_kallsyms(loff_t *pos);
 #else /* ! CONFIG_KALLSYMS */
diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
index 55d052061ef9..e829b22f3946 100644
--- a/kernel/debug/kdb/kdb_private.h
+++ b/kernel/debug/kdb/kdb_private.h
@@ -242,6 +242,7 @@ extern void debug_kusage(void);
 
 extern void kdb_set_current_task(struct task_struct *);
 extern struct task_struct *kdb_current_task;
+extern struct pt_regs *kdb_current_regs;
 
 #ifdef CONFIG_KDB_KEYBOARD
 extern void kdb_kbd_cleanup_state(void);
-- 
2.24.0.432.g9d3f5f5b63-goog

