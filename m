Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239A7C33C9D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98C2222ED
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142336;
	bh=ADyp6Rzsx2MfrdWW4FOXRRHYUFvd+5cFilVBnnNmt8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QfYVLzhTO72HpNrrK1v6cmqBg1YPDb9K8JeEr6QyIK0EbYkgrq4c37kFmkIq2RoVH
	 Xl9HYxUPNJOv3ElmCdYlVc86T8zaItFuBpJlORK1UMlJY8gWF/Jf0q5PPpnmL4Hlbs
	 XtwvzuZxYZQptixcl7KHeKfHHgqBi71f7sWyGvhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbfKSFpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:45:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:41120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730965AbfKSFp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:45:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F23A221783;
        Tue, 19 Nov 2019 05:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142326;
        bh=ADyp6Rzsx2MfrdWW4FOXRRHYUFvd+5cFilVBnnNmt8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aIXdjD3vnUYkZcRyrwvr8cI3OM55zXL6afdPVhATbdjnKk/sNg+Eu3aeCH59F3gaZ
         hxxLAEayggWaYUOUNiCafPTPiMQ666njfmsOf2xGFA5HM3ppCkDL6M+bqAtfjOTOAw
         IFqO5Vc/yWxMwWlUyu3/3xrYrp5N2zJtwjNPO+ew=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+a8d4acdad35e6bbca308@syzkaller.appspotmail.com,
        Oliver Neukum <oneukum@suse.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 008/239] ax88172a: fix information leak on short answers
Date:   Tue, 19 Nov 2019 06:16:48 +0100
Message-Id: <20191119051259.171362433@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit a9a51bd727d141a67b589f375fe69d0e54c4fe22 ]

If a malicious device gives a short MAC it can elicit up to
5 bytes of leaked memory out of the driver. We need to check for
ETH_ALEN instead.

Reported-by: syzbot+a8d4acdad35e6bbca308@syzkaller.appspotmail.com
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/ax88172a.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/usb/ax88172a.c
+++ b/drivers/net/usb/ax88172a.c
@@ -208,7 +208,7 @@ static int ax88172a_bind(struct usbnet *
 
 	/* Get the MAC address */
 	ret = asix_read_cmd(dev, AX_CMD_READ_NODE_ID, 0, 0, ETH_ALEN, buf, 0);
-	if (ret < 0) {
+	if (ret < ETH_ALEN) {
 		netdev_err(dev->net, "Failed to read MAC address: %d\n", ret);
 		goto free;
 	}


