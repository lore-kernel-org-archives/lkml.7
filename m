Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFA4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0AF82183E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368925;
	bh=LzZuXnCAoa66RkeGSE3AOJK+1FlD9SoEH01AknXLD7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QQSYCI0xR8gKHPs989E/wUO20utwLHzJve7HjhYjr+4PPbCHSWNAIktfEc6iiEOa/
	 hYJcW1vYQr7sxCEG9Aiyvo7uwwO+Z0EhspEa94VIGehi3uZU/FXLdcbaGbL48fl79B
	 ijk4FQcKQt7tt4j6W42stDHejL4KIoVRQPOyr64E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732700AbfDDJIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:08:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732680AbfDDJIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:08:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9842B2184B;
        Thu,  4 Apr 2019 09:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368917;
        bh=LzZuXnCAoa66RkeGSE3AOJK+1FlD9SoEH01AknXLD7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AvPRSZ/hl7okdFWh3nXFhKSyweaLLwJloc4s3fTSkeMKV5vBpxmaecsYkaVkrg7Gh
         KdKPB39O0YD9Mk35B+usP3bZbiNPIlHrAZNpOVFtZKlBYuhLRoStxytK4qam/cDPjj
         bZv78aV+/Ygj9PHTkZPTTassEUuKZ2l8dBd+2pkA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 013/246] xsk: fix to reject invalid flags in xsk_bind
Date:   Thu,  4 Apr 2019 10:45:13 +0200
Message-Id: <20190404084619.661847471@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

[ Upstream commit f54ba391d88f5a5d032175b4c308c176e34b80b7 ]

Passing a non-existing flag in the sxdp_flags member of struct
sockaddr_xdp was, incorrectly, silently ignored. This patch addresses
that behavior, and rejects any non-existing flags.

We have examined existing user space code, and to our best knowledge,
no one is relying on the current incorrect behavior. AF_XDP is still
in its infancy, so from our perspective, the risk of breakage is very
low, and addressing this problem now is important.

Fixes: 965a99098443 ("xsk: add support for bind for Rx")
Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xdp/xsk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 85e4fe4f18cc..f3031c8907d9 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -407,6 +407,10 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 	if (sxdp->sxdp_family != AF_XDP)
 		return -EINVAL;
 
+	flags = sxdp->sxdp_flags;
+	if (flags & ~(XDP_SHARED_UMEM | XDP_COPY | XDP_ZEROCOPY))
+		return -EINVAL;
+
 	mutex_lock(&xs->mutex);
 	if (xs->dev) {
 		err = -EBUSY;
@@ -425,7 +429,6 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 	}
 
 	qid = sxdp->sxdp_queue_id;
-	flags = sxdp->sxdp_flags;
 
 	if (flags & XDP_SHARED_UMEM) {
 		struct xdp_sock *umem_xs;
-- 
2.19.1



