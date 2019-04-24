Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE742C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A62821902
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117325;
	bh=Tin76vRHTq2o17NylvICXQEitZ8En0x9T5DaVwtlDw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CXjIkzFX0QFIwYMm/fvenjsUPVFFkeMQ3r5NSTt4w51te1ZksXyua2kjWV+dhlZ60
	 DkI7Wbek+pimmMPf6EAlHJH/0ssWyCF7eNRr2WzcWTL9Oln0f0p4XgcwAxEC79F3YQ
	 o5Za3bdjoQqvoBysZZ5qUDCtUfg0A80CNVbKVi8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732511AbfDXOso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:48:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732495AbfDXOsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:48:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9BAF21902;
        Wed, 24 Apr 2019 14:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117317;
        bh=Tin76vRHTq2o17NylvICXQEitZ8En0x9T5DaVwtlDw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SY3RxWBuubx06NF/5m+QPJt8gQzj5JM90D+IKut5gqAJfCPSe/t2N8hSX4TKduabL
         bmoU0BWbDp/lRupIxT9fbu4boS3vF2klt0O4HgWUFhrS0fdYxR5ART+rJCmZXu7dRn
         I7FCCCsJaP0XYpsmud9TaheqY3sjiapbDVSwPnw8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Matteo Croce <mcroce@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 32/35] kernel/sysctl.c: fix out-of-bounds access when setting file-max
Date:   Wed, 24 Apr 2019 10:47:06 -0400
Message-Id: <20190424144709.30215-32-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424144709.30215-1-sashal@kernel.org>
References: <20190424144709.30215-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit 9002b21465fa4d829edfc94a5a441005cffaa972 ]

Commit 32a5ad9c2285 ("sysctl: handle overflow for file-max") hooked up
min/max values for the file-max sysctl parameter via the .extra1 and
.extra2 fields in the corresponding struct ctl_table entry.

Unfortunately, the minimum value points at the global 'zero' variable,
which is an int.  This results in a KASAN splat when accessed as a long
by proc_doulongvec_minmax on 64-bit architectures:

  | BUG: KASAN: global-out-of-bounds in __do_proc_doulongvec_minmax+0x5d8/0x6a0
  | Read of size 8 at addr ffff2000133d1c20 by task systemd/1
  |
  | CPU: 0 PID: 1 Comm: systemd Not tainted 5.1.0-rc3-00012-g40b114779944 #2
  | Hardware name: linux,dummy-virt (DT)
  | Call trace:
  |  dump_backtrace+0x0/0x228
  |  show_stack+0x14/0x20
  |  dump_stack+0xe8/0x124
  |  print_address_description+0x60/0x258
  |  kasan_report+0x140/0x1a0
  |  __asan_report_load8_noabort+0x18/0x20
  |  __do_proc_doulongvec_minmax+0x5d8/0x6a0
  |  proc_doulongvec_minmax+0x4c/0x78
  |  proc_sys_call_handler.isra.19+0x144/0x1d8
  |  proc_sys_write+0x34/0x58
  |  __vfs_write+0x54/0xe8
  |  vfs_write+0x124/0x3c0
  |  ksys_write+0xbc/0x168
  |  __arm64_sys_write+0x68/0x98
  |  el0_svc_common+0x100/0x258
  |  el0_svc_handler+0x48/0xc0
  |  el0_svc+0x8/0xc
  |
  | The buggy address belongs to the variable:
  |  zero+0x0/0x40
  |
  | Memory state around the buggy address:
  |  ffff2000133d1b00: 00 00 00 00 00 00 00 00 fa fa fa fa 04 fa fa fa
  |  ffff2000133d1b80: fa fa fa fa 04 fa fa fa fa fa fa fa 04 fa fa fa
  | >ffff2000133d1c00: fa fa fa fa 04 fa fa fa fa fa fa fa 00 00 00 00
  |                                ^
  |  ffff2000133d1c80: fa fa fa fa 00 fa fa fa fa fa fa fa 00 00 00 00
  |  ffff2000133d1d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Fix the splat by introducing a unsigned long 'zero_ul' and using that
instead.

Link: http://lkml.kernel.org/r/20190403153409.17307-1-will.deacon@arm.com
Fixes: 32a5ad9c2285 ("sysctl: handle overflow for file-max")
Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Christian Brauner <christian@brauner.io>
Cc: Kees Cook <keescook@chromium.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Matteo Croce <mcroce@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sysctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 34a3b8a262a9..f13601a616ad 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -124,6 +124,7 @@ static int zero;
 static int __maybe_unused one = 1;
 static int __maybe_unused two = 2;
 static int __maybe_unused four = 4;
+static unsigned long zero_ul;
 static unsigned long one_ul = 1;
 static unsigned long long_max = LONG_MAX;
 static int one_hundred = 100;
@@ -1682,7 +1683,7 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(files_stat.max_files),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= &zero,
+		.extra1		= &zero_ul,
 		.extra2		= &long_max,
 	},
 	{
-- 
2.19.1

