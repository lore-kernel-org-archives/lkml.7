Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A52CC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FEF222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458041;
	bh=STwWbPQn+h7P4sF34+F9bnGvCu6VxmicSlXeasaCgZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RHux0bKOsf1hnJuOWXMsCbGAgk2t/QD7ERuOmrMXiDVFgPJeyLloP3x6/PQFU6Dix
	 8q9PIOLw/lZliAjc6cxKE5cpyssE8sIGsDZdnlyVFXg74hgAy4pjHrnoEeUY+6SCNt
	 TzF3GC8vfhrw14ZnBb8fsw4i4iliKzwsDJiB6wm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388247AbfIZAd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:33:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388121AbfIZAd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:33:56 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3183222CD;
        Thu, 26 Sep 2019 00:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458035;
        bh=STwWbPQn+h7P4sF34+F9bnGvCu6VxmicSlXeasaCgZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qLCdLVnB0SQ/ueszCVJaIdHdVemKrorb1YOnN3ElfYmgnyTO0pthqf6fgw6eLFJnz
         SqFkTC2+KWz4OmhtsuE3KadJBk74Rv4cRtYJVnTmNcWdlZ91OKVh7PTOHR36VlEbnt
         DlFH2H0hQcMF4tMa1FJshUZFsBdMVWSENFZg2qTw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/66] tools: Add missing stdio.h include to asm/bug.h header
Date:   Wed, 25 Sep 2019 21:31:52 -0300
Message-Id: <20190926003244.13962-15-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We have a direct fprintf() call in the header, so we need stdio.h
include, otherwise it could fail compilation if there's no prior stdio.h
include directive.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/n/tip-8hvjgh24olfsa4non0a3ohnq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/asm/bug.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/asm/bug.h b/tools/include/asm/bug.h
index bbd75ac8b202..550223f0a6e6 100644
--- a/tools/include/asm/bug.h
+++ b/tools/include/asm/bug.h
@@ -3,6 +3,7 @@
 #define _TOOLS_ASM_BUG_H
 
 #include <linux/compiler.h>
+#include <stdio.h>
 
 #define __WARN_printf(arg...)	do { fprintf(stderr, arg); } while (0)
 
-- 
2.21.0

