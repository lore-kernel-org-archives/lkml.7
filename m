Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEC8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBE92147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6cNE8QD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfCLU3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:29:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32795 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfCLU3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:29:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id c13so2961533wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 13:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/5yG8xrfCpP8AB+WdyEFUE67Um//wbZhauRqrSkBGpU=;
        b=L6cNE8QD+qEBKws6bZAaEVinKJ1VVxbO1qPA3PBrNNvRbU90kbcvzC6vVVh1+VbESy
         FfuypCxd64kfwIJVmPXlOpds6n3NhsCuP82VomKxVKNMs8nLpMDv082zuIk0UdbOR+mr
         0IC35LnmhKC9onZohXgZ0bWbAjsZjXm/Bh7ofG/KmL3y+8c+wzWKlWAFpWr7uLdCpwGr
         kU9t5wAORHPMpYM1lbaW0r3q7Ia3luZlbhJOqRL6E56bh48w4ZBUFtFw98KT3OKZAbJ7
         vjSRdYHiu9pPoqnuS6EKTYENzE2APjJSr2r3FUMf9ETcNOrB28QrTz6DU9+yQDlK5G9A
         SO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=/5yG8xrfCpP8AB+WdyEFUE67Um//wbZhauRqrSkBGpU=;
        b=m6yRHli+lcpMj/dyJj3NdEiaYGsrWZoOJGghbbZjpfc+cPH7G1vte3h/NmbfWTESlV
         LjP1DqeLkF3YQVqaV5z5rx70kAzUPJS5CwILwI8L7oNyhNVCb1isOXSBxH5Pj4i9Y5c0
         p/V+a+cXFgz4jc4lkFPSpBd+LiWAQisr6mjPG90nIrtIto2f9NPpwlulMBWomQa18QeD
         oZ8QqUlNYeluD+D/HRjJFYROwR4GSdWWV3iZhND6aWukJsuXXK+TDy/thOtarvS01D3l
         VaGZHtv1wSu12rEhkBrvEpxuFqrppdJdlseUBkeSdqtAwJMdWhlQZrQIGhtky2pmw6sX
         uz8g==
X-Gm-Message-State: APjAAAXgw9oZeiYxCYKPBC0aRrffqdp/52X9BdRxxhDYjhCsmIvCeGig
        xu9KtGYfzQ7PmN9Xj/F2/Rc=
X-Google-Smtp-Source: APXvYqzs2iziP211uDkoWkpV/g3fhBePYhwRB9XVcbxz1lD8Q/I0onk5LcEOT4yHRDVN28BFoyYdtg==
X-Received: by 2002:a7b:c34c:: with SMTP id l12mr3637853wmj.126.1552422587333;
        Tue, 12 Mar 2019 13:29:47 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id w14sm16242504wrr.18.2019.03.12.13.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 13:29:46 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id BD0E611465D8; Tue, 12 Mar 2019 21:29:44 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/64s: Mark 'dummy_copy_buffer' as used
Date:   Tue, 12 Mar 2019 21:29:21 +0100
Message-Id: <20190312202921.31331-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 07d2a628bc00 ("powerpc/64s: Avoid cpabort in context switch
when possible") a buffer 'dummy_copy_buffer' was introduced. gcc does
not see this buffer being used in the inline assembly within function
'__switch_to', explicitly marked this variable as being used.

Prefer using '__aligned' to get passed line over 80 characters warning
in checkpatch.

This remove the following warning:

  arch/powerpc/kernel/process.c:1156:17: error: 'dummy_copy_buffer' defined but not used [-Werror=unused-const-variable=]

Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 77e44275d025..5acf63d45802 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1153,7 +1153,7 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 
 #ifdef CONFIG_PPC_BOOK3S_64
 #define CP_SIZE 128
-static const u8 dummy_copy_buffer[CP_SIZE] __attribute__((aligned(CP_SIZE)));
+static const u8 dummy_copy_buffer[CP_SIZE] __aligned(CP_SIZE) __used;
 #endif
 
 struct task_struct *__switch_to(struct task_struct *prev,
-- 
2.20.1

