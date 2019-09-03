Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DE6C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 22:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6492122CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 22:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qS3pG4Ke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfICWXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 18:23:52 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:40882 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfICWXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 18:23:52 -0400
Received: by mail-pg1-f202.google.com with SMTP id m19so11866004pgv.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 15:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+PCvSOkvySdWxOAJeySwLu3Fy1OiB15fqDnVbwKlIag=;
        b=qS3pG4Ke205Cz4lU2fIMU8nWWTJ8t2as68GAJkrkJ1i37AY1tNZMcn5UpM3RF7MENe
         QqGa31NuhXtorP3lnuqI+YtVnxbHuwoFbopkYQSQZIz0UcOPCFPyfqAIZ6i7CcvyoSMC
         E/fTnk2F8SVYLZcKyc5gPZqwa4wturG4ZrcImqEnhXR0xkmmErRaty2F6KbJ09W88Nv6
         uMmgDNR0RCt6nv2onrhhzMI93cwr93V8rYcLMqKy0VHRMRvmWMy00+sBK/1KTxp5c86K
         gpnyRFIP/rHdqtc89hRLTVrsHA6LHL6BOZj7tmnpW0EmQ2lbjQ4cEbWzEvebjEIdBbTr
         8wFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+PCvSOkvySdWxOAJeySwLu3Fy1OiB15fqDnVbwKlIag=;
        b=A2+LkcfJaa3qiIL9wPOII05UxNUaV/4/Osnyf8rygezrkjLJz6ynI9mqn1KAY+r1q9
         Ro0dgOkH8cPvzO6ek37qYd2nM53/tOVgvBNQ3SVANt6pZgwQwlCC4iB5bnlZLUnhqAiL
         /UxjVc1cFlS2QdRRNCRdTYtBoAJb2GIn0uJzsuqsht7KEy07YlMenP8gc6M6k4rwOpeH
         dc7DYKEnh98bITPOlmYgy2qIdskErEXdnKQUB97YvZkCL+L1W4csRDcBGkDjZ1bGUgDJ
         Ac00neJyYvPiNxs073BcbSSX0STsqD3Rkj8OkOSM+0RqtuJ/eu8aY8L67i+30Ey/cBbd
         sayQ==
X-Gm-Message-State: APjAAAVDk3glmn3NQyaN8m3CRbKbFG/iTml/0EeJ5FOeCK/pcjP7MSJh
        oto4Xi/DsRaAU01PmDzz/aDEA3C2ASGb+QRZY820UQcr30G6k4gfL7EIVGrU6+Gvil+nNLD0QZy
        XhQGlR9ejeQFjLPBOMcBVcGDQuIAxXgcBHZlAAv6VMjMh8mREFk6Sta9OT2VTHNiCb+UqHHAw
X-Google-Smtp-Source: APXvYqxAAc4HdeiZ6eQP+fKw1JNSLP+M3gfPQWQibaGz4LPlLosNOhf/qVzV9gmkpuGd6wLeSMjQjgb6lhZW
X-Received: by 2002:a63:a011:: with SMTP id r17mr9498033pge.219.1567549431056;
 Tue, 03 Sep 2019 15:23:51 -0700 (PDT)
Date:   Tue,  3 Sep 2019 15:23:46 -0700
Message-Id: <20190903222346.42583-1-moritzf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v2] net: fixed_phy: Add forward declaration for struct gpio_desc;
From:   Moritz Fischer <moritzf@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, hkallweit1@gmail.com, davem@davemloft.net,
        Moritz Fischer <mdf@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moritz Fischer <mdf@kernel.org>

Add forward declaration for struct gpio_desc in order to address
the following:

./include/linux/phy_fixed.h:48:17: error: 'struct gpio_desc' declared inside parameter list [-Werror]
./include/linux/phy_fixed.h:48:17: error: its scope is only this definition or declaration, which is probably not what you want [-Werror]

Fixes: 71bd106d2567 ("net: fixed-phy: Add
fixed_phy_register_with_gpiod() API")
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 include/linux/phy_fixed.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/phy_fixed.h b/include/linux/phy_fixed.h
index 1e5d86ebdaeb..52bc8e487ef7 100644
--- a/include/linux/phy_fixed.h
+++ b/include/linux/phy_fixed.h
@@ -11,6 +11,7 @@ struct fixed_phy_status {
 };
 
 struct device_node;
+struct gpio_desc;
 
 #if IS_ENABLED(CONFIG_FIXED_PHY)
 extern int fixed_phy_change_carrier(struct net_device *dev, bool new_carrier);
-- 
2.23.0.187.g17f5b7556c-goog

