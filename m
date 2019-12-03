Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D685BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D1720674
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413731;
	bh=MbC18X3Sfxye5skgXLrpnqugMo/Tin2MGO7PyG9qQWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t1hewTXKRS8CXOgugjS5ZAwKFeeU5bVG/qkHJC6eL9JhEBdQX8ObqcemyYTBkFo6f
	 lEJ0I84p0A4IUZGOm6jkUfSKlcfNF0eZtbPCpSuzxDnehgdUIzb0yU394KSSPLKXrA
	 UIk8TqYdtC/uOau34GEyP9zUEoe1gZevpPPF+Qac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbfLCWza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:55:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730348AbfLCWz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:55:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 289E52053B;
        Tue,  3 Dec 2019 22:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413725;
        bh=MbC18X3Sfxye5skgXLrpnqugMo/Tin2MGO7PyG9qQWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c8TtKqoEXQjM/Tsn4sB0yM5ddg8pzGEaVYYvJz4c/iHoANbUN0SdlfIRiB/yAsOZ4
         rJLg2roFZ09eAjFHVYmKfxc8ZdiCN+w4/RCVxURaOTpz8TcDewFQCxt1oHHdKfBQwP
         dmyPw/jwNPSd7ppVHC+7MffJQ2tKJhFRd7BsgMuY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marcin Stojek <marcin.stojek@nokia.com>,
        Maciej Kwiecien <maciej.kwiecien@nokia.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 238/321] sctp: dont compare hb_timer expire date before starting it
Date:   Tue,  3 Dec 2019 23:35:04 +0100
Message-Id: <20191203223439.513000733@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Kwiecien <maciej.kwiecien@nokia.com>

[ Upstream commit d1f20c03f48102e52eb98b8651d129b83134cae4 ]

hb_timer might not start at all for a particular transport because its
start is conditional. In a result a node is not sending heartbeats.

Function sctp_transport_reset_hb_timer has two roles:
    - initial start of hb_timer for a given transport,
    - update expire date of hb_timer for a given transport.
The function is optimized to update timer's expire only if it is before
a new calculated one but this comparison is invalid for a timer which
has not yet started. Such a timer has expire == 0 and if a new expire
value is bigger than (MAX_JIFFIES / 2 + 2) then "time_before" macro will
fail and timer will not start resulting in no heartbeat packets send by
the node.

This was found when association was initialized within first 5 mins
after system boot due to jiffies init value which is near to MAX_JIFFIES.

Test kernel version: 4.9.154 (ARCH=arm)
hb_timer.expire = 0;                //initialized, not started timer
new_expire = MAX_JIFFIES / 2 + 2;   //or more
time_before(hb_timer.expire, new_expire) == false

Fixes: ba6f5e33bdbb ("sctp: avoid refreshing heartbeat timer too often")
Reported-by: Marcin Stojek <marcin.stojek@nokia.com>
Tested-by: Marcin Stojek <marcin.stojek@nokia.com>
Signed-off-by: Maciej Kwiecien <maciej.kwiecien@nokia.com>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/transport.c b/net/sctp/transport.c
index 033696e6f74fb..ad158d311ffae 100644
--- a/net/sctp/transport.c
+++ b/net/sctp/transport.c
@@ -207,7 +207,8 @@ void sctp_transport_reset_hb_timer(struct sctp_transport *transport)
 
 	/* When a data chunk is sent, reset the heartbeat interval.  */
 	expires = jiffies + sctp_transport_timeout(transport);
-	if (time_before(transport->hb_timer.expires, expires) &&
+	if ((time_before(transport->hb_timer.expires, expires) ||
+	     !timer_pending(&transport->hb_timer)) &&
 	    !mod_timer(&transport->hb_timer,
 		       expires + prandom_u32_max(transport->rto)))
 		sctp_transport_hold(transport);
-- 
2.20.1



