Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD251C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 04:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0072068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 04:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="GPuluVop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfKVEw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 23:52:29 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:46930 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfKVEw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 23:52:29 -0500
Received: by mail-pj1-f65.google.com with SMTP id a16so2506515pjs.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 20:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BTPqDNY8ITj6j39Wij8R/bajoLbp2Cf1dMzJl7iFkVA=;
        b=GPuluVopXtOjUMpLKx2v2sHa9i02KRqh7e+oVolopt5WS6RZjrwVXS2K6hF4/TY+AF
         9zvVogEpyP8EmqkVTZ+AtDVTTox4sheL4B1ajE+yhlcMqeob57bvz9887OgmkTNjVp2u
         AuqZKgNn1RM/RHicc6XlIASV3HDcy1CWfXdN6J0fSdFI0gpwhv8Sknrf83K5cJcC7cH2
         Bvo6JyRaPjtiQHqzm36bOLzrQ3bcL9fRaCZ+Rr4v+pRZjaXIthl3r46ZMk6+lTKIABfg
         H9Bfnsp2L/bzuVT4aUYwY5NtKDYZYVrkWBQNSpxbRZ2gYdb70F2WUoMvmdRerMefoSsV
         41Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BTPqDNY8ITj6j39Wij8R/bajoLbp2Cf1dMzJl7iFkVA=;
        b=bQKJxOO6NURLvNGExX/xn3tOgvwxjPreC3wA/585W74fj0xWP1M7w6dcbDFqFhef5M
         26rbqzKly0pV5fVqxOW7f7Mn1MHHFd6MCk/OA4UdLvhKOconxqoVJEGSGjsEuJmd3jjw
         5itfujlSMxZWbYpGZP4p7EjAQVF5JqeeVTcekq3oWsJRCyHVXpQ7fv3X+PRTJmVknArJ
         PV+jWCTmDsgfkRMQv8NMOqau04usrEVs+VbdSicF/xwyorq0nkKPW5R/mZp4EBrIiGim
         qaoTblHh9AuxKC2siAisroEB8fWdh85xe3poEA29lxMFo6lEwqH8kXUIOoJeUK2m29OR
         8nEw==
X-Gm-Message-State: APjAAAUSsZmStcnMGTV4wkd+9YdGWLKo4ha2FODJfGxjwHFc2cy+EDxJ
        VbCfsc7yFi6RrwC6pzRw6jytUw==
X-Google-Smtp-Source: APXvYqxBfZFSSnmX5zihZnMsdD5Wb6cF0V4TdPuknsrSsX5oX0l2bTmFRc23NuM/S7hTBnIrC36v5g==
X-Received: by 2002:a17:902:a408:: with SMTP id p8mr12603911plq.266.1574398348541;
        Thu, 21 Nov 2019 20:52:28 -0800 (PST)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id g7sm4823125pgr.52.2019.11.21.20.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 20:52:27 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Christoph Fritz <chf.fritz@googlemail.com>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Christian Hemp <c.hemp@phytec.de>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: da9062: Return REGULATOR_MODE_INVALID for invalid mode
Date:   Fri, 22 Nov 2019 12:51:54 +0800
Message-Id: <20191122045154.802-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-EINVAL is not a valid return value for .of_map_mode, return
REGULATOR_MODE_INVALID instead.

Fixes: 844e7492ee3d ("regulator: da9062: add of_map_mode support for bucks")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/da9062-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 29f4a60398a3..d3ce0278bfbe 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -108,7 +108,7 @@ static unsigned int da9062_map_buck_mode(unsigned int mode)
 	case DA9063_BUCK_MODE_AUTO:
 		return REGULATOR_MODE_NORMAL;
 	default:
-		return -EINVAL;
+		return REGULATOR_MODE_INVALID;
 	}
 }
 
-- 
2.20.1

