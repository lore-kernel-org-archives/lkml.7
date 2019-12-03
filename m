Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7894C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D0120674
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413637;
	bh=Oj8oGygn/LIQ5/PgpE11S4gI61AYHg12G7VY130aoEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XqihpKQZKW45TIjr2aACep4kd9lL+YHodJaYuGM0TvRQv2sHFu7wJIXAiRuEwyo+i
	 BIW9Qzhm7HgYC48qgyB7Yc8pafOUqLo/Onzy+pXrabrJzrsVMIEX0wAP6XxW4WIxBX
	 C+V8dXTGqSM2E9M3/a5zee7X2jHObXiW1lRPOJMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbfLCWx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:53:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730055AbfLCWxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:53:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EC1221555;
        Tue,  3 Dec 2019 22:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413631;
        bh=Oj8oGygn/LIQ5/PgpE11S4gI61AYHg12G7VY130aoEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aIn00BCcRe2HmF03M/KRMhSvHTEDn4924727MQd6FZ7dL/b4ZSrOjYJRM/GF9do9U
         6H5uNmSzT+DeMg3VoTqQlR1JvibRiV3RruTLGyods8Zy6EvCgb2OKVqFEQzLm2C20G
         tjDKQSqfkZqcOwYtkp+F88pX5w3AtRBkHr0KuYdg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anthony Yznaga <anthony.yznaga@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 201/321] tools/vm/page-types.c: fix "kpagecount returned fewer pages than expected" failures
Date:   Tue,  3 Dec 2019 23:34:27 +0100
Message-Id: <20191203223437.579205158@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



