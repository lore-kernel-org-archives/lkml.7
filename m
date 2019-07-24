Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB40C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8925B22C7C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033258;
	bh=khUxIk4oDYzshN3jMswBbEz9tHCV5yR1/rfKNuNPkY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gijEb0OBPU3ET0sfCUdmLtD2xhXd5V68IBCSSYWe5mVPteeiAPBq/13WVwq8WuSPP
	 sUXcLMUArgmS8aJm3xvmfBk33KC894Eh9Jcd6LRHczD/V7u9IRK75poVfn/JcEtJJr
	 BipHi2TkM8pEwcxtciTE4hkHHtmoAefp+Cmm6OIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390750AbfGYFk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390726AbfGYFky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:40:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54DEF22BF5;
        Thu, 25 Jul 2019 05:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033252;
        bh=khUxIk4oDYzshN3jMswBbEz9tHCV5yR1/rfKNuNPkY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u8My4vJFB/ApOUyShYkxyv3pnqHP96oKVbKx1K6KHwehyL8ZKmC3aGWdkTvAmXkaU
         13++/uyXrkEcL8iPw8p75Upz0e15PAmS3xPhHAZt7ZW5dyQgWh3M4aO545O7HiFdwr
         Kh07boRWEi5dQQMAHfomjW34pKKN9Ku5U8wMev1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 145/271] tools: bpftool: Fix json dump crash on powerpc
Date:   Wed, 24 Jul 2019 21:20:14 +0200
Message-Id: <20190724191707.620171659@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit aa52bcbe0e72fac36b1862db08b9c09c4caefae3 ]

Michael reported crash with by bpf program in json mode on powerpc:

  # bpftool prog -p dump jited id 14
  [{
        "name": "0xd00000000a9aa760",
        "insns": [{
                "pc": "0x0",
                "operation": "nop",
                "operands": [null
                ]
            },{
                "pc": "0x4",
                "operation": "nop",
                "operands": [null
                ]
            },{
                "pc": "0x8",
                "operation": "mflr",
  Segmentation fault (core dumped)

The code is assuming char pointers in format, which is not always
true at least for powerpc. Fixing this by dumping the whole string
into buffer based on its format.

Please note that libopcodes code does not check return values from
fprintf callback, but as per Jakub suggestion returning -1 on allocation
failure so we do the best effort to propagate the error.

Fixes: 107f041212c1 ("tools: bpftool: add JSON output for `bpftool prog dump jited *` command")
Reported-by: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/jit_disasm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
index 87439320ef70..73d7252729fa 100644
--- a/tools/bpf/bpftool/jit_disasm.c
+++ b/tools/bpf/bpftool/jit_disasm.c
@@ -10,6 +10,8 @@
  * Licensed under the GNU General Public License, version 2.0 (GPLv2)
  */
 
+#define _GNU_SOURCE
+#include <stdio.h>
 #include <stdarg.h>
 #include <stdint.h>
 #include <stdio.h>
@@ -51,11 +53,13 @@ static int fprintf_json(void *out, const char *fmt, ...)
 	char *s;
 
 	va_start(ap, fmt);
+	if (vasprintf(&s, fmt, ap) < 0)
+		return -1;
+	va_end(ap);
+
 	if (!oper_count) {
 		int i;
 
-		s = va_arg(ap, char *);
-
 		/* Strip trailing spaces */
 		i = strlen(s) - 1;
 		while (s[i] == ' ')
@@ -68,11 +72,10 @@ static int fprintf_json(void *out, const char *fmt, ...)
 	} else if (!strcmp(fmt, ",")) {
 		   /* Skip */
 	} else {
-		s = va_arg(ap, char *);
 		jsonw_string(json_wtr, s);
 		oper_count++;
 	}
-	va_end(ap);
+	free(s);
 	return 0;
 }
 
-- 
2.20.1



