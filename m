Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4F5C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A0D21479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjTNY/B6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfDSTco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:32:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42991 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfDSTcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:32:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id w25so2936851pfi.9;
        Fri, 19 Apr 2019 12:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Opmc57fy+M6CMn85wO5GVzdSn9MSV8hVuhSL868U+yY=;
        b=hjTNY/B65Cca8jZ0d6efgsSYEw1p5a5xCwxZU7j3wjXMwlJcvKs7Rf7AvPxMY9EESV
         lZc9qJzsoJ+rugbZGFDREf/MnHS+Oeag6p8hLD6ZTial3L7ThBbPDGG47qIJTJ4OM6bC
         YHLRTwwmFB6B4Jm4wJIh+rOxxZ0L90HIP5md/+mhIDIk4Dk/wiFdT3sBhYqWyz+/taZh
         uIpTfcCxpgzacA81f1rllALMMnrxBUVVf25rVxfxj2sbfoSPq1KyIX9KAQEX6Cu5gaop
         nwlZdr9YcB9lpQ34gaduqRghEPPp2e2W1esc+Vs7Xjf6rkuBpVKBc1vbdk7MNMUqCNR6
         eGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Opmc57fy+M6CMn85wO5GVzdSn9MSV8hVuhSL868U+yY=;
        b=EIIXvmYRjucd7lSa0EKp78hwMaw5DfE03yPZTlnFDcW2o+a4jknHtePUEah2dgzbVo
         Z3XJ5t5PxnGfeiSt70fD3Cra5XLkzNvcfWayYR73z+ksqx5uzRTLAgZyfVQ1fPw7ar+W
         94y/whl1CXSzgVntGyaoHZNHnMreL/B7JHOcA/tI3GdpjtC7KKaSJFc3lzFvrIpqVJB6
         oz0gSCZfEs6jNoarGS5dAFZCy/qxHSkNkq0+a9ckH6BYpqvZV4LSWeV3z27qkNESWIuQ
         3Ss7ON0LpCTpUHF+wjwa2+wc3/Mb64cfWwoMCbzsYE7JX2mBRl0t55iGuHLRWXSoDVuW
         I9rg==
X-Gm-Message-State: APjAAAV9yQpC+mJhipof5maRjEnKAHIE/XiR524pHLc67/92enDvtGnG
        wCXsa2ObYa3KuAdB9apbtnL5KhHTdn/KiQ==
X-Google-Smtp-Source: APXvYqyGiCWg7OGG1tA7wDwKM7SRJsi4DTOHa1VVBFCV/MYLUhpfATPz5EYoFKYuhxol9Lnh59zVMQ==
X-Received: by 2002:a63:3281:: with SMTP id y123mr2734240pgy.272.1555663574072;
        Fri, 19 Apr 2019 01:46:14 -0700 (PDT)
Received: from localhost.localdomain ([132.237.175.246])
        by smtp.gmail.com with ESMTPSA id y3sm4688740pge.7.2019.04.19.01.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 01:46:13 -0700 (PDT)
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
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Charles Hyde <charles.hyde@dell.corp-partner.google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/1] r8152: sync sa_family with the media type of network device
Date:   Fri, 19 Apr 2019 16:45:46 +0800
Message-Id: <20190419084547.26220-1-crag0715@gmail.com>
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

Change-Id: Ib48a303730bee81667a2859be32e48cc8a66f277
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

