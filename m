Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6387C49ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 12:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5D62086A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 12:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569069786;
	bh=Ngv68cNnpB5AyrA7FnlXFDU27GjCT2wfeuXFz8vWvM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PhXRylH2ThvoiCjXCD3Zw+GhMe/wyY/AxwwgPqDzhZJeHamT+dgIg/dZWnmGvvZb+
	 t3vjAoGeuoT74otqDcdE5O5rcNICGPeTQDe/7ks/ul78npgJ4PSTyBowrnkaYix7Y5
	 c0XdOOscFMsELcprgpAkiLYBZeVphitEkkgqvtmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407666AbfIUMm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 08:42:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407642AbfIUMm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 08:42:58 -0400
Received: from quaco.ghostprotocols.net (user.186-235-137-39.acesso10.net.br [186.235.137.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 972D72086A;
        Sat, 21 Sep 2019 12:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569069778;
        bh=Ngv68cNnpB5AyrA7FnlXFDU27GjCT2wfeuXFz8vWvM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rBSSgAzJq445tt4g+nOBZNZA7w9alvgo6BG3zHon26VDMRlGAHWaEUoBHXZWP72UA
         0HqqZXgr3jTFiGHxzYNxFF4SaeY8gR4gKzR7uo6fUTVei9Qf7xU0tH+5ut2smc9Pbf
         ArwGITZ/6d7sGLNoqkSplgAwvbnkznjKNVSpA/d8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 03/10] tools uapi asm-generic: Sync unistd.h with the kernel sources
Date:   Sat, 21 Sep 2019 09:42:33 -0300
Message-Id: <20190921124240.15741-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190921124240.15741-1-acme@kernel.org>
References: <20190921124240.15741-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the change from:

  78e05972c5e6 ("ipc: fix semtimedop for generic 32-bit architectures")

Which doesn't trigger any change in tooling and silences this perf build
warning:

  Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/unistd.h' differs from latest version at 'include/uapi/asm-generic/unistd.h'
  diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-hpnjuyjzoudltqe7dvbokqdt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/unistd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 1be0e798e362..1fc8faa6e973 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -569,7 +569,7 @@ __SYSCALL(__NR_semget, sys_semget)
 __SC_COMP(__NR_semctl, sys_semctl, compat_sys_semctl)
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_semtimedop 192
-__SC_COMP(__NR_semtimedop, sys_semtimedop, sys_semtimedop_time32)
+__SC_3264(__NR_semtimedop, sys_semtimedop_time32, sys_semtimedop)
 #endif
 #define __NR_semop 193
 __SYSCALL(__NR_semop, sys_semop)
-- 
2.21.0

