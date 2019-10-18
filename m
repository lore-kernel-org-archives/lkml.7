Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B943CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFAE21897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Imarxruy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409668AbfJRJ2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:28:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45526 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387757AbfJRJ2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:28:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id y72so3496446pfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 02:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2zQ3DdxsRN52jblb9zywIzl2Di+YG8z5hUSeV7sQqSs=;
        b=ImarxruyGPcwgA9Yix4GV5gpXFGRncXMe/xRmupDsGnKBimIErWSuO8uyKPDZSuHob
         DEAH+b/+q4XTL/ZSBfhQRQA8qnTG4ZjNTHR4EHFLWcT9G+AOeZVtPZhmQBegmnSFN/rv
         uBB2CdZTqg+poL/mTnw/4VjuU+6H2/RnRejKeIlFdYVBS/AfJ51SkRX4c6lmP56xVXrv
         PuStzbPXk7SGBb27qGgj2OV/skRhExknMmrSvYbGJjAq0ti4hyv4NuA+j/HO/zWULrNd
         wlYWesKPXGn/leAFYT2rFNWQdNO9EyadIk6puXp15eos45MknjY9QiVZNRMLtXLbpr0j
         d7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2zQ3DdxsRN52jblb9zywIzl2Di+YG8z5hUSeV7sQqSs=;
        b=ag/VXKF0b+h4EyCDIrormGLMZTAWgnawO6/S1/ki6KbRGDEQekxP4PIflgJsullhvK
         uvCtg/l6jIjgoIMsmNhA/VLH1UadkegdbXexRk+MpUymGIY+KSrWkDKNCQRi31sa9E9X
         ZnpTgj5Owk81H3RQWoOyAiKlujE0nH96qyCukAiXnB+W7gjGn6nUU1ZkUYnGSwlvQG2k
         WqnRaUDhd2/lsDxI4TA7xAcih99XfjGXNSEuhl5mk48mD2yDcCYpnPaSwHULvYujmkRe
         zYkFCjBqpdvaqBiOhQ8ZiDcyp2HeJh0Y8iq2Wdtv00mmtWek1q80zbyOTsrBCSf7iu9v
         /3gA==
X-Gm-Message-State: APjAAAXuJcK6wqem+fRvok73RzeCrvxCs8h5uQ3xP8oscst+y3lfa1j/
        XjWHyqUk/5G99s75HSDohO+A/A==
X-Google-Smtp-Source: APXvYqy0BNqn4Vykv9sLgst5ckU45MRFvYZM791coX9D1UtMgpzWaE6W15f54ZBKZb93uc6qHeC1Ew==
X-Received: by 2002:a63:1f4e:: with SMTP id q14mr9167259pgm.144.1571390927910;
        Fri, 18 Oct 2019 02:28:47 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id z25sm5929736pfn.7.2019.10.18.02.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 02:28:47 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Reinitialize the list_kref before adding the static OPPs again
Date:   Fri, 18 Oct 2019 14:58:41 +0530
Message-Id: <2700308706c0d46ca06eeb973079a1f18bf553dd.1571390916.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The list_kref reaches a count of 0 when all the static OPPs are removed,
for example when dev_pm_opp_of_cpumask_remove_table() is called, though
the actual OPP table may not get freed as it may still be referenced by
other parts of the kernel, like from a call to
dev_pm_opp_set_supported_hw(). And if we call
dev_pm_opp_of_cpumask_add_table() again at this point, we must
reinitialize the list_kref otherwise the kernel will hit a WARN() in
kref infrastructure for incrementing a kref with value 0.

Fixes: 11e1a1648298 ("opp: Don't decrement uninitialized list_kref")
Reported-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 6dc41faf74b5..1cbb58240b80 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -663,6 +663,13 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 		return 0;
 	}
 
+	/*
+	 * Re-initialize list_kref every time we add static OPPs to the OPP
+	 * table as the reference count may be 0 after the last tie static OPPs
+	 * were removed.
+	 */
+	kref_init(&opp_table->list_kref);
+
 	/* We have opp-table node now, iterate over it and add OPPs */
 	for_each_available_child_of_node(opp_table->np, np) {
 		opp = _opp_add_static_v2(opp_table, dev, np);
-- 
2.21.0.rc0.269.g1a574e7a288b

