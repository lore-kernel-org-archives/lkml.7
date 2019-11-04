Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2973DCA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59F3204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572906158;
	bh=AEX36XsO5lXsy2UodCcGI6ADsqU81+EXoRM9bAA0rL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZH7sYwzw11TDvRKfi83KI/aZc2wiAqpjlEv7Ihyy80+GjpS2zZ0EgCWMYgZW1HO/X
	 ABW0vA+SA95+5u4Jb7M+EAZSyb4X6tKvgQFwHxUE/ORsHsnwX3GuGv8B35DioxfOpt
	 BGYt9Pzsj+7GPKoQcTttNFcUqUCGvoX2boH91cU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388330AbfKDWWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:22:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:51698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388296AbfKDV4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:56:09 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD56221929;
        Mon,  4 Nov 2019 21:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904569;
        bh=AEX36XsO5lXsy2UodCcGI6ADsqU81+EXoRM9bAA0rL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Zj5JGlxsVrRz7bZ9vA2ySbutcsi3r3rQKqn0w1z3qjYBx920ZciiJswKu5ui9KwL
         cQNRlGB8+LpT9ErkIDGkqcuNEPlFVkb1MHK/jS68po76RBi4253d2YA2NKNTk7QAKi
         x+V10rsKNdaCeenaKx33Kp0GikaB8gkStBHWOaLk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+f1842130bbcfb335bac1@syzkaller.appspotmail.com,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 89/95] net: usb: sr9800: fix uninitialized local variable
Date:   Mon,  4 Nov 2019 22:45:27 +0100
Message-Id: <20191104212123.803874685@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212038.056365853@linuxfoundation.org>
References: <20191104212038.056365853@linuxfoundation.org>
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


