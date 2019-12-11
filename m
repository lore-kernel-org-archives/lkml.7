Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31230C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0038F21556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axb460up"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfLKVCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 16:02:10 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42173 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfLKVCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 16:02:10 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so2394655pfz.9;
        Wed, 11 Dec 2019 13:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7E14QxAHzYNC4GmkN5reu67hALT2jTvj+71Kr2N6+eQ=;
        b=axb460upQpz59c56OH4vGMUnI4s4s2e101BW1FG/Ij2bVEXAq8sBfznuA/SA5BtC4s
         4Td8h1WWYUyn6jk2BQBqaKkPbyGjqlPzTI4qAcJ9ul1JGuLVEcJO6KnrtirJkm+SYDcG
         BtPExYIHVQiX63Vwp6CNyK5j1P73A6HFxh1UlrxmI4NEssXHVzM3rgKK2G9y7PTzkmLs
         K9Hz/K1WuuFVKdba8eNKPTf6VhH1oML6HBEUVN0U1akSiphFv8QjQfSMxBlkLCa5M6Q4
         d8MYjDuEZxoby3hh55zL+QM2BquHvpqszcSAcoVT8L4GX0f9UANrYE+wyAiO7bnxTVzO
         bd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7E14QxAHzYNC4GmkN5reu67hALT2jTvj+71Kr2N6+eQ=;
        b=i5dDpYDrS1hLMQP58hulv1W/ccrju4KkQvtFFIJZfR7E7OtnZdtlxN8WxHHkLZ8qLh
         DSp8zkgGJzlge5coh4n6v3RWFSwERns15ZL5WxTV1rn58Wvzk+7ZUYb90TIQU9L5pJjl
         QXGTtYIPCDKFSN8KBQoDOIs21YLj79U2c71+fV2p73amD29ryw+n9EVdJYO9wP5MVNYY
         e267tWjQcl1MuviLpFtTCip2TujpKMHzAviXkf130aoQk6wU8HrKkl/oihpIU3uepiyl
         GON2g4zzrxXGvMLlJ6StitcEqTQWOxM5AxHO2fsZlraA3jRav1LG0XZkPLftKdpfyXcI
         uaIg==
X-Gm-Message-State: APjAAAXyGGhyNdWXuh+asVhNkcA6Fh/K7Q+cerYXgRy3srvF3wg84TIA
        nDEfhjruFiM9Lvgi8vuWiAqTPw0N
X-Google-Smtp-Source: APXvYqyzRrhsJeenZG2Yhmg722+CAiYjJ0iRustdp5ib5FF222IQ+zrvs0oS2RR49alvqc++r4CkyQ==
X-Received: by 2002:a63:ed4a:: with SMTP id m10mr5713033pgk.99.1576098128984;
        Wed, 11 Dec 2019 13:02:08 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g19sm4062137pfh.134.2019.12.11.13.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 13:02:08 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org (open list),
        linux-mips@linux-mips.org, Paul Burton <paulburton@kernel.org>,
        Denis Efremov <efremov@linux.com>
Subject: [PATCH 0/2] watchdog: mtx-1: Relax build dependencies
Date:   Wed, 11 Dec 2019 13:02:02 -0800
Message-Id: <20191211210204.31579-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wim, Guenter,

This came up with Denis trying to fix a MIPS-related build failure:

https://lore.kernel.org/linux-mips/20191210172739.27131-1-efremov@linux.com/

Florian Fainelli (2):
  watchdog: mtx-1: Drop au1000.h header inclusion
  watchdog: Relax dependencies for CONFIG_WDT_MTX1

 drivers/watchdog/Kconfig     | 2 +-
 drivers/watchdog/mtx-1_wdt.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

-- 
2.17.1

