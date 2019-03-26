Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B0EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEE720700
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wN0OIU1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732931AbfCZS3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:29:20 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:42134 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732832AbfCZS2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:49 -0400
Received: by mail-qt1-f201.google.com with SMTP id n10so14436801qtk.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ma5wFY8S+zLWiDtQQwXloQOufb4HtIW6yNfW58R46nU=;
        b=wN0OIU1HzFEnoV/MZj6PHWhTJfdiTInfVQklLLV38xbLMNs2qONKeSBC8YID/jggEH
         t/1BopOkbJq1ePdwJ+QdFX7IctHJCxejZ3vf2jLDkjb3qnbZWMwH8eR/WUCB8Q5Th/Ez
         4lrlGF72lQ48rIq//y3d2kcNqTVMHtToNl/cbQCf2DzfZZG+EjUqxiX4YFqpg71sB+3K
         4F64WWZw8uoy6mXFzkzm4yC/FjOfp8xhXFADBtx6zsC84pABkQC1Oh53fW8hNhMTWWqZ
         fpvmV869hLUznUiw3l7GE6Wlbk40rS3dJJXRhoC6YMJHivTGDpfIWVe8mY/XJ/XO+/57
         VC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ma5wFY8S+zLWiDtQQwXloQOufb4HtIW6yNfW58R46nU=;
        b=FMy9oOuO7Yz7ozP1WtRPze+vjgakknPVbj7jbCFhVosQRKZE4V8gvUeRUTLrGZAFpc
         vGBe8DOY2ZgRfrBW1R0ssiyCClbehI3uCux47U1++xoN2a1u4CDpcYPnOzexYncVqOHq
         WUdV4QTXbKIShLHWcRrpNd8JO+VPJ8avRMUQhLDq1/Bye6yf4JYX2WsqtPC4j9ALJafb
         yNtSFaKvTqhm9JTW37qcT/M+2RWgTa62FF37TkO0lGENtK1L0bvqsATGiD02MY4Ec2SD
         SLxJiNekU6ozt2+Ztdxk8opFNDpGhVeRx0s14bHgktkc3yzluxYBCdlh6tawMlCECcCH
         LWSw==
X-Gm-Message-State: APjAAAVeG+601BCe9knikjPSlMWWDY+OHyLQ2VxZj4bnpvYBNc9jomnf
        mAokys1jBZ0q2yWKql/1pfR6SmYOORKkd9eyClDgeQ==
X-Google-Smtp-Source: APXvYqwe4mmFrCuPysLxkasGyEoSo4wHh50ua9s3bXX44JvYkgrjNaVz/zCC7KJz3TKl7vwF7Bx3Swls6JSZeKjjZ97dXQ==
X-Received: by 2002:a05:620a:153b:: with SMTP id n27mr23767904qkk.343.1553624927797;
 Tue, 26 Mar 2019 11:28:47 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:37 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-22-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 21/25] Lock down kprobes when in confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        davem@davemloft.net, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Disallow the creation of kprobes when the kernel is locked down in
confidentiality mode by preventing their registration.  This prevents
kprobes from being used to access kernel memory to steal crypto data.

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: davem@davemloft.net
Cc: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f4ddfdd2d07e..b9781bd2db8c 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1552,6 +1552,9 @@ int register_kprobe(struct kprobe *p)
 	struct module *probed_mod;
 	kprobe_opcode_t *addr;
 
+	if (kernel_is_locked_down("Use of kprobes", LOCKDOWN_CONFIDENTIALITY))
+		return -EPERM;
+
 	/* Adjust probe address from symbol */
 	addr = kprobe_addr(p);
 	if (IS_ERR(addr))
-- 
2.21.0.392.gf8f6787159e-goog

