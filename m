Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1CAC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D572075D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfD1GAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 02:00:49 -0400
Received: from www.osadl.org ([62.245.132.105]:57046 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfD1GAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 02:00:49 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x3S60YrZ009468;
        Sun, 28 Apr 2019 08:00:35 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Jamal Hadi Salim <jhs@mojatatu.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] net_sched: force endianness annotation
Date:   Sun, 28 Apr 2019 07:54:59 +0200
Message-Id: <1556430899-11018-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the endiannes is being handled correctly sparse was unhappy with
the missing annotation as be16_to_cpu()/be32_to_cpu() expects a __be16
respectively __be32. To mitigate this annotation issue forced annotation
is introduced. Note that this patch has no impact on the generated binary.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem located by an experimental cocci script to locate sparse annontation isues.
net/sched/em_cmp.c:44:31: warning: cast to restricted __be16
net/sched/em_cmp.c:44:31: warning: cast to restricted __be16
net/sched/em_cmp.c:44:31: warning: cast to restricted __be16
net/sched/em_cmp.c:44:31: warning: cast to restricted __be16
net/sched/em_cmp.c:54:31: warning: cast to restricted __be32
net/sched/em_cmp.c:54:31: warning: cast to restricted __be32
net/sched/em_cmp.c:54:31: warning: cast to restricted __be32
net/sched/em_cmp.c:54:31: warning: cast to restricted __be32
net/sched/em_cmp.c:54:31: warning: cast to restricted __be32
net/sched/em_cmp.c:54:31: warning: cast to restricted __be32

This is due to the variable being converted and thus the type is the
teget system type and it must be caset to __be16/__be32 here for sparse
to understand that endianness is adequately handled.

Patch was compile-tested with: x86_64_defconfig

Verification that the patch has no impact on the binary being generated
was done by diff on the binary before and after applying the patch.

Patch is against 5.1-rc6 (localversion-next is next-20190426)

 net/sched/em_cmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/em_cmp.c b/net/sched/em_cmp.c
index 1c8360a..3045ee1 100644
--- a/net/sched/em_cmp.c
+++ b/net/sched/em_cmp.c
@@ -41,7 +41,7 @@ static int em_cmp_match(struct sk_buff *skb, struct tcf_ematch *em,
 		val = get_unaligned_be16(ptr);
 
 		if (cmp_needs_transformation(cmp))
-			val = be16_to_cpu(val);
+			val = be16_to_cpu((__force __be16)val);
 		break;
 
 	case TCF_EM_ALIGN_U32:
@@ -51,7 +51,7 @@ static int em_cmp_match(struct sk_buff *skb, struct tcf_ematch *em,
 		val = get_unaligned_be32(ptr);
 
 		if (cmp_needs_transformation(cmp))
-			val = be32_to_cpu(val);
+			val = be32_to_cpu((__force __be32)val);
 		break;
 
 	default:
-- 
2.1.4

