Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EB8C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 17:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C30207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 17:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jzpuGAHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgAFR1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 12:27:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43908 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFR1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 12:27:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id d16so50542723wre.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 09:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eA5OqXkB3++UqCw3nWhtcdXsiHuPwWe3zZsMrY+R6g0=;
        b=jzpuGAHB6DfsAm0+WuzL4ucBxTHVpKeYsWix/3HqlDl/edJ/k1pa7eKLvJPg1I9b5x
         /KRJ3qh4H/O+NGKjY/7bQM9LmELJTS3ZIIyxXp/lhVPeODk3JK5r3WQa91+3foXpUdLf
         kI+io8ZjBwrS6qmYGu5Bqw/fNNCwnnDauNCl5moVv8JmjzLmt0lza/L/gKo6PH/vk/0n
         FPpAwtDPxch0nChyvNUxMOR7KlcEcV6Y61WGG9mrzWa/Qib7Lm+OSwOGB+/atVUdA3F/
         mmNtHZwldHU0b7JiBcme5V3ekCtC7hdEPmKxijaiYc5UheEkoqMMWgDLprFv0kjyHBpO
         Za2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eA5OqXkB3++UqCw3nWhtcdXsiHuPwWe3zZsMrY+R6g0=;
        b=Mjn1sujIoOGdj3/2fdciW2UjsMbCsRfuvBpBSh2dxC0BrYIjaHtF4qCO8ohv6Q6LYB
         BnFufZkv7U0sRplqztTGwFLIIiL5IUUfMa0FIK4nyYtqUTdGAVm/WlQnyT3kXhijsCoY
         RnCY8ZD4inIQZDrrD5/h6Q1Tz3dB6lAvJ/O0zRB8vCHPi5VdTSQrRfrSAIdsAAhoeyuH
         7zVTIyPObtVpiINHAGPdUOrJSuKHZ13ZX/T0jjUVYC68IV1zubpMpVF8CyKZ9O+S+Ti1
         UIt+SWOwMw3gJwNfP6sMal8bvDosMsT3yjvItHLWWVGadNBe4RJg692dB8l2uLPJe2OD
         FDHg==
X-Gm-Message-State: APjAAAUiDf56jrpHZ+qE5n6ddPHZdCs6bXpnAtOUYsCrkQpztqWWZg0w
        dTBpVmD0xsS6i4Rm0QvtmTvjYFBs86I=
X-Google-Smtp-Source: APXvYqxvtLdAzA4Euyn71p/fPtmaNI3o9qzBh3vLsIJoUiDtgviZd1Out3FTo5PZH5A0cZazGSBx0g==
X-Received: by 2002:a05:6000:f:: with SMTP id h15mr98382623wrx.90.1578331664634;
        Mon, 06 Jan 2020 09:27:44 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id z187sm23725757wme.16.2020.01.06.09.27.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jan 2020 09:27:44 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        jcrouse@codeaurora.org, georgi.djakov@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] interconnect: Check for valid path in icc_set_bw()
Date:   Mon,  6 Jan 2020 19:27:46 +0200
Message-Id: <20200106172746.19803-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use IS_ERR() to ensure that the path passed to icc_set_bw() is valid.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
v2:
- Use WARN_ON() instead of pr_err() (Bjorn)

 drivers/interconnect/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 63c164264b73..d2ba5ae7d25b 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -495,9 +495,12 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 	size_t i;
 	int ret;
 
-	if (!path || !path->num_nodes)
+	if (!path)
 		return 0;
 
+	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
+		return -EINVAL;
+
 	mutex_lock(&icc_lock);
 
 	old_avg = path->reqs[0].avg_bw;
