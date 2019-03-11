Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99F8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF6020657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="bN+F3Mmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfCKFDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 01:03:30 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:56408 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfCKFDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 01:03:30 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 8048D954
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 05:03:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cG_RwqhF7Obm for <linux-kernel@vger.kernel.org>;
        Mon, 11 Mar 2019 00:03:28 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 5A990957
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 00:03:28 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id n15so3346569ioc.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 22:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WKF56yIKs7fJwDygIiRCCfRe3pUyUIX6vdiMggsqlqE=;
        b=bN+F3MmcOHwWpKGVgO/j+znRJF2wCS+ZCj/5uAGkIa8vaRsu9TVLbKP0JE2wJevG+4
         ze15Ahfj7lqQXfs6wMOalSu73sxx4nLwvZhzMGH6H95UaN4wtyzAqhGiigXT+rtkK3y0
         gjjXy68xyBpc8DeJUgKi3Iy0WXOKU9YeodJZYe0i8FqOYGuLk2vVEJzDksfhL0or319N
         tr+5HQoMYSWho/gCOkrw5aEBy7RTXr1s5Wo9Dr28SadxHsLQkuDhUdNOsuejq/hzEA+e
         WWLJkxNldZlMrrqkoBoKg7wkpJ8yt+z7wAqKUIBYZMWFMUpwW19jF1p3r6tG9W1/rIq2
         ksKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WKF56yIKs7fJwDygIiRCCfRe3pUyUIX6vdiMggsqlqE=;
        b=Tyw5EIiO7wnCNDQWXHe0bS6cspYXdvVb/tv7UmFNC2KrhO+Toj/M3KZ+qrAg0kEgM7
         wMeNaM61/DjZHZRFsNl4fTHiaVFxhYxmvQGMcgi0a//hcYUEQRYaXIP3lA4+MON2hUYy
         LtYQJER5dpk8MbNKf1EkUP+oDk9LX1a39fPraYsKfwJK4sxz+JGIAtOvLWmX44y4SXwm
         50+SekiLtaBCBpH+bmTExHJNy0tk4svYVzDFw50Q5Z4ZilA++fUmXbXYeGiLbtVTOVK0
         ik1apvwY+JaHu5B/b27uZt/fwiehxQuuOuPS20HSFPZGcmlFwxN5Wg+xIbuC8WksIGFm
         6OWg==
X-Gm-Message-State: APjAAAVR4LRckKNGBm23I7dq65Nz/j8eczhd1QDSfxZLLHmLkFknpc4Q
        /1CZbXPZKvz8IjQ8vPkGv9mOv1a1/59Ueeig5RIqm5df0GyecZe6VdJaVlbK0Rvec/s7N+HSqMF
        qD6ooSAimmSpc3BUPx3xWPR3trxlc
X-Received: by 2002:a6b:5a03:: with SMTP id o3mr121597iob.9.1552280607869;
        Sun, 10 Mar 2019 22:03:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxKvcJURV09wPAsd54IP+q8x844UTCSIp8mfxkaHwoukwR94NrTqRr6xtTjvC3anxr6VF9Kew==
X-Received: by 2002:a6b:5a03:: with SMTP id o3mr121575iob.9.1552280607545;
        Sun, 10 Mar 2019 22:03:27 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id x25sm1984768ion.78.2019.03.10.22.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 22:03:26 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Derek Chickles <dchickles@marvell.com>,
        Satanand Burla <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: liquidio: fix a NULL pointer dereference
Date:   Mon, 11 Mar 2019 00:02:32 -0500
Message-Id: <20190311050232.3250-1-kjlu@umn.edu>
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
index 9b7819fdc9de..fb6f813cff65 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -1192,6 +1192,11 @@ static void send_rx_ctrl_cmd(struct lio *lio, int start_stop)
 	sc = (struct octeon_soft_command *)
 		octeon_alloc_soft_command(oct, OCTNET_CMD_SIZE,
 					  16, 0);
+	if (!sc) {
+		netif_info(lio, rx_err, lio->netdev,
+			   "Failed to allocate octeon_soft_command\n");
+		return;
+	}
 
 	ncmd = (union octnet_cmd *)sc->virtdptr;
 
-- 
2.17.1

