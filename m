Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFC2C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7B920842
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SZZFDZzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfCCRgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 12:36:31 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47056 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfCCRg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 12:36:29 -0500
Received: by mail-pf1-f196.google.com with SMTP id g6so1286022pfh.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 09:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vJPTx000oHxbopR6zSva+6PYTZChrEwYDWEdYvNHNSw=;
        b=SZZFDZzAKGseSn3ySk56BE72SkGB/cctCQLD2HMzWaXLItoLAUHTNv8+AKaQJtOZr6
         7G94/LEMpIGOB8LeSXhKRk5v48oPEh4Bli2Q7rCzhfC1KM8eGI5kOzW/1qmb6wBJJpn9
         l/7EOWAHDhpr+aUn+8i1DfnYGkCnNE/2zGKFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vJPTx000oHxbopR6zSva+6PYTZChrEwYDWEdYvNHNSw=;
        b=oL/SCMnpW2WhiB6YzrRA4z3a/XzGu9GM5181qQJeRxVWy2rne9sn6Vv26R//dVQt0y
         8hBDytepWgiQ+uz6wHgvFLVVDwBewCOLrI4SiR0RWUQCO3UTXmQzHtNHikG4z/ISYNrC
         XiTQfsna4DKjrQDwgroXKM5YvcBSR+T1lXxSedS9nk7riHe629UItBQD4CvBcCnrShlf
         te/kOyqmHJtsUIE5b5Y3jBanULx+fKQsOkwwJenPmSQkLBQyd1O+VxkMCkulOdDsOh5z
         SlBb0RNRVYFuP4SoDil82ZBdHS138vwPWKEHgIUxCVjg9Z2F1xWvtAshVm3XSK4mDSRb
         eZcQ==
X-Gm-Message-State: APjAAAWRcnEf9XE7tVpk4ghaPxYEPBAlnQKrLsc7u6KOMevGxNh9G/GV
        8QzD4BfijiiPfEtBkAw+TirtfA==
X-Google-Smtp-Source: APXvYqxPgxhRSykWz7+/csq2o3JggZowiY4OEPnJlGnRLSmE+fk/rSEqeuGKOjGVBBzGgGe2M3gKNQ==
X-Received: by 2002:a63:e752:: with SMTP id j18mr14560664pgk.313.1551634588608;
        Sun, 03 Mar 2019 09:36:28 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id d129sm5614737pgc.59.2019.03.03.09.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 09:36:28 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v9 4/5] drm/sun4i: sun6i_mipi_dsi: Support DSI GENERIC_SHORT_WRITE_2 transfer
Date:   Sun,  3 Mar 2019 23:05:26 +0530
Message-Id: <20190303173527.31055-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190303173527.31055-1-jagan@amarulasolutions.com>
References: <20190303173527.31055-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some DSI panels do use GENERIC_SHORT_WRITE_2 transfer protocol to host
DSI driver and which is similar to GENERIC_SHORT_WRITE.

Add support for the same transfer, so-that so-that the panels which are
requesting similar transfer type will process properly.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index b38358465d87..31ec4048804d 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -993,6 +993,7 @@ static ssize_t sun6i_dsi_transfer(struct mipi_dsi_host *host,
 	switch (msg->type) {
 	case MIPI_DSI_DCS_SHORT_WRITE:
 	case MIPI_DSI_DCS_SHORT_WRITE_PARAM:
+	case MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM:
 		ret = sun6i_dsi_dcs_write_short(dsi, msg);
 		break;
 
-- 
2.18.0.321.gffc6fa0e3

