Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82D4C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 11:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831452087F
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 11:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Magw5xp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfDULsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 07:48:37 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36201 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfDULsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 07:48:36 -0400
Received: by mail-pl1-f193.google.com with SMTP id ck15so4559647plb.3;
        Sun, 21 Apr 2019 04:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zPX8nddRpRzZMMKNuqNqkX83XY5HeqqpmfwgbraZ4I8=;
        b=Magw5xp7IYb6lD2+6GvMxT4CLdN2GMjI3Bl+9a1NB4fwLE455oS7UMABMxdNxKN6UD
         6xTGmydAUd/NUBYQ+pREv43BFIbaC+g9BV7WPYb3/l0Yw9k8rKqPGxtJLRvx8coP3BcU
         hn6Aks5iGU84m+OAcHlaZAmqIZcW0OCrzmDj69G15NrY4i4ndaVSB2libpRCQoxcVT9q
         iJBmIVxtH8kSmJM0MGCLWWVsL52nk8bqvia8w9CfWWCOtD3najg+uM7wzoUdWoE32AbW
         SjOXcwhGLkXV2/zKeoVEkl52zAFIiI4RpIxPFIJheaYJaoPYTY6jcCmbA23hcckgrONr
         4JNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zPX8nddRpRzZMMKNuqNqkX83XY5HeqqpmfwgbraZ4I8=;
        b=GUyNRRRKXL9ka1/IaBuL/Ksgfj/b0QMBozeHHv4keVkVCck7gnHaD1rz+pQvdrjvK8
         t2sHOcZGsozI32qzKEr6bnVeHZYehvedYKZWVlYDK2rIUqLhdVtH1M4cJ7DEYC9sq9CR
         NJmfmhZoCQZjOHXUl45w8Vd66xfAINJ8/rG+IKhz3b1iJ79UtPosTDOFupl/HZaXFWWP
         6K9M6e1eqd4kuFfO/3rvrcpbSKhKM4nd8UEVyPrJ8VZ6UKPTKcE6Aq/9GHQUXAu/Jewn
         /BNwymuvVAhNE27HHPAAXLezh8hM9lPBH0/bsDxGRbdSb/lFGt4SRI2NaMaSvIpDCav7
         E5pg==
X-Gm-Message-State: APjAAAX6UrustssKIE/SPoVgcohNe6Fo4yOPJPXc6MzQF72YjIEksToH
        BGl8yWgIW0+UXEqua2Zhro8=
X-Google-Smtp-Source: APXvYqzq1j91dZEOGFBIzQtrWoud4sDwlQWxi2Hdq7rCMDAQOdkNFK3Q5UQ5H28TypvrT+fCKCDe/A==
X-Received: by 2002:a17:902:2bc9:: with SMTP id l67mr14607103plb.237.1555847316330;
        Sun, 21 Apr 2019 04:48:36 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id c5sm11081954pgh.5.2019.04.21.04.48.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 04:48:35 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Jes Sorensen <jes@trained-monkey.org>,
        "David S. Miller" <davem@davemloft.net>, linux-hippi@sunsite.dk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/06] net: hippi:Fix misuse of %x in rrunner.c
Date:   Sun, 21 Apr 2019 19:48:26 +0800
Message-Id: <20190421114826.20512-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer should be printed with %p or %px rather than
cast to unsigned long type and printed with %08lx.
Change %08lx to %p to print the pointer.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/net/hippi/rrunner.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hippi/rrunner.c b/drivers/net/hippi/rrunner.c
index 029206e..0f7025f 100644
--- a/drivers/net/hippi/rrunner.c
+++ b/drivers/net/hippi/rrunner.c
@@ -1298,11 +1298,11 @@ static void rr_dump(struct net_device *dev)
 	if (rrpriv->tx_skbuff[cons]){
 		len = min_t(int, 0x80, rrpriv->tx_skbuff[cons]->len);
 		printk("skbuff for cons %i is valid - dumping data (0x%x bytes - skbuff len 0x%x)\n", cons, len, rrpriv->tx_skbuff[cons]->len);
-		printk("mode 0x%x, size 0x%x,\n phys %08Lx, skbuff-addr %08lx, truesize 0x%x\n",
+		printk("mode 0x%x, size 0x%x,\n phys %08Lx, skbuff-addr %p, truesize 0x%x\n",
 		       rrpriv->tx_ring[cons].mode,
 		       rrpriv->tx_ring[cons].size,
 		       (unsigned long long) rrpriv->tx_ring[cons].addr.addrlo,
-		       (unsigned long)rrpriv->tx_skbuff[cons]->data,
+		       rrpriv->tx_skbuff[cons]->data,
 		       (unsigned int)rrpriv->tx_skbuff[cons]->truesize);
 		for (i = 0; i < len; i++){
 			if (!(i & 7))
-- 
2.11.0

