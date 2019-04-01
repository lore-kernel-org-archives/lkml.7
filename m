Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAADC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7004B206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139332;
	bh=FRHS2tY8RV75nPxmnQJ2DPXLq5bTY1DTtdR6YUFiYAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s5tE18UcG+Uy/CaD4bQHPFkZ35I8LfgGNzVEtAToitQfCYbNTyaAnyx39Mg9M3Uag
	 U2wKTtY8m2tc1wjPnXfzwOkpRDmdacAgkXdOGUVoDjjbQPfrrLZmZE/YcqZviRxHan
	 PM74TsT8KVwqKNoWpuRuT+l111hQrZrB7UnulK7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbfDARWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:22:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731526AbfDARWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:22:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19522206DD;
        Mon,  1 Apr 2019 17:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139327;
        bh=FRHS2tY8RV75nPxmnQJ2DPXLq5bTY1DTtdR6YUFiYAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J7wwES5C2g9b83mXopeRKLdHnIFv0SQTjOaBWedugk2uKLVALobID2JNRY656S7Ox
         9CmMIFq24AfWyBJ2Rfe2NA/YKznrDAK2eGvpkSvhUafLV7qQySbCBhOESN74++elzC
         /26A3vPR4uuDUEtp7ORK6Tme7kJZTeMbYFrgZhVA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 006/107] genetlink: Fix a memory leak on error path
Date:   Mon,  1 Apr 2019 19:01:21 +0200
Message-Id: <20190401170045.934006548@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -365,7 +365,7 @@ int genl_register_family(struct genl_fam
 			       start, end + 1, GFP_KERNEL);
 	if (family->id < 0) {
 		err = family->id;
-		goto errout_locked;
+		goto errout_free;
 	}
 
 	err = genl_validate_assign_mc_groups(family);
@@ -384,6 +384,7 @@ int genl_register_family(struct genl_fam
 
 errout_remove:
 	idr_remove(&genl_fam_idr, family->id);
+errout_free:
 	kfree(family->attrbuf);
 errout_locked:
 	genl_unlock_all();


