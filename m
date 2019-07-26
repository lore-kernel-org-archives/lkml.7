Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47413C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5E522C7E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564154951;
	bh=4zUQ3mFen+G+852s1/5awg/7sJQT7678uvNjAI8tJyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cLzDb3e+qptb/56fUhViCeXVUNJ+gJYKrlffThmZ8pFxQftK9Aie5OXdvPtsAKhKT
	 br1BT+XXVVBypJcQ2LHeg9liyAcaY6wIQFPNug2ZdLK83Wl+S62BymP+gQihYCeZ5E
	 7h1I+uAl7H5dlSEXHOCRCOYPJgKweHHwr52nRaw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388701AbfGZP3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:29:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388221AbfGZP3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:29:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D54022CBD;
        Fri, 26 Jul 2019 15:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564154943;
        bh=4zUQ3mFen+G+852s1/5awg/7sJQT7678uvNjAI8tJyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c1vbm/uKftP9Aj+S4NPo6lyDvWf+6e0kR1xW9gge9c8NevN02n3Q1oj0j8XBd21AZ
         MUUcbCVGr0osYFHnSjbC57u2Y7zGKeagCDvOB/MxOu/gqOSj4u0k1TqC4vN+Gk07ka
         XOj5S2UfWwr+ahaNODi1CEjOR9we+RarTpCWUA8c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 02/62] caif-hsi: fix possible deadlock in cfhsi_exit_module()
Date:   Fri, 26 Jul 2019 17:24:14 +0200
Message-Id: <20190726152301.971349391@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152301.720139286@linuxfoundation.org>
References: <20190726152301.720139286@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit fdd258d49e88a9e0b49ef04a506a796f1c768a8e ]

cfhsi_exit_module() calls unregister_netdev() under rtnl_lock().
but unregister_netdev() internally calls rtnl_lock().
So deadlock would occur.

Fixes: c41254006377 ("caif-hsi: Add rtnl support")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/caif/caif_hsi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/caif/caif_hsi.c
+++ b/drivers/net/caif/caif_hsi.c
@@ -1455,7 +1455,7 @@ static void __exit cfhsi_exit_module(voi
 	rtnl_lock();
 	list_for_each_safe(list_node, n, &cfhsi_list) {
 		cfhsi = list_entry(list_node, struct cfhsi, list);
-		unregister_netdev(cfhsi->ndev);
+		unregister_netdevice(cfhsi->ndev);
 	}
 	rtnl_unlock();
 }


