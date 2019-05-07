Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1E1C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D49720656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtMY5pBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfEGQ65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 12:58:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35188 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfEGQ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:58:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id h1so8616574pgs.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 09:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O3F7bdzCJVvXWFJraTuep0VKxXgWnuSEosT9JtZwBl0=;
        b=OtMY5pBCve9l9++jLockjsXtTUN3BkfdYW7oPEAh0dYgmTcA/93NWuCEUP11bOFiSo
         c0pg3aKoNwBbSCINAka02TpSDyp6ItYTYEoFjOnyKi/UqGZ8DyxNNfktPjOff5gJelqV
         uXHar6beyiLocJ35FJ7YuNCGC0xlsslYwEb+vyvzk4XGCpgwq0hVVSdKHNo2nuP8Busr
         CRx49DluRN5LyjrUqUExJrvA5mg0S2jsG7mJcHENfF+KREUM5Lty2vLjvs9mCzrowniq
         D3y1xd/7CRfzJPxPcP/dwqgonOUjc+cWPtysmdiOGqRRF3ifgbK8acwCCrryEFVSuY/3
         enzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O3F7bdzCJVvXWFJraTuep0VKxXgWnuSEosT9JtZwBl0=;
        b=GKHhDcu8OODXmq1ZyGTjYMweJsysJrxUlbXOoWZhS+0KqnGVWkIEG9FJ8m783+THv7
         Me0LorcyLmUvGU6ZGbXhqvkxn2bV8SEozx8Vmw+Q88l9DbDI/KnqkZpqwm2MctQRzT+9
         5vXM+i+QyrxdKEtOioxaLyUoMUssjHwF96EmQTZK3LTaAchJpFCn4yt4NGC12jNGrgwl
         ojKAq1lzw49PyOr2D2DRXu6bVgVY95/CDX5TYTareSJL7LgjHL3lpZhRxSqbICVr5cEP
         SySoWjz80Y5vQLk9Ejdv1fStW2ah12+pYXNYwt1arapPqYCe4Pz5ZwbtsDTXg9CVLvN7
         ee3A==
X-Gm-Message-State: APjAAAV9gb7fxyoUbips1oILg/7YglBd9nbWBEJ1/N8M7SytMhxa8t3F
        vYHYY8XyGqU1b+TN531RJ60=
X-Google-Smtp-Source: APXvYqy7UEeAGiQO6c3HCRaC+GO0QSzUNg75f1Nl9sihob97Wg+kpW2IdWtx7ktPjr9ApscZfh7yLw==
X-Received: by 2002:a63:8e4b:: with SMTP id k72mr8953049pge.428.1557248335921;
        Tue, 07 May 2019 09:58:55 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:1b24:991b:df50:ea3f])
        by smtp.gmail.com with ESMTPSA id r12sm18140093pfn.144.2019.05.07.09.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 May 2019 09:58:55 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH v2 2/7] devcoredump: fix typo in comment
Date:   Wed,  8 May 2019 01:58:29 +0900
Message-Id: <1557248314-4238-3-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/dev_coredumpmsg/dev_coredumpsg/

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v2
- New patch in this version.

 drivers/base/devcoredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 3c960a6..e42d0b5 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -314,7 +314,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 EXPORT_SYMBOL_GPL(dev_coredumpm);
 
 /**
- * dev_coredumpmsg - create device coredump that uses scatterlist as data
+ * dev_coredumpsg - create device coredump that uses scatterlist as data
  * parameter
  * @dev: the struct device for the crashed device
  * @table: the dump data
-- 
2.7.4

