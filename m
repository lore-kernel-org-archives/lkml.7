Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D383C04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E8D2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557920615;
	bh=ODSkC85um+xb2HLufxlD81zot8WRz6w5P6oSyh8mHLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=igzx7/r7H6/QDtBDAadcvzwiWCdKIeJUVfVX+yrugrBw3PF7CwFPZMWQNKhHJGKrk
	 33LlnpqqcfH4B7hMYuGXERAlHiIM+0AUZC3rGVA7qPRsRIdgPGrw6x4tbBCpFZmnzM
	 VleVw7GgEAL1VDBtYVC+Mrio5nxjYjeW+j/qtX8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731862AbfEOL1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731373AbfEOL1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:27:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA71F206BF;
        Wed, 15 May 2019 11:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919641;
        bh=ODSkC85um+xb2HLufxlD81zot8WRz6w5P6oSyh8mHLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xX77/xBWfewgRtlK6lYfilAfvAod4FJXpOxuslnbRo6eOaqz7847eO6mjecjE2XAO
         w/JJTw5zaWLyWJejzB9nnim2bhaCP5GrnANmEJNNRU4VFGLKoO1QOfspXHBswd8p85
         uYjPTi5up38IuZev58SPfeCsg4Q6l2yqpljvu8FI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
        David Howells <dhowells@redhat.com>,
        Jonathan Billings <jsbillin@umich.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 039/137] afs: Unlock pages for __pagevec_release()
Date:   Wed, 15 May 2019 12:55:20 +0200
Message-Id: <20190515090656.231699539@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090651.633556783@linuxfoundation.org>
References: <20190515090651.633556783@linuxfoundation.org>
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
index 72efcfcf9f95e..0122d7445fba1 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -264,6 +264,7 @@ static void afs_kill_pages(struct address_space *mapping,
 				first = page->index + 1;
 			lock_page(page);
 			generic_error_remove_page(mapping, page);
+			unlock_page(page);
 		}
 
 		__pagevec_release(&pv);
-- 
2.20.1



