Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C14C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D7C2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="g5WpoUbS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389138AbfKGN21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:28:27 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33063 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389004AbfKGN2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:28:03 -0500
Received: by mail-lj1-f194.google.com with SMTP id t5so2296411ljk.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E+91P1B4I9nUdKLz0FwOjZwRdttTAkpiPZ4BDPYb2xA=;
        b=g5WpoUbS7tBcQdvpARR9AGtrAIvtk6MXU53yoZ8VIwHDb1Ya/JtCWE1CNjVHPMPlav
         ltgeX4wpZTM5XFSYSZn1DAfKp8WCSoRDGSj1qcnA86GHrcU0GJQP4uVr18ptoVzAhY+5
         KwQb8Sw+D9Pu5VkMKBgfSFf2Iqluzs6RfNO5LNQuq/l1/Ttwxexb2mY4Mg5wWyYjE9wQ
         0XSY/Q7ikoNUCAr5aH3PGRGrluOQ5dHF+WNTEgLkDWY112pEjzJ1mrYRkCmI0jVLCGTl
         wD8YlD01Ep2FJQmBGBAr6Mh6f4t/TWfMr+2TZyBk5D9JCEbIQ5eAPEl8+PMGp9nbwh0i
         m5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E+91P1B4I9nUdKLz0FwOjZwRdttTAkpiPZ4BDPYb2xA=;
        b=ty1sZ+q4Rx1r2bKNiYIUIace7KJeWe7a5hw2nxQaBViHk9T4KHJWE3azHp3idrux2j
         Is9Phk/M7C9kc9Kar9uzDtFYHEdczf7V1kEoCXeyHTJA5cGLfbaMHlbvHfefyGdnIwnZ
         hEd0xjU4zhc+ujTDZfH6yl/hyxfNs7mV+KSogGGBDoPBBpkqzg8jQBYz0kLG22NJfQb3
         qZT4Po7ZkIQbTlYMw7LkhtoBWWU4HPwRUAZbzwmcQn2FWBT3aTIamaihNsLAHeXfqRq6
         n/8Xsn6CZNszVTmiF5znBg4/iSICJT0riybbfZbX3+CJHWhIGrUbYXn/h8JQdvVisMUr
         7pTQ==
X-Gm-Message-State: APjAAAVsgL3VI7wIOJo2IEA4tuDaBqMYL/nYzXKAUdtznDhPK2JnnpMi
        3g8YXwqZ3L1rDsSdBg3zl3xuUw==
X-Google-Smtp-Source: APXvYqwn+iQ3pVojvgDyvsr6gdQbHu0WY7g1yYKAvcNBdTRdeMj7qL3wttyDLkyFw+z/p7RjuNscIw==
X-Received: by 2002:a2e:8608:: with SMTP id a8mr2576547lji.172.1573133281587;
        Thu, 07 Nov 2019 05:28:01 -0800 (PST)
Received: from mimer.lan (h-137-65.A159.priv.bahnhof.se. [81.170.137.65])
        by smtp.gmail.com with ESMTPSA id y20sm3151507ljd.99.2019.11.07.05.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 05:28:00 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     nicolas.dichtel@6wind.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH v3 2/6] rtnetlink: skip namespace change if already effect
Date:   Thu,  7 Nov 2019 14:27:51 +0100
Message-Id: <20191107132755.8517-3-jonas@norrbonn.se>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191107132755.8517-1-jonas@norrbonn.se>
References: <20191107132755.8517-1-jonas@norrbonn.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTM_SETLINK uses IFA_TARGET_NETNSID both as a selector for the device to
act upon and as a selection of the namespace to move a device in the
current namespace to.  As such, one ends up in the code path for setting
the namespace every time one calls setlink on a device outside the
current namespace.  This has the unfortunate side effect of setting the
'modified' flag on the device for every pass, resulting in Netlink
notifications even when nothing was changed.

This patch just makes the namespace switch dependent upon the namespace
the device currently resides in.

Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 net/core/rtnetlink.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index aa3924c9813c..a21e7d47135b 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2394,11 +2394,15 @@ static int do_setlink(const struct sk_buff *skb,
 			goto errout;
 		}
 
-		err = dev_change_net_namespace(dev, net, ifname);
-		put_net(net);
-		if (err)
-			goto errout;
-		status |= DO_SETLINK_MODIFIED;
+		if (!net_eq(dev_net(dev), net)) {
+			err = dev_change_net_namespace(dev, net, ifname);
+			put_net(net);
+			if (err)
+				goto errout;
+			status |= DO_SETLINK_MODIFIED;
+		} else {
+			put_net(net);
+		}
 	}
 
 	if (tb[IFLA_MAP]) {
-- 
2.20.1

