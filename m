Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA54C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C15221897
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559065851;
	bh=Fh9AJAz2SjZYGlSEjxBbRYHGTyOnLZSXohp7ZXuOLZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F8QC3codoZ9N40VJUq9JjE+muNOzrYEtBCk85oCkLhg04MifEU+n+C9gCsEsb3Jef
	 5j9xIVaFtBn03ndQFGfLvpsBG8fBzPkm/Km/zauFx4wIngQtM4frMFb47vMibVxcWr
	 eGSnEDj5fLSEGCBtiGbT9EcdvjCOSNhnDuGpFx70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfE1Ruu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 13:50:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbfE1Rus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 13:50:48 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E3FB2183F;
        Tue, 28 May 2019 17:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559065848;
        bh=Fh9AJAz2SjZYGlSEjxBbRYHGTyOnLZSXohp7ZXuOLZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zlpIlQiT2U5GU2ordDpV1vRSgCL9xhZiPAxJxGMA6gtpuaqf9uaaVlJgHpE6bJRpP
         XOCpZcZZ9cM+eXVzBtEYFMFnAzzlPyJ4j7QugX8sO/YVH1lnRFz3xIfGrmwTgQg1fy
         IcamEI9H487pEyJfItz0CQBuKyAiHzKN6VAA/22s=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 05/14] tools headers UAPI: Sync linux/sched.h with the kernel
Date:   Tue, 28 May 2019 14:50:11 -0300
Message-Id: <20190528175020.13343-6-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528175020.13343-1-acme@kernel.org>
References: <20190528175020.13343-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the change in:

  b3e583825266 ("clone: add CLONE_PIDFD")

This requires changes in the 'perf trace' beautification routines for
the 'clone' syscall args, which is done in a followup patch.

This silences the following perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/sched.h' differs from latest version at 'include/uapi/linux/sched.h'
  diff -u tools/include/uapi/linux/sched.h include/uapi/linux/sched.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Christian Brauner <christian@brauner.io>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-lenja6gmy26dkt0ybk747qgq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/sched.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
index 22627f80063e..ed4ee170bee2 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -10,6 +10,7 @@
 #define CLONE_FS	0x00000200	/* set if fs info shared between processes */
 #define CLONE_FILES	0x00000400	/* set if open files shared between processes */
 #define CLONE_SIGHAND	0x00000800	/* set if signal handlers and blocked signals shared */
+#define CLONE_PIDFD	0x00001000	/* set if a pidfd should be placed in parent */
 #define CLONE_PTRACE	0x00002000	/* set if we want to let tracing continue on the child too */
 #define CLONE_VFORK	0x00004000	/* set if the parent wants the child to wake it up on mm_release */
 #define CLONE_PARENT	0x00008000	/* set if we want to have the same parent as the cloner */
-- 
2.20.1

