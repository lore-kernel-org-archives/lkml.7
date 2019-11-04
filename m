Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10008CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67522084D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572905003;
	bh=AEX36XsO5lXsy2UodCcGI6ADsqU81+EXoRM9bAA0rL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d945fjOyokVRvQqoh6qOZNYSKuuVBPvCeaflWNfiC5cPdphNYX8bUbi/3maP+uql4
	 RzxzifWwR7NQSAsMlTZkoeqGFpbgJXMox+GSk2dTHRL6dI+aW/rWUb7KA/6lXcaCco
	 PmW4ETzyughVx+zOmJTsrbwmfDa8RVEak4G4ysCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389487AbfKDWDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:03:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389473AbfKDWDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:03:14 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8489205C9;
        Mon,  4 Nov 2019 22:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904994;
        bh=AEX36XsO5lXsy2UodCcGI6ADsqU81+EXoRM9bAA0rL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z2w42cANHfJBlr2CePngOqf6ta01Vp1tIhACUfcTN5iEHrRQeYN6PUCfKkcdulKhy
         RGQDbhWGBvZHlQ7DLOzGvLHqEHzcfXg3QcS0MFSo9cLR10ISkrp6rZ9wvMH9UN1WiX
         LoSg+9D8KLYLhcmI7RZCKNtkCGcE42VcMJCxnRPs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+f1842130bbcfb335bac1@syzkaller.appspotmail.com,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 143/149] net: usb: sr9800: fix uninitialized local variable
Date:   Mon,  4 Nov 2019 22:45:36 +0100
Message-Id: <20191104212146.731740926@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212126.090054740@linuxfoundation.org>
References: <20191104212126.090054740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Vidic <vvidic@valentin-vidic.from.hr>

commit 77b6d09f4ae66d42cd63b121af67780ae3d1a5e9 upstream.

Make sure res does not contain random value if the call to
sr_read_cmd fails for some reason.

Reported-by: syzbot+f1842130bbcfb335bac1@syzkaller.appspotmail.com
Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/usb/sr9800.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/usb/sr9800.c
+++ b/drivers/net/usb/sr9800.c
@@ -336,7 +336,7 @@ static void sr_set_multicast(struct net_
 static int sr_mdio_read(struct net_device *net, int phy_id, int loc)
 {
 	struct usbnet *dev = netdev_priv(net);
-	__le16 res;
+	__le16 res = 0;
 
 	mutex_lock(&dev->phy_mutex);
 	sr_set_sw_mii(dev);


