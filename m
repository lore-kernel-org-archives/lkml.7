Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28C5C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89EE621743
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565291681;
	bh=9kmlft1CQdZPtgpeBxTcJEBanms8b+x93peniWoSeK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B/PuXJECnDVJvWRw96kqXrIN98V1MQFUk+6s8M2BlcG7ldozlDbbPu13iww+d1ZXc
	 a7tlXtHo3zvhSzsYzmCeFBrA3TTlxvCDdyqXEI204pqhuc24pKq86w0uHYaIfhzttc
	 n9r9jtotc8bzKOlzAOoN4YrbIdDPkpKtKJgOh8aI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404814AbfHHTIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:08:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404391AbfHHTH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:07:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE88B214C6;
        Thu,  8 Aug 2019 19:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565291277;
        bh=9kmlft1CQdZPtgpeBxTcJEBanms8b+x93peniWoSeK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZgJ/G1p/RCB77vGLcPpJYwSDIs2bbMllHc+Qh+l9byAbdEU3UYLx2+oR91if+2r48
         8KrOvrBsDf7/TJ/CGIe6ogM6rmDVhg09XHfLEiGA66OIZ6iqx/hl2I6JSt3OC9x3jZ
         D++Iv+gQYaFBWBAVS9s0AQCBxFdJvS9uhDwv6b/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
        Peter Lebbing <peter@digitalbrains.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.2 55/56] Revert "mac80211: set NETIF_F_LLTX when using intermediate tx queues"
Date:   Thu,  8 Aug 2019 21:05:21 +0200
Message-Id: <20190808190455.554583542@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808190452.867062037@linuxfoundation.org>
References: <20190808190452.867062037@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

commit eef347f846ee8f7296a6f84e3866c057ca6bcce0 upstream.

Revert this for now, it has been reported multiple times that it
completely breaks connectivity on various devices.

Cc: stable@vger.kernel.org
Fixes: 8dbb000ee73b ("mac80211: set NETIF_F_LLTX when using intermediate tx queues")
Reported-by: Jean Delvare <jdelvare@suse.de>
Reported-by: Peter Lebbing <peter@digitalbrains.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/iface.c |    1 -
 1 file changed, 1 deletion(-)

--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1222,7 +1222,6 @@ static void ieee80211_if_setup(struct ne
 static void ieee80211_if_setup_no_queue(struct net_device *dev)
 {
 	ieee80211_if_setup(dev);
-	dev->features |= NETIF_F_LLTX;
 	dev->priv_flags |= IFF_NO_QUEUE;
 }
 


