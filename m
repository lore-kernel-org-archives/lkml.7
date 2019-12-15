Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93EBC43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 15:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8034920866
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 15:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="gFbnXdjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfLOPYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 10:24:03 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:54016 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfLOPYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 10:24:02 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 47bSqP2mydz9vZ5g
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 15:24:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id s7tMtDrrs8GL for <linux-kernel@vger.kernel.org>;
        Sun, 15 Dec 2019 09:24:01 -0600 (CST)
Received: from mail-yw1-f69.google.com (mail-yw1-f69.google.com [209.85.161.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 47bSqP1jM0z9vZ5x
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 09:24:01 -0600 (CST)
Received: by mail-yw1-f69.google.com with SMTP id j9so3764634ywg.14
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 07:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LXeOuc0B3gYX32LabDU9f+RSGbyw1wcQBHVeANF/Ibg=;
        b=gFbnXdjz2JyDs4kf8BW4QAMQEHuYlzIExGtIGz08EPf7yeUz69r2qyT9KH+d6UHKYD
         +8Y68qzOIDZjoC/J/jbi/P+wfQs+Ts54xVgQNcRO570Hu0dMRXd2kpxg4sVOQFF7rltE
         5hqGsoOLgKmq0/4sEYqHVWCiFKXmHBgYJdsG2+YCSeKjNTJW3EGZtWqAy3/lrDv5wm6y
         QU2i0RKp0HvZuZF4i3elIn/MjXO7LBHPV/lWHDNK8k3C33mOoZq9EV1HlAqMac7v+YMH
         x90F2rZA0JpnodY+TigIVIH/qhsKVxsws4grBrtIq1w8VRJIqe/5lAYf+2f4ihzU79Z+
         WMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LXeOuc0B3gYX32LabDU9f+RSGbyw1wcQBHVeANF/Ibg=;
        b=fqJjph2nHQIWdqAM6CtB9EnoawqN0YmUXHJadS6aKHdQXi4zmuZuEYIwRKJssv3HXA
         ARlIQGlC+5+aSRKFu3fEFEDwale/Et5KyiH17c/wo60WEhEseb9XqNP356O67r94uhUJ
         t9GlOM6NHsaX0CEcaE5Az8zNK9+COP6wlbgj/J96V6zfkZE4sj/aoz/H6W+3RNa49wXD
         MTNArxL/E/xV88fTuYEtxTXoFFExsm9ifXG6tqyxKY4hwamfNvwWBUiKCIDkNTSEnc/e
         IttCAa/HnsCrDkEOpq4CC7Np/eTAYj4cgsSv67Sbk+nkhILSwd0D99vx2IUKqyL7WEP7
         G6MA==
X-Gm-Message-State: APjAAAWDWt5Lo0M4m6nTXT9L2Rn7e/N7fNrKzyTGXHm4izf+60+i5KxW
        hiklMZGTobYsYjiv6QMnldoxF8anlv3f5B/owavgrZ3jejkhAdhdQf0QLj4BpSNxqsnQ10Hvb8n
        rnAXw9gx0cHimuGQdHKW3ap0NaBG4
X-Received: by 2002:a25:7cc1:: with SMTP id x184mr12866651ybc.69.1576423440623;
        Sun, 15 Dec 2019 07:24:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqzmH7sFfvfBy1cep+91o5KmIInPx1Yz9wIMEp9QMF/hlEh4qqQVE73XWTB1gu0XWKPd9zKF2g==
X-Received: by 2002:a25:7cc1:: with SMTP id x184mr12866635ybc.69.1576423440363;
        Sun, 15 Dec 2019 07:24:00 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id b192sm3235899ywe.2.2019.12.15.07.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 07:24:00 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mac80211: Remove redundant assertion
Date:   Sun, 15 Dec 2019 09:23:48 -0600
Message-Id: <20191215152348.20912-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In wiphy_to_ieee80211_hw, the assertion to check if wiphy is NULL is
repeated in wiphy_priv. The patch removes the duplicated BUG_ON check.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 net/mac80211/util.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 32a7a53833c0..780df3e9092e 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -39,7 +39,6 @@ const void *const mac80211_wiphy_privid = &mac80211_wiphy_privid;
 struct ieee80211_hw *wiphy_to_ieee80211_hw(struct wiphy *wiphy)
 {
 	struct ieee80211_local *local;
-	BUG_ON(!wiphy);
 
 	local = wiphy_priv(wiphy);
 	return &local->hw;
-- 
2.20.1

