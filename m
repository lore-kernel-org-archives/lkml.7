Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17341C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA82220881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9Zc5r+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfEONwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 09:52:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45798 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfEONwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:52:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id b18so2754424wrq.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 06:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nytq/On43q8XPsmcb/kSTUQUu6ygGympqGdBDgeJzfY=;
        b=C9Zc5r+fI+/FO7h8AYtoREtVY8FaEZvGe/awFqM/h2Sjhl2yPheAI5gJllXqLo/9g8
         EYfqpBRqmVDz62X80O9XaD8idB4VEQAx4zIxi5CbJUJguCTDzSvAUYq+ESEsH0nOerRZ
         U0mcrPGx7YzHOQIXjyMWkPXtuTZe125hPDKlCLP7vR03oXTXpQl1K8ApJ+vIY2YSnluA
         njBDBytCi+CK1XjhQX0db0niLdYzN4A7f6gmN5h44c5LuMzbr+UOS8fHbNxW8+EbESEP
         B9DiP5TNWjH+vWzLQyGUopvXFZ11R94g09DYr6gkU3KEMiHMdhlHgXKOhop3LVLnXHNT
         KmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=nytq/On43q8XPsmcb/kSTUQUu6ygGympqGdBDgeJzfY=;
        b=em8NxyYsgl31c2KBLchD9w4w6M1JhbUwWeIQMWSI+tLPm73G9flqtIdvqZ9R6eliVq
         //yzy+tiE/tU2VJx5MfrtbNkIP0J3NdGFTCtqkMWeW4AfxQ+aJddpZj45kAABC369PfE
         +qFsXHaJMafsyOHHbtMYiWXoOTOraef9Ubs60gT0DuMoAI4rrXB8Ax375jETk8AM56wC
         cFM4j9I89FXyh8olN7KwSORd14wirkcQkcX+XVkchKVdKRFdCT4X7EKojjGK8HOtANVe
         su4CKD7gCYwkoce1FFGRfxAwXOe2yFU9KskaJxXzrs4TBQt/Nwt5d/zA+30z7csNwLok
         Yn0w==
X-Gm-Message-State: APjAAAWFMEPq2HlsFkoL5kpp2QRRAC75tsnCQv10JNGFkVLVtn3wwZiq
        X1fiPGgkxYsfqkCmeIELHILRSvxB
X-Google-Smtp-Source: APXvYqxn8yBAWfFqMrTjax6PBoUXe7fjtfc1XiH6muJ6fS3SzOZiH/DzI+lzz7JVSfykkQBkJ5jBHA==
X-Received: by 2002:adf:e850:: with SMTP id d16mr10513190wrn.269.1557928321334;
        Wed, 15 May 2019 06:52:01 -0700 (PDT)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id x187sm2256456wmb.33.2019.05.15.06.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 06:52:00 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 1FBCB1146D7B; Wed, 15 May 2019 15:51:49 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Christoph Hellwig <hch@infradead.org>,
        Michael Neuling <mikey@neuling.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc: silence a -Wcast-function-type warning in dawr_write_file_bool
Date:   Wed, 15 May 2019 15:51:46 +0200
Message-Id: <20190515135146.5866-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190515120942.3812-1-malat@debian.org>
References: <20190515120942.3812-1-malat@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit c1fe190c0672 ("powerpc: Add force enable of DAWR on P9
option") the following piece of code was added:

   smp_call_function((smp_call_func_t)set_dawr, &null_brk, 0);

Since GCC 8 this triggers the following warning about incompatible
function types:

  arch/powerpc/kernel/hw_breakpoint.c:408:21: error: cast between incompatible function types from 'int (*)(struct arch_hw_breakpoint *)' to 'void (*)(void *)' [-Werror=cast-function-type]

Since the warning is there for a reason, and should not be hidden behind
a cast, provide an intermediate callback function to avoid the warning.

Fixes: c1fe190c0672 ("powerpc: Add force enable of DAWR on P9 option")
Suggested-by: Christoph Hellwig <hch@infradead.org>
Cc: Michael Neuling <mikey@neuling.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: do not hide warning using a hack

 arch/powerpc/kernel/hw_breakpoint.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index f70fb89dbf60..969092d84a2f 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -386,6 +386,11 @@ void hw_breakpoint_pmu_read(struct perf_event *bp)
 bool dawr_force_enable;
 EXPORT_SYMBOL_GPL(dawr_force_enable);
 
+static void set_dawr_cb(void *info)
+{
+	set_dawr(info);
+}
+
 static ssize_t dawr_write_file_bool(struct file *file,
 				    const char __user *user_buf,
 				    size_t count, loff_t *ppos)
@@ -405,7 +410,7 @@ static ssize_t dawr_write_file_bool(struct file *file,
 
 	/* If we are clearing, make sure all CPUs have the DAWR cleared */
 	if (!dawr_force_enable)
-		smp_call_function((smp_call_func_t)set_dawr, &null_brk, 0);
+		smp_call_function(set_dawr_cb, &null_brk, 0);
 
 	return rc;
 }
-- 
2.20.1

