Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C85C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6081B206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="AnUX+Txr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfCKHZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:25:25 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:51158 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfCKHZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 03:25:25 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 079839CD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:25:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KfpiXfR7ko-c for <linux-kernel@vger.kernel.org>;
        Mon, 11 Mar 2019 02:25:23 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id CF1959BB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 02:25:23 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id x9so4287120ite.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 00:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=V1yPZ5O5Ka3zAp6GBcGsu4rU8aLAHLAkjYh3VEHgCbs=;
        b=AnUX+TxrvZIpbmJystXg/7g9iKPf1o1eD6pSveUv0jET/6br/ikNcDsfWxCelhpGbx
         /SOrVrxbFkDWPxmTqFSoCqsSOc6W7o9icLfX1lZ/q4I4gBIUCK1wPrMYJaKC4kjpzuwR
         2bxG127+R2ZHCVdeiBPMQD5hfV7AVNpU62WfJjWQLumJdWtnbJ2OmGDvv0BDujsELRFs
         HRWwc6iqTdSqfiIXZJEZU5sBggJU3KniQlgOxaXEP2gqWHhHbHIuKfx5THV/VzPkp3iG
         YV5VxGF7vIAyly3VkEC/Bl6CCjvNiGWWzuCHCqnXcb16BqjTGI2brUn+vnW4JP+npTRw
         LoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V1yPZ5O5Ka3zAp6GBcGsu4rU8aLAHLAkjYh3VEHgCbs=;
        b=SJo1RA+vs3SFoVUNFpdMwZVWnefvTkCj77GOB671f6ssg/Bq2gNFvj/9P89zgSpOsM
         OTVNTKUxfSCYo7seAn+lTUpIj02SJ2ZUFvywr8EVozK+VUYI9wj16eBZnG5alPw9Lf7Y
         AjO6z6RMemX/b0sUUeMoEfVJiN0bWLw0vdkcFuZl9y9EgTaMHubKz6MbZpAzJ1I1K4P2
         qHiZ/HC19LglAv5+2fuqJ68RKhliDWE7coNasHC9PC2tD3BrNUxOWRmtaiwcAwLASzVO
         V9BnGwhrXVKlT7pHgJvCrXF1Ma50YOG1YaGqMlrnZqNb95gXj63DRlEEpfZM0u0FQVaB
         6K7Q==
X-Gm-Message-State: APjAAAUDg7XLQKtNwzBA0F0aOvbr5KkeHbjwJMKbYi6DXIC6S8EPNHqH
        w3VkpG9oxgUmkl8U916ip0HgPQboFt8yf7SX2q6eJD40XauxMAbgDefOfzpBa0D3toUkdEabaBf
        D6qdTzylMfwbZWcMA/rc7DEhgNvz2
X-Received: by 2002:a24:45e3:: with SMTP id c96mr14086762itd.89.1552289123188;
        Mon, 11 Mar 2019 00:25:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyYxB4ZFgw+YmFqKXxGAK0Yt4KlsntDtu3GzJlOJw5ThV/JA4EC4mK1YOQexw2btEyOfLqGFA==
X-Received: by 2002:a24:45e3:: with SMTP id c96mr14086752itd.89.1552289122934;
        Mon, 11 Mar 2019 00:25:22 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id y26sm1966486iob.16.2019.03.11.00.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 00:25:22 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Michael Hennerich <michael.hennerich@analog.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: ieee802154: fix a potential NULL pointer dereference
Date:   Mon, 11 Mar 2019 02:25:17 -0500
Message-Id: <20190311072517.29740-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case alloc_ordered_workqueue fails, the fix releases
sources and returns -ENOMEM to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ieee802154/adf7242.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index cd1d8faccca5..cd6b95e673a5 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -1268,6 +1268,10 @@ static int adf7242_probe(struct spi_device *spi)
 	INIT_DELAYED_WORK(&lp->work, adf7242_rx_cal_work);
 	lp->wqueue = alloc_ordered_workqueue(dev_name(&spi->dev),
 					     WQ_MEM_RECLAIM);
+	if (unlikely(!lp->wqueue)) {
+		ret = -ENOMEM;
+		goto err_hw_init;
+	}
 
 	ret = adf7242_hw_init(lp);
 	if (ret)
-- 
2.17.1

