Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06F7C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95ED521783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118983;
	bh=OO6n8+8fpvuQYORdso34RDWt5h1ChvIzr+09+4h4/0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KvMZkoQcYU63Q4kP4CvVQxmXZcXVDUcz9nokx9GM9fmbyS6gEgXig9GIQm7kdHfJa
	 lxZKHyDdhmzkmucu/xQCbkFDdEtiwtWTwGct/8Si7OqvrqblZSRa4j1hoH5b9PvY5Y
	 nAR35Hp/Lubm6TU3qKxLGqTKsUaschPraIOumkv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbfJCQJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:09:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387480AbfJCQJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:09:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DA06215EA;
        Thu,  3 Oct 2019 16:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118977;
        bh=OO6n8+8fpvuQYORdso34RDWt5h1ChvIzr+09+4h4/0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y6ybbV1FC64JLJbnhPzIRzfuEReByzHwebYnOQdGT6ZJXKPyDAkhO1RZ3SzdWPvxE
         99m2jXMCxnF7X7rK9O5YXLHoXMQlVXdjP7uMfPVZBmHhOvQPmUDrUfrOzDp3w+SL9m
         pGORsK3i1Q1sglFYWF8O5NS0nmceWhanbIsdLvOM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH 4.14 043/185] sch_netem: fix a divide by zero in tabledist()
Date:   Thu,  3 Oct 2019 17:52:01 +0200
Message-Id: <20191003154447.588828756@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit b41d936b5ecfdb3a4abc525ce6402a6c49cffddc ]

syzbot managed to crash the kernel in tabledist() loading
an empty distribution table.

	t = dist->table[rnd % dist->size];

Simply return an error when such load is attempted.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_netem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -708,7 +708,7 @@ static int get_dist_table(struct Qdisc *
 	struct disttable *d;
 	int i;
 
-	if (n > NETEM_DIST_MAX)
+	if (!n || n > NETEM_DIST_MAX)
 		return -EINVAL;
 
 	d = kvmalloc(sizeof(struct disttable) + n * sizeof(s16), GFP_KERNEL);


