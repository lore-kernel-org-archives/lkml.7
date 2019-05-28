Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C62DC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2817920883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qh2G+h0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfE1MCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:02:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36493 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbfE1MCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:02:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so10875329pgb.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 05:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Qd+HXfP6tWSI0HcoIJwl+Fpj0ExKVFRKQwLbv5Nwsc0=;
        b=Qh2G+h0IkFtmzBypvp6s8Vegoz6aCZlFwcjjPeKT9rb6sO9VJpcIiVmIf64KrUUT1E
         /4glrIPx0QUMRnrbcNNjZczdnGMnvMHMfTYS7ecp/Y61+1ctNDgfqKovsUmsgXAB77Xg
         AxaeNaKjcT+2mgIudjd4kdxM98ePVA9RhOJ0D+9V8+WfJqze9BHHaTX6NGXSJ6++N4pe
         +x2xlx8q/tvFokTZwxkChZNwvNr2Gsi/jzS7V+rOm4VWtfNgT+HKqd85wNFuE2yjssaW
         784kC7oe3hCabApxWNhKf9s0HIhG5fjGvY/z4ER/zooyLGJUTuzAsGCR9BuJLLR0BXYZ
         atbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Qd+HXfP6tWSI0HcoIJwl+Fpj0ExKVFRKQwLbv5Nwsc0=;
        b=PK/TGSCcHrtBlkthShVZCKJwVOdrXN/bPXeGzao7MHHOSBUIGlVATR6eVNpp9VNsxU
         A3c0akH9rDGqRT9fHJCXMSo8FdRF08VbFkvw8iAK2PeFjfHO682TNtdlu91dq9ROuzVh
         D5mijhY53hF3FfeJtbVUZGvceYCYsE/ME2Cw79EkCY0NqlBzE3tO6s/cfH9TfZLQbWI9
         cds89APkJvl+5NBpFvyE7MXSxBq+jlfm3fk5LHj6h2KlhBsXyrRwiQFf8XJe0MvDLUaa
         JvixU7fF1rmV/BBzS8DBM/3TAWsDnWcs55yuiB6coTQkHr0hFRrMI6a5HE2QPc4RnYtc
         eHPQ==
X-Gm-Message-State: APjAAAXeuOE81Ee8rpQDBt37+hhZ4Pfg6FrD+0WGmtKtfkikEQgOS3JU
        k9zSbW9+/dfwmqVpZ1DavOuAwfJql24=
X-Google-Smtp-Source: APXvYqyKfn1+wV6XqZugXo4Afzd1vu95hGPOgvY9Z2pS7ediMhD34LGA+OQfKiSVMaAfqZ1q4WE26w==
X-Received: by 2002:a65:6551:: with SMTP id a17mr36667987pgw.1.1559044971524;
        Tue, 28 May 2019 05:02:51 -0700 (PDT)
Received: from xy-data.openstacklocal (ecs-159-138-22-150.compute.hwclouds-dns.com. [159.138.22.150])
        by smtp.gmail.com with ESMTPSA id p16sm14063075pff.35.2019.05.28.05.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 May 2019 05:02:51 -0700 (PDT)
From:   Young Xiao <92siuyang@gmail.com>
To:     gxt@pku.edu.cn, peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     Young Xiao <92siuyang@gmail.com>
Subject: [PATCH] unicore32: fix framepointer check in unwind_frame
Date:   Tue, 28 May 2019 20:04:00 +0800
Message-Id: <1559045040-23659-1-git-send-email-92siuyang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes corner case when (fp + 4) overflows unsigned long,
for example: fp = 0xFFFFFFFF -> fp + 4 == 3.

Copy from commit 3abb6671a9c0 ("ARM: 7913/1: fix framepointer check in
unwind_frame").

Signed-off-by: Young Xiao <92siuyang@gmail.com>
---
 arch/unicore32/kernel/stacktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/unicore32/kernel/stacktrace.c b/arch/unicore32/kernel/stacktrace.c
index e37da8c..8e5d12e 100644
--- a/arch/unicore32/kernel/stacktrace.c
+++ b/arch/unicore32/kernel/stacktrace.c
@@ -43,7 +43,7 @@ int notrace unwind_frame(struct stackframe *frame)
 	high = ALIGN(low, THREAD_SIZE);
 
 	/* check current frame pointer is within bounds */
-	if (fp < (low + 12) || fp + 4 >= high)
+	if (fp < low + 12 || fp > high - 4)
 		return -EINVAL;
 
 	/* restore the registers from the stack frame */
-- 
2.7.4

