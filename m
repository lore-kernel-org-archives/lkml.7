Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBC5C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E0224672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782634;
	bh=yTxjhlA0GOCxsjuGn4rKAiPTxp3UhagqMA/rASlPzQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EEVShzCYCJYbyMpu4+R2vYkgc2VNlWQas/fATOqPqSE6MZUrFZdh9geFH8JAXTqfU
	 5xw2n423kHbfVLgmowQaM/5XzOq0mG/vDQZ4ltXqEOyLqojIGfgza9U+vO8bfRQ8KB
	 EkSbBwi8rHP8sSTIPfUgkCrYNiGoDK6eBv7fi74w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfLSTKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:10:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:57818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728208AbfLSSjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:39:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77FFC24680;
        Thu, 19 Dec 2019 18:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780771;
        bh=yTxjhlA0GOCxsjuGn4rKAiPTxp3UhagqMA/rASlPzQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WrycaBp6CbcQrZdlV7zrsPoR/uaCosViPN3+xxOjBl2UAdJGYIcEQMIoC5w5kR7+K
         vgyHsmIUkkrWcnXIHbmPO8pHnW5XYte+KUtmo5ht5GMsUrGQ09jHxi+7zQ4CR06DEF
         sOWjudj+kYaAsf/wCxkTCdX3CkvFRuS/7I8zLUm0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 073/162] appletalk: Set error code if register_snap_client failed
Date:   Thu, 19 Dec 2019 19:33:01 +0100
Message-Id: <20191219183212.250605627@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

commit c93ad1337ad06a718890a89cdd85188ff9a5a5cc upstream.

If register_snap_client fails in atalk_init,
error code should be set, otherwise it will
triggers NULL pointer dereference while unloading
module.

Fixes: 9804501fa122 ("appletalk: Fix potential NULL pointer dereference in unregister_snap_client")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/appletalk/ddp.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -1927,6 +1927,7 @@ static int __init atalk_init(void)
 	ddp_dl = register_snap_client(ddp_snap_id, atalk_rcv);
 	if (!ddp_dl) {
 		pr_crit("Unable to register DDP with SNAP.\n");
+		rc = -ENOMEM;
 		goto out_sock;
 	}
 


