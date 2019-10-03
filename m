Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA6AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E8220862
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570124585;
	bh=9zw12UQm7V/vEeQcMHuxi5xBI7Fc+TKHsLppDEfOcmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KMZ7kGL5KjtY+2uSqIJB6Ff34lTSB2V/LpAylXb9D9zJw/Dh8ermMvmaNYE8+t+L2
	 2Wp9VNmRfsdU0FLdaTGPiWqPz8yf1O8LzX2BpWiHYSQtm/e9bNgb/t4pdHL8K1ThHl
	 ZqaiaBPPe4EduLv7lVBmmIosrjfPlpzzC1qFfOr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390597AbfJCRnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:43:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730690AbfJCP4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:56:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAACA20830;
        Thu,  3 Oct 2019 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118197;
        bh=9zw12UQm7V/vEeQcMHuxi5xBI7Fc+TKHsLppDEfOcmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tAULlERoHCYyjI/WiF3/tsK+Wepy50aJ7g8l9LvzHqRJL+DMeL3cSJypGHuwBBJqU
         HLUxyDj7YbIL9uJbZeFczRhh7uQYvWv3eDlUnueWw8LRZqXc2Qs4Ag7ecz149Zpntj
         N2liEtMUaHJ3qKYqMzxFxdFu4hMCiupJM7wZhf7M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH 4.4 24/99] sch_netem: fix a divide by zero in tabledist()
Date:   Thu,  3 Oct 2019 17:52:47 +0200
Message-Id: <20191003154305.598741452@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154252.297991283@linuxfoundation.org>
References: <20191003154252.297991283@linuxfoundation.org>
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
@@ -713,7 +713,7 @@ static int get_dist_table(struct Qdisc *
 	int i;
 	size_t s;
 
-	if (n > NETEM_DIST_MAX)
+	if (!n || n > NETEM_DIST_MAX)
 		return -EINVAL;
 
 	s = sizeof(struct disttable) + n * sizeof(s16);


