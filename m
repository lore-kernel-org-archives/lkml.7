Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08C8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3DD2084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="BGWYUwch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfCLFCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 01:02:13 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:34904 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfCLFCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 01:02:12 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 13457A00
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 05:02:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ydLaZqEjNMGg for <linux-kernel@vger.kernel.org>;
        Tue, 12 Mar 2019 00:02:10 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id D8CE29D1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 00:02:10 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id v3so971734iol.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 22:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GfdWM9SSU7KfpdKIZzPpOpuTjbGIrvUY//TTRkRyo1k=;
        b=BGWYUwchhNVeCgZBoDBH4UKpaQr5T0h/RgqAWCNl/5B0vE8wmK9V3uDs4mQCMyM2Dw
         hlrYClNJE3J1YsOfT/SxnI+c+Ct9QRroNMaoIKI4Vk9w391yIwAZhAe6KY7IfpAqRgjV
         v8JKG1+vAztwb6UxUxiiGfxm+Gv/RmJfPi2CSYjMjtStawpQxBSR3o2zC8mIcF93JopG
         yO7j54hOjWUMz/lf1YXZnnDR8vlqyMt6dbS0pvm/ATzoU2An+JXUFehfBV09pUv71RPh
         3CxM0iP2/IBnegfxtgOawVUo2GlL6zmlG7zUPngNKbn27i1n7UGcvzPxXa+K7ZJZ+rK2
         FYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GfdWM9SSU7KfpdKIZzPpOpuTjbGIrvUY//TTRkRyo1k=;
        b=MR4kIm47+ohwRitg3IFl+gh1pD8aEqAKqvQ9W+Lg7v5llx31H04N7OrRK4FKWlgB6Y
         xjfo1g8x+UfYCJNUXx/VoN4LAkV0wieTbxI4DEyLpDCgn/qcJ/+Xb6JeBmrRnb+KmF0L
         DFMJ+TevinZ2P8nrlX+YhD0xK367CYKUEI8SYvJZPxmJYzhGN/cTeZvl9v7KSuP01E2d
         e7U55QDygTWBiMivpYi+5pTJdMV4ONS5hqJ3qkSirehH6YfB2rlSLkNDakBK4W4xFBXt
         EFV9UjHqvcNZzXMPOaX+r4Qj3ApCXdh2Cq51dlLZmtM4Tn6TZrE8/uWniDobs1l3koml
         +OPQ==
X-Gm-Message-State: APjAAAVCN2Kf7pettBLKGPFbPI8EYHOQlhZ5yLIMFBOXfm60sWNxij9/
        02eGerwa1IzZr8Ldh06keuq+pyO/lGGduYVIOu3n5/KoTwXNPkK0EKUp65pZp5pztv9RSF/XFU6
        aV3jOov2+ABGZGHPoaTADhqdzwyIm
X-Received: by 2002:a02:85ec:: with SMTP id d99mr11811794jai.116.1552366930473;
        Mon, 11 Mar 2019 22:02:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxslqLpIgRl8QFYE5oUsL0JMPs46bt4QOb6Wyfx39EPkn4L1aPkB54MDW4k2WFHG2cSAulelA==
X-Received: by 2002:a02:85ec:: with SMTP id d99mr11811778jai.116.1552366930212;
        Mon, 11 Mar 2019 22:02:10 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id e11sm3170229iog.79.2019.03.11.22.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 22:02:09 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] hv_netvsc: fix a possible NULL pointer dereference in netvsc_get_ethtool_stats()
Date:   Tue, 12 Mar 2019 00:01:49 -0500
Message-Id: <20190312050149.3032-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case kvmalloc_array fails, we should stop using it to avoid
NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/hyperv/netvsc_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index cf4897043e83..4b3a03029fe8 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -1426,6 +1426,9 @@ static void netvsc_get_ethtool_stats(struct net_device *dev,
 	pcpu_sum = kvmalloc_array(num_possible_cpus(),
 				  sizeof(struct netvsc_ethtool_pcpu_stats),
 				  GFP_KERNEL);
+	if (!pcpu_sum)
+		return;
+
 	netvsc_get_pcpu_stats(dev, pcpu_sum);
 	for_each_present_cpu(cpu) {
 		struct netvsc_ethtool_pcpu_stats *this_sum = &pcpu_sum[cpu];
-- 
2.17.1

