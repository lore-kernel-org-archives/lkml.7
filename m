Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8605C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BB221835
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569765810;
	bh=GtHpxFOaDYYWQVsQM0RZkuCcKb7B2yjT8rUSga6pWtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qw7rwPx4X21UPasAa+sHcUjacHDJAaU188GWUkhr+P5tsWdjWqILu9oE+akgEe3K5
	 /EmCfhpIsb7N2sEa2MmkzGYqup90J7Td8EHx6HwC4WwYAmNf3G85npS3X0eqc8zc/7
	 OBMg4pc2k63rtGK+YcowDIJfMwtm8Y2ofWv2N5cI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbfI2ODa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 10:03:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729120AbfI2OD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 10:03:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 899EA21835;
        Sun, 29 Sep 2019 14:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569765807;
        bh=GtHpxFOaDYYWQVsQM0RZkuCcKb7B2yjT8rUSga6pWtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uBrwWdZ2r5vscipcGu3Vbx0brKuvEKrzfsKQJIjn8/zvaZtngj6K6gp6TaGTtlqGt
         VRySl9SV6u3L8s0fwoxxcauut2TumG0hEhPPKVj/ygi8anI8ey+IVh19fSiUm3I3Ma
         OGofo0KyZBjs7Q0DypyoDK1JTO92+88qf+scqkSQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 5.3 03/25] clocksource/drivers: Do not warn on probe defer
Date:   Sun, 29 Sep 2019 15:56:06 +0200
Message-Id: <20190929135009.157837674@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929135006.127269625@linuxfoundation.org>
References: <20190929135006.127269625@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Hunter <jonathanh@nvidia.com>

commit 14e019df1e64c8b19ce8e0b3da25b6f40c8716be upstream.

Deferred probe is an expected return value on many platforms and so
there's no need to output a warning that may potentially confuse users.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clocksource/timer-probe.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/clocksource/timer-probe.c
+++ b/drivers/clocksource/timer-probe.c
@@ -29,7 +29,9 @@ void __init timer_probe(void)
 
 		ret = init_func_ret(np);
 		if (ret) {
-			pr_err("Failed to initialize '%pOF': %d\n", np, ret);
+			if (ret != -EPROBE_DEFER)
+				pr_err("Failed to initialize '%pOF': %d\n", np,
+				       ret);
 			continue;
 		}
 


