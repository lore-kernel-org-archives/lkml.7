Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A02BC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040B6208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560441736;
	bh=8M7Ht7uR3C8y+ng4cJglq02l4gO9fdwxHm6+doxQks8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TEF9GfZSk3BkbLFw5Ye8y1nW+LpWp4O/aVOXqVO+v70XNy/szKaPGOJbVr7kZKOtq
	 2meqRQJ/QuxqLcKYV4pcyc0qyUkc7W2rcrKBEO3R+8kOy0U+2mMbSh4TGTIxIe/Ls4
	 kdHh5FRCUG7nnqw/fgMtYlehuagtMMFWQcitvMqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390571AbfFMQB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:01:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731419AbfFMIsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:48:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E096321743;
        Thu, 13 Jun 2019 08:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415692;
        bh=8M7Ht7uR3C8y+ng4cJglq02l4gO9fdwxHm6+doxQks8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xMYmxM+XYY5Ybg1TTGGmCUIyVNjP3/kViE+oEwBEpBbU+vxcCaYWqY5umGmW1dpYj
         eUV5kYHClaShHcG/+1GRLPJ8S26TEpSkFxPwopHb/cKa3uglyfPeoMT58ChJU+W8ag
         R3XOLft53yq4nW93Y7i6XWai7rlpwidtPx1Uy2jI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 091/155] net: thunderbolt: Unregister ThunderboltIP protocol handler when suspending
Date:   Thu, 13 Jun 2019 10:33:23 +0200
Message-Id: <20190613075658.184288472@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 9872760eb7b1d4f6066ad8b560714a5d0a728fdb ]

The XDomain protocol messages may start as soon as Thunderbolt control
channel is started. This means that if the other host starts sending
ThunderboltIP packets early enough they will be passed to the network
driver which then gets confused because its resume hook is not called
yet.

Fix this by unregistering the ThunderboltIP protocol handler when
suspending and registering it back on resume.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/thunderbolt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/thunderbolt.c b/drivers/net/thunderbolt.c
index c48c3a1eb1f8..fcf31335a8b6 100644
--- a/drivers/net/thunderbolt.c
+++ b/drivers/net/thunderbolt.c
@@ -1282,6 +1282,7 @@ static int __maybe_unused tbnet_suspend(struct device *dev)
 		tbnet_tear_down(net, true);
 	}
 
+	tb_unregister_protocol_handler(&net->handler);
 	return 0;
 }
 
@@ -1290,6 +1291,8 @@ static int __maybe_unused tbnet_resume(struct device *dev)
 	struct tb_service *svc = tb_to_service(dev);
 	struct tbnet *net = tb_service_get_drvdata(svc);
 
+	tb_register_protocol_handler(&net->handler);
+
 	netif_carrier_off(net->dev);
 	if (netif_running(net->dev)) {
 		netif_device_attach(net->dev);
-- 
2.20.1



