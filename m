Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E412C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555042173E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576078455;
	bh=vvWS3qoUQuDi/xgwjMJGFXIYcuOJi6WlpF6XIGYhKGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DIwqTRS3UIju6FjO5qjGiyNvKRSfi+ghBS5VZcmkJY/lPOZBRoQgJfkqFrpPylWgV
	 CZmaFw26ddYje45wp3+Vxtoffo9mew2qUV0WMPOxknKEJs1YzNOSTCskvArXoViTCV
	 p8qKziB+DvuzQKQEVzv/3zw3QVPrkjVIu/NbQSSs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387655AbfLKP2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:28:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732704AbfLKP2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:28:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 114E224679;
        Wed, 11 Dec 2019 15:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576078089;
        bh=vvWS3qoUQuDi/xgwjMJGFXIYcuOJi6WlpF6XIGYhKGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejgWvBagZ9bgEzrE7vyB7aUCOpFtyp0dWxhMC/+o/dWgClUPLI/57LcE70dmIpNxd
         9rswYCBx7l723almCZKJV+EmJdlnn8ASUe6gC8Rua6UjwOpDlTbzVK8h7i0UQA5FcX
         9O7ywoXrWXu5vDwFD+uFzO6IBY1yBZr3WuIzWbYk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 78/79] kernel: sysctl: make drop_caches write-only
Date:   Wed, 11 Dec 2019 10:26:42 -0500
Message-Id: <20191211152643.23056-78-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211152643.23056-1-sashal@kernel.org>
References: <20191211152643.23056-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index f8576509c7bef..4c4fd4339d330 100644
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

