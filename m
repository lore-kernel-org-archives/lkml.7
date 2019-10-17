Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F20ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9B620872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571328217;
	bh=B5iMgY/aipxVW5qjCNPP/LdTChvebeosKWFquPrdp08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TAS3LvVvn+8jDyzRTnnRlADQGeI3DzUvMPdmThmY5ruV5QwDxVlE2R5A4DW9GF7cC
	 KgqVoX8D+ZqfHdViBZobRgzpmstYkRwJQOgQg5/wISnn6wAYezE7QsFpE1TJE91UDs
	 4hAENM4dfRnwfhhxjpFEOOt42aVUEMMsjrkGq7Vo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440320AbfJQQDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:03:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405871AbfJQQDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:03:32 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E11F222BE;
        Thu, 17 Oct 2019 16:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571328211;
        bh=B5iMgY/aipxVW5qjCNPP/LdTChvebeosKWFquPrdp08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R8FOwPoZfW9CCoF+5uyGlm2boSREzZKaPw0Vr4z6pLV+jAAMvJBRVt0HbUTRL0QYf
         usoaI0Dqys4cVIs6oYy9aFp9ali+fmi0ub2J3+qWeKciDiR48Qm7sgBq4rIbqp1BZZ
         D6nqY1PdrZLD5dc/5bDjy/r4vhzP9wclJpX6wOb0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tao Xu <tao3.xu@intel.com>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 07/11] tools headers kvm: Sync kvm headers with the kernel sources
Date:   Thu, 17 Oct 2019 13:02:57 -0300
Message-Id: <20191017160301.20888-8-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017160301.20888-1-acme@kernel.org>
References: <20191017160301.20888-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the changes in:

  bf653b78f960 ("KVM: vmx: Introduce handle_unexpected_vmexit and handle WAITPKG vmexit")

That trigger these changes in tooling:

    CC       /tmp/build/perf/arch/x86/util/kvm-stat.o
    INSTALL  GTK UI
    DESCEND  plugins
  make[3]: Nothing to be done for '/tmp/build/perf/plugins/libtraceevent-dynamic-list'.
    INSTALL  trace_plugins
    LD       /tmp/build/perf/arch/x86/util/perf-in.o
    LD       /tmp/build/perf/arch/x86/perf-in.o
    LD       /tmp/build/perf/arch/perf-in.o
    LD       /tmp/build/perf/perf-in.o
    LINK     /tmp/build/perf/perf

And this is not just because that header is included, kvm-stat.c
uses the VMX_EXIT_REASONS define and it got changed by the above cset.

And addresses this perf build warnings:

  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/vmx.h' differs from latest version at 'arch/x86/include/uapi/asm/vmx.h'
  diff -u tools/arch/x86/include/uapi/asm/vmx.h arch/x86/include/uapi/asm/vmx.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Tao Xu <tao3.xu@intel.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-gr1eel0hckmi5l3p2ewdpfxh@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/vmx.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/uapi/asm/vmx.h b/tools/arch/x86/include/uapi/asm/vmx.h
index f01950aa7fae..3eb8411ab60e 100644
--- a/tools/arch/x86/include/uapi/asm/vmx.h
+++ b/tools/arch/x86/include/uapi/asm/vmx.h
@@ -86,6 +86,8 @@
 #define EXIT_REASON_PML_FULL            62
 #define EXIT_REASON_XSAVES              63
 #define EXIT_REASON_XRSTORS             64
+#define EXIT_REASON_UMWAIT              67
+#define EXIT_REASON_TPAUSE              68
 
 #define VMX_EXIT_REASONS \
 	{ EXIT_REASON_EXCEPTION_NMI,         "EXCEPTION_NMI" }, \
@@ -144,7 +146,9 @@
 	{ EXIT_REASON_RDSEED,                "RDSEED" }, \
 	{ EXIT_REASON_PML_FULL,              "PML_FULL" }, \
 	{ EXIT_REASON_XSAVES,                "XSAVES" }, \
-	{ EXIT_REASON_XRSTORS,               "XRSTORS" }
+	{ EXIT_REASON_XRSTORS,               "XRSTORS" }, \
+	{ EXIT_REASON_UMWAIT,                "UMWAIT" }, \
+	{ EXIT_REASON_TPAUSE,                "TPAUSE" }
 
 #define VMX_ABORT_SAVE_GUEST_MSR_FAIL        1
 #define VMX_ABORT_LOAD_HOST_PDPTE_FAIL       2
-- 
2.21.0

