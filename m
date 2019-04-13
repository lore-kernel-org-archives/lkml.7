Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B467C10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E0920850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCNp/nRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfDMB2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 21:28:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35359 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfDMB2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 21:28:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id w1so14141609wrp.2;
        Fri, 12 Apr 2019 18:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F2o/fDMsgAgKGVc4r+PwYVCFJ7SCy/olm+10o88uPXU=;
        b=PCNp/nRkjnK3fjMVkZhDIYMa1z1d3xH/E37fJTw332Df+PEnfml11gO7TvTlwLV5aT
         EOw5wXEj8dzoFRA0l0O6sVK9C8B3uFmTNrdgSHiSQ5Lty3G8rBlchbYpGebu+asQ491h
         USRZhwkvvWG2DSA+oOWYj3nudU9589dM0lk1nHn3dtn2ycEnXY8vctehUVlG3DS+sSKw
         zh03tCM0fJ4iZ0Yt2mm29VtYUykK2i9ExG5mSgwN2KHCA62IWnmQ5cn8KbGMOaGdGJKr
         Nexi6ebwg04T92tCtD/GahrXdE4NUzLNkVDPn/2fhbAYKX5JpZNOwmDbRYtesb03F7S2
         yOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F2o/fDMsgAgKGVc4r+PwYVCFJ7SCy/olm+10o88uPXU=;
        b=n21MCPkJBlz188uzZ4KxTAIJ6o30ACD4BqUHknyN1oleQOGv/O9IU+Aqii2eti2G+U
         qS4+iqm3YIcXstTOSzsq60mlalmL8XbjtiNvXw6spB+pfw5JcuS0S2BXuyBbq2EQPfJW
         xKq65qtorddC3KV8o6QWgB2wyNrXECQaCbc3tjbrztOqaCeHcgKhPoLC0JdCn4qNUvbr
         zRuT7FtkxFR93WiMArh6Q9viGnBvAjxS40P3p319YRFGHckW+CJU8dVsYXevR/g8tiW+
         6ZGEq108w7H0HHdKhmOQlAZuyW/KcmcXxG31VrU68c2zQWRy/8iLKrx7oBjr5Sw1BEQp
         wGCA==
X-Gm-Message-State: APjAAAVxVJsFckTxcop3SdYL2y2k1/b7H46yhZOTrMW8a5skKKBTm7KH
        HmyJDaxHlD/mH38xlwTAa/w=
X-Google-Smtp-Source: APXvYqylHKFF/u77DeFzT4R8ugz7ISuUUwYdupld+eZrta60gX/XFijUjsSJsb0W2+ezCmNmoZHC4A==
X-Received: by 2002:adf:828f:: with SMTP id 15mr36872288wrc.17.1555118917044;
        Fri, 12 Apr 2019 18:28:37 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id r9sm8053141wmh.38.2019.04.12.18.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 18:28:36 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v3 net-next 06/24] net: dsa: Call driver's setup callback after setting up its switchdev notifier
Date:   Sat, 13 Apr 2019 04:28:04 +0300
Message-Id: <20190413012822.30931-7-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190413012822.30931-1-olteanv@gmail.com>
References: <20190413012822.30931-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the driver to perform some manipulations of its own during
setup, using generic switchdev calls. Having the notifiers registered at
setup time is important because otherwise any switchdev transaction
emitted during this time would be ignored (dispatched to an empty call
chain).

One current usage scenario is for the driver to request DSA to set up
802.1Q based switch tagging for its ports.

There is no danger for the driver setup code to start racing now with
switchdev events emitted from the network stack (such as bridge core)
even if the notifier is registered earlier. This is because the network
stack needs a net_device as a vehicle to perform switchdev operations,
and the slave net_devices are registered later than the core driver
setup anyway (ds->ops->setup in dsa_switch_setup vs dsa_port_setup).

Luckily DSA doesn't need a net_device to carry out switchdev callbacks,
and therefore drivers shouldn't assume either that net_devices are
available at the time their switchdev callbacks get invoked.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v3:
None.

Changes in v2:
More verbiage in commit message.

 net/dsa/dsa2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index d122f1bcdab2..17817c1a7fbd 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -369,14 +369,14 @@ static int dsa_switch_setup(struct dsa_switch *ds)
 	if (err)
 		return err;
 
-	err = ds->ops->setup(ds);
-	if (err < 0)
-		return err;
-
 	err = dsa_switch_register_notifier(ds);
 	if (err)
 		return err;
 
+	err = ds->ops->setup(ds);
+	if (err < 0)
+		return err;
+
 	if (!ds->slave_mii_bus && ds->ops->phy_read) {
 		ds->slave_mii_bus = devm_mdiobus_alloc(ds->dev);
 		if (!ds->slave_mii_bus)
-- 
2.17.1

