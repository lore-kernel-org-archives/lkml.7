Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5856BC04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14BEB20843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919867;
	bh=NhgZtDE+kJfP2c9ihs85vwuYjgcxXW1BjKaxNGSvzRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rve6kE3xXuebUTXdy0dYJCtEFS7jBeGgBH7IuZQTaBDlAp49y2/wN+CVjeY4A7r36
	 9PZygRzXplUQMnrn+42GF93bh17mQMNViL49rLfh84Jc/B7N8ujnskpE1sDIciHCR4
	 wCSiIiKJUs4s/69HXAjK9aj6OoBtpBcQ6ACCZ8dI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732839AbfEOLbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:31:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732829AbfEOLbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:31:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B626206BF;
        Wed, 15 May 2019 11:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919862;
        bh=NhgZtDE+kJfP2c9ihs85vwuYjgcxXW1BjKaxNGSvzRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZTWu80AdBHqfpkOxjee4OnbOz1nc9wGUTjwRd5B9W+9+C2zISI4GZ7xJCXdDYom+H
         TK4km/wiX6nUHTMlt1ron1aKD2QbF8xKnWGKFV6VU3y/cP4Vr2thxOeHg2vCbFsqBV
         FfnTQ6+LWlXuYj6RE93Y+h+/wZHj+TX2JKkHZ10g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 120/137] aqc111: fix endianness issue in aqc111_change_mtu
Date:   Wed, 15 May 2019 12:56:41 +0200
Message-Id: <20190515090702.401821988@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090651.633556783@linuxfoundation.org>
References: <20190515090651.633556783@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit b8b277525e9df2fd2dc3d1f4fe01c6796bb107fc ]

If the MTU is large enough, the first write to the device
is just repeated. On BE architectures, however, the first
word of the command will be swapped a second time and garbage
will be written. Avoid that.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/aqc111.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -453,6 +453,8 @@ static int aqc111_change_mtu(struct net_
 		reg16 = 0x1420;
 	else if (dev->net->mtu <= 16334)
 		reg16 = 0x1A20;
+	else
+		return 0;
 
 	aqc111_write16_cmd(dev, AQ_ACCESS_MAC, SFR_PAUSE_WATERLVL_LOW,
 			   2, &reg16);


