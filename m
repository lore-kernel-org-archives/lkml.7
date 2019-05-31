Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3F2C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738AA2650B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="2AtMxCgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfEaHfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 03:35:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37228 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaHfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 03:35:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id h1so5786116wro.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 00:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=s1a3ffK83MdLiV09gJmbZprosRcZAkmT+m5DPcFIxLc=;
        b=2AtMxCgTOMoBq7V9O7ebISL00QYFiROr5UX+WTKR05o5v0dVhtwpjUbP0ywuufRSCM
         wDJrYJeUH9R+b+Jdvioau1ENioD6Qribz6U8CFcxipGne2CTrxV7FayE/+IjMGzbs7SX
         hat2IjnZnc9/hU12Tz3ql2SJJ4CmSrTRqwc2Ywi1FDgNePgDQuCg/1TpHAB8T9FW1XkQ
         BZ74F01wprRlXAXSZRb926n11MZcEKM3+M7QFr1h61RYzqu4crdrThXgG8xILJTnynpq
         nlTSIfG/d7CdNzdl43AjcOOQJId5ugbuwo9Z/vckY4v1NUuqJxSv9gbzAaB5JEEJxXBV
         pypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s1a3ffK83MdLiV09gJmbZprosRcZAkmT+m5DPcFIxLc=;
        b=NBpc2ur7wlWXEmBd17TMo55c450k8ftlrVZ8bU67XJ8f4u5w+gQV9zwQZ725Hdnin/
         CxneHXCPCOMFSmVBmnTkW4SS8yYdClT7QWkx42SoEL5uvpgHe5ayMFHZBCXXxX8Vyijr
         hTx/yphTGtB4gy0VYO0Ew/kEqsmFozuOjLly9M+mxEKxpXxcMdBzkDdkFl0w0/2ZPF+4
         2o7fSq3ZwLmsvQ5OhRbmAgdGChfFnKcVx4kIAETEBnm+76crHTcU6PGZF62+JHeYeYmh
         42vig32ZPIL0ylWs6TI+UA2lbpfnnnZFXgkUal0Mg+ECfvE44/9bSErxC78MEmD67w/i
         5JdA==
X-Gm-Message-State: APjAAAVbZTOcd0Vkk78Th6/KXu3B0/+mxuWY9XB9IdUh/jkOFKMZZyaP
        dCcsD45jqTSpTxwCHGH3oTKLNnDbBsc=
X-Google-Smtp-Source: APXvYqzW5W/cGqo1lduxfmk0mQcqRPMhScqJjyMum6NFeXqwzHHcOB9UUS6QS5cuQrryl5bXKzjy7Q==
X-Received: by 2002:adf:dc04:: with SMTP id t4mr5714889wri.126.1559288121099;
        Fri, 31 May 2019 00:35:21 -0700 (PDT)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id g5sm6021418wrp.29.2019.05.31.00.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 00:35:20 -0700 (PDT)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] net: dsa: mv88e6xxx: avoid error message on remove from VLAN 0
Date:   Fri, 31 May 2019 10:35:14 +0300
Message-Id: <20190531073514.2171-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When non-bridged, non-vlan'ed mv88e6xxx port is moving down, error
message is logged:

failed to kill vid 0081/0 for device eth_cu_1000_4

This is caused by call from __vlan_vid_del() with vin set to zero, over
call chain this results into _mv88e6xxx_port_vlan_del() called with
vid=0, and mv88e6xxx_vtu_get() called from there returns -EINVAL.

On symmetric path moving port up, call goes through
mv88e6xxx_port_vlan_prepare() that calls mv88e6xxx_port_check_hw_vlan()
that returns -EOPNOTSUPP for zero vid.

This patch changes mv88e6xxx_vtu_get() to also return -EOPNOTSUPP for
zero vid, then this error code is explicitly cleared in
dsa_slave_vlan_rx_kill_vid() and error message is no longer logged.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 28414db979b0..6b77fde5f0e4 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1392,7 +1392,7 @@ static int mv88e6xxx_vtu_get(struct mv88e6xxx_chip *chip, u16 vid,
 	int err;
 
 	if (!vid)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	entry->vid = vid - 1;
 	entry->valid = false;
-- 
2.11.0

