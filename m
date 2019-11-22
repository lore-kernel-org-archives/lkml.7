Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4C5C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED08B20714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403718;
	bh=Oj8oGygn/LIQ5/PgpE11S4gI61AYHg12G7VY130aoEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FNG327ZsknnMS8t67ESz6OOqRm083joSc1PIYFrr5Jb5jW1tqld+VztKqb4p3c8A6
	 8xC2FlQ1to0DUlv+sIYg7y3dHc7tzKjxAqAvUbsVQV4PdvJZf0AnrNynG1cmdZUNfk
	 wuGvg6evZwGPVGmoGsH8hPZvuuSTP66hdXru5TUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfKVGV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:21:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:57732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728383AbfKVFwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:52:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2513A2072E;
        Fri, 22 Nov 2019 05:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401931;
        bh=Oj8oGygn/LIQ5/PgpE11S4gI61AYHg12G7VY130aoEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L8VZRql/SICa/QwUCndg8KSHKdH0xDKQqFrlBvZsCK4QqdwR9g32y7P15q2jElEfa
         YszmUn/mVc6iNInYxh7PHib/BEhe/KnJtcs/68uZeFiSMQatMnFLgeeMhNIPyoAJs2
         akJcASIp8VxkPixeGpry22JAtYALlKAUwGnK1jqw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anthony Yznaga <anthony.yznaga@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 157/219] tools/vm/page-types.c: fix "kpagecount returned fewer pages than expected" failures
Date:   Fri, 22 Nov 2019 00:48:09 -0500
Message-Id: <20191122054911.1750-150-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anthony Yznaga <anthony.yznaga@oracle.com>

[ Upstream commit b6fb87b8e3ff1ef6bcf68470f24a97c984554d5a ]

Because kpagecount_read() fakes success if map counts are not being
collected, clamp the page count passed to it by walk_pfn() to the pages
value returned by the preceding call to kpageflags_read().

Link: http://lkml.kernel.org/r/1543962269-26116-1-git-send-email-anthony.yznaga@oracle.com
Fixes: 7f1d23e60718 ("tools/vm/page-types.c: include shared map counts")
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: David Rientjes <rientjes@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/vm/page-types.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/vm/page-types.c b/tools/vm/page-types.c
index 37908a83ddc27..1ff3a6c0367b0 100644
--- a/tools/vm/page-types.c
+++ b/tools/vm/page-types.c
@@ -701,7 +701,7 @@ static void walk_pfn(unsigned long voffset,
 		if (kpagecgroup_read(cgi, index, pages) != pages)
 			fatal("kpagecgroup returned fewer pages than expected");
 
-		if (kpagecount_read(cnt, index, batch) != pages)
+		if (kpagecount_read(cnt, index, pages) != pages)
 			fatal("kpagecount returned fewer pages than expected");
 
 		for (i = 0; i < pages; i++)
-- 
2.20.1

