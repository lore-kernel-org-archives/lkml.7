Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1042BC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10D1215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="KvmAoUKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfH2T0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:26:05 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.61]:14150 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728063AbfH2T0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:26:04 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id B9B79859D64
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 14:25:06 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 3Q2ciQ5Lt3Qi03Q2ci5BIM; Thu, 29 Aug 2019 14:25:06 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QhHaIcHbmOkxpmshf6EBelOsxAfyUIkBYwOyIG9a0zg=; b=KvmAoUKsztt4fQnMMHDt+Hdpvn
        UrTLi+K5w2M5bZLz+0IIHfZoxPZVb8jMy3w+kYRhVEHJZYhaNq0aWBhs1hiUtAD+BU6HAt2OTw40T
        GsalC8uW+sFrxxtGf7sDQb0u36lIwYcbWrUQJ/5zf4yM3gdjr6+8d2g88ogZFeyxfC0NAjS5E/kKz
        qY63RDo+OAYGft+WZD7Q/hLZGINkZ1Rys2mEsNZRC5KB+54ezADXNoZTQBXdKsx6pUfWZ9li/QdeF
        4tMyjbeWQKcNe40etS7ZEGjZtxdS16EgPET+xFKCRzgEFO7QBzc1EtoEqXOdeE4uE+cgI7c4Bx6TP
        476ZD4kg==;
Received: from [189.152.216.116] (port=45278 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1i3Q2b-0022NZ-P5; Thu, 29 Aug 2019 14:25:05 -0500
Date:   Thu, 29 Aug 2019 14:25:03 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] rapidio/rio_mport_cdev: use struct_size() helper
Message-ID: <20190829192503.GA28957@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.152.216.116
X-Source-L: No
X-Exim-ID: 1i3Q2b-0022NZ-P5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.152.216.116]:45278
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 21
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct rio_switch {
	...
        struct rio_dev *nextdev[0];
};

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

So, replace the following form:

(RIO_GET_TOTAL_PORTS(swpinfo) * sizeof(rswitch->nextdev[0])) + sizeof(*rswitch)

with:

struct_size(rswitch, nextdev, RIO_GET_TOTAL_PORTS(swpinfo))

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 8155f59ece38..2787d2b7694d 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -1708,8 +1708,8 @@ static int rio_mport_add_riodev(struct mport_cdev_priv *priv,
 	if (rval & RIO_PEF_SWITCH) {
 		rio_mport_read_config_32(mport, destid, hopcount,
 					 RIO_SWP_INFO_CAR, &swpinfo);
-		size += (RIO_GET_TOTAL_PORTS(swpinfo) *
-			 sizeof(rswitch->nextdev[0])) + sizeof(*rswitch);
+		size += struct_size(rswitch, nextdev,
+				    RIO_GET_TOTAL_PORTS(swpinfo));
 	}
 
 	rdev = kzalloc(size, GFP_KERNEL);
-- 
2.23.0

