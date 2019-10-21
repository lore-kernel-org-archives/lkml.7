Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7920CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900F12084B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mq1CuWcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbfJUUwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 16:52:35 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33878 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730428AbfJUUvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 16:51:49 -0400
Received: by mail-qk1-f196.google.com with SMTP id f18so13541006qkm.1;
        Mon, 21 Oct 2019 13:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8m6K/WMO8zxyMttz6j+QnaDf4E6+eGlpyVOiEpkVr2s=;
        b=Mq1CuWcr3wmyuej9kvzNamOty4GwOWREYnEKh5M5qJ1A3l4JUr9uUkLAacfXD0xrd/
         QynrR9VtxI/0r5lXHJk5yk1c/oxPf+R5nOhAmS6Br5rI0dduyb+WMvum0cGAWFbjHNy9
         Vb03kc1lfKTl+d0waVg//lyyYOE/FEAZe0CrpsNGq8kze++HDhU2r1STajnRleHuIX1a
         tJbm1i+0gs1BkTOz7O2mW8zA2TX4yYNxWgMCd6nBk19sYKqKfaV5qMcnjKnSLOE/mfpU
         G8ApUIXRVagEY+++0whvbLr/u1xjBGHh0EczMBOGU4+ZOhYY3ZLRopUZ++Q8bf+7bwJE
         L9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8m6K/WMO8zxyMttz6j+QnaDf4E6+eGlpyVOiEpkVr2s=;
        b=A1pO+cBZvEnnRxxZO/JNDzkknHemXp4njXcTC42dJa12ysT8MVvv79SNbV+s/mt5DN
         oQ2LdOVmtEU2EsFTXOMhEPfr79sK4Sn9pnYrafGNZE3l5FOA3tfrBqITY+k492Hf9Zx/
         ZU123YNY28wO7mOayMMj27wy8yvcheXiKcJ5CDCA7DpCUqU5kkDoS+65+eiDsAzCHUE/
         YJBW0J/GidxFmCWDOQyyoQQMKHaOMty0boHo2egwCPOT09O4ofVPbOUOMccFqcKnbryH
         E5WndQ0tHaHKZaM8UzMFH9Ix6IY+Ruc8TW1/4DFJl+DgCYKdWBM3CCKrChrx+d9M+L1x
         THXg==
X-Gm-Message-State: APjAAAVsKrR/vZXtVKTpJjkrasTNOaHOkfXmKz9cYm8022qOxibMLQVX
        Tcz7vNA4eaTXxP0al7Xk+7c=
X-Google-Smtp-Source: APXvYqy6cjA3Wy2hbKtaPCFE0GRBXbmwf2zYkbN/QRmjbgcGe5qyNKYjniHRDjNrheQn9JzVcHiE7g==
X-Received: by 2002:a37:5b46:: with SMTP id p67mr707686qkb.318.1571691108617;
        Mon, 21 Oct 2019 13:51:48 -0700 (PDT)
Received: from localhost (modemcable249.105-163-184.mc.videotron.ca. [184.163.105.249])
        by smtp.gmail.com with ESMTPSA id z5sm7939300qkl.101.2019.10.21.13.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 13:51:48 -0700 (PDT)
From:   Vivien Didelot <vivien.didelot@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: [PATCH net-next v2 08/16] net: dsa: use ports list to setup multiple master devices
Date:   Mon, 21 Oct 2019 16:51:22 -0400
Message-Id: <20191021205130.304149-9-vivien.didelot@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191021205130.304149-1-vivien.didelot@gmail.com>
References: <20191021205130.304149-1-vivien.didelot@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a potential list of CPU ports, make use of it instead
of only configuring the master device of an unique CPU port.

Signed-off-by: Vivien Didelot <vivien.didelot@gmail.com>
---
 net/dsa/dsa2.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index a4de7ff8b19b..514c0195e2e8 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -493,19 +493,27 @@ static void dsa_tree_teardown_switches(struct dsa_switch_tree *dst)
 
 static int dsa_tree_setup_master(struct dsa_switch_tree *dst)
 {
-	struct dsa_port *cpu_dp = dst->cpu_dp;
-	struct net_device *master = cpu_dp->master;
+	struct dsa_port *dp;
+	int err;
 
-	/* DSA currently supports a single pair of CPU port and master device */
-	return dsa_master_setup(master, cpu_dp);
+	list_for_each_entry(dp, &dst->ports, list) {
+		if (dsa_port_is_cpu(dp)) {
+			err = dsa_master_setup(dp->master, dp);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
 }
 
 static void dsa_tree_teardown_master(struct dsa_switch_tree *dst)
 {
-	struct dsa_port *cpu_dp = dst->cpu_dp;
-	struct net_device *master = cpu_dp->master;
+	struct dsa_port *dp;
 
-	return dsa_master_teardown(master);
+	list_for_each_entry(dp, &dst->ports, list)
+		if (dsa_port_is_cpu(dp))
+			dsa_master_teardown(dp->master);
 }
 
 static int dsa_tree_setup(struct dsa_switch_tree *dst)
-- 
2.23.0

