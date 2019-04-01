Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C95C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F8E20651
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141864;
	bh=XCKwkhL/dH4zF/9+nTKITiL16Vs2LOeHeyYXZbhoozQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E3gVt/9HZ/TeXgbUSmZDaqtrZqz0UCh5dlpeP5nLueZLna81U1Z2Hll/UP7yrxkIZ
	 HD8FxnFxQzxwBiiKSywmwPnTOTRVUoM57CSaJAxKXe0XHKB2N0honlQh5TojozhSD2
	 gCs7oguALQ6X+FMD7RHGF1Ym+SBX8gfA9Nq6lhu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbfDASEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:04:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730663AbfDAROB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:14:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A12A8218FE;
        Mon,  1 Apr 2019 17:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138254;
        bh=XCKwkhL/dH4zF/9+nTKITiL16Vs2LOeHeyYXZbhoozQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ddJ/BP+JbH+vMtGQzIoMbyCO0n4uuSdojp1Lh/EnY8LvpreVBejeVBG0ZdUt6B0wB
         gWe1Na1m4j7cCVilbINk6nabbgHXsAvO4/nza3ZgtM3KUoNMAGmMHccs31xhMyjTo1
         Y+6F8iU9KFITHJpk2RJkZQJtV8D74cNfCGgR/1Dw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 005/146] genetlink: Fix a memory leak on error path
Date:   Mon,  1 Apr 2019 19:00:17 +0200
Message-Id: <20190401170048.879279309@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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


