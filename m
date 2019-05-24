Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F392EC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB152081C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoRLoquI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388807AbfEXFxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 01:53:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45739 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387622AbfEXFxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 01:53:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id i21so4404226pgi.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 22:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9+4//n5ozpFc0YQBRlOwfVoh3tI6iGzki/F622gvN9Q=;
        b=OoRLoquIDETzGrPfniuEHRUVrwnvvyLKriTpztzO/2ae84pkh06qfBB1dt5GyS+R5B
         p2YQb5nsvqHpkNGtsOtN8zeXb5IfB0/fC4NOk1V55hXPa4aNANE7Li/Nw3bahGnEeJ3d
         D1IrNwHjfXZ6k5ZoyYwhREnTafe6A2aXOwEyyS0CBfsbqdcyWpwdZOWU9AKEdp3cxNLG
         OsAL1C6EqbSAn62VfMmeNm1fWywPuE2x72OdwD1pF8QCggnhmqarT/HPLFU/VPP6i/Bt
         P0PJmCsYqKX3DlkjssJqHbwZq0+xhk3XkwBzJswj4oUpNEmVczj+l61/jFSSuPB7/Guq
         BYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9+4//n5ozpFc0YQBRlOwfVoh3tI6iGzki/F622gvN9Q=;
        b=NWSsbEeFfvMHIHsOOP2f7BfuPFqdCgJgpesTxNkqPpLGHkdh8v4/E1g6dfsGBbq/WV
         SP3EIj0ADfgmK5tH9thS1b1tG5I7/ziLf0WbvYiScRe3WITfnZa0l6iJ9Pf0LEGd3e3i
         TPunTTORHizETZNS3flFibXBlgNLFrmQLxKR5++obEzXr8loFQE/qhth5ZfunDmIcgz9
         ERtR0xbCcLn1KWG9nMgBYNaGn8HYg9JnWzce4Jgs9vq5n9HHL30FbI3HvyLGGGbGmJNq
         SBCW4plCLLZjhJYUxAkqzizPVTkiGml5ULfAL3Y3BJBAJBiZGA3wlCgCaD7rWo+/Olu5
         g+5Q==
X-Gm-Message-State: APjAAAVc5GfJwg4V6cHyZiZWZCOGggr2b6rDibOTfiAKTRYHKG96CMNK
        Myh5oa4GV4hP9aIJK079Dl4=
X-Google-Smtp-Source: APXvYqyUzwLCAYS1GKGkc1+R9nYGizTKYhIWvIweZOqx3t7ims/KVtLGmUYXlhkkWcdJJWA7p81mlg==
X-Received: by 2002:a62:e803:: with SMTP id c3mr63391468pfi.58.1558677183225;
        Thu, 23 May 2019 22:53:03 -0700 (PDT)
Received: from localhost.localdomain ([110.225.17.212])
        by smtp.gmail.com with ESMTPSA id o2sm1654771pgq.50.2019.05.23.22.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 22:53:02 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, colin.king@canonical.com,
        herbert@gondor.apana.org.au, qader.aymen@gmail.com,
        sergio.paracuellos@gmail.com, bhanusreemahesh@gmail.com,
        mattmccoy110@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: ks7010: Remove initialisation
Date:   Fri, 24 May 2019 11:22:38 +0530
Message-Id: <20190524055238.3581-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial value of return variable ret is never used, so it can be
removed.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index e089366ed02a..3775fd4b89ae 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1067,7 +1067,7 @@ int hostif_data_request(struct ks_wlan_private *priv, struct sk_buff *skb)
 	unsigned int length = 0;
 	struct hostif_data_request *pp;
 	unsigned char *p;
-	int result = 0;
+	int result;
 	unsigned short eth_proto;
 	struct ether_hdr *eth_hdr;
 	unsigned short keyinfo = 0;
-- 
2.19.1

