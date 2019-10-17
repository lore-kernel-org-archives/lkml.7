Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25498FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32D420872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571328220;
	bh=6roXkU0LnAMjh3YbSbsMeZJtAjspuA9zVaIsKZ0KpmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XHRhxmCSIMdaKQQO3w6ggCvG2FNYQCkjWwJdyzVUBvB0fJ4xCbVxl9LgfvAPT1UmU
	 NsCuKrsxX110jCdTAh8cZEVqcfmK78ezpW3s1EiY86yCo8EIl25AWbTxvx2eVqKnSG
	 KzisdibSajsYkpJAjAGmhB4grR5aoJ2BXrVCUQzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440365AbfJQQDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:03:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440238AbfJQQDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:03:35 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E7A221D7A;
        Thu, 17 Oct 2019 16:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571328214;
        bh=6roXkU0LnAMjh3YbSbsMeZJtAjspuA9zVaIsKZ0KpmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MZm4WauZ9eeVEnW/ws2qUCYyBZfpz4/+wVxlAr1+rALmgRkLZYntfiaa7qxi/Rmg6
         /NdzIqVxvM3SV9DoG4wzpU3yPUqBtfV/0qlUpo23eRmzA9PWqBK6kbBu3BNuJeEeZq
         NvTVrvDc1Nh8QzEdFX6/bZPSBfkaoEradMCyOAPA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 08/11] tools headers kvm: Sync kvm headers with the kernel sources
Date:   Thu, 17 Oct 2019 13:02:58 -0300
Message-Id: <20191017160301.20888-9-acme@kernel.org>
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

    0cb8410b90e7 ("kvm: svm: Intercept RDPRU")

That trigger a rebuild in too in tooling:

    CC       /tmp/build/perf/arch/x86/util/kvm-stat.o

But this time around no changes in tooling results, as SVM_EXIT_RDPRU
wasn't added to SVM_EXIT_REASONS, that is used in kvm-stat.c.

And addresses this perf build warnings:

  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/svm.h' differs from latest version at 'arch/x86/include/uapi/asm/svm.h'
  diff -u tools/arch/x86/include/uapi/asm/svm.h arch/x86/include/uapi/asm/svm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jim Mattson <jmattson@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lkml.kernel.org/n/tip-pqzkt1hmfpqph3ts8i6zzmim@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/svm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/arch/x86/include/uapi/asm/svm.h b/tools/arch/x86/include/uapi/asm/svm.h
index a9731f8a480f..2e8a30f06c74 100644
--- a/tools/arch/x86/include/uapi/asm/svm.h
+++ b/tools/arch/x86/include/uapi/asm/svm.h
@@ -75,6 +75,7 @@
 #define SVM_EXIT_MWAIT         0x08b
 #define SVM_EXIT_MWAIT_COND    0x08c
 #define SVM_EXIT_XSETBV        0x08d
+#define SVM_EXIT_RDPRU         0x08e
 #define SVM_EXIT_NPF           0x400
 #define SVM_EXIT_AVIC_INCOMPLETE_IPI		0x401
 #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS	0x402
-- 
2.21.0

