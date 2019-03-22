Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4FDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5142195D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255909;
	bh=7eibj3al9HMLW6P5VvZplGcWbt/dBpLCkrKS64I7abY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oup/V1twzNwC3sUNqhJeoIB9yILmugdwQN2JzBC2ihvbVk7O9nBEwrC0yOOokfl8T
	 3oOJL/hapJTjT6kXZABK+8DoJzMVxn/3PzIdcqTekZvWkDC/fvy10Y+mRiRMRQXn7N
	 b8bKqE0G88QymfQIUGuRAsXAFoH+OXCo9KES0Eos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387833AbfCVL62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:58:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730121AbfCVL6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:58:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F17C22195D;
        Fri, 22 Mar 2019 11:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255904;
        bh=7eibj3al9HMLW6P5VvZplGcWbt/dBpLCkrKS64I7abY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uUP8MySs7jD/5co5eQ/6rOKlSePn1sG5gstqLu9Oe02o7XYiaugdzje/IibdHWIf8
         Ch84uQCKptn9xUYiX4gM9auDQaH6a2+C5SyEfUKvFOIPS2D5bLC8fc+3cy5oMP5p5E
         /4YBjx0ylFbxd2FoniCqGJaazTJRx1CQzmMmW41M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Francesco Ruggeri <fruggeri@arista.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 050/280] netfilter: compat: initialize all fields in xt_init
Date:   Fri, 22 Mar 2019 12:13:23 +0100
Message-Id: <20190322111309.123528121@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8d29d16d21342a0c86405d46de0c4ac5daf1760f ]

If a non zero value happens to be in xt[NFPROTO_BRIDGE].cur at init
time, the following panic can be caused by running

% ebtables -t broute -F BROUTING

from a 32-bit user level on a 64-bit kernel. This patch replaces
kmalloc_array with kcalloc when allocating xt.

[  474.680846] BUG: unable to handle kernel paging request at 0000000009600920
[  474.687869] PGD 2037006067 P4D 2037006067 PUD 2038938067 PMD 0
[  474.693838] Oops: 0000 [#1] SMP
[  474.697055] CPU: 9 PID: 4662 Comm: ebtables Kdump: loaded Not tainted 4.19.17-11302235.AroraKernelnext.fc18.x86_64 #1
[  474.707721] Hardware name: Supermicro X9DRT/X9DRT, BIOS 3.0 06/28/2013
[  474.714313] RIP: 0010:xt_compat_calc_jump+0x2f/0x63 [x_tables]
[  474.720201] Code: 40 0f b6 ff 55 31 c0 48 6b ff 70 48 03 3d dc 45 00 00 48 89 e5 8b 4f 6c 4c 8b 47 60 ff c9 39 c8 7f 2f 8d 14 08 d1 fa 48 63 fa <41> 39 34 f8 4c 8d 0c fd 00 00 00 00 73 05 8d 42 01 eb e1 76 05 8d
[  474.739023] RSP: 0018:ffffc9000943fc58 EFLAGS: 00010207
[  474.744296] RAX: 0000000000000000 RBX: ffffc90006465000 RCX: 0000000002580249
[  474.751485] RDX: 00000000012c0124 RSI: fffffffff7be17e9 RDI: 00000000012c0124
[  474.758670] RBP: ffffc9000943fc58 R08: 0000000000000000 R09: ffffffff8117cf8f
[  474.765855] R10: ffffc90006477000 R11: 0000000000000000 R12: 0000000000000001
[  474.773048] R13: 0000000000000000 R14: ffffc9000943fcb8 R15: ffffc9000943fcb8
[  474.780234] FS:  0000000000000000(0000) GS:ffff88a03f840000(0063) knlGS:00000000f7ac7700
[  474.788612] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  474.794632] CR2: 0000000009600920 CR3: 0000002037422006 CR4: 00000000000606e0
[  474.802052] Call Trace:
[  474.804789]  compat_do_replace+0x1fb/0x2a3 [ebtables]
[  474.810105]  compat_do_ebt_set_ctl+0x69/0xe6 [ebtables]
[  474.815605]  ? try_module_get+0x37/0x42
[  474.819716]  compat_nf_setsockopt+0x4f/0x6d
[  474.824172]  compat_ip_setsockopt+0x7e/0x8c
[  474.828641]  compat_raw_setsockopt+0x16/0x3a
[  474.833220]  compat_sock_common_setsockopt+0x1d/0x24
[  474.838458]  __compat_sys_setsockopt+0x17e/0x1b1
[  474.843343]  ? __check_object_size+0x76/0x19a
[  474.847960]  __ia32_compat_sys_socketcall+0x1cb/0x25b
[  474.853276]  do_fast_syscall_32+0xaf/0xf6
[  474.857548]  entry_SYSENTER_compat+0x6b/0x7a

Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/x_tables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index aecadd471e1d..13e1ac333fa4 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1899,7 +1899,7 @@ static int __init xt_init(void)
 		seqcount_init(&per_cpu(xt_recseq, i));
 	}
 
-	xt = kmalloc_array(NFPROTO_NUMPROTO, sizeof(struct xt_af), GFP_KERNEL);
+	xt = kcalloc(NFPROTO_NUMPROTO, sizeof(struct xt_af), GFP_KERNEL);
 	if (!xt)
 		return -ENOMEM;
 
-- 
2.19.1



