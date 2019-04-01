Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B23C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C8020830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139824;
	bh=BRM0vHzAXwu6TbIYlpvLys6KhjT+03YGEl0QGcq5ogk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WCG3xlFypKc1hUdlgr+Pr+Wl8ghVmfLmFr9ddYtzmr9qTT827vDWnytbSRzigzatE
	 2awDNQFOg6dFPsBcqnLbR3Pp771zdMQgd1x6kpoP5EkxTL4VCcBojG0HDgBVJnMUi8
	 Mdn19dFy3wT8d6cGub1OI+Gi/4kn1+Imk+CbTCIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733081AbfDARaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:30:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733069AbfDARaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:30:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 082862146E;
        Mon,  1 Apr 2019 17:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139819;
        bh=BRM0vHzAXwu6TbIYlpvLys6KhjT+03YGEl0QGcq5ogk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OKw219nEIo4rEy7M+fk4uIozRIsSqZah50MUhDlGYVKL/O1mEVz22dS1xGDbuOPDj
         aPUuLSAo4FFt1n95XcEQb0Jx0DgsaxqqllDISGhBi1LPy4vpuyJoFOf23vB50jO7sp
         J4bt5jtbN1Vy9yWr6DzXtCCtbyj2j6wQAvxczG38=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Vasily Averin <vvs@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 023/131] mm/rmap: replace BUG_ON(anon_vma->degree) with VM_WARN_ON
Date:   Mon,  1 Apr 2019 19:01:33 +0200
Message-Id: <20190401170053.954755814@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

commit e4c5800a3991f0c6a766983535dfc10d51802cf6 upstream.

This check effectively catches anon vma hierarchy inconsistence and some
vma corruptions.  It was effective for catching corner cases in anon vma
reusing logic.  For now this code seems stable so check could be hidden
under CONFIG_DEBUG_VM and replaced with WARN because it's not so fatal.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Suggested-by: Vasily Averin <vvs@virtuozzo.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/rmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -408,7 +408,7 @@ void unlink_anon_vmas(struct vm_area_str
 	list_for_each_entry_safe(avc, next, &vma->anon_vma_chain, same_vma) {
 		struct anon_vma *anon_vma = avc->anon_vma;
 
-		BUG_ON(anon_vma->degree);
+		VM_WARN_ON(anon_vma->degree);
 		put_anon_vma(anon_vma);
 
 		list_del(&avc->same_vma);


