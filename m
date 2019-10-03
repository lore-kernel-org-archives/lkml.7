Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E6BC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7F2222BE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118698;
	bh=BdAJnqwsm9EAGhDxelc1iBVbcc2+bRgVx3WhndJS2Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y6IP1zVxf2Cb89k3/XCyGGX99mcbIMFVbkGlwatHoGuEl5NXY4Hekcez8GadW8rq3
	 oaBQ2jntW4AVac8wArrOmHNhInF/resDdX7eMwfBQVJaYO6eC5h7EvZxqsfvscJ8Kh
	 Kwvwrz1sF30B/XZuyRtLWvtlz4zQM/emDeuaw23o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732493AbfJCQE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:04:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731475AbfJCQEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:04:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC58D222BE;
        Thu,  3 Oct 2019 16:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118694;
        bh=BdAJnqwsm9EAGhDxelc1iBVbcc2+bRgVx3WhndJS2Ps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LPNNT0Ti+lxsR6XCoLeOSafyUeSyOfl4v166IMMvYkAWzZa4fQn/X0Qq+zChO4fA6
         1OiSuBlis9JtTVp0X9y4J7vLtBQyQ5XXTCYGlHOyGzHAE8h1BQ4SK3CjqgaEAdNbio
         6PegwbsSfrtH0bwVt+39LfTugYHof2GLbhboRDrw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.9 103/129] fuse: fix missing unlock_page in fuse_writepage()
Date:   Thu,  3 Oct 2019 17:53:46 +0200
Message-Id: <20191003154406.232901295@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154318.081116689@linuxfoundation.org>
References: <20191003154318.081116689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

commit d5880c7a8620290a6c90ced7a0e8bd0ad9419601 upstream.

unlock_page() was missing in case of an already in-flight write against the
same page.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Fixes: ff17be086477 ("fuse: writepage: skip already in flight")
Cc: <stable@vger.kernel.org> # v3.13
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/file.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1694,6 +1694,7 @@ static int fuse_writepage(struct page *p
 		WARN_ON(wbc->sync_mode == WB_SYNC_ALL);
 
 		redirty_page_for_writepage(wbc, page);
+		unlock_page(page);
 		return 0;
 	}
 


