Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A068C00523
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE672072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUkML9Or"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgAFBR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:17:28 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36254 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgAFBR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:17:26 -0500
Received: by mail-lf1-f68.google.com with SMTP id n12so35324335lfe.3;
        Sun, 05 Jan 2020 17:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cVivrbUaLAvYOWEQyaxZv2B+LG1a8MlZfEIn/W+0au8=;
        b=kUkML9OrabwAEvWeZsnyBC7uNshLNoKhsWdF/XhXTjEArYIMFGZy1/9+c9uyWp6veo
         Cu01hB5n9NRIkEoX8pzRCbOx4amSb4gQ2WwVCuhvj5pctPwbVEL6IZyHpZJ0HlsNVEz6
         sFH5O+iJM9fsJ1GXfTW8iErxK+I3NfsV+LgOrxU0NM1bL8O7BT2yICh+6jtGtXNrjAHs
         Q7CTKT5IPh1kRixqQWeMjcFnPZc0d6KH7UAGihWw73vFa7iHx5EZzmVr6S0a06fo060j
         YdcvsaGfIPX5BsOqnC6cSNNKJvZCgw+6m6ehr5JL/qYvwlVZZbEv7rab6bAJZk6LYY7z
         L3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cVivrbUaLAvYOWEQyaxZv2B+LG1a8MlZfEIn/W+0au8=;
        b=FsLXhpjnCMcZTwbqVy4pDg8rppO3hMmLoK6/cO+Q6OdJ+wR4ixVyvHNoZsiI1DbkXR
         3jJGs0aLhKAGTXie94MlBbyAAhgX6SC5t9ccCmc/VKaUsi3WSYcxGx1eSEy5Y57f2pHY
         l7+Ex+TAL6cvjtlwwB4HOWu+opGRCQBlFoVduKPfuhnk6i92hp/AR5G3MEk43PDS9+nS
         WwzpbSDDEFI6i0w5umhjmPvJMOXXkEfdDU6KlssXVq9hn4vZSvZd5HPhtcTOYVOuzhM4
         sma4Lf+IduxmZ+1AGrXeUq/U81eO118MvBCbn3yZHnQyaeM9vHul8XlY8+LCwTZGNQTJ
         2dYQ==
X-Gm-Message-State: APjAAAXojcvmbxd+CM1A6O8Nkf/0itvCbn2xkxbNk4x0rTzNWpJ1fQNp
        I4/FSPdGSGPAXt3Pm5u/Xbk=
X-Google-Smtp-Source: APXvYqwwCWxjRa08Q9QsCh5DWxn6v0JUV2txxv78VLf9uv7Zi78RSe26MCLNWRtfzT8ZyBqXcEgfJw==
X-Received: by 2002:ac2:43a7:: with SMTP id t7mr51491468lfl.125.1578273444243;
        Sun, 05 Jan 2020 17:17:24 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y14sm28353271ljk.46.2020.01.05.17.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:17:23 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/13] dmaengine: tegra-apb: Prevent race conditions on channel's freeing
Date:   Mon,  6 Jan 2020 04:16:58 +0300
Message-Id: <20200106011708.7463-4-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106011708.7463-1-digetx@gmail.com>
References: <20200106011708.7463-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's incorrect to check the channel's "busy" state without taking a lock.
That shouldn't cause any real troubles, nevertheless it's always better
not to have any race conditions in the code.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 664e9c5df3ba..24ad3a5a04e3 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1294,8 +1294,7 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
 
 	dev_dbg(tdc2dev(tdc), "Freeing channel %d\n", tdc->id);
 
-	if (tdc->busy)
-		tegra_dma_terminate_all(dc);
+	tegra_dma_terminate_all(dc);
 
 	spin_lock_irqsave(&tdc->lock, flags);
 	list_splice_init(&tdc->pending_sg_req, &sg_req_list);
-- 
2.24.0

