Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F159FC48BDB
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C540620684
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dj4CGCsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfGGWgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 18:36:00 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46997 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbfGGWfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 18:35:54 -0400
Received: by mail-qk1-f194.google.com with SMTP id r4so11824295qkm.13;
        Sun, 07 Jul 2019 15:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zYZMMVB0p2vPiUsxM7xlHTtkTuiIoBu14nXRTurteBU=;
        b=Dj4CGCsLeD650+nQjlgz0ZPQ5dExQ8Y7KAzdCDqRn6gSOx13yKk38EsvVTOmSdzwf9
         ADoBTzdFe5PvByqJbzwar5z/iqq+GVOdgHNzzFB484qcmzc2paK5RgxutdQwOINylWYG
         +1cHnYwVjE6SHvmVNccFq6D/Spsu0v5C0NsdiEA0CHKm2TonQ9tWPh1GnD40qYcpzPYO
         fX4qC/8a44mmutcbTp2FxFukGy9wW4leBJZyiuZHa+ToKoYfLo036xIT99c6KiiV809B
         ZTBPC+lVNaVi8VoRW1hmqFr6pvaO69ho18NRJswDulJ05Wdj5wf6yEMBnhB1DGImFwBx
         ucvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zYZMMVB0p2vPiUsxM7xlHTtkTuiIoBu14nXRTurteBU=;
        b=Kv2dwXCE95yFVsqXiTErkLkkKrD893J3RrxyWDZCricqer/y+nKTu4rJnGduveJP+f
         pS2IwK2KHuChfLX7QbaC8Uw5YfJpnrMmyshK81v68Lj27ILbNgHlMPcjyuL/dbFEeO1V
         UMBGPziYt5+BSR66uLOeWxYHaf0GzSAuiXyT8gRi8FtYgDIZYOhStGEoJRAhDmYtGo2a
         7FAq33D4nNEtNZ1azffsOi8KCzLdDKZEE5Pan5Yi0379VbMCESuACq2F/hCuJIZ0rL2y
         JgXSIb/qSna+ZUN0ptvax5xZdHgv6t5DXKOztrnC47Bo7RgjD/3u0/Vm5lfs5lRs/qHp
         x3EA==
X-Gm-Message-State: APjAAAUe2+GY2/to0NvoTkWDPpGx2ef1HlMbLyTPN/4XDMWeY/gSmU6W
        HLI0+27R/W7RPaz4Cc1wLCI=
X-Google-Smtp-Source: APXvYqyntEvL8BaKmjjASARnHCPbkwUcYPtDsaVd6FdncEMzylJMgU9a9OfY9U2aBIv0HlJXjGx5bA==
X-Received: by 2002:ae9:e64d:: with SMTP id x13mr11143733qkl.445.1562538953226;
        Sun, 07 Jul 2019 15:35:53 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id p4sm6998453qkb.84.2019.07.07.15.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:35:52 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 23/24] PM / devfreq: tegra30: Increase sampling period to 16ms
Date:   Mon,  8 Jul 2019 01:33:02 +0300
Message-Id: <20190707223303.6755-24-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707223303.6755-1-digetx@gmail.com>
References: <20190707223303.6755-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase sampling period by 4ms to get a nicer pow2 value, converting
diving into shifts in the code. That's more preferable for Tegra30 that
doesn't have hardware divider instructions because of older Cortex-A9 CPU.
In a result boosting events are delayed by 4ms, which is not sensible in
practice at all.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 19e872a64148..bde19b758643 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -71,7 +71,7 @@
  * translates to 2 ^ (K_VAL + 1). ex: 2 ^ (6 + 1) = 128
  */
 #define ACTMON_AVERAGE_WINDOW_LOG2				6
-#define ACTMON_SAMPLING_PERIOD					12 /* ms */
+#define ACTMON_SAMPLING_PERIOD					16 /* ms */
 
 #define KHZ							1000
 
-- 
2.22.0

