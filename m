Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5FDC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 20:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2779C2068D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 20:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="eciT/QwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfKQU2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 15:28:46 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:54820 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfKQU2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 15:28:45 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 100DBA67
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 20:28:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iT5d2jkz_BKu for <linux-kernel@vger.kernel.org>;
        Sun, 17 Nov 2019 14:28:43 -0600 (CST)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id DBF279B9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 14:28:43 -0600 (CST)
Received: by mail-yb1-f198.google.com with SMTP id p4so12019420ybp.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 12:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wBc17qrjKmSItYE88uMyJX08lkaFrl0hKy0d5h7YKUQ=;
        b=eciT/QwSJZ5I9UaCkzJWuOPWuPyFCfOHXD0LRNGhOP1VBRSyhEUwh64543StNvSQUf
         Z+Z0ISeQ56hDEVS2P4UMYioerVMKsWQS3fsFp5vsUS+QRug+X+BqPi6oNddw/nU/o/Pk
         rozJAmvN/48uJmHOLtRu4/tVSnDpH65LDA9PBnVZU20PGmS+Ptg1RNscmJtLPx5mLO4g
         bk++w9wdsY7XSFCLL1E5L1Qb9n4nmec8qgyDPgWvcrpyXG8rpu7rpZlEMd3p7JwAdYt6
         +puD9aHK0+42chQRBvD401ujAfzzeri47MWVTvOQFaJtNkATbda8DHTvoBtX7lERP12I
         0gKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wBc17qrjKmSItYE88uMyJX08lkaFrl0hKy0d5h7YKUQ=;
        b=uCma/ryxpY4bPC1uwubdG0tYnkTcOJAgzwdbt2J0CBIri1eCeiiXG7//t8T7nUVmcI
         L5JHAup1rrxNxsej2BPv0P0BG9eXFzVv3jab9TpZGDH68T+btjCBEli6XD9AnMtAshDR
         AaMoUCDMe8vH5uGqwrQCui6NA1Bve5Yf0sdfX90yqUcyFCo7MNtDS43BvpNXES48henX
         Hm7pltmKTkHaNOq57+RTzLrIswDRwz3CKbaeDpTOcTzK38yHDitRazRLiOJC7i6/Ol6Z
         05N1z1YWJ8mO4193hx5SNefVq6LcE7XsFcBc48unIP9B1L989bO9uujh2Ny9TuPj9OXi
         YQcQ==
X-Gm-Message-State: APjAAAUKeN9lTQVWmiTNOuBC0vyqgdxTuvWSRPXEGK5QtFxsagKnzKN9
        AyB1QNb6ORhilMIpxx34S75xhc23ZoHqZl01nPrV+jM/wD5ypUbrO0nJ4D0khSNbG6TI3XLy6Mw
        h3q0U7LHNEQ/wV3Cu3EC6JtqqRbKJ
X-Received: by 2002:a25:6649:: with SMTP id z9mr19227117ybm.132.1574022523434;
        Sun, 17 Nov 2019 12:28:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxDNJLEh5pGjh3lGV7hpQ4vc6QC7P9lu8F5/t/kqjfvi5ZqNAv1YDGfeKXZdy9dA33+lbyKvA==
X-Received: by 2002:a25:6649:: with SMTP id z9mr19227106ybm.132.1574022523191;
        Sun, 17 Nov 2019 12:28:43 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id c9sm7327900ywb.54.2019.11.17.12.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 12:28:42 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: atm: Reduce the severity of logging in unlink_clip_vcc
Date:   Sun, 17 Nov 2019 14:28:36 -0600
Message-Id: <20191117202837.7462-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of errors in unlink_clip_vcc, the logging level is set to
pr_crit but failures in clip_setentry are handled by pr_err().
The patch changes the severity consistent across invocations.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 net/atm/clip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/atm/clip.c b/net/atm/clip.c
index a7972da7235d..294cb9efe3d3 100644
--- a/net/atm/clip.c
+++ b/net/atm/clip.c
@@ -89,7 +89,7 @@ static void unlink_clip_vcc(struct clip_vcc *clip_vcc)
 	struct clip_vcc **walk;
 
 	if (!entry) {
-		pr_crit("!clip_vcc->entry (clip_vcc %p)\n", clip_vcc);
+		pr_err("!clip_vcc->entry (clip_vcc %p)\n", clip_vcc);
 		return;
 	}
 	netif_tx_lock_bh(entry->neigh->dev);	/* block clip_start_xmit() */
@@ -109,10 +109,10 @@ static void unlink_clip_vcc(struct clip_vcc *clip_vcc)
 			error = neigh_update(entry->neigh, NULL, NUD_NONE,
 					     NEIGH_UPDATE_F_ADMIN, 0);
 			if (error)
-				pr_crit("neigh_update failed with %d\n", error);
+				pr_err("neigh_update failed with %d\n", error);
 			goto out;
 		}
-	pr_crit("ATMARP: failed (entry %p, vcc 0x%p)\n", entry, clip_vcc);
+	pr_err("ATMARP: failed (entry %p, vcc 0x%p)\n", entry, clip_vcc);
 out:
 	netif_tx_unlock_bh(entry->neigh->dev);
 }
-- 
2.17.1

