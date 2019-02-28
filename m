Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73020C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1762133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pnhNMoj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388180AbfB1XNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:13:09 -0500
Received: from mail-oi1-f201.google.com ([209.85.167.201]:42519 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388128AbfB1XNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:13:04 -0500
Received: by mail-oi1-f201.google.com with SMTP id j205so9747438oih.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JIwaSFIgIpUk1i3h4qdR8xZajEtDlWkjNkGrpJU0gjI=;
        b=pnhNMoj3vEwEZFQ80G+9zkZNjLXJb/86amfRx9ym9v/+3EvPEut4iVIgscYdJFc90A
         m1w294KRxnq5r8gj97JIKxU8ZiLkOhVJ+LOPc1fd5QYFG6kBaWFAzWtKXVwW/Hcr2YO9
         J9VFWbp5K1QXuhedJNxRRssZWy5rpc5C2jFMdB7Ush+pn9Fr+onFXwGStQLqZWQa7J6L
         dqXhrvzgWTvII4B1PXZ7eDgVj0KLKO8Bs4KPuhGuvYQ3Iw9T5L4ghAkGdJypAihkcdfm
         Pb8S9wc8LVS8ofuhm0G15AUrOGnogvi0xzmLh6CA+WGqMZj7p+NBNgzDatgZy5pqTbvl
         8uMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JIwaSFIgIpUk1i3h4qdR8xZajEtDlWkjNkGrpJU0gjI=;
        b=d1wMdgdCP8bebS3h2IaBn2fB0MTxovVJO/vbthpRRnO4pjhYJQhnMhGV9sLWVIBSEn
         Pw41lzhC61fix9RN2DWZhJlOMRKrLBhdES1chRYNOCsOflFfkYFe6a3Gdrtd0y5EDyRJ
         uDyCsz1OiBhKXL14j5tsztIkbqsJeotw6boKyIFzfTI2f5ven1Ud4E5K/g2nu3F1TPVq
         gc4SbzyDUjwgpis2dXgqQVjqbZTs5lulN3mOm2PxKtt2+wdwevzZqfUDtwtQBxSxKOp7
         eCLiZsCnOtW2aoWaSdzeXpPqxyZsn4PyLMUYClFsOzExrYYa/16bM1uO8N4I60dCcs84
         ygHQ==
X-Gm-Message-State: APjAAAVo8/WInVM8F4IpcbvnsesXgKfX6qKlWMzvDAz/J9M7Wm1T2Xo4
        Llp6HSjdRuhT4O+Xd/KXKmWyC4J92cGWhphcRmOuDg==
X-Google-Smtp-Source: APXvYqyTAQpBWJqJBvnFjzipwZ1yX7nxGIsNthCKsjRm6tRMc3jq4nOkuFbUCwM1avNqR/85HT7iEU7SeMicoTGP0rwGYQ==
X-Received: by 2002:a05:6830:8b:: with SMTP id a11mr1298882oto.33.1551395584234;
 Thu, 28 Feb 2019 15:13:04 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:59 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-23-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 23/27] Lock down kprobes
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
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
2.21.0.352.gf09ad66450-goog

