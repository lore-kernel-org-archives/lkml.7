Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C567BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D4B21902
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116883;
	bh=gPD0lLuxLI/lZSdxmEYXta7yYBLsxT/9JMcUJ9Dz4r4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tEOCpWO8mqtMNZL9Q2MvfOzvz33aSd3DwQr5W75a49b+d0fMHEuDgodSRvQB1aSa4
	 c0+Bb8bF6QNOVZ+aOprEhMMHCvZxP3J0difUSWwYB66s0uTX9jTTwRrVLer2gLrMx4
	 nxdeg5emGTIKZ3UrfeYs/wuRbJz0pSTWlj6z9JYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732098AbfDXOlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:41:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731580AbfDXOlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:41:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D41D21902;
        Wed, 24 Apr 2019 14:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116871;
        bh=gPD0lLuxLI/lZSdxmEYXta7yYBLsxT/9JMcUJ9Dz4r4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RXRbp06fThFrP+FhQnVpnRsOSZeTl1zNN+H71AZrLFW6sulWznFYIJy6DHUNEFZ01
         thFx0oUhixVBgAgrXd+tm0ZMv0iuEoNJ4v8BXRGgada6Z6AmfJyCSUTsN6cuFM9Ui9
         hQbcKoLzTYqLqVN/IRecYEO04Hpcaj6bk8gFtZ7E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Matteo Croce <mcroce@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 47/52] kernel/sysctl.c: fix out-of-bounds access when setting file-max
Date:   Wed, 24 Apr 2019 10:39:05 -0400
Message-Id: <20190424143911.28890-47-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143911.28890-1-sashal@kernel.org>
References: <20190424143911.28890-1-sashal@kernel.org>
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
index 9e22660153ff..9a85c7ae7362 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -125,6 +125,7 @@ static int zero;
 static int __maybe_unused one = 1;
 static int __maybe_unused two = 2;
 static int __maybe_unused four = 4;
+static unsigned long zero_ul;
 static unsigned long one_ul = 1;
 static unsigned long long_max = LONG_MAX;
 static int one_hundred = 100;
@@ -1696,7 +1697,7 @@ static struct ctl_table fs_table[] = {
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

