Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC284C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB2720659
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498720;
	bh=eZv+YpP5eYDz+Bio6+BQJrk0ecW2XPekj7nIgLLMGeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=saeMHtv10Iy84WFcV4RNRVe7vMTjb4Fmqk8RHgCRRpJruoqw0AgEQT0CIVjE86Smq
	 GiJDFQ+Wc+PotZUbOGpe/6k1KdphSyKSNoBxZWvniF8qYAsBZaUP7201nwbrwHA2Dv
	 uq2Yw4MzlnyWKiwgbXRySJqwzeFOrHWKojIg3OKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730895AbfKKS6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:58:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:59300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730977AbfKKS6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:58:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7399721655;
        Mon, 11 Nov 2019 18:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498716;
        bh=eZv+YpP5eYDz+Bio6+BQJrk0ecW2XPekj7nIgLLMGeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kzotdb+bpQ0BWU8qFlOiAtbzQdA8zpcMoRCGLTMR/Rpo1EykdX+gZOYsjsAFt5Mpo
         jpwfYeQzjT+6uRYsTTvw6bOXjeiuUuYoUtK1m15B4CXYNzDHcG0kSI7iP35ifD/9xz
         hg23uJB1dHf8omlXKKki/bjbCyv9VZKH2SnDMwKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 159/193] wimax: i2400: Fix memory leak in i2400m_op_rfkill_sw_toggle
Date:   Mon, 11 Nov 2019 19:29:01 +0100
Message-Id: <20191111181512.857464569@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 6f3ef5c25cc762687a7341c18cbea5af54461407 ]

In the implementation of i2400m_op_rfkill_sw_toggle() the allocated
buffer for cmd should be released before returning. The
documentation for i2400m_msg_to_dev() says when it returns the buffer
can be reused. Meaning cmd should be released in either case. Move
kfree(cmd) before return to be reached by all execution paths.

Fixes: 2507e6ab7a9a ("wimax: i2400: fix memory leak")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wimax/i2400m/op-rfkill.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wimax/i2400m/op-rfkill.c b/drivers/net/wimax/i2400m/op-rfkill.c
index 8efb493ceec2f..5c79f052cad20 100644
--- a/drivers/net/wimax/i2400m/op-rfkill.c
+++ b/drivers/net/wimax/i2400m/op-rfkill.c
@@ -127,12 +127,12 @@ int i2400m_op_rfkill_sw_toggle(struct wimax_dev *wimax_dev,
 			"%d\n", result);
 	result = 0;
 error_cmd:
-	kfree(cmd);
 	kfree_skb(ack_skb);
 error_msg_to_dev:
 error_alloc:
 	d_fnend(4, dev, "(wimax_dev %p state %d) = %d\n",
 		wimax_dev, state, result);
+	kfree(cmd);
 	return result;
 }
 
-- 
2.20.1



