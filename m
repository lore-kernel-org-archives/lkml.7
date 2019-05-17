Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18121C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE9E216FD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558121818;
	bh=GIFnA3ky94WXXUqzctrv7KFJPVpknyXAMJ/WXUtwSlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aYCr0qjzrJ3+Wi2rhFaIDWWsy4GqcuLyjSoVfygMaQ9L3ifH1RAHRH3TirnSMGxEK
	 ZMXu7b6q6rwSlYJlXK7lvEGtFiVQALUXxK5+IhYEMKVQTfOGGrFBhnLGjEtVFZMCPg
	 ktXPnmB+0/3TehI5EgJtnqxuvb0EUf5Hf2AhYuQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfEQTg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:36:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729325AbfEQTgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:36:53 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC6E1217D4;
        Fri, 17 May 2019 19:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558121812;
        bh=GIFnA3ky94WXXUqzctrv7KFJPVpknyXAMJ/WXUtwSlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EJp5MQjNXC/aAZMBl8+LeDDISmo+f/TOu+3Ix4G/0QdeQOBBJnYPe4PVSXDQcleLs
         xBFnDu3aruwAB53OjbkZm7qhb1O8SyNnbT+Ta9ffe6RgL5CFhTx1VcXVd/eCAyPwFL
         mBmJxWPj2byibvQOADzrKrqivEz9ls5lJqNWIZy4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 06/73] tools arch: Update arch/x86/lib/memcpy_64.S copy used in 'perf bench mem memcpy'
Date:   Fri, 17 May 2019 16:35:04 -0300
Message-Id: <20190517193611.4974-7-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To bring in the change made in this cset:

  b69656fa7ea2 ("x86/uaccess: Fix up the fixup")

Silencing this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.S' differs from latest version at 'arch/x86/lib/memcpy_64.S'
  diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S

No changes in the tooling using this, that was just to ease some objtool
return checking.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-j0mxgqkuibhw5qid9saaspdu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/lib/memcpy_64.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/lib/memcpy_64.S b/tools/arch/x86/lib/memcpy_64.S
index 3b24dc05251c..9d05572370ed 100644
--- a/tools/arch/x86/lib/memcpy_64.S
+++ b/tools/arch/x86/lib/memcpy_64.S
@@ -257,6 +257,7 @@ ENTRY(__memcpy_mcsafe)
 	/* Copy successful. Return zero */
 .L_done_memcpy_trap:
 	xorl %eax, %eax
+.L_done:
 	ret
 ENDPROC(__memcpy_mcsafe)
 EXPORT_SYMBOL_GPL(__memcpy_mcsafe)
@@ -273,7 +274,7 @@ EXPORT_SYMBOL_GPL(__memcpy_mcsafe)
 	addl	%edx, %ecx
 .E_trailing_bytes:
 	mov	%ecx, %eax
-	ret
+	jmp	.L_done
 
 	/*
 	 * For write fault handling, given the destination is unaligned,
-- 
2.20.1

