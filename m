Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A12C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 01:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAE92075C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 01:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSwF2+Lr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfEDBSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 21:18:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33411 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfEDBSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 21:18:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id e28so9949444wra.0;
        Fri, 03 May 2019 18:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tHmbQEBxmUDjUBw4vJF51xJd9xZGVrC7H9l/slmei+4=;
        b=cSwF2+LrR+XqUOXvwzSjtPv5S1kFJUKtnCMqzIAjPN0znGxe3Vwq4HET5M2MJSSAv8
         FqUFK5bGhO1TaOT7r+sTHI7B7NT2ZhnHgKbFgdAovlpRHCVJuCIjo8WhN9PQkWRllqGC
         kc4tBlx5mRL4pg5xrqKfd1xkH5sm5pGrXlQzKCF6ppNxofUjax6odu0612pOxa+4v1S+
         he7roxQN3I3cIQWDy5F2L2HNfDpQ8YQ9JtJhg3WQgd5rrB7550Xf0098qXVrnwVRXb2i
         cl/gpoFxuA2YxI1Y6qmNBpH1Sdx9Q2OBvCONHa/B5Z/yClfcD9O9lkRf0kTaPx7O8uDB
         kxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tHmbQEBxmUDjUBw4vJF51xJd9xZGVrC7H9l/slmei+4=;
        b=gVMw7owJleyT3zvg4VgPLtiqF/w1pKi9OKG+hJ635vXDJ8nt+ZYBpLYsbigz8C75b6
         Acs44T9pAV8ot1CLJv/xt5tsl2s5TrLtcCV4LURNiHXeiHRdCzFp4mjJPrt+18dglHUG
         /8Rd1WANmV40qFkpKYk9Ed+rqH3xg6RDFnd+ToY5jyyzpDx0wHHCqy7KUViLBrCoaCX2
         UUb9EDVlc/kMN95hVrwV/aejH0ZZ1+sUz1kUkidFEJX4f7w0/t7KFQL4SqDQE1MO+aJL
         ydic2w2FDTOaafgjtFkuDuaLPH/16fDwXbb2Etk9KsUR6YFcymJ0BnjCTUUbfxR6AvYD
         GpGg==
X-Gm-Message-State: APjAAAXjvvcHGozdM6WKUpsyog/oYDgzJSa1RMaGDMehGKHrUuuAlcmh
        sin7eBchEWIj3/BbtIS+10ODRGue7DE=
X-Google-Smtp-Source: APXvYqz8nJX5LmH7U2oTaGMYxl5oVTjYXLA/pg+avz3nYvbXWp603XeUsnVcyzY6//hHeoaITxqehw==
X-Received: by 2002:adf:f309:: with SMTP id i9mr9010499wro.258.1556932719680;
        Fri, 03 May 2019 18:18:39 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id t1sm3937639wro.34.2019.05.03.18.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 18:18:39 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 1/9] net: dsa: Call driver's setup callback after setting up its switchdev notifier
Date:   Sat,  4 May 2019 04:18:18 +0300
Message-Id: <20190504011826.30477-2-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504011826.30477-1-olteanv@gmail.com>
References: <20190504011826.30477-1-olteanv@gmail.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 net/dsa/dsa2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index bbc9f56e89b9..f1ad80851616 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -371,14 +371,14 @@ static int dsa_switch_setup(struct dsa_switch *ds)
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

