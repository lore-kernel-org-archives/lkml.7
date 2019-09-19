Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E50C4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5787521929
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568895181;
	bh=VsflyVe/RWoN6qQ8WhPLCghpepbcvjVtYo4B1DA5oAs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=rHYAPsXMB71IdOEnN5DURmLT8A1uaxt8BPHJTU9CvHASfSS3oXqL0PzuurftwTFoG
	 5P9F++v6PTcJ6w/9GKgN1gV4ANCm5DyjoRc8VEuaalPD6u7o/M9Thoaq459i+Mquqy
	 r1/vlXJtzeKEWcY4HPCL/e0Sbl0z+1FLqBYeo3Rg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390200AbfISMNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 08:13:00 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44585 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388792AbfISMNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 08:13:00 -0400
Received: by mail-lf1-f65.google.com with SMTP id q11so2160228lfc.11;
        Thu, 19 Sep 2019 05:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AAGhvqwd75jlWoyN7RtLuLmQlBabVo3K+eJUc/Gzlw8=;
        b=I+fWSqLXskt+W9JCVUaVDdgxCjnHs9SngDhZ6ddtTpEHqRqALggs0Pzu9DGLeyUmlU
         s5SntY7fIS15FYNNcS7Bgu8ZuXvdbUE1C0isqFYgjIdHMvI52zPc5si6SWtWbUHvPKI0
         b0EXSvCx5+4/5aIMXUlky8wKD8nv3geoGMhf7Rn80LlcWTxVb8k/MBvu4ogIrQmTa1Bu
         RXvZRgQqaMzIlwFvA+fueRmaT3PU3dgwXup/5ot7kwAgPgVQ4xDRgMJw8sWgHsPrEdkd
         80Wbqpnjqske0K4nPjpA1l5wJdekIJV9rSXiSAbbXl6hJjXX+k/ZuhilCnnflRgBv2Tp
         dhCw==
X-Gm-Message-State: APjAAAUmCei2Y1na09s+VmqxpF5e9VLOhhYNyCng+upbeCL3Q/4uaBPK
        qTO3LCZFmWVgzivdkTgT4Lzgac3/
X-Google-Smtp-Source: APXvYqxkxMhx6AXLEzlWI2uF4kvz8bcFVDoGXg87MGyIpnW1DMdRhVl7Zz7XRH8wHiKEdibwpDoJ3Q==
X-Received: by 2002:a05:6512:251:: with SMTP id b17mr5172700lfo.35.1568895177514;
        Thu, 19 Sep 2019 05:12:57 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id x76sm1859097ljb.81.2019.09.19.05.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 05:12:56 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@xi.terra>)
        id 1iAvIu-0007yb-AS; Thu, 19 Sep 2019 14:12:57 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, andreyknvl@google.com,
        syzkaller-bugs@googlegroups.com, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        syzbot+f4509a9138a1472e7e80@syzkaller.appspotmail.com
Subject: [PATCH] ieee802154: atusb: fix use-after-free at disconnect
Date:   Thu, 19 Sep 2019 14:12:34 +0200
Message-Id: <20190919121234.30620-1-johan@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The disconnect callback was accessing the hardware-descriptor private
data after having having freed it.

Fixes: 7490b008d123 ("ieee802154: add support for atusb transceiver")
Cc: stable <stable@vger.kernel.org>     # 4.2
Cc: Alexander Aring <alex.aring@gmail.com>
Reported-by: syzbot+f4509a9138a1472e7e80@syzkaller.appspotmail.com
Signed-off-by: Johan Hovold <johan@kernel.org>
---

#syz test: https://github.com/google/kasan.git f0df5c1b

 drivers/net/ieee802154/atusb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index ceddb424f887..0dd0ba915ab9 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -1137,10 +1137,11 @@ static void atusb_disconnect(struct usb_interface *interface)
 
 	ieee802154_unregister_hw(atusb->hw);
 
+	usb_put_dev(atusb->usb_dev);
+
 	ieee802154_free_hw(atusb->hw);
 
 	usb_set_intfdata(interface, NULL);
-	usb_put_dev(atusb->usb_dev);
 
 	pr_debug("%s done\n", __func__);
 }
-- 
2.23.0

