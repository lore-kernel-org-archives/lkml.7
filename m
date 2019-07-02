Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50AFC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C8B21841
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562054867;
	bh=nHuwhUTRAxfjXPVHa1/B3FzGKUEmmVuofCaXCYoxoko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IqAfNoEjvW+Y++TQ6/zKIB6VzKBeuFSNasHYFiykt0C9Cv6OFrP6Hn/J9I1ZTdB6R
	 lL7aZqwHzzq5onETTGkzLmq9OPZ+HyJvVhNYho2xYqRF00uZi2XFxZJP4nGTXjNkeS
	 RP8AcB/0iLzZvB75Z7mKKiaSBimcM2N3GHlVM9Ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfGBIHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:07:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbfGBIHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:07:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0371021479;
        Tue,  2 Jul 2019 08:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562054862;
        bh=nHuwhUTRAxfjXPVHa1/B3FzGKUEmmVuofCaXCYoxoko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bj7g+eTnm6HZ/JTG1fzoYbzdKzoDZHp0yC+du++pSzVvl4Gs3l33MnAHW1iYrW59S
         /RmJqi5HVxRkojAdEV3E/lFHb1yr9GKMIGpXZ9MwIy106LjtN1wsu7ImiL3ebvDyhP
         x1HXv+HOjShzbuaiKvwCP1vVVzf+1qDNZd3SgBaY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+afabda3890cc2f765041@syzkaller.appspotmail.com,
        syzbot+276ca1c77a19977c0130@syzkaller.appspotmail.com,
        Xin Long <lucien.xin@gmail.com>,
        Neil Horman <nhorman@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 57/72] sctp: change to hold sk after auth shkey is created successfully
Date:   Tue,  2 Jul 2019 10:01:58 +0200
Message-Id: <20190702080127.559912786@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702080124.564652899@linuxfoundation.org>
References: <20190702080124.564652899@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 25bff6d5478b2a02368097015b7d8eb727c87e16 ]

Now in sctp_endpoint_init(), it holds the sk then creates auth
shkey. But when the creation fails, it doesn't release the sk,
which causes a sk defcnf leak,

Here to fix it by only holding the sk when auth shkey is created
successfully.

Fixes: a29a5bd4f5c3 ("[SCTP]: Implement SCTP-AUTH initializations.")
Reported-by: syzbot+afabda3890cc2f765041@syzkaller.appspotmail.com
Reported-by: syzbot+276ca1c77a19977c0130@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/endpointola.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/net/sctp/endpointola.c
+++ b/net/sctp/endpointola.c
@@ -126,10 +126,6 @@ static struct sctp_endpoint *sctp_endpoi
 	/* Initialize the bind addr area */
 	sctp_bind_addr_init(&ep->base.bind_addr, 0);
 
-	/* Remember who we are attached to.  */
-	ep->base.sk = sk;
-	sock_hold(ep->base.sk);
-
 	/* Create the lists of associations.  */
 	INIT_LIST_HEAD(&ep->asocs);
 
@@ -167,6 +163,10 @@ static struct sctp_endpoint *sctp_endpoi
 	ep->prsctp_enable = net->sctp.prsctp_enable;
 	ep->reconf_enable = net->sctp.reconf_enable;
 
+	/* Remember who we are attached to.  */
+	ep->base.sk = sk;
+	sock_hold(ep->base.sk);
+
 	return ep;
 
 nomem_hmacs:


