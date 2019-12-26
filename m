Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E83EC2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 20:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B91120828
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 20:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wI6RHv+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfLZUpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 15:45:35 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:33472 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZUpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 15:45:34 -0500
Received: by mail-pj1-f74.google.com with SMTP id u91so4122515pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 12:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=U/F0Ny1cWR9vZvhJ3YyD2gGoI3HlhJe0r1qEnyZLWxo=;
        b=wI6RHv+mVRYhGm1FR8NrPKPneutZrzsof1fPLKZqZYxtqdukNtRH114M26za60wiKv
         frQ18CYqvXianRWhPCdApmjkJoLXMxPNl8utHPZhGBuHh9XlNbwUBzAOWmhmAX4KF7/w
         jusyuWrxUPgMMplG2g42wpPrNUSYRS7ob//eVX2BlwuwkJiXAVfKDYfT+IeeI4vi54eA
         EdeLgpvBdpRh94mctPK3GZdQb5Vwl15YfTsXo4ti6yFt0JzDk+88i0dzxoHnMyRdkHSz
         NM5m6b3e0tURTzw3+CbNSNLxQI66g1/NOv/+wHUAo2EsdzjNYQqUwUPey0Ble8xanC1n
         fuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=U/F0Ny1cWR9vZvhJ3YyD2gGoI3HlhJe0r1qEnyZLWxo=;
        b=ObTxNrQeGHIztaVbYaoXrGCa1RU53hvsTPmt/P7gv2KS5u8TnyNchzqKlGgN2I+yHa
         ruSwlyoD429gJjoh3Np1tQO42OTSdz6okpfAq1OsiKGbJeZR9qsIly738Wxk8bxSv5I6
         RNdwsKmuihgwxpuu9Hf8RUhG9onsFEeMSFgQGWBO29Gy0DCPe4lH4Z9KVM7viPtlzcP1
         z9ATcFG9JGNY3OjDrPTWZ1SD2MslcXYTsx948DLiGAaSJAIgIRaYUy6F4lctRwcIbAXc
         9h6HEuUyrp2r6v6RStnCz1S4yrU6PHbcOGwSBpB27Nx2iyAfoP8f0uwQlw03jepu8EXD
         gKAQ==
X-Gm-Message-State: APjAAAXsyOM0iP4nS4TtxEPNMgIZ+cE6ldijNvVHOyls+UEsfhQcAZ/v
        DqcgcdvrdzHAEi8dfuz4SCNqkhLQk0Q39FtTJyC7QzcL5nuAcldWyjtT973AaNJXOd9NU3iZCj4
        h2lz3I4TnWtAbT700GEbW1o2dBXqIb0sqbk+EubcwZq56GP879OhcibaDg8Bi4Mi/d4D5bpCZTM
        7fJ4EnzZy3
X-Google-Smtp-Source: APXvYqx5xjoGFvSFi6eyTgVV9nktwEV6ByHHsJ2GcUXuivyrjLvP1jAWRZFuaN6Z1rjSIOSZyVfI53D+VqczAv9S+VQ=
X-Received: by 2002:a65:4587:: with SMTP id o7mr49947184pgq.303.1577393132464;
 Thu, 26 Dec 2019 12:45:32 -0800 (PST)
Date:   Thu, 26 Dec 2019 12:45:12 -0800
Message-Id: <20191226204512.24524-1-asteinhauser@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH] Removing a dead definition or RSB_FILL_LOOPS
From:   Anthony Steinhauser <asteinhauser@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, tglx@linutronix.de,
        Anthony Steinhauser <asteinhauser@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is never used, but it is misleading.
Signed-off-by: Anthony Steinhauser <asteinhauser@google.com>
---
 arch/x86/include/asm/nospec-branch.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 5c24a7b35166..07e95dcb40ad 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -37,7 +37,6 @@
  */
 
 #define RSB_CLEAR_LOOPS		32	/* To forcibly overwrite all entries */
-#define RSB_FILL_LOOPS		16	/* To avoid underflow */
 
 /*
  * Google experimented with loop-unrolling and this turned out to be
-- 
2.24.1.735.g03f4e72817-goog

