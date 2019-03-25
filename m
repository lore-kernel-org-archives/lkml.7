Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529A0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD7D2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NIjTDHQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbfCYWLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:11:38 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:50934 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731170AbfCYWK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:10:56 -0400
Received: by mail-pf1-f202.google.com with SMTP id a3so6399650pfi.17
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=naZ0ixtXEBG7XGPLPxcUPIELDdBmoCPAXKyiyaNTZ5I=;
        b=NIjTDHQHLWbBplFeWWC4DRIWlFLcDZNTxuEyxwPxtXI2qmNuqY428e8JBIwylotaIw
         ylsTVVH9P/FOzh/oECPMhER8ShKqU/Oojusg3kQ0yTKZnOETHhFv3numCvnwKRdjEnGD
         ldQasPDsT2jf2buPy6NZeoNpKrdxyERByjj79L1/dagfSJO7099lgFWB8X/duR41w9UC
         iYrE2xAAl5rfRQt3+WS9KdIY0YSiZXF000HvMH83kygW9yVJ8uW4A5jbuDyM8MR7A0ev
         0Lu2sJVrtiBY5OhVpkRQdMIEt56Yv5en0v8UGiq/8udcfKdFC1gxhJxBVvzxDVDZnGAp
         ox6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=naZ0ixtXEBG7XGPLPxcUPIELDdBmoCPAXKyiyaNTZ5I=;
        b=BhWlJj0z/kf87si1+gXHxcTMJ/m9Da2dSQET1H4ZjFeMINnQc07oxI0vmFuGG5Xsot
         LqIIZGUKh4bIfOyV4hFKdrhxZVoRToZZAXKxWzTo6HiXjGt/x9qhO2iEEMIbCfWxZheD
         nH8YRAPx5H50RlpOBu65Ut6C9hQnlXnDxtxwyXXD+A620tW11pfFRro3kWF8k+fpADTg
         +TKwPyi0wHac3ORUed6bKygwBv61xXFtNPosYQti1ixJKF37k7juMaLlcZoFWK6TNfZR
         Qp3cQ9Qx3pYkxdwe2gnMxVg62yka5JQDsxehSJ4g/05KzBpYUPFNFDbhlOQLaDg99QYY
         mcUQ==
X-Gm-Message-State: APjAAAX0+BivR/NsPeAc0j9oV/hy0Q5WdL+lpIoikC6DJIwvUoqNZiVm
        3VNK70VZxxqULkFMo7SZkjdqitpxgw1wgwW2knMSEA==
X-Google-Smtp-Source: APXvYqzN3xQUlEDfZ5+zFhO3QC8Yq79t0kRhGvrE59XgU2rstOpQfmofhCWF259NyTHdEf0rdfpMm975BTAJIqf8WLZgcQ==
X-Received: by 2002:a63:470a:: with SMTP id u10mr26134869pga.17.1553551855675;
 Mon, 25 Mar 2019 15:10:55 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:49 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-23-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 22/27] Lock down kprobes
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        davem@davemloft.net, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Disallow the creation of kprobes when the kernel is locked down by
preventing their registration.  This prevents kprobes from being used to
access kernel memory, either to make modifications or to steal crypto data.

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: davem@davemloft.net
Cc: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f4ddfdd2d07e..6f66cca8e2c6 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1552,6 +1552,9 @@ int register_kprobe(struct kprobe *p)
 	struct module *probed_mod;
 	kprobe_opcode_t *addr;
 
+	if (kernel_is_locked_down("Use of kprobes"))
+		return -EPERM;
+
 	/* Adjust probe address from symbol */
 	addr = kprobe_addr(p);
 	if (IS_ERR(addr))
-- 
2.21.0.392.gf8f6787159e-goog

