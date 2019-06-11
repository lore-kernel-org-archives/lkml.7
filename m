Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C828C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418212063F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390841AbfFKN2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 09:28:16 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.89]:28690 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726713AbfFKN2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:28:15 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id D8AE0400CB727
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 08:28:14 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id agowhYZqT2qH7agowhjxzF; Tue, 11 Jun 2019 08:28:14 -0500
X-Authority-Reason: nr=8
Received: from [189.250.75.107] (port=56764 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hagov-003AjN-D8; Tue, 11 Jun 2019 08:28:13 -0500
Date:   Tue, 11 Jun 2019 08:28:11 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Lawrence Brakmo <brakmo@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] bpf: verifier: avoid fall-through warnings
Message-ID: <20190611132811.GA27212@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.75.107
X-Source-L: No
X-Exim-ID: 1hagov-003AjN-D8
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.75.107]:56764
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, this patch silences
the following warning:

kernel/bpf/verifier.c: In function ‘check_return_code’:
kernel/bpf/verifier.c:5509:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (env->prog->expected_attach_type == BPF_CGROUP_UDP4_RECVMSG ||
      ^
kernel/bpf/verifier.c:5512:2: note: here
  case BPF_PROG_TYPE_CGROUP_SKB:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that it's much clearer to explicitly add breaks in each case
(that actually contains some code), rather than letting the code to
fall through.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1e9d10b32984..e9fc28991548 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5509,11 +5509,13 @@ static int check_return_code(struct bpf_verifier_env *env)
 		if (env->prog->expected_attach_type == BPF_CGROUP_UDP4_RECVMSG ||
 		    env->prog->expected_attach_type == BPF_CGROUP_UDP6_RECVMSG)
 			range = tnum_range(1, 1);
+		break;
 	case BPF_PROG_TYPE_CGROUP_SKB:
 		if (env->prog->expected_attach_type == BPF_CGROUP_INET_EGRESS) {
 			range = tnum_range(0, 3);
 			enforce_attach_type_range = tnum_range(2, 3);
 		}
+		break;
 	case BPF_PROG_TYPE_CGROUP_SOCK:
 	case BPF_PROG_TYPE_SOCK_OPS:
 	case BPF_PROG_TYPE_CGROUP_DEVICE:
-- 
2.21.0

