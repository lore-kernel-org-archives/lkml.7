Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AE7C4360D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 22:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B7F20673
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 22:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRgnktXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfIYWKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 18:10:20 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44090 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbfIYWKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 18:10:20 -0400
Received: by mail-io1-f67.google.com with SMTP id j4so954776iog.11;
        Wed, 25 Sep 2019 15:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O0oSKhXEOzcFKjIBbLlMltGKt1P3oZHAsL4yEuhL7wA=;
        b=XRgnktXh+11PNGpyISrs+IVtdJnkKTtOPaDxUCJNdaLB9LEVgJ2Z5AyhKg+go7pqTj
         Djhi4R+afAv+OOE0dR6LXgvYFwrYfurYDD4wStjOBcqhkd11b+SkHow8OyxUSCPjgBCb
         lq8nkYcn49Jy6UEBRDBO+5s6LqmGGU802zAuVAH6zmGz8fOPWdDeu1rqs7MsaQ/V3B3s
         yq5d2sY7H5eekfgzEtN4niRLbLYgj08nONboPeQ2FuuRyIHwlJ8ojgzkIEQoJPbZTYJH
         rzsXKt2PBl5tf23F8YVHIlPTMuGOCC4DVTojNQQzQxFya6MNaR6rDr6VqP0L3agM/XFT
         m5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O0oSKhXEOzcFKjIBbLlMltGKt1P3oZHAsL4yEuhL7wA=;
        b=eIs5EvdSfD0es0QAGNz2GGNdaoCYYr+7t4PV1WU9e0SEeBq84c1Ny7zYcvR60o+vvv
         zdV/jUrDvAyM7VgJihX3OeFNHOHn/O1cdZB+06INYeWHLTJ/hRy+E7M18CrWfBls20Ze
         A4B9drxcqcfAY6iynAWQohljdvLK4FjU4XFxHeyLCiwWdPchFBeQ0JT/QeIrZ2qbos36
         fZSULq3bF0mS3H6++7ODCuHXC/OSg1bg4AKo9djGNvBTx6IF7VZeYEBzhjsY46oODQ8X
         U/z1bNLaS/hmIo8f18RMjsKWtNxptqbdDYabunn5JKv0Vk/fUclqdIq/ByhpJmdY8Wo5
         bAVA==
X-Gm-Message-State: APjAAAV4AAWZiot73Z+CAdZCjWF9gvZzT6Szm3L0oWi1a256AP91JgiX
        4HEIkRsp56gnx0y0YheYFew=
X-Google-Smtp-Source: APXvYqySrKwE7cmfckFerADDb8snKLOdGcDCCwiOFB8XYIPL/o6gqCx5rXBJqY7/wY/i3GBjpA6nxw==
X-Received: by 2002:a5e:c241:: with SMTP id w1mr270445iop.36.1569449419584;
        Wed, 25 Sep 2019 15:10:19 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id q17sm58357ile.5.2019.09.25.15.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 15:10:19 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] genetlink: prevent memory leak in netlbl_unlabel_defconf
Date:   Wed, 25 Sep 2019 17:10:08 -0500
Message-Id: <20190925221009.15523-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In netlbl_unlabel_defconf if netlbl_domhsh_add_default fails the
allocated entry should be released.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 net/netlabel/netlabel_unlabeled.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index d2e4ab8d1cb1..c63ec480ee4e 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -1541,8 +1541,10 @@ int __init netlbl_unlabel_defconf(void)
 	entry->family = AF_UNSPEC;
 	entry->def.type = NETLBL_NLTYPE_UNLABELED;
 	ret_val = netlbl_domhsh_add_default(entry, &audit_info);
-	if (ret_val != 0)
+	if (ret_val != 0) {
+		kfree(entry);
 		return ret_val;
+	}
 
 	netlbl_unlabel_acceptflg_set(1, &audit_info);
 
-- 
2.17.1

