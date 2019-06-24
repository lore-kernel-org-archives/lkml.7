Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB43C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D475E20645
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561371150;
	bh=SREwUm8J1kTp+qb9RpDj1Ff57Rw1vxR+PlbiFITmhdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jtKyQLtdUvMTH7DxcIsF1ZZnS4DUT2b7vjom6nxHuPQ82ZJ2NHbmVnTlYZKL9+t9+
	 EliOEUVYRTz6UjqBY8Tn3/w/hDcUjAfRgsHPUfm1ZxNoPGhAKj+t89TuPIPD+320os
	 iaPW0W7PQMvb2SUSCQOkLQKWd//72CW78+jHsd0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbfFXKM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:12:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730014AbfFXKFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:05:55 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A02E42146F;
        Mon, 24 Jun 2019 10:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561370755;
        bh=SREwUm8J1kTp+qb9RpDj1Ff57Rw1vxR+PlbiFITmhdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wb0k19n8HkUdayeccepnIUOLQUxW8riA2y0MWV6rw4dKkTZwd84UF7AjEQvTvHriN
         mDpvIUhKowEnZc3oCEBR6xY6udl9KaqxbvqdZJhg672OUEZT5btqylvRJ8xu6NdMlf
         nKDkgr6T4/WeLox6glFhqJbTLo7ei2QY2s3FnO5I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anisse Astier <aastier@freebox.fr>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.19 78/90] arm64: ssbd: explicitly depend on <linux/prctl.h>
Date:   Mon, 24 Jun 2019 17:57:08 +0800
Message-Id: <20190624092319.067481327@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092313.788773607@linuxfoundation.org>
References: <20190624092313.788773607@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anisse Astier <aastier@freebox.fr>

commit adeaa21a4b6954e878f3f7d1c5659ed9c1fe567a upstream.

Fix ssbd.c which depends implicitly on asm/ptrace.h including
linux/prctl.h (through for example linux/compat.h, then linux/time.h,
linux/seqlock.h, linux/spinlock.h and linux/irqflags.h), and uses
PR_SPEC* defines.

This is an issue since we'll soon be removing the include from
asm/ptrace.h.

Fixes: 9cdc0108baa8 ("arm64: ssbd: Add prctl interface for per-thread mitigation")
Cc: stable@vger.kernel.org
Signed-off-by: Anisse Astier <aastier@freebox.fr>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/ssbd.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm64/kernel/ssbd.c
+++ b/arch/arm64/kernel/ssbd.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/errno.h>
+#include <linux/prctl.h>
 #include <linux/sched.h>
 #include <linux/thread_info.h>
 


