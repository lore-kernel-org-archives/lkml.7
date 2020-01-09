Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D108C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC2120721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iS8Ev0HQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732701AbgAIP7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:59:12 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38264 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgAIP7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:59:12 -0500
Received: by mail-pl1-f193.google.com with SMTP id f20so2728260plj.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 07:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LZt9a2PQrpf+A+nxkCn06oFfpq5bfrLSSWchL8Vn24E=;
        b=iS8Ev0HQAIHQAO3N6JvdOq9Twe4+K0Zmvwncbh5RlqD58/lMcGWVWtsUNdqPv+RExg
         eFyD2q4cb7iodF5EZKM6DVu0CKX85Vvm+AC+V3CZb5xUG6fnWvS5wctCdpHfCj9m1L6k
         t6s6CPOe1hvlN0zFPwS8QwhVUPjVnahmMoWds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LZt9a2PQrpf+A+nxkCn06oFfpq5bfrLSSWchL8Vn24E=;
        b=ZdqZpBRaJy/eAV7OyWNvrWfWCRiNuySCeMG879on6oVLmEvfC92Icij3G+Yj06zFly
         MYC9ccXYgG0BAnRGPptMousanSWVUisNKumoOMarkIAI1XoJc/QXyD6IXuevmzMs/acr
         W6tDLIGLu8Na64RmxWa36rkimB2sbISkG/Gb52RWdLnyK9BtDDNHM8pc1e2Zh0seILgB
         ybnDVkriiF5kHS3iZEZh73oHpF9gGZeVWYK53LHx9v3zgSTc5aX4GoBRHLVmLJNsPgsb
         rfSEKqMWVIgsMHgZSUwjXT8Ikh9ggGZqGVl4tkmLlc/ORy8MkC9kTjk1qfMU5vlJJfnN
         pp4Q==
X-Gm-Message-State: APjAAAXsYCQzmaGvDhR5Rah9mt7LAwwwPBSv7sg8JcBDyNb4tzLwA6R/
        tDTTrg82SHZdXdYUSXc+qHES2Q==
X-Google-Smtp-Source: APXvYqx94aUoF6poz7iaU23A6RDDy3TWCcJiOR0Ahkc2Aeynq5ACsN6rTjvYWCQIoYqYd5ku7zV1XQ==
X-Received: by 2002:a17:902:6b09:: with SMTP id o9mr11418833plk.209.1578585551290;
        Thu, 09 Jan 2020 07:59:11 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j20sm7832793pfe.168.2020.01.09.07.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 07:59:10 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 0/4] Fix alarmtimer suspend failure
Date:   Thu,  9 Jan 2020 07:59:06 -0800
Message-Id: <20200109155910.907-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We recently ran into a suspend problem where the alarmtimer platform
driver's suspend function fails because the RTC that it's trying
to program is already suspended. This patch series fixes that problem
by making the platform device a child of the RTC.

The last two patches are non-critical changes to how we do the wakeup
and some code cleanup. The first patch fixes a memory leak that I
saw by inspection.

Stephen Boyd (4):
  alarmtimer: Unregister wakeup source when module get fails
  alarmtimer: Make alarmtimer platform device child of RTC device
  alarmtimer: Use wakeup source from alarmtimer platform device
  alarmtimer: Always export alarmtimer_get_rtcdev() and update docs

 kernel/time/alarmtimer.c | 41 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)


base-commit: 4becfd1b26ef4014a20fb38dd17554077adbed5d
-- 
Sent by a computer, using git, on the internet

