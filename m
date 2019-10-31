Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE96CA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 02:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B8320862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 02:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZaA7iSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfJaCJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 22:09:55 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33595 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfJaCJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 22:09:44 -0400
Received: by mail-qt1-f196.google.com with SMTP id y39so6419453qty.0;
        Wed, 30 Oct 2019 19:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YI44zesxZRhYNZfnCnbeDYU2hmCekT4dtXSOSwje0n0=;
        b=mZaA7iSbfheBiMmDBzz/dAyHv090K3ORpbbJUqXUxFIQMaDA9ziRVeihCsffN5uN2c
         yHUa215WqubXjXjyjNbPrF+jxLelqU9S9iGT3b0OQ0eKAJBuBVEyC9nR/pdhZGC2BpAq
         VZVLe8j2gQIDwCLkXnIu+jNBlAjjixTcBgGbzOlLgKH3KMejTEBn3LHIsiYW38lKuxJ1
         HoX/pJSQ761SavJjmWXAbIQKxmCo7zoKVsGc3v4nhVJZTG0zGDuYdzWqrcpuBh3DbhAk
         PULQS/pRu7mehEetSBCLczuLQItfQ+z7U5N3sI0CEZEwj6OaXuyhy13H4dDOXsihcljT
         K4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YI44zesxZRhYNZfnCnbeDYU2hmCekT4dtXSOSwje0n0=;
        b=t97dP2gAMpLZLWImrMxiHuFnLdItc/Zssa12Er0yUaSuWLdPZFpXNiOgkLGSPB7pKp
         aoMHZUvWiB6NAWRnTUxynvTIdeA0YOMsmdlEFJ8lFUvdwaya7sFIJbwO2XEvMFQt3IeI
         cS7qk0WHqtz4NF8mCDOZeb1fNLML6VVcHrSruMhCXaZs8UTAKD7WBIqdfVQFpL0xbyZy
         Fe6yZwze57r3UcIRXJNg/W5XPN3SbfLQoKYs7XJpUNyY97yG2jFNZj0qOH8p3Qg181vi
         NZXGUrVcdtwxz2dRHZjLHgLD49B9O/hykbwC1GGYPd2SvYM2MF5ShlNs0jCJqNTmq5RZ
         TyHw==
X-Gm-Message-State: APjAAAWFMjv46eiMsuoOyDF84dZhSMaEkJnQ1H10k/8oZ3gJape4JRBL
        x5MF/bYe8eg0G/OBtXS8ayDs2Gw7
X-Google-Smtp-Source: APXvYqw8gxd7DwHvMaFfMJLEzKmpohmsN8WHtnuXn7LWZ+JTs953Y/Q+Qbdyw6Hkw142LshV7gg4Dw==
X-Received: by 2002:ac8:2430:: with SMTP id c45mr3298643qtc.328.1572487782440;
        Wed, 30 Oct 2019 19:09:42 -0700 (PDT)
Received: from localhost (modemcable249.105-163-184.mc.videotron.ca. [184.163.105.249])
        by smtp.gmail.com with ESMTPSA id q204sm1328006qke.39.2019.10.30.19.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 19:09:41 -0700 (PDT)
From:   Vivien Didelot <vivien.didelot@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: [PATCH net-next v2 6/7] net: dsa: remove limitation of switch index value
Date:   Wed, 30 Oct 2019 22:09:18 -0400
Message-Id: <20191031020919.139872-7-vivien.didelot@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031020919.139872-1-vivien.didelot@gmail.com>
References: <20191031020919.139872-1-vivien.didelot@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because there is no static array describing the links between switches
anymore, we have no reason to force a limitation of the index value
set by the device tree.

Signed-off-by: Vivien Didelot <vivien.didelot@gmail.com>
---
 net/dsa/dsa2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index 371f15042dad..ff2fa3950c62 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -711,8 +711,6 @@ static int dsa_switch_parse_member_of(struct dsa_switch *ds,
 		return sz;
 
 	ds->index = m[1];
-	if (ds->index >= DSA_MAX_SWITCHES)
-		return -EINVAL;
 
 	ds->dst = dsa_tree_touch(m[0]);
 	if (!ds->dst)
-- 
2.23.0

