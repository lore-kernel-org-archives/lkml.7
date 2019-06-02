Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48174C28CC3
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 00:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB4423A9B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 00:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfFBA2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 20:28:34 -0400
Received: from mx.ewheeler.net ([66.155.3.69]:33506 "EHLO mx.ewheeler.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfFBA2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 20:28:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by mx.ewheeler.net (Postfix) with ESMTP id B8A46A0692;
        Sun,  2 Jun 2019 00:28:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
        by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id W-A0Bg48Fkrc; Sun,  2 Jun 2019 00:28:31 +0000 (UTC)
Received: from mx.ewheeler.net (mx.ewheeler.net [66.155.3.69])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx.ewheeler.net (Postfix) with ESMTPSA id C446BA067D;
        Sun,  2 Jun 2019 00:28:31 +0000 (UTC)
Date:   Sun, 2 Jun 2019 00:28:31 +0000 (UTC)
From:   Eric Wheeler <drbd-dev@lists.ewheeler.net>
X-X-Sender: lists@mx.ewheeler.net
To:     Lars Ellenberg <lars.ellenberg@linbit.com>
cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drbd: fix discard_zeroes_if_aligned regression
In-Reply-To: <20190528131823.GD5803@soda.linbit>
Message-ID: <alpine.LRH.2.11.1906012121470.27699@mx.ewheeler.net>
References: <15124635.GA4107@soda.linbit> <1516057231-21756-1-git-send-email-drbd-dev@lists.ewheeler.net> <20180116072615.GA3940@infradead.org> <20180116094907.GD4107@soda.linbit> <alpine.LRH.2.11.1905101728280.1835@mx.ewheeler.net>
 <20190528131823.GD5803@soda.linbit>
User-Agent: Alpine 2.11 (LRH 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1690155773-127689699-1559435311=:27699"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1690155773-127689699-1559435311=:27699
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 28 May 2019, Lars Ellenberg wrote:

> On Fri, May 10, 2019 at 05:36:32PM +0000, Eric Wheeler wrote:
> > Hi Lars,
> > 
> > We just tried 4.19.x and this bugs still exists. We applied the patch 
> > which was originally submitted to this thread and it still applies cleanly 
> > and seems to work for our use case. You mentioned that you had some older 
> > code which zeroed out unaligned discard requests (or perhaps it was for a 
> > different purpose) that you may be able to use to patch this. Could you 
> > dig those up and see if we can get this solved?
> > 
> > It would be nice to be able to use drbd with thin backing volumes from the 
> > vanilla kernel. If this has already been fixed in something newer than 
> > 4.19, then please point me to the commit.
> 
> I think it was merged upstream in 5.0
> f31e583aa2c2 drbd: introduce P_ZEROES (REQ_OP_WRITE_ZEROES on the "wire")

Thanks Lars, I appreciate your patch.  

Your unaligned zerout code in drbd_issue_discard_or_zero_out() looks 
great.  I particulary like how you adjusted max_discard_sectors to the 
granularity, as well as alignment handling.  Well thought out.

Your commit notes that "for backward compatibility, P_TRIM means zero-out, 
unless the DRBD_FF_WZEROES feature flag is agreed upon during handshake."

We test our environment by deploying the newer kernel on one of the DRBD 
servers and checking for regressions---but this will cause a zero-out on 
the new server because the old server doesn't yet support DRBD_FF_WZEROES.

For our purpose, can you think of any reason that it would be unsafe to 
hack the following into drbd_do_features() so the newer version will not 
zero-out while we test and get both nodes up to the newer version?

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index c7ad88d..76191e6 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -5382,6 +5382,8 @@ static int drbd_do_features(struct drbd_connection *connection)
 	connection->agreed_pro_version = min_t(int, PRO_VERSION_MAX, p->protocol_max);
 	connection->agreed_features = PRO_FEATURES & be32_to_cpu(p->feature_flags);
 
+	connection->agreed_features |= DRBD_FF_WZEROES;
+
 	drbd_info(connection, "Handshake successful: "
 	     "Agreed network protocol version %d\n", connection->agreed_pro_version);


--
Eric Wheeler



> 
> -- 
> : Lars Ellenberg
> : LINBIT | Keeping the Digital World Running
> : DRBD -- Heartbeat -- Corosync -- Pacemaker
> : R&D, Integration, Ops, Consulting, Support
> 
> DRBD® and LINBIT® are registered trademarks of LINBIT
> 
---1690155773-127689699-1559435311=:27699--
