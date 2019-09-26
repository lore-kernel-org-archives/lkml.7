Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BCBC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F6E222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458215;
	bh=sLcZxQTsS71JuIvTCNnjFmXiRKEFUmWIhlO86PqRz/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uEe7PbRBXEQqfPseHtmDBt/fhImG3pRMGMpaCO28qf0vgVK3Yk3DOoD9L1pvDOIaU
	 eQI1IXyQ4+d8lAkJQRjdbiLQOPqUh3ZU/chJ9PChRu6tCyBaeD1if4i/HkpFcBERiw
	 MGfG0PBgdlKhAMmzZVIMj+RRx9acwvfqfpFGYvM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390932AbfIZAgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:36:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729276AbfIZAgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:36:49 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CA0021D6C;
        Thu, 26 Sep 2019 00:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458208;
        bh=sLcZxQTsS71JuIvTCNnjFmXiRKEFUmWIhlO86PqRz/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jMxOQan/PLjnXDPFtwSzBJYxPZ+d/WdjYF/hqBWO60j2ZTyl1yx6eyyiNFlwn9IT4
         y/VwiXyrMcFrx5yKkwD6m7ryVLuczgKaPaO716Vs7O82/LWGONiPnurA9s4zQj2xqB
         /ByqnvOByR7YHBKSeBxzthUJ6Rz/8C+4/DjK0+O4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 64/66] perf jvmti: Include JVMTI support for s390
Date:   Wed, 25 Sep 2019 21:32:42 -0300
Message-Id: <20190926003244.13962-65-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

Enable JVMTI support for s390 perf tool chain.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20190909114116.50469-3-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/Makefile | 1 +
 tools/perf/util/genelf.h      | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/arch/s390/Makefile b/tools/perf/arch/s390/Makefile
index cb198787570a..6ac8887be7c9 100644
--- a/tools/perf/arch/s390/Makefile
+++ b/tools/perf/arch/s390/Makefile
@@ -4,6 +4,7 @@ PERF_HAVE_DWARF_REGS := 1
 endif
 HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
+PERF_HAVE_JITDUMP := 1
 
 #
 # Syscall table generation for perf
diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
index b72440bf9a79..d4137559be05 100644
--- a/tools/perf/util/genelf.h
+++ b/tools/perf/util/genelf.h
@@ -35,6 +35,9 @@ int jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_ent
 #elif defined(__sparc__)
 #define GEN_ELF_ARCH	EM_SPARC
 #define GEN_ELF_CLASS	ELFCLASS32
+#elif defined(__s390x__)
+#define GEN_ELF_ARCH	EM_S390
+#define GEN_ELF_CLASS	ELFCLASS64
 #else
 #error "unsupported architecture"
 #endif
-- 
2.21.0

