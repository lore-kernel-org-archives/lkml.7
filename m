Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC45C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7212075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="lhqMw+3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfCKGRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:17:44 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:48570 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfCKGRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:17:41 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 28F03B1E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:17:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lpOQyumz7Ivh for <linux-kernel@vger.kernel.org>;
        Mon, 11 Mar 2019 01:17:40 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 0313BB1D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 01:17:40 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id b199so3431462iof.14
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 23:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xN31h4x5ZALT9IMTYpU74QFk79bWQWoed0tpkI2F+nc=;
        b=lhqMw+3UXwVFwXl0FlWnFiknCdFKbcPn4bcDr9SYzwLToP6jmqIEfxEiyZ6bV8mczk
         rRsFOtuu7QkDsene56c5AF8QdnUpjEfdWexasd+JH1MiwgcgtjUhVxtf0q9gSBXmbOdj
         XYrJcrjedis1BVvaw4yEfM/bVC/uqO04lhmqs8j5HjgmoxfS67xCIIUHKnFqdDU9+WSf
         2uucKhjndeHHAxoCsora0ix1u6xO6T1YkYa4nUz7DiR1f6a59XLpOupROj9NNuiJDa2e
         CAHGSyrFIpN0wejAq+85md7xBVBGZBN2X9Q+kFT0s0//Wrn6dyXHk6ZXZNOwsLfIlOKO
         LW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xN31h4x5ZALT9IMTYpU74QFk79bWQWoed0tpkI2F+nc=;
        b=W0yMZTgcUARLAgjxA700rBsM99xmHKScti9xA8IqAfrvgACCxijaLoF9x67KC09Pti
         l4a/2470B9tKpzznhNwhH2DkdNGYlYRaUfUnKAGw6IL9ESLtSM3hl75O0mBuS+X8Dx4z
         DioAGbY48RJ9Vfykxu/23jEoClQU4ZmWQEAOK0LGc+U347BEtmh46lpWvXD8LK+mu4fF
         p7aQ9lQnXvRFzMG8dfOwB/UEWbihhh9Yf/Sutc0kgEZb3gA8DpT0LZledgLP/cOeZuBd
         yNQelTBy6K0oB2qqtadCHxNfPtJUsY5DvaZ40xZdP69haO+2FMLQ1YZwnAP2SBc0SjjT
         AQpg==
X-Gm-Message-State: APjAAAUNQlARcNPnEFYIxRgYwSZy/t4c3gdHX+lC5bcBhKCfvA1KHdAT
        n2ljzsoHPPQVTliJm2jowOTWDt+AKehGWqpGo8fb/GF79FejNi+B4PvkCxvLUTdKpXx3TC8L2dq
        EJcKIqPaaeHCQoSmK2JLfaWuUveH+
X-Received: by 2002:a6b:ee1a:: with SMTP id i26mr1570075ioh.201.1552285058642;
        Sun, 10 Mar 2019 23:17:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx5swzk1OVg/XV75LuXGqzphQmq0xi2cmDiKpqytwW0qY3fSutv0qCaNUh11Pq+BuZlsqzpRQ==
X-Received: by 2002:a6b:ee1a:: with SMTP id i26mr1570072ioh.201.1552285058445;
        Sun, 10 Mar 2019 23:17:38 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id a8sm340203iol.35.2019.03.10.23.17.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 23:17:37 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: fm10k: fix a potential NULL pointer dereference
Date:   Mon, 11 Mar 2019 01:17:32 -0500
Message-Id: <20190311061732.19064-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case alloc_workqueue fails, the fix returns -ENOMEM to avoid
potential NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 5a0419421511..215f232674f1 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -41,6 +41,8 @@ static int __init fm10k_init_module(void)
 	/* create driver workqueue */
 	fm10k_workqueue = alloc_workqueue("%s", WQ_MEM_RECLAIM, 0,
 					  fm10k_driver_name);
+	if (unlikely(!fm10k_workqueue))
+		return -ENOMEM;
 
 	fm10k_dbg_init();
 
-- 
2.17.1

