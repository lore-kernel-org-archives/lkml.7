Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFCCC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AE520850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m+qjN7rn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfDLK2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:28:06 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38618 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfDLK2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:28:05 -0400
Received: by mail-ot1-f65.google.com with SMTP id e80so7938049ote.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 03:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ryZOG9VWOye2KDv1BF4UI2W2F776JTHdFGOzv+qLbPo=;
        b=m+qjN7rnHvouHXvPK72mSWvcvikt0TijoLIzMUiXOiILop/kWoWNjLWCSwNK+NyVeX
         42jo1Ax8efWMTT9zuVCDmO+ERI+ul5w7QDrj4uB97ur4laQQm4mjGcIEAIzR4+BA6Pfm
         U3w5FYsXVsRYUKP8mlRTlh85oIJ7pOdwD3r18bNMb9ExDhCDYcpJQvpLDwEWQtHKKsi+
         3Y8StTc5jadZcsydlXhJJ3ycRdBjgHAHuWDm/RM5kvkghhNgtU7xhPZBRhHA/7/T3ZP1
         CiJSCVDXl9QG04WeIvsmLkGTGgNZGCituYChFt7ugQefRRj1ft7UcUvbz3NKPqeDveFV
         n8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ryZOG9VWOye2KDv1BF4UI2W2F776JTHdFGOzv+qLbPo=;
        b=WHvNYWu6Rc7UWWwhoTcGvlh/VBcs9D/NrZWMclA+Hss+1KlbVYW1KkSvyQjJejSk81
         EgIPtPqwXFsqbRa7RwSH8dU1VxOxiKvdMRYXDwht+klwXrwPSZRO+A2DLkcwtOStiXtP
         SI4ekXIhg1+pRbszBxZ/fr+kIj6WS7XcukhVwVQRrIBjW1MmORgqjzXEwqrT2ISsDYub
         Xw/mRJxLMrOYTMP2gGclwwkBqlT9AdEHXpi0F3ivLTcqmJuUjJ13IsnIJMPyUr+WYAGG
         IJPGeCvJxjvYavrg6//5l08PoPoHCs3K42BJ7iX+BUjQFpi3AWMApdH/JHGZnt1+AobY
         jG6A==
X-Gm-Message-State: APjAAAVt3aAfnP77V5sNLlWOIhLl+aQrF9M89FZ/6NLgq1ViJSl6k6sL
        fS93cjZI6buLBmrdS6u0EChNcQ==
X-Google-Smtp-Source: APXvYqx+KrTH06Ps0USKbQhapJHTaMWcGp6gzFAmMyohfcKNJyN+quMT6ubo3ItL8Sr7KTQrAmRBKg==
X-Received: by 2002:a05:6830:20cd:: with SMTP id z13mr36530493otq.168.1555064884588;
        Fri, 12 Apr 2019 03:28:04 -0700 (PDT)
Received: from localhost.localdomain (li808-42.members.linode.com. [104.237.132.42])
        by smtp.gmail.com with ESMTPSA id 88sm17530692otj.3.2019.04.12.03.27.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 03:28:03 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 2/4] coresight: replicator: Add new device id for static replicator
Date:   Fri, 12 Apr 2019 18:27:36 +0800
Message-Id: <20190412102738.12679-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190412102738.12679-1-leo.yan@linaro.org>
References: <20190412102738.12679-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a device id for the new static replicator compatible
string; it changes the driver name from "coresight-replicator" to
"coresight-static-replicator" as well.

This patch also gives warning when use the replicator obsolete DT
binding.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-replicator.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 4e0da85efd2d..8c9ce74498e1 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -189,6 +189,9 @@ static int replicator_probe(struct device *dev, struct resource *res)
 		dev->platform_data = pdata;
 	}
 
+	if (of_device_is_compatible(np, "arm,coresight-replicator"))
+		pr_warn_once("Uses OBSOLETE CoreSight replicator binding\n");
+
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
@@ -285,13 +288,14 @@ static const struct dev_pm_ops replicator_dev_pm_ops = {
 
 static const struct of_device_id static_replicator_match[] = {
 	{.compatible = "arm,coresight-replicator"},
+	{.compatible = "arm,coresight-static-replicator"},
 	{}
 };
 
 static struct platform_driver static_replicator_driver = {
 	.probe          = static_replicator_probe,
 	.driver         = {
-		.name   = "coresight-replicator",
+		.name   = "coresight-static-replicator",
 		.of_match_table = static_replicator_match,
 		.pm	= &replicator_dev_pm_ops,
 		.suppress_bind_attrs = true,
-- 
2.17.1

