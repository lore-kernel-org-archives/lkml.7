Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29473C3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C3C2253D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003692;
	bh=HrTVBqJGvBqiSddNJgGarJ2BT+eOP7XFbllL+9PsWnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N5ior6/Zp0VuipJWNSKaV8JBcLokVSWjNfuFcd2829BxeclHd46acTw4NwdnJdqmG
	 r2tOuxpmchJomVktu1xdkbGbYOP0xv82yZVkeaj07Ug5bG9TCj3YRcxUJHcRJC+RPW
	 AU9a/+f3w/8JjZrGB8qnMy76/p6TgyKsJBaCSf+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgABWVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:21:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728752AbgABWVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:21:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ED6224125;
        Thu,  2 Jan 2020 22:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003684;
        bh=HrTVBqJGvBqiSddNJgGarJ2BT+eOP7XFbllL+9PsWnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EbMovZjbhnFlu0eRV43NAnxB+oDzTBVReW5lA7A9if77Vga5/K7TrjXHM+7D8q/ky
         NAse5r+Jf0tyPoqcISuhRMHY9KedweZFs76oop0kkRoz4xj7HnKi3acdoQLcs9XH96
         DyVirMWmsNngpOC0KqzkTP7xz2u2UUfYAcskl7oY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 071/114] kernel: sysctl: make drop_caches write-only
Date:   Thu,  2 Jan 2020 23:07:23 +0100
Message-Id: <20200102220036.228967185@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220029.183913184@linuxfoundation.org>
References: <20200102220029.183913184@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Weiner <hannes@cmpxchg.org>

[ Upstream commit 204cb79ad42f015312a5bbd7012d09c93d9b46fb ]

Currently, the drop_caches proc file and sysctl read back the last value
written, suggesting this is somehow a stateful setting instead of a
one-time command.  Make it write-only, like e.g.  compact_memory.

While mitigating a VM problem at scale in our fleet, there was confusion
about whether writing to this file will permanently switch the kernel into
a non-caching mode.  This influences the decision making in a tense
situation, where tens of people are trying to fix tens of thousands of
affected machines: Do we need a rollback strategy?  What are the
performance implications of operating in a non-caching state for several
days?  It also caused confusion when the kernel team said we may need to
write the file several times to make sure it's effective ("But it already
reads back 3?").

Link: http://lkml.kernel.org/r/20191031221602.9375-1-hannes@cmpxchg.org
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Chris Down <chris@chrisdown.name>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index f8576509c7be..4c4fd4339d33 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1411,7 +1411,7 @@ static struct ctl_table vm_table[] = {
 		.procname	= "drop_caches",
 		.data		= &sysctl_drop_caches,
 		.maxlen		= sizeof(int),
-		.mode		= 0644,
+		.mode		= 0200,
 		.proc_handler	= drop_caches_sysctl_handler,
 		.extra1		= &one,
 		.extra2		= &four,
-- 
2.20.1



