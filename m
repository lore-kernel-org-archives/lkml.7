Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9297C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A388A218BC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563509147;
	bh=PYUMwW81nL4j6L7dWWoWrTNOr2MEWKgrnQEjci95ZC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VANI27vGvK8VlXzsm7PdaiG4egRU4eZ2kNOP1PbHC8VbdT/2tDurJUCeKTyU/oMMW
	 tae8UjGSQOrxHhlRNSxxSXWYlMHjZKn2pmZOFz1K8ms7cPMgaH2YfeiEednn/zH+mn
	 o1baDenFoqJnX6gzNVj4t7RtNwX5GKH5rmHL1KiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731982AbfGSEFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:05:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731851AbfGSEFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:05:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AAEE21873;
        Fri, 19 Jul 2019 04:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509141;
        bh=PYUMwW81nL4j6L7dWWoWrTNOr2MEWKgrnQEjci95ZC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F71xRK4Zk4zq08K0wYBerVComzBDnamw/uOCq/2CM0xidiULarUeU7htdsuiQktmk
         RMRjW9U5OEwsHZYAJt79hKJGZlTOxUbsEM195/6K37WxI8Gfq7zrPJxTWd//EGh0C2
         X6Vq5NWQPRHI0Hu6TvxJHCmgZJrZAQoewsAzs8mE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 093/141] kallsyms: exclude kasan local symbols on s390
Date:   Fri, 19 Jul 2019 00:01:58 -0400
Message-Id: <20190719040246.15945-93-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719040246.15945-1-sashal@kernel.org>
References: <20190719040246.15945-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 33177f01ca3fe550146bb9001bec2fd806b2f40c ]

gcc asan instrumentation emits the following sequence to store frame pc
when the kernel is built with CONFIG_RELOCATABLE:
debug/vsprintf.s:
        .section        .data.rel.ro.local,"aw"
        .align  8
.LC3:
        .quad   .LASANPC4826@GOTOFF
.text
        .align  8
        .type   number, @function
number:
.LASANPC4826:

and in case reloc is issued for LASANPC label it also gets into .symtab
with the same address as actual function symbol:
$ nm -n vmlinux | grep 0000000001397150
0000000001397150 t .LASANPC4826
0000000001397150 t number

In the end kernel backtraces are almost unreadable:
[  143.748476] Call Trace:
[  143.748484] ([<000000002da3e62c>] .LASANPC2671+0x114/0x190)
[  143.748492]  [<000000002eca1a58>] .LASANPC2612+0x110/0x160
[  143.748502]  [<000000002de9d830>] print_address_description+0x80/0x3b0
[  143.748511]  [<000000002de9dd64>] __kasan_report+0x15c/0x1c8
[  143.748521]  [<000000002ecb56d4>] strrchr+0x34/0x60
[  143.748534]  [<000003ff800a9a40>] kasan_strings+0xb0/0x148 [test_kasan]
[  143.748547]  [<000003ff800a9bba>] kmalloc_tests_init+0xe2/0x528 [test_kasan]
[  143.748555]  [<000000002da2117c>] .LASANPC4069+0x354/0x748
[  143.748563]  [<000000002dbfbb16>] do_init_module+0x136/0x3b0
[  143.748571]  [<000000002dbff3f4>] .LASANPC3191+0x2164/0x25d0
[  143.748580]  [<000000002dbffc4c>] .LASANPC3196+0x184/0x1b8
[  143.748587]  [<000000002ecdf2ec>] system_call+0xd8/0x2d8

Since LASANPC labels are not even unique and get into .symtab only due
to relocs filter them out in kallsyms.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/kallsyms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index e17837f1d3f2..ae6504d07fd6 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -150,6 +150,9 @@ static int read_symbol(FILE *in, struct sym_entry *s)
 	/* exclude debugging symbols */
 	else if (stype == 'N' || stype == 'n')
 		return -1;
+	/* exclude s390 kasan local symbols */
+	else if (!strncmp(sym, ".LASANPC", 8))
+		return -1;
 
 	/* include the type field in the symbol name, so that it gets
 	 * compressed together */
-- 
2.20.1

