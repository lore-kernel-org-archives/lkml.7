Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335D3C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037B12171F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429402;
	bh=75bIZkEY8lHjMkqWn5U4NGFfy/4ukdRLtigCv2Eknhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jpbu9XsgI1oG1cyMzEUJWbHiWVQD7OkQIp5RpsnqrlYHANYw2xnhcq6ufGtfCK43a
	 GEpKwLSk/c6WRFgBuc+5f27C4SM3ZqSkb1CCLoRTQtGRWFrWbgZvOZlOlBIlto13XN
	 jFQOrx+bk2GN/2PUkMAt1DhbHOxhHJCmadUCh4Mg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfG2TnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:43:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389321AbfG2TnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:43:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AE1B21655;
        Mon, 29 Jul 2019 19:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429396;
        bh=75bIZkEY8lHjMkqWn5U4NGFfy/4ukdRLtigCv2Eknhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=meOYiZjaZEOHZ6B46yAbMm884usdlNB7hPC/gcmO7KekxVGfGY8WzhTP3pNfJk4Rc
         VcOkmfKe2kgjktUAm4vbRmWllTPTnxk6eqyvmBiZrU8a0vK80UQrS8SJScDKC9g3SY
         ksqLk9S6lbNgT7VW2Yotqgr/tmCj5xwn7ovRBJqE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Robin Murphy <robin.murphy@arm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 085/113] mm/gup.c: mark undo_dev_pagemap as __maybe_unused
Date:   Mon, 29 Jul 2019 21:22:52 +0200
Message-Id: <20190729190715.840669831@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190655.455345569@linuxfoundation.org>
References: <20190729190655.455345569@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 790c73690c2bbecb3f6f8becbdb11ddc9bcff8cc ]

Several mips builds generate the following build warning.

  mm/gup.c:1788:13: warning: 'undo_dev_pagemap' defined but not used

The function is declared unconditionally but only called from behind
various ifdefs. Mark it __maybe_unused.

Link: http://lkml.kernel.org/r/1562072523-22311-1-git-send-email-linux@roeck-us.net
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/gup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index caadd31714a5..43c71397c7ca 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1367,7 +1367,8 @@ static inline pte_t gup_get_pte(pte_t *ptep)
 }
 #endif
 
-static void undo_dev_pagemap(int *nr, int nr_start, struct page **pages)
+static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
+					    struct page **pages)
 {
 	while ((*nr) - nr_start) {
 		struct page *page = pages[--(*nr)];
-- 
2.20.1



