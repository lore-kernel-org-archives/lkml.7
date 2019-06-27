Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36201C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074732133F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnzNbIbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfF0VMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 17:12:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34131 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfF0VMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 17:12:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id p17so3822318ljg.1;
        Thu, 27 Jun 2019 14:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AeDkLG3JsMSjObKDQMYG/VozAMgCnodFTyf26atSmqk=;
        b=mnzNbIbbqKNJCzqn+Fp5emJAoI8IwuM4FkM2GnDYDU53YPAgCf16FnL8z7dai7gGtq
         c06RtF/DdprwXIndqv5J7qABb6stRZJH7sQMpTFigJukPAd6lKyhFf4AEmO2dIVeXBh2
         xDq5L8t1C3GA5eyfp8BySc9bfGpZUpXLEFGR59QdKKk//gnjj0VwTQoXeriZPnzgXJVH
         GzOmhkRJEuW20Qdkq0iohoR774J5KbliQcjT7d/9DcsKlGo1hWMi+hdqGI2sc72Hvs9F
         /WyN85kxK9W+AdwqqPhv0Bu03HU7/lTj8QJTQx/8k8nZ1LqiPVxZEJXHMKOqcURaJx/g
         xoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AeDkLG3JsMSjObKDQMYG/VozAMgCnodFTyf26atSmqk=;
        b=l77H/+OxDYzfdexkPnNpZH6hUxwFoi62XiefGXkea3Nwa7p8wWpG7/ZO6C0qZM0KTd
         /HMl0/WbOMdPYIoZrXVk9VtcxXSZRHQ/xI6HGA5Y07EmfhxwY+Vd2G+uKnwOvd819cxx
         peU6RgblltEGY4KvGCFsgriqFmd1B2DG+7Q/x1Lqfx/RGw0DNDGo61fGhUB6RB4RszTx
         kQ63muaaHh4U52ZN4xRqZZwsSEQJZ+RF9ajyMuuAR8bUz3EtKdGgfkhWS/AJgzYSpEpO
         mxNhXmy1vdA5XQMK63ozpwzVlxOG6itIx1fsW0CBMqjEHxxsU/2KQm7cpI1qZQcDUG7q
         U29A==
X-Gm-Message-State: APjAAAVOrF+b6dDqwiQN8oMVIWojNn1cdRZ30twoIsxqS8m5nJ2YX02K
        tUz57Wu9wonxn9JtWaPPA7Y=
X-Google-Smtp-Source: APXvYqwn6zbGqTQ/VkxayOz4oVeRk7NgocPzBYWF5lOOS7vEd4MVoYv1wERYoqfsir+7I2VdtNM1jQ==
X-Received: by 2002:a2e:3008:: with SMTP id w8mr4025027ljw.13.1561669959095;
        Thu, 27 Jun 2019 14:12:39 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id p29sm30485ljp.87.2019.06.27.14.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 14:12:38 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/22] PM / devfreq: tegra30: Fix integer overflow on CPU's freq max out
Date:   Fri, 28 Jun 2019 00:11:08 +0300
Message-Id: <20190627211115.21138-16-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190627211115.21138-1-digetx@gmail.com>
References: <20190627211115.21138-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is another kHz-conversion bug in the code, resulting in integer
overflow. Although, this time the resulting value is 4294966296 and it's
close to ULONG_MAX, which is okay in this case.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index f86593ab3008..9a6ede689991 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -172,7 +172,7 @@ struct tegra_actmon_emc_ratio {
 };
 
 static const struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
-	{ 1400000, ULONG_MAX },
+	{ 1400000, ULONG_MAX / KHZ },
 	{ 1200000,    750000 },
 	{ 1100000,    600000 },
 	{ 1000000,    500000 },
-- 
2.22.0

