Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85790C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5695221925
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138830;
	bh=B18fq4sMOSbs6Zt0ofq9mIxZinCq/uD4gW5S6vOSRiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RRzITsq+z7RedPw1yPiJJq7suIGgSI+IyqJF5UwU9f5omOaSFSfS09M3wuLQHx4Q5
	 6e+1m9NCzb54Eofhyfsy5FnXS5X7RNChBP9GsaJDE/CS8rbqXPP5eYgTWlmAOPqDHy
	 88zhJNrqmeInFH9cXqJcqClWqif3QoAg11PQX86g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbfDARNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:13:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730601AbfDARNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:13:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5912B21B18;
        Mon,  1 Apr 2019 17:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138823;
        bh=B18fq4sMOSbs6Zt0ofq9mIxZinCq/uD4gW5S6vOSRiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EufLKMYkrY21akQonmxhx3IC82pTReWnJYN4a0paRvmC7PHvLyGMViCTFDO5lptAM
         +tHax3PYmSTQ40VGgrRwDhiQrsEJkcVvFduwjL8FhRJ+L5abdVMMsYsMpcgPG0nDex
         N3MAnpNnQlEb/ZJh9cfllrUizf9tzljR38PJBwc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 005/134] genetlink: Fix a memory leak on error path
Date:   Mon,  1 Apr 2019 19:00:41 +0200
Message-Id: <20190401170044.721229666@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit ceabee6c59943bdd5e1da1a6a20dc7ee5f8113a2 ]

In genl_register_family(), when idr_alloc() fails,
we forget to free the memory we possibly allocate for
family->attrbuf.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 2ae0f17df1cd ("genetlink: use idr to track families")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netlink/genetlink.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -366,7 +366,7 @@ int genl_register_family(struct genl_fam
 			       start, end + 1, GFP_KERNEL);
 	if (family->id < 0) {
 		err = family->id;
-		goto errout_locked;
+		goto errout_free;
 	}
 
 	err = genl_validate_assign_mc_groups(family);
@@ -385,6 +385,7 @@ int genl_register_family(struct genl_fam
 
 errout_remove:
 	idr_remove(&genl_fam_idr, family->id);
+errout_free:
 	kfree(family->attrbuf);
 errout_locked:
 	genl_unlock_all();


