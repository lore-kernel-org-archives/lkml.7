Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5B9C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D93C20870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="li8rydRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731411AbfCaRm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:42:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44142 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731237AbfCaRmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:42:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id y7so8847137wrn.11;
        Sun, 31 Mar 2019 10:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uB5kgl1loxer1OZEb7/acsvj4cgOwpRLPzVuXyhBpl4=;
        b=li8rydRz5l5TzVBvqb3XaxSK8lHFVt/oaxnkXj8LnjBecCoLffb9ukmAuAypQtN5XO
         EGea0OVCJX/vJwnH9TfHslK9JbUgayWtch9R9NmHlWFEJ5cSTzYIUOJZ31KM/nZqmwWn
         XNrn6VhR379TjM94Tk/q9/Wo0Vr+/IHO6FsiUeylfQUSo7gDpFfWtLyk+aOG1iTEVQsO
         LqZSeu9tyitdNzTR4TsN8GRlNefu/qPHAsugoyVJB6LrlFgSN0iYAl4CN1bStln25mYK
         GEOWK+HcNrqxaOuCitQWmj3B+7OxuMGAMAU7L3t8i6zqqe++RckuzaNyM0RoxPKOvp5F
         Svzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uB5kgl1loxer1OZEb7/acsvj4cgOwpRLPzVuXyhBpl4=;
        b=ouQbJYQ9WytuL0lSiy4R9hEk9za/LlVRejITHYiYrq1695qtxrtmgaggOEiKqZea58
         aOozq2IZ41TM8XMwuq3ym6t88HQVeeG3ffCf6v6VydpbHDrxCu7yWtwqkQV9JJA51El5
         x6uvmzQpuad9E/S6J58eu2lf6VGp2YJKmk8EKlEJSFIetlKJ+bPKhSRUG1Xx2VzzanmF
         agR1kABRlBtviW2dobsI6NZ9XycAU/vwxHaQR+9joBNIvoE7CGTFwLu7oOMyNUBZa4Al
         6LTPxCRMdfRrisN5bZ8GJyn2UUsCLboySnEQ92/eBVVrYb1YxYdOjHVmpjlPPm9I98Q0
         hIcw==
X-Gm-Message-State: APjAAAWeiU+r7XUtyxLOcgNPnV6LbRUAhnl+NjNbMiM3D82n6847vJ2E
        eqk9AUzPOx/sgz9NoSOaRl+A23+1iSGL3Q==
X-Google-Smtp-Source: APXvYqxkL1Yi8RcH1uGXRcegMvoWAhsBGnyj4GZwzDlJIVZuspWDKN5hZQlsO5gtLrJSMyVPDQtNlA==
X-Received: by 2002:a5d:4a87:: with SMTP id o7mr33709221wrq.306.1554054171987;
        Sun, 31 Mar 2019 10:42:51 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id v192sm10892354wme.24.2019.03.31.10.42.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:42:51 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, georg.waibel@sensor-technik.de,
        Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 02/17] net: dsa: Fix pharse -> phase typo
Date:   Sun, 31 Mar 2019 20:42:17 +0300
Message-Id: <20190331174232.22060-3-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190331174232.22060-1-olteanv@gmail.com>
References: <20190331174232.22060-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 net/dsa/switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/switch.c b/net/dsa/switch.c
index e1fae969aa73..fde4e9195709 100644
--- a/net/dsa/switch.c
+++ b/net/dsa/switch.c
@@ -196,7 +196,7 @@ static int dsa_port_vlan_check(struct dsa_switch *ds, int port,
 	if (!dp->bridge_dev)
 		return err;
 
-	/* dsa_slave_vlan_rx_{add,kill}_vid() cannot use the prepare pharse and
+	/* dsa_slave_vlan_rx_{add,kill}_vid() cannot use the prepare phase and
 	 * already checks whether there is an overlapping bridge VLAN entry
 	 * with the same VID, so here we only need to check that if we are
 	 * adding a bridge VLAN entry there is not an overlapping VLAN device
-- 
2.17.1

