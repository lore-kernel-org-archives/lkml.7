Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59164C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E39920843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557918935;
	bh=7mdAG++hHPV5dcH9i80MCr5GlBNWq0L2PV9ChcBDkYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GKjwmPAS82ZAkiw7C7vjypGdIZ6+tdi+3FvTsn7SK2OMX1q3rZcjf8vGddEhCGj6G
	 SvSp16rEbbIV4u6b4XqvJKLKeUch0ximm1qYZyc3VBJDkUHK1FPQMmKz56Z3zB371x
	 z0d+ze7BoKKNtsEUB5OUE/FZpBOlj/hdNmO+hquE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbfEOLPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:15:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730261AbfEOLP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:15:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE6C820644;
        Wed, 15 May 2019 11:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918928;
        bh=7mdAG++hHPV5dcH9i80MCr5GlBNWq0L2PV9ChcBDkYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JrotjxiXwvzh93xygsTE1H6wnsaGhcIlG4ncZmZU7WTweUbUPptLwqhaLZzAKOB0J
         tWToDW4GoGWk7Wa1Se4SfR7Vt8EwMLzBqmO4nFj6I4ctGZm/kynebWGQ+brh+uZQzK
         kp/jThBIIawpVcgX0mNVj/OXbyQZCFp2s/XdQ5tI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.9 30/51] cw1200: fix missing unlock on error in cw1200_hw_scan()
Date:   Wed, 15 May 2019 12:56:05 +0200
Message-Id: <20190515090625.639425719@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090616.669619870@linuxfoundation.org>
References: <20190515090616.669619870@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

commit 51c8d24101c79ffce3e79137e2cee5dfeb956dd7 upstream.

Add the missing unlock before return from function cw1200_hw_scan()
in the error handling case.

Fixes: 4f68ef64cd7f ("cw1200: Fix concurrency use-after-free bugs in cw1200_hw_scan()")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/st/cw1200/scan.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/st/cw1200/scan.c
+++ b/drivers/net/wireless/st/cw1200/scan.c
@@ -84,8 +84,11 @@ int cw1200_hw_scan(struct ieee80211_hw *
 
 	frame.skb = ieee80211_probereq_get(hw, priv->vif->addr, NULL, 0,
 		req->ie_len);
-	if (!frame.skb)
+	if (!frame.skb) {
+		mutex_unlock(&priv->conf_mutex);
+		up(&priv->scan.lock);
 		return -ENOMEM;
+	}
 
 	if (req->ie_len)
 		memcpy(skb_put(frame.skb, req->ie_len), req->ie, req->ie_len);


