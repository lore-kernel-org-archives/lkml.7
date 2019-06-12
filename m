Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4164FC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3936206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ZVrvVIYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbfFLRCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:02:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48375 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730601AbfFLRCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:02:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5CH1N20778114
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 12 Jun 2019 10:01:23 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5CH1N20778114
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560358884;
        bh=br9vLeCDx8US3m4mlAyWxbrfb+JPCE7Wl06mLgthCGs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ZVrvVIYXdpftW+mD0QYRE9x6zChxCPJYBOVaQYQD5HiRI/oj3vMjFo8f1WLzB0/F7
         wf9hClDMH4UraJ23xWFJT6X/P+qquAvJtzO9bcJ8R5XhwiIU23J93fCAkl62dsKuUy
         Y5y6Fd/F+uGYE4aJojd2Xdsu2Gv+c5PDg/LVg2ceRP3iBvUfRqVDBH1FQ8Gk5TM4sX
         Y55h7ve6A9rCE0V7Yd5o0udQ7pexcWNUMy7mvZJBLcsNJscOehKHM07HXCZ/+kU9Rf
         yOxb1wnGM1wWRdo96l76jMuhPz9foB9fwFVGCdbqvIfS0odyG2V+KYSnwaXiE0GdJX
         sEPGs6i3bENog==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5CH1LQp778104;
        Wed, 12 Jun 2019 10:01:21 -0700
Date:   Wed, 12 Jun 2019 10:01:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Matt Mullins <tipbot@zytor.com>
Message-ID: <tip-71ab8323cc357c68985a2d6fc6cfc22b1dbbc1c3@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, gustavo@embeddedor.com,
        hpa@zytor.com, mingo@redhat.com, daniel.thompson@linaro.org,
        christophe.leroy@c-s.fr, x86@kernel.org,
        rick.p.edgecombe@intel.com, bp@suse.de, mingo@kernel.org,
        peterz@infradead.org, luto@amacapital.net, dianders@chromium.org,
        mmullins@fb.com, tglx@linutronix.de, namit@vmware.com
Reply-To: namit@vmware.com, tglx@linutronix.de, mmullins@fb.com,
          luto@amacapital.net, dianders@chromium.org, peterz@infradead.org,
          mingo@kernel.org, x86@kernel.org, bp@suse.de,
          rick.p.edgecombe@intel.com, daniel.thompson@linaro.org,
          christophe.leroy@c-s.fr, hpa@zytor.com, mingo@redhat.com,
          gustavo@embeddedor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190531194755.6320-1-mmullins@fb.com>
References: <20190531194755.6320-1-mmullins@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/kgdb: Return 0 from kgdb_arch_set_breakpoint()
Git-Commit-ID: 71ab8323cc357c68985a2d6fc6cfc22b1dbbc1c3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  71ab8323cc357c68985a2d6fc6cfc22b1dbbc1c3
Gitweb:     https://git.kernel.org/tip/71ab8323cc357c68985a2d6fc6cfc22b1dbbc1c3
Author:     Matt Mullins <mmullins@fb.com>
AuthorDate: Fri, 31 May 2019 12:47:54 -0700
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 12 Jun 2019 18:52:44 +0200

x86/kgdb: Return 0 from kgdb_arch_set_breakpoint()

err must be nonzero in order to reach text_poke(), which caused kgdb to
fail to set breakpoints:

  (gdb) break __x64_sys_sync
  Breakpoint 1 at 0xffffffff81288910: file ../fs/sync.c, line 124.
  (gdb) c
  Continuing.
  Warning:
  Cannot insert breakpoint 1.
  Cannot access memory at address 0xffffffff81288910

  Command aborted.

Fixes: 86a22057127d ("x86/kgdb: Avoid redundant comparison of patched code")
Signed-off-by: Matt Mullins <mmullins@fb.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Nadav Amit <namit@vmware.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190531194755.6320-1-mmullins@fb.com
---
 arch/x86/kernel/kgdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 9a8c1648fc9a..6690c5652aeb 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -758,7 +758,7 @@ int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
 		       BREAK_INSTR_SIZE);
 	bpt->type = BP_POKE_BREAKPOINT;
 
-	return err;
+	return 0;
 }
 
 int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
