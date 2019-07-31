Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F733C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAD82067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jf1DCaJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfGaRnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:43:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46589 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbfGaRm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:42:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id k189so13356664pgk.13;
        Wed, 31 Jul 2019 10:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cbyckh733zLn1k1KQNdqh7wE649sTzAEf7Zo27dCO9o=;
        b=Jf1DCaJW8x+CqvK5dK/oe6T/tEBnNjjoHaS6Avg/5nrZ7lnqPw+SLoTaf+oV3NKePM
         n/0ITNvE2NeMBsgUDLZ+V3WCNertUHwXh+F/wmGzsoBtnV4UOwyht+yCaNW3xTT7vPNL
         nprz7JaRptMhEvs56d4Y0ktKlLBfB0Ikb56p/ucPFRYWddbWyYZqL7HkDfOWkU99ZTEu
         TcwP8RNXr6VWDi11URP9yOBYxUIHxzaGvznHzUin9xkrUFnZtEM3NSjgLcFlKZk+EsE7
         eX6d+NmjkJbZwDVvsNMPO8YdWCahYFIUXlhlggzX/1zZqj6hmFMu6+nhX2BU5iMQmhoC
         Q3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cbyckh733zLn1k1KQNdqh7wE649sTzAEf7Zo27dCO9o=;
        b=fWIJgzjqED9zc4cJZ4nYCjhdyEmp/ifczzNjbudbrLXFYBO29wh/9D57tfC+8+8ui7
         c0WT0QSEULnBiDlOLqCmJjhMpacnzqqSkX2HCuopJ20OtJE7qhyDSEEqKSveK4zDAm1h
         b1kDiNqAlWVVqd0hc3b3JO5nEjjkRKCP+flhyCcaFxb2K7w6zIyiWNZ+tJWHBg1YdqOf
         9KZIX3L7CCpsCTD8plMZAcLZSrRUh31F/DQPdlfnHIGTGxiVEKuJwsHIP5l6zNRX5IOO
         fHNGcWXpFbHUrbADJ8nAc3UeEjzWi4L06lB5lVO7pLOuKaWu+n65WNiYGG6tt6hj4qWN
         6ung==
X-Gm-Message-State: APjAAAUOh9t92mnsQZRj5njK1Zf5ek8dj2ihjKrT/+eV4GO/b2diPRc/
        79qFuo1KfuhSWg8voPhOEndK2BK8
X-Google-Smtp-Source: APXvYqxdqHqvtynEU7yEnDIrijIctPi9FrUx6AMyMOZ85UVTMWrO/hZXpwZJYxX/Rd1+zUiH6EvUGg==
X-Received: by 2002:aa7:91cc:: with SMTP id z12mr48569536pfa.76.1564594978845;
        Wed, 31 Jul 2019 10:42:58 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id k8sm65941259pgm.14.2019.07.31.10.42.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:42:58 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rick Ramstetter <rick@anteaterllc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Ziirave_wdt driver fixes
Date:   Wed, 31 Jul 2019 10:42:47 -0700
Message-Id: <20190731174252.18041-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone,

This series contains various fixes/improvements for ziirave_wdt
driver. Hopefully each commit is self-explanatory.

Feedback is welcome!

Thanks,
Andrey Smirnov

Andrey Smirnov (5):
  watchdog: ziirave_wdt: Add missing newline
  watchdog: ziirave_wdt: Be verbose about errors in probe()
  watchdog: ziirave_wdt: Be more verbose during firmware update
  watchdog: ziirave_wdt: Don't bail out on unexpected timeout value
  watchdog: ziirave_wdt: Log bootloader/firmware info during probe

 drivers/watchdog/ziirave_wdt.c | 74 +++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 23 deletions(-)

-- 
2.21.0

