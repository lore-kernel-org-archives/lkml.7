Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E0BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 22:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054F621741
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 22:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="BagOUe1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfCWWdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 18:33:47 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:47058 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfCWWdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 18:33:47 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id DC71ECCB
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 22:33:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id slBaO5_Wcx9P for <linux-kernel@vger.kernel.org>;
        Sat, 23 Mar 2019 17:33:45 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id B0DDACB9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 17:33:45 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id a9so4864478iol.6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 15:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Psj+9E0ZGFt1heJVKpqtu9ZsCWPx1khP7AIh+OGqXtE=;
        b=BagOUe1tyzkSzznenoK/C0wGDpzYl7eEpW/6VFkmj2RHxXkNEV4Crchekq6U2ySgte
         YIgLO8mVDBlBw4fqXnOCTa+QLNNCecwWUwQKoOf88KGE0mEBgyYYlQoFMiP/pn3u4vyA
         GKtAwZROhZIdEai1eyUN9ZbFVZfQe2LDbnYcSnxXCsrsAZo1qpXQ2yMA1Tz8QWdFWBBZ
         t5pPVTAv2gc17X7m3tRup9lTM1sfYLIyN8J7s+GfGN9mHEd8Du41rgxKtDbXDKea5Zr/
         4JhBAmGXFfYZX8A3c0tO++GiObJpGal51opOO4t5AtdNPT2Fd5itRDuR9tt+DdcNq+/X
         r1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Psj+9E0ZGFt1heJVKpqtu9ZsCWPx1khP7AIh+OGqXtE=;
        b=PujlDciG0PmVaiadRM6fvuGWS4KNd4SzVFAdHYasxJyMGU1KFbu+QY7POwLyRjcSNL
         fq8e+bt7F2gDc/rQiHDM0kz1GG4eAEHe/WzfE4eKEbuQaSVxi0bx+NPeLf7UTLBuw8WS
         dCpIacNNSrVl+2IkKPl+GYcsTLO6vOdV1fuU0bmEYMbmQX7oTJKLURFFwgPcMDeRjCnL
         Cs6kHyN0rxjn1IOl0YigylxqcRydg7AMAF8stec8LFnPstfo6C7qcv4nKWjMZZDpLDwT
         DtI6qZIk1wU489/itUr25InhwYg7GpWxq3+XJo26yBG0JV40/bFgV0JUNIczqokGnbPH
         5dfA==
X-Gm-Message-State: APjAAAWaIhBKt9reeX3CYmOttiMcL0uKV/DRbQVzhzoSjpSeE4tyIIKa
        nIXiKx7qrFpCtLgvoHezQRlCAss1dMJIxW8+PoW3LNqng4rZKrkJp8Fs3cvhqG+QkUO2B+kI/jT
        35ivlr1xuZCgxgKNTldrHI1lj01jb
X-Received: by 2002:a24:9a86:: with SMTP id l128mr3362035ite.12.1553380425316;
        Sat, 23 Mar 2019 15:33:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwI92qwFiQVbGu3E57gI4WuOC3+XyW1LN6US+lDwUzzD62LTxJtB9AQCjhnPPyp2GAt79tBow==
X-Received: by 2002:a24:9a86:: with SMTP id l128mr3362028ite.12.1553380424978;
        Sat, 23 Mar 2019 15:33:44 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id 71sm3443185itm.31.2019.03.23.15.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 15:33:43 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: mwifiex: fix a missing check of ssid
Date:   Sat, 23 Mar 2019 17:33:39 -0500
Message-Id: <20190323223339.13703-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sme->ssid may be invalid and thus should be checked.

The fix adds such a check and returns an error if it is invalid.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index c46f0a54a0c7..a46820cf609f 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -2343,6 +2343,12 @@ mwifiex_cfg80211_connect(struct wiphy *wiphy, struct net_device *dev,
 	struct mwifiex_adapter *adapter = priv->adapter;
 	int ret;
 
+	if (!sme->ssid) {
+		mwifiex_dbg(adapter, ERROR,
+			    "%s: Invalid ssid\n", dev->name);
+		return -EOPNOTSUPP;
+	}
+
 	if (GET_BSS_ROLE(priv) != MWIFIEX_BSS_ROLE_STA) {
 		mwifiex_dbg(adapter, ERROR,
 			    "%s: reject infra assoc request in non-STA role\n",
-- 
2.17.1

