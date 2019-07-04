Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195E1C5B578
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CB62189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bl9EX14h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfGDC7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 22:59:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36251 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfGDC7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 22:59:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id c13so2182388pgg.3;
        Wed, 03 Jul 2019 19:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cdGNxnCG0dRMJ1+NSl9LIvswxDirWPGLvHhxjBvgLBg=;
        b=Bl9EX14hsyMh1TbRFVAEiPY0YsMGwRNJWb2jOLCWtq7VYUpc+Ql3X+vnTdwsTE1Mjj
         Xw9R1qbJpqWcPybC7B/4RG5+d59sPyJCOZzCCxjhSDSApD/n6IPglHdt/fcT9ydtbEVg
         ffSFi0Jj5aV7aIMjHpL1sAI1iE84I/CbvJSfZpn6rDAaWruQmzghG4LzCpXVd3PORL2Z
         pNF0Sczh2Zjp5O8TRn+d/rAsHF/+bfpymK9A0HdTgKJoYO/lm5t/iebFplNiir/Rx5g9
         7Z2JrMpPys+PhYLJ2Kky+19jH1ijK+GvCEP5DXD35+lJDXF/M2G6/4p2QTqoI09W2hXb
         9AkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cdGNxnCG0dRMJ1+NSl9LIvswxDirWPGLvHhxjBvgLBg=;
        b=IKZuZeCvr39NJOK62Bu748wVj6nlM9BXRf5IDzbhzcZImxheDjiLBOy+Dt1iXcFU0f
         VlVo9JXfnfg2XhulwyAGqVOBHLqKAr6nyEFQcy0sF1RIZak9+YMnENsY6b0w5yTr0AQf
         l47vE/vNFa+2JrGI3JMIPHfe83GpbqkJqrAm/zDOtc8JN6SsDN0GGYaNp8sSrLM7xDZY
         rxJIqx9Jb+js101TxEicU7aXzJ+AewevhS7KfG8nTtq6mVTOAe3zDOlkHPvUM2ZKgcsw
         m95flLL+xQKEkNk2mR37px6oebq3OmV0f4CyGM4IzctbL1h+T3b71ulj0R71BaOFtO5b
         fYog==
X-Gm-Message-State: APjAAAXLxKGTIj5miWSKjwUBEM7yQbaJA6eCT88fHKWFrPOTy0L413yE
        Mp6wwfoVo8aUkJWIe0nSRCo=
X-Google-Smtp-Source: APXvYqwY4iu+EFJOXIvAaE4uZFsF5WtzhQD09WQtvm68YZFKudL5xQwT7dxwcZl7ElVVmQ6BOF4glQ==
X-Received: by 2002:a17:90b:d82:: with SMTP id bg2mr16831319pjb.87.1562209153111;
        Wed, 03 Jul 2019 19:59:13 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id i36sm3472199pgl.70.2019.07.03.19.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 19:59:12 -0700 (PDT)
Date:   Thu, 4 Jul 2019 08:29:06 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: ethernet: allwinner: Remove unneeded memset
Message-ID: <20190704025906.GA20005@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded memset as alloc_etherdev is using kvzalloc which uses
__GFP_ZERO flag

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/net/ethernet/allwinner/sun4i-emac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
index 9e06dff..6253e5e 100644
--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -818,7 +818,6 @@ static int emac_probe(struct platform_device *pdev)
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 
 	db = netdev_priv(ndev);
-	memset(db, 0, sizeof(*db));
 
 	db->dev = &pdev->dev;
 	db->ndev = ndev;
-- 
2.7.4

