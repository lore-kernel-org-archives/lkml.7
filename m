Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FB4C282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2FA205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639288;
	bh=uu3IdUy+7dfGB7tzNOlP2lRoWgO/DVyjNyZ5vA0JBLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2gvFU412BQJELB/TZxW8kN54CT0CfUhK082UIvM3ReHdnJChYhYLnHpn07cuVKJoO
	 GRkkrb7qCiCBJUNWn+mc00qAIGU9Y/zxs1/GRXRcEpBtebSchNUBK+nArLq6KoSMUc
	 gY1KVdoZUNHVjGEKe/zn1CEAEJVHZZzsJE3GY9yM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390270AbfEWTV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:21:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390262AbfEWTVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:21:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB6DD205ED;
        Thu, 23 May 2019 19:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639285;
        bh=uu3IdUy+7dfGB7tzNOlP2lRoWgO/DVyjNyZ5vA0JBLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wHR2U2ucf04Jh4Ltg9qX48MX6W1jTn5qjmsmn7rF25buweOidy5w7czBsXQHjJYJO
         VPKWQ1fEdSLGmQpYCuwpxUDkv7phbwbTFC1uK9uRrDW6rHvKmsaq180PGx7rISXSX1
         hLtd5EHiB5c5jYv97yhWNGBptc3oDmDhKBy4MV4I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.0 048/139] RDMA/ipoib: Allow user space differentiate between valid dev_port
Date:   Thu, 23 May 2019 21:05:36 +0200
Message-Id: <20190523181726.931270270@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

commit b79656ed44c6865e17bcd93472ec39488bcc4984 upstream.

Systemd triggers the following warning during IPoIB device load:

 mlx5_core 0000:00:0c.0 ib0: "systemd-udevd" wants to know my dev_id.
        Should it look at dev_port instead?
        See Documentation/ABI/testing/sysfs-class-net for more info.

This is caused due to user space attempt to differentiate old systems
without dev_port and new systems with dev_port. In case dev_port will be
zero, the systemd will try to read dev_id instead.

There is no need to print a warning in such case, because it is valid
situation and it is needed to ensure systemd compatibility with old
kernels.

Link: https://github.com/systemd/systemd/blob/master/src/udev/udev-builtin-net_id.c#L358
Cc: <stable@vger.kernel.org> # 4.19
Fixes: f6350da41dc7 ("IB/ipoib: Log sysfs 'dev_id' accesses from userspace")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/ulp/ipoib/ipoib_main.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -2402,7 +2402,18 @@ static ssize_t dev_id_show(struct device
 {
 	struct net_device *ndev = to_net_dev(dev);
 
-	if (ndev->dev_id == ndev->dev_port)
+	/*
+	 * ndev->dev_port will be equal to 0 in old kernel prior to commit
+	 * 9b8b2a323008 ("IB/ipoib: Use dev_port to expose network interface
+	 * port numbers") Zero was chosen as special case for user space
+	 * applications to fallback and query dev_id to check if it has
+	 * different value or not.
+	 *
+	 * Don't print warning in such scenario.
+	 *
+	 * https://github.com/systemd/systemd/blob/master/src/udev/udev-builtin-net_id.c#L358
+	 */
+	if (ndev->dev_port && ndev->dev_id == ndev->dev_port)
 		netdev_info_once(ndev,
 			"\"%s\" wants to know my dev_id. Should it look at dev_port instead? See Documentation/ABI/testing/sysfs-class-net for more info.\n",
 			current->comm);


