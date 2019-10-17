Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247DAFA3736
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE02920854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nw1HzU4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439958AbfJQONs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:13:48 -0400
Received: from mail-wm1-f74.google.com ([209.85.128.74]:54484 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439941AbfJQONp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:13:45 -0400
Received: by mail-wm1-f74.google.com with SMTP id g67so1123455wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 07:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3gVtAYjAise6qkpXvJpnBc4+Dg01VPHxIztWXKyEDrs=;
        b=nw1HzU4YhpADMRj5UcTtHVLYN5BYzkEigcx4qq8GgANxDr1oa7wwp9eBrai6SevU3L
         j6+eBoMTDTLr4MfHhPgQAfCVxbs/TDtYH3dM34nHE9GwrKvxMVkIM8SKmzOVCgyNsl1J
         8JCWp8E1/V2C5sPtkhe+9qZtMe1Jlqj/tGsabkTzYwAXrhNRPPV61Krj4j7eL33dzCRo
         vi3iEmj/yoEDHZlTklvYDdAo2+pPavz2RxydqsIaxQBoN62eHioWvJMGflKNnvf3DEvQ
         uH0PCgQuc9bA4n/QMMwlzKF0xDJkVO6Esd8Thk2Un4lhRcJMfpw6KYrPCMgh7QspQH3M
         /3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3gVtAYjAise6qkpXvJpnBc4+Dg01VPHxIztWXKyEDrs=;
        b=chXT4HdwZ9zD0iDjhYTX7fuJkx7XrEVc+geTLiUe3H8dpkzGNP8JXXMbysEhnYNB42
         iY5uG63Cv43RCJs7orm9VoDH6c92G1/eW2TOVTiU3cSqY+Rsrkm0Vmz2t5xEg4sCej54
         NfiRRgF+AJQznvD6FPHVIhxo9hmpCqclwCDmfv6I8c4vjVd3RENNN+m34PaP6/E5rdPv
         92AZgbCqz6ix0xt91bEfp9nyLKSS3d00MQNLeEw4mEEcn0tJ2fwn1o5rUyaZyOyrs9yo
         Ch/Ail52I6jU+Zv6I/+dJr8hlH1nMnU1HXYs/WNFYD40JfsSdcvLSEUDW1kP9WPEcrBU
         kG6A==
X-Gm-Message-State: APjAAAUd0MG+2kbIuvDu7C/ub2jyRI6GSDzeNz3qHGl30Vy4sVhpLA+1
        CSN0HNlUqraq8yeHc/mVtA8CvHbg+w==
X-Google-Smtp-Source: APXvYqwm5MBAQfwag+rUQZPLBD5lU8Dcy9D4qbG5eYoF6kbjjpG7UAv0Jr3LBxiSV8B2Gx4Vpx/JXFdfwA==
X-Received: by 2002:adf:b102:: with SMTP id l2mr3493651wra.269.1571321621593;
 Thu, 17 Oct 2019 07:13:41 -0700 (PDT)
Date:   Thu, 17 Oct 2019 16:13:02 +0200
In-Reply-To: <20191017141305.146193-1-elver@google.com>
Message-Id: <20191017141305.146193-6-elver@google.com>
Mime-Version: 1.0
References: <20191017141305.146193-1-elver@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 5/8] seqlock: Require WRITE_ONCE surrounding raw_seqcount_barrier
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com,
        parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com,
        bp@alien8.de, dja@axtens.net, dlustig@nvidia.com,
        dave.hansen@linux.intel.com, dhowells@redhat.com,
        dvyukov@google.com, hpa@zytor.com, mingo@redhat.com,
        j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net,
        jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com,
        npiggin@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch proposes to require marked atomic accesses surrounding
raw_write_seqcount_barrier. We reason that otherwise there is no way to
guarantee propagation nor atomicity of writes before/after the barrier
[1]. For example, consider the compiler tears stores either before or
after the barrier; in this case, readers may observe a partial value,
and because readers are unaware that writes are going on (writes are not
in a seq-writer critical section), will complete the seq-reader critical
section while having observed some partial state.
[1] https://lwn.net/Articles/793253/

This came up when designing and implementing KCSAN, because KCSAN would
flag these accesses as data-races. After careful analysis, our reasoning
as above led us to conclude that the best thing to do is to propose an
amendment to the raw_seqcount_barrier usage.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/seqlock.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 1e425831a7ed..5d50aad53b47 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -265,6 +265,13 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
  * usual consistency guarantee. It is one wmb cheaper, because we can
  * collapse the two back-to-back wmb()s.
  *
+ * Note that, writes surrounding the barrier should be declared atomic (e.g.
+ * via WRITE_ONCE): a) to ensure the writes become visible to other threads
+ * atomically, avoiding compiler optimizations; b) to document which writes are
+ * meant to propagate to the reader critical section. This is necessary because
+ * neither writes before and after the barrier are enclosed in a seq-writer
+ * critical section that would ensure readers are aware of ongoing writes.
+ *
  *      seqcount_t seq;
  *      bool X = true, Y = false;
  *
-- 
2.23.0.866.gb869b98d4c-goog

