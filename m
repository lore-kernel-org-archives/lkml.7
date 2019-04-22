Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91145C10F14
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6309320870
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQNGrTtX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfDVCYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 22:24:14 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41322 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfDVCYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 22:24:14 -0400
Received: by mail-pl1-f196.google.com with SMTP id d1so5087056plj.8;
        Sun, 21 Apr 2019 19:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nsMmiC7jhSKTFlhgcEpu4yxQzWbtu7ogv5Doohyfyhc=;
        b=eQNGrTtXaXcktSJFYrle3/WJ8Ifhx2VHoatKxP2gRrZHqXhCMubsa484jvg9NcIn7/
         yd3X4H0AWVVYJwZAQMXdK4yAzH2ZruOSatrusEXhYE++9/DSgCAqDEk/1Kgm1gvrtcp5
         quMaXjW5d0EIhT20vOme3XMF9H3nQsKMCrftamLXmsW/j/uEaGhA0qdZHCRvxpHr2qfu
         FnwpGIjnwtvPXqD1RKFolkP/+sm5LuL/E1rU5+/yHwkRQoCsHUXjrD2ekYYkOzC4/tmv
         D5+npoRQoBcmaMdleiz5/M3x8I8+LCJ0hf7Ql3VIJc/FAXTz8BmEkrFm0w6HTsx90tPN
         Cebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nsMmiC7jhSKTFlhgcEpu4yxQzWbtu7ogv5Doohyfyhc=;
        b=WEwDeE2SqFfX5s6azAoNU5x/LHr1Dutl/gBdzKYSUIYBilYUP8vQE6jKI6GPOGkjg2
         DwR9tRlPtD1HdFF27HwYq+dhTdnyLb7i02OgLTr5UTG69Xx2NDLoS9kX40Tbjubm0WuG
         1duc5Ly6uLpOuclcvKt0dqF9sG5Ezmk7CnLEBSenCDbphxh1SSVTmqhjyQq01s3091RC
         mdfHkQE2PFsEZe5m96lchu4Etd/sOYJLIIv2tk8SmDmgJGYXCZF2Y8j+3TR7BdwsCOtL
         shZUYRj58rDcR+wZ2AbEw6uPjTdouqwUhJrsOVgLhyG6wQBhciqqPOZhmGbktDXUTib8
         iWsA==
X-Gm-Message-State: APjAAAXmJSz9bdJofJdF1YwGIB2V8OC3Lqed9EWLMBhqKvpAh51p/2Y9
        aJhqWi31F/Su4WF/eXgcudMriUwtndt6BQ==
X-Google-Smtp-Source: APXvYqx8euJwNPPJwsDs/oYN4KZ/d3dFLA9g+AtN9UONU4qiVll3hLpO2gx6zTfhAGXH/1Q05qOFeA==
X-Received: by 2002:a17:902:e704:: with SMTP id co4mr18218291plb.30.1555899853182;
        Sun, 21 Apr 2019 19:24:13 -0700 (PDT)
Received: from localhost.localdomain ([132.237.175.246])
        by smtp.gmail.com with ESMTPSA id p7sm17217298pfp.70.2019.04.21.19.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 19:24:12 -0700 (PDT)
From:   crag0715@gmail.com
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, hayeswang@realtek.com,
        mario_limonciello@dell.com, crag0715@gmail.com,
        "Crag.Wang" <crag.wang@dell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Simon Glass <sjg@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Grant Grundler <grundler@chromium.org>,
        David Chen <david.chen7@dell.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Slaby <jslaby@suse.cz>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Charles Hyde <charles.hyde@dell.corp-partner.google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        zhong jiang <zhongjiang@huawei.com>
Subject: [PATCH v2 1/1] r8152: sync sa_family with the media type of network device
Date:   Mon, 22 Apr 2019 10:23:06 +0800
Message-Id: <20190422022307.19616-1-crag0715@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Crag.Wang" <crag.wang@dell.com>

Without this patch the socket address family sporadically gets wrong
value ends up the dev_set_mac_address() fails to set the desired MAC
address.

Signed-off-by: Crag.Wang <crag.wang@dell.com>
---
 drivers/net/usb/r8152.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 4c63b40d5e00..41fb39ce69c9 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -1225,6 +1225,8 @@ static int determine_ethernet_addr(struct r8152 *tp, struct sockaddr *sa)
 	struct net_device *dev = tp->netdev;
 	int ret;
 
+	sa->sa_family = dev->type;
+
 	if (tp->version == RTL_VER_01) {
 		ret = pla_ocp_read(tp, PLA_IDR, 8, sa->sa_data);
 	} else {
-- 
2.20.1

