Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905C6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0DD2186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfCTFJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:09:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35750 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbfCTFJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 01:09:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so877776pgf.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 22:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NzF2lox56cCw7G7V/HuQAT3g3XyLKaDXps4ZB1oA+bc=;
        b=Fk8K7AsU6La5lO3wRAxifDP4cjlbwd7BOOatAPDsU313oOSfSeAuS4LksQOwDPDZqH
         KfMEdQPlNWCxyQbnXG+rvE3+qdzqa0v7oRzX842Vx7vioXyqKTtfz2KGe9DZLJHy31BF
         Kqxd+bElNtZF/Fp+mgy0McODs1zG0MVz5gYXzOJpBLGeKI3O/oX0yvQulOmeCaXBluXW
         AB2zmkbEZq9JN1iHHalJSDqbxH6T0AhSX7co92JlQ+fKr9gGiTZfCv6IKxdU4O8AURe8
         ufwD7w+XsavkyNESyPdSbVz4W6REqJdA71IVjOQXWsS0LVfv/CsJrS1PK3XNYPxPZV6m
         fIUQ==
X-Gm-Message-State: APjAAAXiMJU2b75Y2t3HJwJ3f8b+UfBb1mDdiSni0azTf7YRDU7Qn3Yo
        OM8bb0IlN3o2xAV99J3RwVQSbJWJuyk=
X-Google-Smtp-Source: APXvYqz11gH+I/P5+wWWISa5BJ9kL4DjJeRovWcoEtWVrZ9t7h0ul+/Pcy/JsXGCFXwgldP+Gz6FQg==
X-Received: by 2002:a17:902:7b93:: with SMTP id w19mr5881676pll.141.1553058594147;
        Tue, 19 Mar 2019 22:09:54 -0700 (PDT)
Received: from localhost ([122.177.144.121])
        by smtp.gmail.com with ESMTPSA id t10sm1470971pgo.27.2019.03.19.22.09.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 22:09:53 -0700 (PDT)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     bhsharma@redhat.com, bhupesh.linux@gmail.com,
        Boris Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org
Subject: [PATCH v3 3/3] Documentation/vmcoreinfo: Add documentation for 'MAX_PHYSMEM_BITS'
Date:   Wed, 20 Mar 2019 10:39:34 +0530
Message-Id: <1553058574-18606-4-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553058574-18606-1-git-send-email-bhsharma@redhat.com>
References: <1553058574-18606-1-git-send-email-bhsharma@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for 'MAX_PHYSMEM_BITS' variable being added to
vmcoreinfo.

'MAX_PHYSMEM_BITS' defines the maximum supported physical address
space memory.

Cc: Boris Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dave Anderson <anderson@redhat.com>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: x86@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 Documentation/kdump/vmcoreinfo.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/kdump/vmcoreinfo.txt b/Documentation/kdump/vmcoreinfo.txt
index bb94a4bd597a..f5a11388dc49 100644
--- a/Documentation/kdump/vmcoreinfo.txt
+++ b/Documentation/kdump/vmcoreinfo.txt
@@ -95,6 +95,11 @@ It exists in the sparse memory mapping model, and it is also somewhat
 similar to the mem_map variable, both of them are used to translate an
 address.
 
+MAX_PHYSMEM_BITS
+----------------
+
+Defines the maximum supported physical address space memory.
+
 page
 ----
 
-- 
2.7.4

