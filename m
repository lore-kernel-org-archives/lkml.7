Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C150C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78B520880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141807;
	bh=FhVljO2bC0DncAYcLdobIeeDSELjAzBpi8dYD4rcV5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0go8Diwvu/rVbIFyxOIGt9OQ9TlpNBlq4iW8iB5SNwHCEqQq9FaviP/axRbIc5Va9
	 LXwpm52KdyXz5k+Wso3xR0D1qwRimjTZ97rgLSNvxqzjyU2Nn9WCbXt+4BFSVVC4Eq
	 CYcJSSPCqvrzMTMpyIYXGcIwNyFWQ05NpLr7OE5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbfDAROH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:14:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730651AbfDAROA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:14:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D481B21906;
        Mon,  1 Apr 2019 17:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138263;
        bh=FhVljO2bC0DncAYcLdobIeeDSELjAzBpi8dYD4rcV5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XH8ZB+ZX3yJBm/d5VOb/wm2z3N09klfMGl5jPdezXH/esjP+i9JDArGT3unVnPP7K
         067X2ir1CkBumglfP9DBx2WiJcn5MsuFZTOQLuYXqcNrPylQ/CiteaXDTDrg8LVk3q
         JHpQ74UwusW4ibcVY7svQc6NI0I+Yw1fMKEnbatQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 016/146] net-sysfs: call dev_hold if kobject_init_and_add success
Date:   Mon,  1 Apr 2019 19:00:28 +0200
Message-Id: <20190401170049.902911556@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit a3e23f719f5c4a38ffb3d30c8d7632a4ed8ccd9e ]

In netdev_queue_add_kobject and rx_queue_add_kobject,
if sysfs_create_group failed, kobject_put will call
netdev_queue_release to decrease dev refcont, however
dev_hold has not be called. So we will see this while
unregistering dev:

unregister_netdevice: waiting for bcsh0 to become free. Usage count = -1

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: d0d668371679 ("net: don't decrement kobj reference count on init failure")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/net-sysfs.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -934,6 +934,8 @@ static int rx_queue_add_kobject(struct n
 	if (error)
 		return error;
 
+	dev_hold(queue->dev);
+
 	if (dev->sysfs_rx_queue_group) {
 		error = sysfs_create_group(kobj, dev->sysfs_rx_queue_group);
 		if (error) {
@@ -943,7 +945,6 @@ static int rx_queue_add_kobject(struct n
 	}
 
 	kobject_uevent(kobj, KOBJ_ADD);
-	dev_hold(queue->dev);
 
 	return error;
 }
@@ -1472,6 +1473,8 @@ static int netdev_queue_add_kobject(stru
 	if (error)
 		return error;
 
+	dev_hold(queue->dev);
+
 #ifdef CONFIG_BQL
 	error = sysfs_create_group(kobj, &dql_group);
 	if (error) {
@@ -1481,7 +1484,6 @@ static int netdev_queue_add_kobject(stru
 #endif
 
 	kobject_uevent(kobj, KOBJ_ADD);
-	dev_hold(queue->dev);
 
 	return 0;
 }


