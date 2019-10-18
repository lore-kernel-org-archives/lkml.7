Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43751CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DE320700
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R67W02Lz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408400AbfJRORy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:17:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35071 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732676AbfJRORy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:17:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id l10so6050946wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 07:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fTm5JH2L5agfNTgSt6jIVduSEI+HxSv62N1+6WMd74s=;
        b=R67W02Lz1HjMvW2zQm++LCIQ21AzasDaKd9lyBCAv1JTy32UMXliPR+K+neuS3KxxR
         IUeID/8BP/H7qC61bBPYfLeuuDOgQW5c0Zy1VjzZOg8ma8zsEgdQWKWyDTgPXxEFuMo/
         u89cpWHzeoHBCkfqK4kNCh7bWGZbVn6bQXYwsCT9Pe1VLMF1poeq9qEDdVppr9uRBiQ9
         SI5F/BQTW2j+V2QP4q/fnGgWM+dHfAoG1MErow6uLKvK35S134x5sL0grP0Jr9pBta62
         uxcOEkzrKXdQMiimnSkNOCeiq8CyB0i+YwhoP+ex01NdUEh4koGBpt/zSeavD5Bqv7ps
         kSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fTm5JH2L5agfNTgSt6jIVduSEI+HxSv62N1+6WMd74s=;
        b=sshaGm1Ghm1bTqVmfJCxfO4BQKj6y5xAt0GPAhera2yB6RJXC0oVhWfYnIc1KpoXPi
         VGN8/khLTUNVcIphzHqY1VFgA4fEg9MEOi7xOvfgI/nsebd3ew7vi919IoW/VS15ToU/
         Fa8lloUdeZkcGBMGNnjg7g+2fBR/7ZHj1R07RZ4PVleivl13RsekQ7GOB9eozfmbiXnl
         qktH4LMamkLfmHghSu1uUeG0BwtUOhIMjsNjziP1YZ9ifjIlWc9ZlftR5TlSCj0Zcr49
         EnPEf2niFXY3jAzL+Mg+RSLKeiKMFCBHHFkx2dLk8efLA1KF1vblmEqRgJ3mdXs/Oiyn
         ymEg==
X-Gm-Message-State: APjAAAVNIi3wjrtWcUW/G9lZJ+SODVzVZ3L0KUJekZNM7O+pZpqUBAiU
        CjpxIUxtasz9GTxNtEKKWkmnzQ==
X-Google-Smtp-Source: APXvYqyXvXy8m4FlfE3Ivxs8/mhlAHKkQr/uz8IZ5NCsVUpgWET0v8kN7+RJAAD51s81jOaWspyCQg==
X-Received: by 2002:a5d:490e:: with SMTP id x14mr8607219wrq.340.1571408272158;
        Fri, 18 Oct 2019 07:17:52 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r13sm7110988wra.74.2019.10.18.07.17.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Oct 2019 07:17:51 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org
Cc:     vincent.guittot@linaro.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH] interconnect: Add locking in icc_set_tag()
Date:   Fri, 18 Oct 2019 17:17:50 +0300
Message-Id: <20191018141750.17032-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We must ensure that the tag is not changed while we aggregate the
requests. Currently the icc_set_tag() is not using any locks and this
may cause the values to be aggregated incorrectly. Fix this by acquiring
the icc_lock while we set the tag.

Fixes: 127ab2cc5f19 ("interconnect: Add support for path tags")
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index e24092558c29..4940c0741d40 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -408,8 +408,12 @@ void icc_set_tag(struct icc_path *path, u32 tag)
 	if (!path)
 		return;
 
+	mutex_lock(&icc_lock);
+
 	for (i = 0; i < path->num_nodes; i++)
 		path->reqs[i].tag = tag;
+
+	mutex_unlock(&icc_lock);
 }
 EXPORT_SYMBOL_GPL(icc_set_tag);
 
