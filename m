Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C8FC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6907121537
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054408;
	bh=MnLRgpKf8bf7JXa3l3G1EigBR7h3gNLETgMTq6ZJNU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fHIsqCVJgOlaZxbXZcufCiw55FqfvAOiniSz6CEg3nq89oHYGyCM/5qanp/fdStJ5
	 +nld+fz64SXlbqMoZaNE0/ihtd4YD1/YDuptKERfbQv2ka1xNvpJsPLaiv0dEzvAzb
	 gsvWI+HZnbMgHU5qsrnnbun7LBdTV+QFv4zS0VGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbfFTSN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729253AbfFTSNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:13:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CF0A2082C;
        Thu, 20 Jun 2019 18:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054402;
        bh=MnLRgpKf8bf7JXa3l3G1EigBR7h3gNLETgMTq6ZJNU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0I24ZKhCnzXtwowSEsl5Uv1o4OsqunqI4zp1fBCEpFAfCmSntFB3b2xDNngqhMF11
         zQCkA5ByKsI5Wbge3SR3QyD5mt+5SvOCVJ7jyHq4y4VZuwOkWMvl3nWJsO0bd9OvZK
         c6BSMn1j4jUfAf0swWHuxHppKMwcvQ6m8PjzG7x4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+afb980676c836b4a0afa@syzkaller.appspotmail.com,
        Jeremy Sowden <jeremy@azazel.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 06/98] lapb: fixed leak of control-blocks.
Date:   Thu, 20 Jun 2019 19:56:33 +0200
Message-Id: <20190620174349.679064015@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174349.443386789@linuxfoundation.org>
References: <20190620174349.443386789@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Sowden <jeremy@azazel.net>

[ Upstream commit 6be8e297f9bcea666ea85ac7a6cd9d52d6deaf92 ]

lapb_register calls lapb_create_cb, which initializes the control-
block's ref-count to one, and __lapb_insert_cb, which increments it when
adding the new block to the list of blocks.

lapb_unregister calls __lapb_remove_cb, which decrements the ref-count
when removing control-block from the list of blocks, and calls lapb_put
itself to decrement the ref-count before returning.

However, lapb_unregister also calls __lapb_devtostruct to look up the
right control-block for the given net_device, and __lapb_devtostruct
also bumps the ref-count, which means that when lapb_unregister returns
the ref-count is still 1 and the control-block is leaked.

Call lapb_put after __lapb_devtostruct to fix leak.

Reported-by: syzbot+afb980676c836b4a0afa@syzkaller.appspotmail.com
Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/lapb/lapb_iface.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/lapb/lapb_iface.c
+++ b/net/lapb/lapb_iface.c
@@ -182,6 +182,7 @@ int lapb_unregister(struct net_device *d
 	lapb = __lapb_devtostruct(dev);
 	if (!lapb)
 		goto out;
+	lapb_put(lapb);
 
 	lapb_stop_t1timer(lapb);
 	lapb_stop_t2timer(lapb);


