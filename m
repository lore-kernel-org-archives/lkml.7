Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3B7CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 14:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3650A2085B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 14:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1/aTXY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfKAOiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 10:38:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50348 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfKAOiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 10:38:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id 11so9564292wmk.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 07:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d/QAmQIaJZqvBZN9gtf42lfTOPBui/1bELKuGyuJdb8=;
        b=A1/aTXY88hwx0sfCCWkO613b31JI7fBe2Fo7wc0qyRX1OqGtc1ZqPTHH3fVptzI2xR
         kjtzIFwT28c8pyCN1rXIAb7VEv+u4LqEx23SRT2bH3mzJkw5AkHNOs4lt482evX6TdWF
         Owbgw07QIaJIvXlIn0YuxP0DnJ1ZY33AiQXaHs13ZhtLhRBr6AsyzgXdcRaO31s6BfbC
         cq/gJdjEVmPEDAHhPV8CvWUhlxccGm2a3OBVYvTtNkvqGihMhGX0GOr/Ignd7Nxemwmz
         JnE2XSKIlW/ZcBwn1hZtqeovVZlQjWliWYbL8JCHXD5aWz0FsGz9AIOM/1cmNSrVmNYv
         19yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d/QAmQIaJZqvBZN9gtf42lfTOPBui/1bELKuGyuJdb8=;
        b=Y5eZIc+mqH8XH14JH2uNLUSp9xMKw8bVeo1eDkFV8tHmRfs7G/4V+LJSirFQjDp70T
         DeTdn2wAnEpkWqjqZrkRtls31Gp9XCBu5iZSS9Am+ho2iJZMToh5BXKLY1Pepmu+JgkA
         g2nOUfs8Rm5NF7/QoJpJrnM9XdVBxu6pZ4Vn5duif9o77ZBoTzgo06iUZqHwGLwn//+i
         NB2iFF65PqWcz3CmjiXTVNuiN4nTnqTrwT8aW8fIW17Qi77nK1519zM7IZ1PP6/VsyKQ
         aPBiTuKBqKdROBVgH0Q5J8egtU1MII46qzqHLC72B2p4U6TI1NYme/SsXtq/sLXuUrHA
         DiJw==
X-Gm-Message-State: APjAAAWiDyTswFu8NhQOjdV7nMrD3myrznaElm5+YbwwVCiKK0caPTMj
        MlpcDL5YtO9puimx0J5ZEtk=
X-Google-Smtp-Source: APXvYqyI+Q4wEtZDCOGjwU9VHlMJmHZrNaWIfLyrtIJAa8a3WH1InYAp3J1RaSxDOIYycLFVQMvstw==
X-Received: by 2002:a1c:10a:: with SMTP id 10mr10579982wmb.17.1572619092780;
        Fri, 01 Nov 2019 07:38:12 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id l15sm6391895wmh.18.2019.11.01.07.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 07:38:12 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] gpu: ipu-v3: prg: add missed clk_disable_unprepare in remove
Date:   Fri,  1 Nov 2019 22:38:01 +0800
Message-Id: <20191101143801.17774-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to disable and unprepare clks when remove.
Add the calls to clk_disable_unprepare to fix the problem.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/gpu/ipu-v3/ipu-prg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/ipu-v3/ipu-prg.c b/drivers/gpu/ipu-v3/ipu-prg.c
index 196797c1b4b3..6ae6d634c983 100644
--- a/drivers/gpu/ipu-v3/ipu-prg.c
+++ b/drivers/gpu/ipu-v3/ipu-prg.c
@@ -430,6 +430,8 @@ static int ipu_prg_remove(struct platform_device *pdev)
 	list_del(&prg->list);
 	mutex_unlock(&ipu_prg_list_mutex);
 
+	clk_disable_unprepare(prg->clk_axi);
+	clk_disable_unprepare(prg->clk_ipg);
 	return 0;
 }
 
-- 
2.23.0

