Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4C0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C5C218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553866712;
	bh=eqKbIVALLPYmBZ7uDnJuCqOCpjiTvL/1QOM5+NBx220=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FvpWaQcly7qCiaaLsiscZpU+5eLygMcUNXuSyIaIqHPpwP+o6q0krsu6B7ZNrxiQX
	 dbwaHbKudjv6DU4KhJdzo9eZMN+LU81++iw67SAH9Aq7YsHYFIX8wzy3b/HvqcMcCb
	 o5H4wEph0+oQ3vOIuZk6o00yLBEdLT7yyacVwvdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbfC2Nib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:38:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729636AbfC2Ni3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:38:29 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76CAC2186A;
        Fri, 29 Mar 2019 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553866708;
        bh=eqKbIVALLPYmBZ7uDnJuCqOCpjiTvL/1QOM5+NBx220=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OxmAGFKzF9qKPD9Ev9Z4yaOF6j5qy9VvLRRy3wh/f1PlqdBjFsygmmNulnLFu/Sug
         WodAnb4oxBpiu/ofVsfO0zEDsW3x4a7L7IdfUoeK6iTYeTvkMMf5mXDbqA/d7cWrEQ
         SNIshs/eHEddJfmsLItKiqc2KApY7evWuXaXBqaY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 05/13] tools headers uapi: Sync linux/fcntl.h to get the F_SEAL_FUTURE_WRITE addition
Date:   Fri, 29 Mar 2019 10:37:53 -0300
Message-Id: <20190329133801.21004-6-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329133801.21004-1-acme@kernel.org>
References: <20190329133801.21004-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  ab3948f58ff8 ("mm/memfd: add an F_SEAL_FUTURE_WRITE seal to memfd")

And silence this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/fcntl.h' differs from latest version at 'include/uapi/linux/fcntl.h'
  diff -u tools/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-lvfx5cgf0xzmdi9mcjva1ttl@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/fcntl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/fcntl.h b/tools/include/uapi/linux/fcntl.h
index 6448cdd9a350..a2f8658f1c55 100644
--- a/tools/include/uapi/linux/fcntl.h
+++ b/tools/include/uapi/linux/fcntl.h
@@ -41,6 +41,7 @@
 #define F_SEAL_SHRINK	0x0002	/* prevent file from shrinking */
 #define F_SEAL_GROW	0x0004	/* prevent file from growing */
 #define F_SEAL_WRITE	0x0008	/* prevent writes */
+#define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
 /* (1U << 31) is reserved for signed error codes */
 
 /*
-- 
2.20.1

