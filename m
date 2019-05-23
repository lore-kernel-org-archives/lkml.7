Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C921C282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0FF2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639489;
	bh=WP83gq+M7tCXOm5JOYaYjgXeecYtRirPo/bjriYZoYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WDqt30J/bhRLAecYYayNK6FMcE8Ymmcp00k55AJPk2Za4QdJM8vbU+ZG1MM6Cew4/
	 xYfVqQncApIurWi9t+BJdDmt2u8YfgpcIigfcPffXiLt6ULo2QOnobZWvnAvHiNf0/
	 huMnR/5spU3t1NLcdIfVz47KQrBJcpomQWH6hWbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390986AbfEWTYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:24:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390970AbfEWTYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:24:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E9BD2133D;
        Thu, 23 May 2019 19:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639484;
        bh=WP83gq+M7tCXOm5JOYaYjgXeecYtRirPo/bjriYZoYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fwKd84tGwsgF2q8lRhgha1RCASeB3I0p1V2OnypcMopNNk2urtyUCrfP3Fy8hdj4F
         G1ROY5SiNfDzVrdJzKmL1i4O5oCsM7f1vWMCEBxu8B1TVeVpXK/mzM8JFSEK54agPs
         DgtO+BRmN/x3cUpViCQ2bVCgnLON1A+RPD1booNY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 122/139] bpf: Fix preempt_enable_no_resched() abuse
Date:   Thu, 23 May 2019 21:06:50 +0200
Message-Id: <20190523181735.408177139@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
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
index e734f163bd0b9..1fbd7672e4b37 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -455,7 +455,7 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 		}					\
 _out:							\
 		rcu_read_unlock();			\
-		preempt_enable_no_resched();		\
+		preempt_enable();			\
 		_ret;					\
 	 })
 
-- 
2.20.1



