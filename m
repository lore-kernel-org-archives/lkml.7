Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B83C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6266520733
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519008;
	bh=yTxjhlA0GOCxsjuGn4rKAiPTxp3UhagqMA/rASlPzQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LNe7NWVRoUW2yXpbJT1OBUaT85dDaBTTFfYesi+096SP16EN+SIitNVFAZkJMU3z8
	 TwViAx7N5gavEMdCA/HiicMNORzdC0PWwHeFlE6B/4xi4OlPBEUbzha5aYGLdyT24t
	 /MQ780m6PsUQBh7OQBza9ap5e8LUiaHG2ISk3SI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfLPR4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:56:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:55076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727908AbfLPR4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:56:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88158206B7;
        Mon, 16 Dec 2019 17:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519003;
        bh=yTxjhlA0GOCxsjuGn4rKAiPTxp3UhagqMA/rASlPzQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B4YptT7a9akPE55UlQnVAxG3+Bh3h/fywmrxDkUtZD7wkGjNEZZ0tuvw9QSwLWu0S
         NAFc70N5STqKlT976g+MaZFdT+ORAo1upUsLZhOxrrqNqEmwoovySpJdPDGjG1t8gk
         7gwlKENmysD1vHVgtJrcOKurzKgWk5RrH5ZVsKX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 156/267] appletalk: Set error code if register_snap_client failed
Date:   Mon, 16 Dec 2019 18:48:02 +0100
Message-Id: <20191216174911.038675598@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
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
 


