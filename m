Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843D5C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC2921871
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610825;
	bh=5nSmCcPbIpASKzdeIYBzAwmQCcchzc3qseVcePUQNb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zsl26oPepFW+Msto4bqWmskZpGK2pgeUfJVb5w9Mrz9foxT/mR/Df7bb5jyr6lb6P
	 nSDo1/YcMjURDhiGScgOqoJ9hYnY3AjPfrCgX87pBJ8Vc2L6pO62P+9SIhMzrDfhvB
	 16/KrIY1QyNbOXqH3EpHjtgIMC7KsqgLX/zANvL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391581AbfDRSHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:07:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391570AbfDRSHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:07:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 954D72186A;
        Thu, 18 Apr 2019 18:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610821;
        bh=5nSmCcPbIpASKzdeIYBzAwmQCcchzc3qseVcePUQNb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cla9a/rHLtoJ5M2uR8tr0nsVqG0VGOzaZuadbSvW6Cz7rd61xEU6QHIA+wD7TkObL
         lNs59EITIrF0gtsqyaK/7v7+PAm1Go9680M0gN3EleD4F+NgznzQ9Lcm9HtiKqZ9JM
         8HZJygUiiCR3PHbfZswb1bkbSjhJ8OYEQYaP+qdA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Balbir Singh <sblbir@amzn.com>
Subject: [PATCH 4.14 76/92] bpf: fix stack state printing in verifier log
Date:   Thu, 18 Apr 2019 19:57:34 +0200
Message-Id: <20190418160436.908926030@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexei Starovoitov <ast@fb.com>

commit 12a3cc8424fe1237aaeb982dec4f0914ddd22f3e upstream.

fix incorrect stack state prints in print_verifier_state()

Fixes: 638f5b90d460 ("bpf: reduce verifier memory consumption")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Balbir Singh <sblbir@amzn.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -268,7 +268,7 @@ static void print_verifier_state(struct
 	for (i = 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
 		if (state->stack[i].slot_type[0] == STACK_SPILL)
 			verbose(" fp%d=%s",
-				-MAX_BPF_STACK + i * BPF_REG_SIZE,
+				(-i - 1) * BPF_REG_SIZE,
 				reg_type_str[state->stack[i].spilled_ptr.type]);
 	}
 	verbose("\n");


