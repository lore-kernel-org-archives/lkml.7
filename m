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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14702C5B576
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0568205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3Q+zZgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfF0VNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 17:13:05 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35512 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfF0VMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 17:12:47 -0400
Received: by mail-lj1-f193.google.com with SMTP id x25so3830645ljh.2;
        Thu, 27 Jun 2019 14:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qG6k6y4hGZkN0L4NvCOd637zA3RASq59cRyx3KTNlDk=;
        b=G3Q+zZgQsswT9Zaua1JVKEw2Q1dRTRs4D+nibSLptEKjgzpJVWBoAKA0CZyZnT0EQC
         U1Tq6Zb4kJubMNi9k0pdaIdTKBEvU7zXuiHaw81qRneskknP4OoON9Pix2Wbjnkx9ljj
         jMsgMWibBhhaCYkNtvKqivT5h11zLDmxeYavDXeZOuOChpKzOt4di7a6BSA4xQ7+PWSr
         FvAuN2diM7/zHa5DRRsT3V0Jlcz+p5xPPA8ZSqbK3zNxQgkKBICBU/k4qXcpAMuaNHlV
         ZoorphkPh8/YH8JsaW+EarXFr+8/sHqTN90NncnoU2UIqcxLuPsl3wL7fA+xCcHGQ4Pi
         KKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qG6k6y4hGZkN0L4NvCOd637zA3RASq59cRyx3KTNlDk=;
        b=cUXVLzNuMVoMJzzgR/u5MMD5ZwskU2fLCJYKOM4Gb94b2HqUV4qH5MoxoP//aszbja
         GQ8R5GrK6v2i1XakVhaeAe04e4IDCe0qA/hNFtcfjukyqaOyPI0R8HUXAxdKlaqGslk8
         Va+MzDFuIS66PVwW3350wM7Vhh5L58hdjfZYJB1Lcat2P6eatLHeBZecRpbkki2LBdGD
         srnK7o4/lSs9B6gO0GJU5S6h2oEscNr7oJjzZI0N4M01zxYaVqK/uquaXuoVp03rW9As
         p2XJJcH594s0Ydi+Ye7Eo2aT+u9JNrj0s+a+PAxVurOGTYSswSMOFJArwvkFcVIfkNOC
         /Jtw==
X-Gm-Message-State: APjAAAV4yTG0B4dGx5c3WfMJy2HPKzejPhiYBmYZBWzQUG5KKa5Ldt70
        bvS4WyrD9SHIfLJDYAYIqrk=
X-Google-Smtp-Source: APXvYqxxvzuPiyszXV19XCikZOUCCKOkpB7spg0euRVmUWdFFUmfsNmQoPIU4nRYfnP6SbR5yDUSRg==
X-Received: by 2002:a2e:89ca:: with SMTP id c10mr3988956ljk.106.1561669965129;
        Thu, 27 Jun 2019 14:12:45 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id p29sm30485ljp.87.2019.06.27.14.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 14:12:44 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 21/22] PM / devfreq: tegra30: Include appropriate header
Date:   Fri, 28 Jun 2019 00:11:14 +0300
Message-Id: <20190627211115.21138-22-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190627211115.21138-1-digetx@gmail.com>
References: <20190627211115.21138-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not very correct to include mod_devicetable.h for the OF device
drivers and of_device.h should be included instead.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 5b1feaf8c16e..3ca227c95829 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -13,7 +13,7 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/module.h>
-#include <linux/mod_devicetable.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/reset.h>
-- 
2.22.0

