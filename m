Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB4CC28CC5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 21:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F9825599
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 21:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRiwCirB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfFBVkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 17:40:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45250 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfFBVkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 17:40:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id b18so9962169wrq.12;
        Sun, 02 Jun 2019 14:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t1FrpxBOR0hUwhQ+f2ACkGv/sQawiqLGs8UWQzTbErI=;
        b=KRiwCirBYCrXsnlEY7grw7RSbJsI5mGA/hoMgaGT9Ve2lNqpn8MeVd3/omNgefaNpD
         69Xg6MPMuDaZEXnWlecT4qb/KdbiydrSYh2UlZI73dy7+4Ha608ZwRvJEMcrakcaTEsR
         EOeeoHsOpBUuK6q3OZzAb3LyPNZ9fF60+hBH4f4f7ajdM2cVMf+GnS0dbvjhR7CTmoAs
         O6RI9UdJ6g8Z8K5POXcPPBzLrFgpxDeF8dhQC+O4GkvB6o//FXyRnPYHG3e9VU8dXxEM
         XEAD6Ux5amy8y0bfSMZinxy42ooy0eqv4v0pOReIeQoMkJTWpACmvTW9fPTyBsDfQzQU
         sZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t1FrpxBOR0hUwhQ+f2ACkGv/sQawiqLGs8UWQzTbErI=;
        b=W8UEvb6gP1vRVri9Dbg7QEqdFz+FiQSP6SUvG+X/grJnTo9AiNViv2kwduDO6U0Tmi
         itBmG164nsw+TttU03hljmB5zb5LY6h/SNbzLTqMbux/ijl8OhbhSna8/8lCCphWVgY5
         MatGquayH1AGTQy2DLHMkcn+zwBU4Dt0QgkKet+5i4beC8sMBXyAFVFdVCdQBbo2lK4g
         yyExGk0hqzfDetXPZ9ty/r/WWMuQLCtiVxXL6zJYvjeov920+ggUu+UclPphMIe9qweK
         uRaCoPsNN4/KuiZHNe/JGgkoMJJ0QCa4PrFp0rsQezqnQgSX4TicFoaWpJoazf/QKwQj
         Mlbg==
X-Gm-Message-State: APjAAAWDMYR2NRwIwOmOD+2rxuNHZXIRG/2bXWznD4KwSAjJF1D2/XzV
        cID3nD444PsBBcdNpOd3yow=
X-Google-Smtp-Source: APXvYqzR90/gTab9u1qSxOC4MyHX/v/hax0ruw9lY4GfRXQ0rJWUkHspB9xe5/c384fjA72lB1iJXw==
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr81537wrn.31.1559511602933;
        Sun, 02 Jun 2019 14:40:02 -0700 (PDT)
Received: from localhost.localdomain ([86.121.27.188])
        by smtp.gmail.com with ESMTPSA id 65sm26486793wro.85.2019.06.02.14.40.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 14:40:02 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net, richardcochran@gmail.com,
        john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 net-next 02/10] net: dsa: Add teardown callback for drivers
Date:   Mon,  3 Jun 2019 00:39:18 +0300
Message-Id: <20190602213926.2290-3-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190602213926.2290-1-olteanv@gmail.com>
References: <20190602213926.2290-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is helpful for e.g. draining per-driver (not per-port) tagger
queues.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
Changes in v2:

Patch is new.

 include/net/dsa.h | 1 +
 net/dsa/dsa2.c    | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index a7f36219904f..4033e0677be4 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -361,6 +361,7 @@ struct dsa_switch_ops {
 						  int port);
 
 	int	(*setup)(struct dsa_switch *ds);
+	void	(*teardown)(struct dsa_switch *ds);
 	u32	(*get_phy_flags)(struct dsa_switch *ds, int port);
 
 	/*
diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index b70befe8a3c8..5bd3e9a4c709 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -407,6 +407,9 @@ static int dsa_switch_setup(struct dsa_switch *ds)
 
 static void dsa_switch_teardown(struct dsa_switch *ds)
 {
+	if (ds->ops->teardown)
+		ds->ops->teardown(ds);
+
 	if (ds->slave_mii_bus && ds->ops->phy_read)
 		mdiobus_unregister(ds->slave_mii_bus);
 
-- 
2.17.1

