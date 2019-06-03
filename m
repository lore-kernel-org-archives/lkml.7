Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A45C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E6F27F56
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559553391;
	bh=sVe/hc/9Uz5givtDxZl6T6BsIsAPVmZI5xhxpdMn4QM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ETz2rONxDuWfD+ZSTMtXBBmbbLD7seUNNHPKjtSpi3TBMQnixoq0qRlmkzkB5frRH
	 Y66U0GxocQww1AMEhrQtTjOYi3D+ooHdRlxUdmK4yX9egByH2b9Rsqju3AP16VOjIa
	 4Aga08iHVwC6zVhQgQhysNlLtO5oV0igArRsV+uc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfFCJQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:16:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728667AbfFCJMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:12:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 971B627DF3;
        Mon,  3 Jun 2019 09:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559553159;
        bh=sVe/hc/9Uz5givtDxZl6T6BsIsAPVmZI5xhxpdMn4QM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HpHcyEyEB1h2y05ZPmEwdgcThrexx9pt7mi76i8JqKJ2lSQf3Yze5gyX4aHEHOXo3
         woaRLzCETHhwW3Hfd3B0uxB+W8OwG2kpKaCJhXvGAK3C/9Ks7o4yCcz6bS9sWAWF8p
         mqUgWs6VBQZrV7x3iBXoebblqhaQi4lExXUGg12Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 30/36] net/tls: dont ignore netdev notifications if no TLS features
Date:   Mon,  3 Jun 2019 11:09:18 +0200
Message-Id: <20190603090522.983099765@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603090520.998342694@linuxfoundation.org>
References: <20190603090520.998342694@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit c3f4a6c39cf269a40d45f813c05fa830318ad875 ]

On device surprise removal path (the notifier) we can't
bail just because the features are disabled.  They may
have been enabled during the lifetime of the device.
This bug leads to leaking netdev references and
use-after-frees if there are active connections while
device features are cleared.

Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_device.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -981,7 +981,8 @@ static int tls_dev_event(struct notifier
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 
-	if (!(dev->features & (NETIF_F_HW_TLS_RX | NETIF_F_HW_TLS_TX)))
+	if (!dev->tlsdev_ops &&
+	    !(dev->features & (NETIF_F_HW_TLS_RX | NETIF_F_HW_TLS_TX)))
 		return NOTIFY_DONE;
 
 	switch (event) {


