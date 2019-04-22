Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D19C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 05:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D472077C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 05:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O897wwR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfDVFEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 01:04:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46176 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfDVFEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 01:04:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id 9so5123513pfj.13;
        Sun, 21 Apr 2019 22:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nsMmiC7jhSKTFlhgcEpu4yxQzWbtu7ogv5Doohyfyhc=;
        b=O897wwR5sSHdszjTGLUArhG7+M6XZAfs4T3tCp2tl2beeeoNSwHcLtcIAcgpC9kJ4B
         eAOkpvGWAR+N7H3OpCh5eP3ANc5jwVI0VJPC04qBJK9PgI7x/PlsLgmIek1O4nO6JT/Y
         1Ju0H5EQYsMC4XH89En3loHtiqrTR2UuoUi8GjLpUjOux6mxgy6iOAolsSpbS1MDOU/E
         gX3AQFp9x+CDO4OxmjA6FXkgc3JwTvztVhNvoycVmbZXbzJYdS/e5tEtmz+vnqS5SzXM
         SM7CxSQGKszAxGPIoj/Q7AM26PO1nP7CTwfNE0XjaCRt8BUb1SjKTHm+nKtxriKeyQ5e
         XHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nsMmiC7jhSKTFlhgcEpu4yxQzWbtu7ogv5Doohyfyhc=;
        b=KTaWyxpdMqaUfDTHdC7JwNUnZy8xD163JkzyGItMMowvK4G+pJ6+YYtl6rTCbk/18x
         9dLSXNQY4qfNfuvid6wG3C2LBHQXZ8vviDuY1uYkNwVPnkl7KTjkWN+QhYJakWj4Blx6
         LfGPEJebZyu351+uV2zHNg8x/ReH1M7KPT9ehZRL81tdM1Zl24YnDlFd0dmrqCI8E8VL
         TnjgXwtplc5aihpCNjjzp0Q4XnJiZUi1DvazvWGim2DWAXus1JANrSKyVcpYWE6gJAUH
         SI4XDETx6DyGkwZCmBZ9LBAIdJzc4S89uxTpHvWGJCvz1IvaGGbs/tuaa5d/Ve5fZQRA
         CIKA==
X-Gm-Message-State: APjAAAX6TydtAzWYelL1aWySW68ZqtIgIVR0eqbybPhBEfpcmftnjapD
        R/1JeCcaWtlDiEZxgpMeui0D9BddhwLkYQ==
X-Google-Smtp-Source: APXvYqz1m4xyKyT7tpHFVEIrxRTHDMPP04U1aV6vk1oh821HmIXL4FBqng/d+Ir/VptUpGXqKaJhdQ==
X-Received: by 2002:a63:f64f:: with SMTP id u15mr8734681pgj.192.1555909461379;
        Sun, 21 Apr 2019 22:04:21 -0700 (PDT)
Received: from localhost.localdomain ([132.237.175.246])
        by smtp.gmail.com with ESMTPSA id y8sm16192332pgk.20.2019.04.21.22.04.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 22:04:20 -0700 (PDT)
From:   crag0715@gmail.com
To:     linux-usb@vger.kernel.org, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, hayeswang@realtek.com,
        mario_limonciello@dell.com, crag0715@gmail.com,
        "Crag.Wang" <crag.wang@dell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Simon Glass <sjg@chromium.org>,
        Grant Grundler <grundler@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        David Chen <david.chen7@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Charles Hyde <charles.hyde@dell.corp-partner.google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        zhong jiang <zhongjiang@huawei.com>
Subject: [PATCH v2 1/1] r8152: sync sa_family with the media type of network device
Date:   Mon, 22 Apr 2019 13:03:43 +0800
Message-Id: <20190422050344.24513-1-crag0715@gmail.com>
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

