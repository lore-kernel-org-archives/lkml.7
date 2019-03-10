Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044B0C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 08:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD26620657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 08:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="VD82JrKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfCJITY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 04:19:24 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:36990 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfCJITX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 04:19:23 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id F3EDEB63
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 08:19:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GMBqES2V9iiZ for <linux-kernel@vger.kernel.org>;
        Sun, 10 Mar 2019 03:19:21 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id BFBAC75E
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 03:19:21 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id 142so2179605itx.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 00:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qyyGdfejw+uEXBzWeHy1i/Jtc6c84bzQtX7dUxo4/3I=;
        b=VD82JrKRzMB3jlX9fdcBDZ5vlX02nvtC/2YuMsZIdPCl0CHPzco65jYDa3teitLd/x
         uO6ABOulNpalsSB/ydzgiPRq3BSfx5aIHMQXxfAxT9f2Djsr1CNrymclSbvA6q0XIv9y
         HDwbQkmSnGU7I/KyOEFPr0u+5ZEbfU8OrwYRmnWaFI91siA8YVjtaCqQPhxPomGbGRKf
         F3zxqrohJdoeYhpMzKzAolRkH1BMNka5E3Kkd8HhPfMJZXVMsvCjScVmfD82yKS+9Vu9
         YtbWFdxmoF7bSsocqyJ61VJgyxGBTzfratozCCG7TGqLLXp1RFdeVAP8k+TdduwSnPVw
         xGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qyyGdfejw+uEXBzWeHy1i/Jtc6c84bzQtX7dUxo4/3I=;
        b=J8ojRKJ+HzIDAHx8fWRIcEVpdjNgw1S/06AWtLuggfZNpfAhNiRh8OAB0JUMp91EF6
         UxYwJ15b+CGWe07NetTU2dLpvQv7MgAOERxT0bOe1B+xci/FUBeur78bVk+d89IED/zd
         4kxw2Qr3QJnR+OPxX4EorA+auv16bDK4zFe81Kk60iPIYvOUIKPOnseC7svWTpzhjAuv
         vUTZQA45wiLS9W7cipdS4Na5IU2AHCEO5cMGmLe2R8kxF4tZDzjjGomF7CCjB3ep+4u8
         U07gJtnM9o0WJhd4pinc6Sg0z4/xJdvWiqMIYiNMSajad5EVteAozSwV6J/HWKO8YdQl
         UuBw==
X-Gm-Message-State: APjAAAXd3yQliIF2ZKqhJBnasBW5L8NraiomxHWx4QyextQLpQMfL7yD
        W7dGkSLh/RO7lOIcMiD50VZ+Io2LmPLdzDzciHyhIqCJwJXDRKmSCCypLXoYul+IjJjzOkwh70e
        vW8ozjtaQjdJe88BZxQcsuYA/yVsA
X-Received: by 2002:a6b:7517:: with SMTP id l23mr14351862ioh.74.1552205961405;
        Sun, 10 Mar 2019 00:19:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqw2Qj20TzgXNjfEIydtuqveosdeZT7qIvMwfwl+rQ0Fk10WQVtfAvtzqItRYcW1K+4/k+ANIg==
X-Received: by 2002:a6b:7517:: with SMTP id l23mr14351857ioh.74.1552205961149;
        Sun, 10 Mar 2019 00:19:21 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id y18sm953507ioa.56.2019.03.10.00.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 00:19:20 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Derek Chickles <dchickles@marvell.com>,
        Satanand Burla <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: liquidio: fix a NULL pointer dereference
Date:   Sun, 10 Mar 2019 03:19:15 -0500
Message-Id: <20190310081915.7024-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case octeon_alloc_soft_command fails, the fix reports the
error and returns to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/cavium/liquidio/lio_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 9b7819fdc9de..a3781d7a7b5c 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -1192,6 +1192,11 @@ static void send_rx_ctrl_cmd(struct lio *lio, int start_stop)
 	sc = (struct octeon_soft_command *)
 		octeon_alloc_soft_command(oct, OCTNET_CMD_SIZE,
 					  16, 0);
+	if (!sc) {
+		netif_info(lio, rx_err, lio->netdev,
+				"Failed to allocate octeon_soft_command\n");
+		return;
+	}
 
 	ncmd = (union octnet_cmd *)sc->virtdptr;
 
-- 
2.17.1

