Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A18C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AF32083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256736;
	bh=YO7FLkhrr1GOg5XRlNjlw/cDzgBkOn9jA1FYikRHPLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MV9UXKgQEvpLcpoHfv7f7/sht6EPCveaknqJIoxrC1wUdx/7bPojFP7BquggoPaPL
	 6z6Dn9yQoe6XPLGw0nmxSwdD+4qDjjiFdeUyQUGQvCY3aDcCcxhxCSTiDdfzvmyQr9
	 2os4D3EqS8d34PuXY3jhI4LkDzxBThnFEd7acbK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389601AbfCVMMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:12:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389449AbfCVMMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:12:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76E1A2083D;
        Fri, 22 Mar 2019 12:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256726;
        bh=YO7FLkhrr1GOg5XRlNjlw/cDzgBkOn9jA1FYikRHPLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P9Ev146fX5MHtP6YlZ011Kldie1t51KeoQCFyvIJAFWhNUh7dNLF2HTJOL5TMAU89
         bDGwQjWX7+AUsqR5E0iN9YMtWnDxrGD0OzrLtvwr4UI+8sSnXxTLElP0lzjLv0P7cL
         FVusSmhcjU5xj9f/ipPaK+quP3u645SLqSgUODV0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        zhengbin <zhengbin13@huawei.com>,
        Dominique Martinet <dominique.martinet@cea.fr>
Subject: [PATCH 5.0 002/238] 9p/net: fix memory leak in p9_client_create
Date:   Fri, 22 Mar 2019 12:13:41 +0100
Message-Id: <20190322111258.504058704@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: zhengbin <zhengbin13@huawei.com>

commit bb06c388fa20ae24cfe80c52488de718a7e3a53f upstream.

If msize is less than 4096, we should close and put trans, destroy
tagpool, not just free client. This patch fixes that.

Link: http://lkml.kernel.org/m/1552464097-142659-1-git-send-email-zhengbin13@huawei.com
Cc: stable@vger.kernel.org
Fixes: 574d356b7a02 ("9p/net: put a lower bound on msize")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/9p/client.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1061,7 +1061,7 @@ struct p9_client *p9_client_create(const
 		p9_debug(P9_DEBUG_ERROR,
 			 "Please specify a msize of at least 4k\n");
 		err = -EINVAL;
-		goto free_client;
+		goto close_trans;
 	}
 
 	err = p9_client_version(clnt);


