Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F05C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE34B2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i86wsPp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbfGOKA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:00:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41516 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbfGOKA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 06:00:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id q4so7464466pgj.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 03:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5aSldgrUNSK5XytyDzCE2r6IPKJFqEPbYobzHqmxrgk=;
        b=i86wsPp+N/DWz7EWLy/hkz5gmE1W4UcwoI41T3KH2E2Eduip2LoEakJk2Euy51rqBh
         VcUrlKtSjyMOa5didb9kkNmMPQedYna2CXJILoC6U2QmO/cJhOgda2uuqaO2DvRyQjWX
         K3XeZeq/tCKRD/kQf/bloKELfHr8dcbuYAb32ur5F8HhGF1SXs0Hi0MgLF5XsgCVWcSL
         uKfRbztPVzufskCkwhGjpN3VIVdav6jc/HCizJpR0QKdsgwSanKpHDYd/p8/M4Q7mNOE
         z43phdtSQndFFgwt5646aW5jw/+WaMVKdjtWI8aAJ9sx51pxmW+EFFKB1cBLk0nXoTxT
         okdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5aSldgrUNSK5XytyDzCE2r6IPKJFqEPbYobzHqmxrgk=;
        b=bXxv8cmDP34iuotVPeC8b1yki7DnekCPIEYCaxydTysz96mKd9FtyljvPVITfjeV3f
         JTP1UVtaBB7FCkrl/PcEnAdPLdrzgk3nlNPr750OuEk59a1wEw+w97xcdHhyuo23CXnD
         ets65oxjVaVyolI7sDBEhkzfm0rrBqeGqus4Tjy7w+hj5wVSrIbWEOBGugXnHU3HaLig
         LC7+w8yP9JVnmAULc2RaW6rTmqtNlwataZXT/myjCszzZdQitXi4uFk8r6cnncGSPHxV
         /4O2RBPlnJdOv31Od+Pa2a3at1Fm2ZrJ0sM7CZNuCJuwpfOKo9SrTtDlEmrCG1AMee8V
         tigQ==
X-Gm-Message-State: APjAAAWq92SQFnPRG5UU3AJ3sC77PA2iwtQpKHZRxdJttax7YunKNKFI
        cSHBvXJUPb4Ra0LzVXQqSmDZOQ==
X-Google-Smtp-Source: APXvYqyjjljxwukQaF3urZseJzTy1AsnzMnYzJjfnyDdNrG7pSlanlxu4i8SlqG9v66BGSqdS8sWQQ==
X-Received: by 2002:a17:90a:3086:: with SMTP id h6mr28866035pjb.14.1563184828689;
        Mon, 15 Jul 2019 03:00:28 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e13sm21971842pff.45.2019.07.15.03.00.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Jul 2019 03:00:28 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: host: sdhci-sprd: Fix the missing pm_runtime_put_noidle()
Date:   Mon, 15 Jul 2019 18:00:14 +0800
Message-Id: <7bff392d44bf32e9e762ef6e3b53df0d95c22c91.1563184567.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the SD host controller tries to probe again due to the derferred
probe mechanism, it will always keep the SD host device as runtime
resume state due to missing the runtime put operation in error path
last time.

Thus add the pm_runtime_put_noidle() in error path to make the PM runtime
counter balance, which can make the SD host device's PM runtime work well.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci-sprd.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 6ee340a..603a5d9 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -624,6 +624,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	sdhci_cleanup_host(host);
 
 pm_runtime_disable:
+	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 
-- 
1.7.9.5

