Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FD3C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5263F20862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919335;
	bh=Hf8qXXvC/RpJAv8+tngHo+7/65d/kNCeXPGYNRJ0nXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V8M4r9i9lX1Q4rAakxtEdB9g91PB9+41OfNwSCAONThG+mnqp6ykaT2F8afWoXYhl
	 FRc1qhF7wPkGsmt8OdTpatFJLToWtvmxmtT4/edVXwz3OHGzuOvhDuUGk4M3aVZ+3Z
	 BX6mfbtSnPG6DutU0+RezQHKD4AEt8nNTYVjtQSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbfEOLWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:22:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730877AbfEOLWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:22:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E261F20818;
        Wed, 15 May 2019 11:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919330;
        bh=Hf8qXXvC/RpJAv8+tngHo+7/65d/kNCeXPGYNRJ0nXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2mCGPoykVFK+lm+aTesP2qxZ92C8M6Fiz0EwF1yF60IoZp9zWsZovmKEr9etltE7N
         TZFB3FO6PXzrml/fjDloF2PJkN3U6tUF1b/LFyBlYxset9KA45L439ONjKxjHaqWRM
         5S2bTj5+43hkUXUYJZCvDo6ILwX3ARHJou0MlOdU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
        David Howells <dhowells@redhat.com>,
        Jonathan Billings <jsbillin@umich.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 033/113] afs: Unlock pages for __pagevec_release()
Date:   Wed, 15 May 2019 12:55:24 +0200
Message-Id: <20190515090656.091640301@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090652.640988966@linuxfoundation.org>
References: <20190515090652.640988966@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 21bd68f196ca91fc0f3d9bd1b32f6e530e8c1c88 ]

__pagevec_release() complains loudly if any page in the vector is still
locked.  The pages need to be locked for generic_error_remove_page(), but
that function doesn't actually unlock them.

Unlock the pages afterwards.

Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Jonathan Billings <jsbillin@umich.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/write.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 19c04caf3c012..e00461a6de9aa 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -253,6 +253,7 @@ static void afs_kill_pages(struct address_space *mapping,
 				first = page->index + 1;
 			lock_page(page);
 			generic_error_remove_page(mapping, page);
+			unlock_page(page);
 		}
 
 		__pagevec_release(&pv);
-- 
2.20.1



