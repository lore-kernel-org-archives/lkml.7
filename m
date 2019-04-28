Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB20CC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 09:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAFD21473
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 09:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PjzpGgCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfD1Jvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 05:51:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42931 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfD1Jvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 05:51:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so11105984wrx.9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 02:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=aAPgdAL7F9ZQM/t7uLbFfU6JxKR0GNZw8r9SgrUMppI=;
        b=PjzpGgCB5XRY0j6HusinIsXEi/Eap6Nk/cbJiEydwQtyWIobVOOQkeZcOawkgDWIoX
         WPCW7KzSjI4FwhJnQddUslEXf26IjYl30ryZeI5S/+qtROqEoca8zLCUBM96ddj3vehI
         Cq7A0op7llO4ABD50JZFGFWxA0W9N04Lwu6O/l3HgNlIC2e4Ici64DhhnHR2J5Z4VOnI
         kYrzGY2JR74loxBPn77j45qgLB9ZDnaYNKdn976D4C9/m2tPAHqql/Zx03/DuPiiVQ6k
         eajovNUFa42a1L0f660SRko5bYVoupwYyfVjP2zCAnN5Lyrgc5Z4q/th1udlZqQ4g32S
         cE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aAPgdAL7F9ZQM/t7uLbFfU6JxKR0GNZw8r9SgrUMppI=;
        b=ReRi8MZqa35mNlUOd+A8891XE5QoN4+PNGZKQcYjYd7Wow1/zc1Z4ZhM8Gpqzb/jwh
         cp8tMWXhGWMTR/OY3b5D/EdXWdbUw9wDj/rgspvbNn6mf5IJov1fTXvCD2HGKJDvFo8y
         1nYSpfEREMMy2sA+IKJFF+LJu9GtTuxeaNNE+sn87EyZOhZF34MayUePImLopQHK/pPJ
         mIzEYxzfmJYxk4UHO6JF15TJxIMVPbj2KMSJy0Of2IqiDdhDd4Q8X3Qa6cr3OH683IWy
         hNEMkAlVAckeCTlkspBlTKk2YaUHOqxzdKSNyLBtxJHzglNqCcLItT6LEUjNGvtd7aSu
         /PAw==
X-Gm-Message-State: APjAAAWnqFf6ZkbQVjuGHAyfcaU2wx6YLm3hip/DHB5XRUunZnpp7PTn
        QUFXNtwPS5QdGvuiRTcR0f0LeQ==
X-Google-Smtp-Source: APXvYqwLA4kk+NumkHkcyFweOkN16QWgMmE0Y+Hj6jaAfH8+mLSReJEGZEtQvX6o7++PTpcZvCIk0A==
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr1542361wrw.104.1556445093253;
        Sun, 28 Apr 2019 02:51:33 -0700 (PDT)
Received: from clegane.local (86.204.129.77.rev.sfr.net. [77.129.204.86])
        by smtp.gmail.com with ESMTPSA id e5sm1560675wrh.79.2019.04.28.02.51.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 02:51:32 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>
Subject: [PATCH - resend 1/3] thermal/drivers/cpu_cooling: Fixup the header and copyright
Date:   Sun, 28 Apr 2019 11:51:03 +0200
Message-Id: <20190428095106.5171-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The copyright format does not conform to the format requested by
Linaro: https://wiki.linaro.org/Copyright

Fix it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index ee8419a6390c..42aeb9087cab 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -2,9 +2,11 @@
  *  linux/drivers/thermal/cpu_cooling.c
  *
  *  Copyright (C) 2012	Samsung Electronics Co., Ltd(http://www.samsung.com)
- *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
  *
- *  Copyright (C) 2014  Viresh Kumar <viresh.kumar@linaro.org>
+ *  Copyright (C) 2012-2018 Linaro Limited.
+ *
+ *  Authors:	Amit Daniel <amit.kachhap@linaro.org>
+ *		Viresh Kumar <viresh.kumar@linaro.org>
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *  This program is free software; you can redistribute it and/or modify
-- 
2.17.1

