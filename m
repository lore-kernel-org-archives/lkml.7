Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA5DC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 16:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9456020675
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 16:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="z7tRA1gT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbfDTQn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 12:43:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35572 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbfDTQn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 12:43:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so9610788wmd.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 09:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=9LWAQ+Zu3TBr75Ddka1nuc2K7DFM7icth7zvA3s4epg=;
        b=z7tRA1gTVEASzMv3A3+abL18OvE90UzKIf8dutZggb6HdFiauqCmaR7896c01zQerl
         DhyrLR/o4puGzvB0MKcaRlhjgflARQXm13gDbE+lXORt6Jv+D2LSmv9TthmoFVA0Be7Z
         bOYLrNPKeQmGnllrviFdHKcKeP1/Ap690H4J+bWpI+OZPIh8F0cztMuXNvFvlvwIKM/n
         pvYIT6//MJAqvb0QI0oX0RSw0VVeBAjNfJpL4j79okEX9U2EQbpJuoNlNwdmhwbR9qup
         RNrEqyK3Dc7MSvQ5yRodyNbCD+77Up0d5N8HwP8R5u8cilPzNF+iS/b/SIhmnpMOMh+z
         STYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9LWAQ+Zu3TBr75Ddka1nuc2K7DFM7icth7zvA3s4epg=;
        b=BbWZYl9suVnUa2SYWLF8pWeysH7AEcCyyGQq+AXRaYdsRVW6xx+dg2GbfJH20h7vgI
         XyT7si4CD5yLDW3UuqTmPxhHiSfckNGf75PQ0jjFv/JqCLroPikC8J4UKrP397qd5Dn+
         WIQfUN8f/AAYmgkkicpcVYa/7hujSWvzGIJRwlEEgKEtO+1WdEOehcLpMj7Ab8zYhsSq
         UszMgzI92nIYPnJ1YK2gkJWQ5pZdZ6fzoZFqlyXNuA9Sj5mXuhNHwMSTnNWLTj66GcwF
         Tjn0P8garJX41cNuENLTG6AQlVBBETuaLH2Rl67yDg0liBPThvACN0FcnJsQEat1c2Rq
         780A==
X-Gm-Message-State: APjAAAVLlwOKmXhJ8bPU++pOpiwfz6XvPrO7nuu0JDU5p5FoTpEbPRpR
        3NpnWMvDg0geS/tHY3mQrQNmmw==
X-Google-Smtp-Source: APXvYqxO8ATvtr0njmSqfvUIG7PgktWSHLqt1c/tDNSpejR1/7c2ky68LpBNRiQzILvDGF1Hn9nFIA==
X-Received: by 2002:a1c:ef08:: with SMTP id n8mr6624586wmh.85.1555778605552;
        Sat, 20 Apr 2019 09:43:25 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id 17sm6063283wmk.39.2019.04.20.09.43.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 20 Apr 2019 09:43:24 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     corbet@lwn.net, davem@davemloft.net, tgraf@suug.ch
Cc:     linux-decnet-user@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] Documentation: decnet: remove reference to CONFIG_DECNET_ROUTE_FWMARK
Date:   Sat, 20 Apr 2019 16:43:01 +0000
Message-Id: <1555778581-21468-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DECNET_ROUTE_FWMARK was removed in commit 47dcf0cb1005 ("[NET]: Rethink mark field in struct flowi")
Since nothing replace it (and nothindg need to replace it, simply remove
it from documentation.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/networking/decnet.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/networking/decnet.txt b/Documentation/networking/decnet.txt
index e12a4900cf72..d192f8b9948b 100644
--- a/Documentation/networking/decnet.txt
+++ b/Documentation/networking/decnet.txt
@@ -22,8 +22,6 @@ you'll need the following options as well...
     CONFIG_DECNET_ROUTER (to be able to add/delete routes)
     CONFIG_NETFILTER (will be required for the DECnet routing daemon)
 
-    CONFIG_DECNET_ROUTE_FWMARK is optional
-
 Don't turn on SIOCGIFCONF support for DECnet unless you are really sure
 that you need it, in general you won't and it can cause ifconfig to
 malfunction.
-- 
2.21.0

