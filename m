Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14416C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14B420820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGTXvmj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407415AbfIWRR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 13:17:58 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35235 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfIWRR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 13:17:57 -0400
Received: by mail-qk1-f196.google.com with SMTP id w2so16257142qkf.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 10:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NqsehSBKMKDO8NnwgZk11cPX0Pb+XtQ+3DVSQLpGbJo=;
        b=LGTXvmj+7/EJH4QYdmB05CZVGcHxpOXXQSP85/rWtT5nOtbNoaGGKivN4EXG1GMX4m
         T+TpllFX4nO3p4uD0NHIewInxNN0kzdFPpsK3i6qP2G8mwhGmQxurRSkH2gpL7qk/JAt
         ZxhSz50Vhqbt3cFmvvFp6iv+J9aBUgUrSuJdQAJ+4bPLv4PUTPqV56Gp6S+fxFAdBkWj
         sV10kJ2tLNVSv3/srOpqH4iUiE+i/O0yWH+dXLJksa1yJEdxcQ0oExSJMSJ1XQPvK8q/
         ER9/VOB8a3Dwv8oPW/nmMJ7j3wNgm/uaLRRjimemqIXNlU0r+xfZfMgqQ0tJ1+Q2gUzo
         pTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NqsehSBKMKDO8NnwgZk11cPX0Pb+XtQ+3DVSQLpGbJo=;
        b=rQuhyBBf0r1jS2DmXotE9ucY31D8gVMUJK8WoR7Zq+q1/QVMcCnX7yT/N26QgZKXbq
         YtTW24xhhjnoWRC5cZFy3wqYExYdgaUqTj2F3qIQFnlqQXA2Gk9RczDLR9mKws6hbIaS
         FAV3fsLVMV61v/Jb62Jju8MRar2wUxnmsOpzF4jA7eiMpYrTZrNRTSJBe5LSFVtCQQ/4
         19b6ePgWZGFtdiQ/oqZ1pvcvaMHUQeirLRBt08FytN4ApPdvCABWuDf+dCt7w4C81SoA
         pExBLNSj31KPF7I/BaQbMmWMXV2c9IiDl2O6hF/dGBRaHiTe4g66E3TQ7vYm9vb3s7Ny
         mNiw==
X-Gm-Message-State: APjAAAWEh2S2cZD/3nX+8Sw4jj1TGV+2SxBdtjLPG2LCZkLmalqWwzg6
        +fg74dY0R25eaFhteFIkkm8=
X-Google-Smtp-Source: APXvYqzQY91GpAjlBimxNHbbd38GmmzfY3qT6CV8kJMFT2ZSyjHb6tn75miQqKFyAeh0emvPyNM3mw==
X-Received: by 2002:a37:a68e:: with SMTP id p136mr919474qke.49.1569259076654;
        Mon, 23 Sep 2019 10:17:56 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k54sm6917600qtf.28.2019.09.23.10.17.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 10:17:56 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 23 Sep 2019 13:17:54 -0400
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: [PATCH] x86/purgatory: Add $(DISABLE_STACKLEAK_PLUGIN)
Message-ID: <20190923171753.GA2252517@rani.riverdale.lan>
References: <20190922173241.GA44503@rani.riverdale.lan>
 <CAKwvOd=X9+uxQSzKad8B-Lw=ZarBT+SfNpBm_TE0k+DeJZmrsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOd=X9+uxQSzKad8B-Lw=ZarBT+SfNpBm_TE0k+DeJZmrsw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit b059f801a937 ("x86/purgatory: Use CFLAGS_REMOVE rather than
reset KBUILD_CFLAGS") kexec breaks is GCC_PLUGIN_STACKLEAK is enabled, as
the purgatory contains undefined references to stackleak_track_stack.
Attempting to load a kexec kernel results in:
	kexec: Undefined symbol: stackleak_track_stack
	kexec-bzImage64: Loading purgatory failed

Fix this by disabling the stackleak plugin for purgatory.

Fixes: b059f801a937 ("x86/purgatory: Use CFLAGS_REMOVE rather than reset KBUILD_CFLAGS")
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/purgatory/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 527749066d31..fb4ee5444379 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -25,6 +25,7 @@ KCOV_INSTRUMENT := n
 
 PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
 PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss
+PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN)
 
 # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
 # in turn leaves some undefined symbols like __fentry__ in purgatory and not
-- 
2.21.0

