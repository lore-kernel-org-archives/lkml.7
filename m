Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81562C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A4720830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570120482;
	bh=ZSr+ymMHWbVbOK74oW3ZFZxpB4i/n3GUFDbjMk3BF4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fobs5zWyI0h0MwEKeHLvMNzHITUrZqMLcpu/zaxF1xqCferJ8OOrDJYeDD/MBPNmn
	 Dn0PfErMwmlVBwjpT8BGDawP2n04oGlljuyNoZWst+bUcEzvMeFGFJBM2GfjwSGeVs
	 IBY7vrQECUIa3J2TCgp/AxOgBd65/v70xnpCSJYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392122AbfJCQel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:34:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391775AbfJCQej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:34:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D9A620830;
        Thu,  3 Oct 2019 16:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120478;
        bh=ZSr+ymMHWbVbOK74oW3ZFZxpB4i/n3GUFDbjMk3BF4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MhR2wjqG8wNQ0LFe0cplbQn6d5ND7PUmlNee7rNZ+iGxEi8QCF0WaUbK1IW9bC6iw
         OWLnL64Bl0h0mSkTO5w7+qi7f6QW3+U09zpDud+IPQY+umf4XVrUxRvUcYBzQI7k3s
         pX6x22kQTD8leeM8BfodAvdxGj0FhrvI24rNc6dk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 5.2 236/313] fuse: fix missing unlock_page in fuse_writepage()
Date:   Thu,  3 Oct 2019 17:53:34 +0200
Message-Id: <20191003154556.245317543@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
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
@@ -1767,6 +1767,7 @@ static int fuse_writepage(struct page *p
 		WARN_ON(wbc->sync_mode == WB_SYNC_ALL);
 
 		redirty_page_for_writepage(wbc, page);
+		unlock_page(page);
 		return 0;
 	}
 


