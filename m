Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88C9C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 20:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867C320862
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 20:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4tUadj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfJFUee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 16:34:34 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38452 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfJFUee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 16:34:34 -0400
Received: by mail-qt1-f195.google.com with SMTP id j31so16373382qta.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 13:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2c8ZK7szNdI0lwDgcSx/BNDVw8gIfjfayd7qp8p7o20=;
        b=s4tUadj3B648+EYQH1tuz/RvaBZDjoG0+kAO5HR4hlh8tSGsE+hWmx1nPDgr2D8bE6
         D1gQFKTsgg+l+nCYrMeZyw4ZmyY5eTGKX6aexG8nPEhg0fiFvb8UQHoMNOij6CnjnFwh
         4qTlMkRpSyeELHYaPoLC3k7+BeDLByBzeSm57DaO8sCsgKLv5get/gV6WqCfP1GxJ97K
         gu7M/7ttrXBPPwRkyQsHPMH1vloPrZ8nfu/R76Vq4asyz3bt+oH5cao6y4B8S0hm7GwC
         Orb8FKF2ykjp0ssRYSjh0p/rMk8r24ori7KfoDIL0PXeG8oNRMLUfZkKhllPtFAF6HWN
         1MUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2c8ZK7szNdI0lwDgcSx/BNDVw8gIfjfayd7qp8p7o20=;
        b=HcCSncHzu1ToPejUjf9Qj0jPAxKTCQaFDB9zvhuktqig1VSLrj/B3ppjVuDQVEGSUf
         aJMRVhaEXHGulD9LYk0Qawo6lgDjFAI9qTmat+BYMfOHUhUpVVMqs6ORFNDVj5+2E2p7
         Hint/hIZpv6yyPrGZ69ttkJp5naouFjfhxItcJbSgAM6DUIlZtgL7uThTV4Zr0tOa3Ej
         2ziatHtG9xiu/QCy24lewyzip6JbfVr3v4Cu7NZVaHlAeb/t+zn3Ong3QCI4e05GkOA9
         UZ/Vyl/IBsxrs1lYFYdmxvm2YQywfzMkWfjoVS8JPmE6SITlHqT1c8R4+r6DDjQNWhAH
         020Q==
X-Gm-Message-State: APjAAAXX1F7+D0HWwB0Likr2diNw+7VQvKlOs/qIztZPlLUvQgnOoDSn
        hMc6iWmYGvJOIV25lC7yEN4=
X-Google-Smtp-Source: APXvYqynzUAAjBGQc81jeNQJq/G9gH18HPFL1aO5LqR1PPvEgM967i2OpTzvS7vzSFO7Z7U01h6EAg==
X-Received: by 2002:ac8:1289:: with SMTP id y9mr26464313qti.201.1570394071917;
        Sun, 06 Oct 2019 13:34:31 -0700 (PDT)
Received: from GBdebian.terracota.local ([177.103.155.130])
        by smtp.gmail.com with ESMTPSA id n125sm6690999qkn.129.2019.10.06.13.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 13:34:31 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
        nishkadg.linux@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        trivial@kernel.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH] staging: rtl8712: align block comments
Date:   Sun,  6 Oct 2019 17:34:20 -0300
Message-Id: <20191006203420.11202-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up warnings of "Block comments should align the * on each line"

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/rtl8712/recv_linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/recv_linux.c b/drivers/staging/rtl8712/recv_linux.c
index 84c4c8580f9a..70a4dcd4a1e5 100644
--- a/drivers/staging/rtl8712/recv_linux.c
+++ b/drivers/staging/rtl8712/recv_linux.c
@@ -115,8 +115,8 @@ void r8712_recv_indicatepkt(struct _adapter *adapter,
 	skb->protocol = eth_type_trans(skb, adapter->pnetdev);
 	netif_rx(skb);
 	recvframe->u.hdr.pkt = NULL; /* pointers to NULL before
-					* r8712_free_recvframe()
-					*/
+				      * r8712_free_recvframe()
+				      */
 	r8712_free_recvframe(recvframe, free_recv_queue);
 	return;
 _recv_indicatepkt_drop:
-- 
2.20.1

