Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BBDC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA95621851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639121;
	bh=bd8CLshTdtJtuUpp8mPtIPDnOT6V9ey41gamWfUD9Ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L2t2lsUzl01qurYwcl1HbLPJBnuURAfXxE4E+SiOkSyWER6l84ofW3mRFWRqxfOVL
	 C26HT/zHjjZxTzbz+eYFFNDg3pfCfZCZW0EYH2Ms4n1gw2FlCNLe1fyOTembyclU2f
	 VLrAH8kFWgz2cS6WyUPfyY/+PXygzxXIPK8+Poog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389671AbfEWTSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:18:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389660AbfEWTSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:18:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58E9920863;
        Thu, 23 May 2019 19:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639115;
        bh=bd8CLshTdtJtuUpp8mPtIPDnOT6V9ey41gamWfUD9Ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CtjpyS/o5VGH9IH2Xlz5L1DNinymI+0YjoNLz8pBHbtigauONW+G6bGweNSk0Zq8P
         AHlu8AsHfvB/DuyGspSrQ8avdi8VkwnWr3Q3cTV3EB3IItv6yXIpRz45qlh4oH929K
         WAHJ+P2+2h06sw47FOICbEZ1ftI5Lw20h3ljvQXo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 100/114] bpf: Fix preempt_enable_no_resched() abuse
Date:   Thu, 23 May 2019 21:06:39 +0200
Message-Id: <20190523181740.223939766@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181731.372074275@linuxfoundation.org>
References: <20190523181731.372074275@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 0edd6b64d1939e9e9168ff27947995bb7751db5d ]

Unless the very next line is schedule(), or implies it, one must not use
preempt_enable_no_resched(). It can cause a preemption to go missing and
thereby cause arbitrary delays, breaking the PREEMPT=y invariant.

Cc: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 523481a3471b5..fd95f2efe5f32 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -400,7 +400,7 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 		}					\
 _out:							\
 		rcu_read_unlock();			\
-		preempt_enable_no_resched();		\
+		preempt_enable();			\
 		_ret;					\
 	 })
 
-- 
2.20.1



