Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E60C28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE9124BBB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFE4DqoY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbfE3DkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:40:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41469 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbfE3DkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:40:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id q17so3017399pfq.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 20:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=On4X9gP05IE6u39GfyTMWmnrBCSblT4ly+1lTynpuxM=;
        b=WFE4DqoYhBaDtI9vw3yEq3Sxu3mrMEHM4SNbqfZDx7gvEkRpIDcYfZQiHrSXQ1Bc7B
         FK+LpSF8yaLmLfFN5JYb7uj1zjEQektzjXwoPdv3ZQaKBCm/ElkH+ni23Al/lwx2KgQG
         AfhookdRR5uoVsK8/zss+h1bMt9jBNPhTzG4Eu+a25QFFV5nu4WB7B5plmiZ4sM8rbZL
         pgvBSDmABvSSWZbepyvbrSth84KbKOm07FT4plShm+qxtdFkO5tu5ztV326tDGiLQ2rt
         YKnj2Yn+0yF+fzra8DM4HhFuSscDR9floBREUQ12DB/kazlg2m+CadyTZmQZP6i7qqZA
         1PNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=On4X9gP05IE6u39GfyTMWmnrBCSblT4ly+1lTynpuxM=;
        b=qceonGsqykFoKCiorq+OC80Sw+ccvuEgmWmu3FMKH8ADvUqpVqVqycCqFSD505jRNC
         1NWtogBNbGZMJtwLoquuBCYcJGpkMU49/3G3mN1lMgcS4vZIlfc+BqYjcTT7hLamzaGD
         EGHr4xpwM4crmhul0AtyI+2rN/IIgVbFhUCfVhuyMcb5jxqHMlBfuF8ttTrBQleOFX+q
         1ZmeXousGRRy0Wx8LtdrHeO9kMHjJw8kgXsA1bs0hPos81azVXMqceGcHNuqSQO2SQBH
         DaP17K1tGHaNC5iCPgzjcjr+32o0H3otRTUyfyTmDMptRoI8RMWnaWR2YZrNB8UcQFT9
         hkgQ==
X-Gm-Message-State: APjAAAXpCt3XpwFNzQZgw9PNpES4mstIvQdMdII+BDj00IshcD4+oirW
        S4/3WbjbfO+bWwBvS7AEVpU=
X-Google-Smtp-Source: APXvYqxuFSdogN4yad6fsZaedYCCU8dUKIXjf4voXj6fUVc2vKA9MzYgvckHtvbeiGEpL+lIZvhLKA==
X-Received: by 2002:a17:90a:b393:: with SMTP id e19mr1414944pjr.91.1559187603609;
        Wed, 29 May 2019 20:40:03 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id r4sm1155654pfq.134.2019.05.29.20.39.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 20:40:03 -0700 (PDT)
Date:   Thu, 30 May 2019 11:39:49 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     ssantosh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] knav_qmss_queue: fix a missing-check bug in
 knav_pool_create()
Message-ID: <20190530033949.GA8895@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In knav_pool_create(), 'pool->name' is allocated by kstrndup(). It
returns NULL when fails. So 'pool->name' should be checked. And free
'pool' when error.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
---
diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 8b41837..0f8cb28 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -814,6 +814,12 @@ void *knav_pool_create(const char *name,
 	}
 
 	pool->name = kstrndup(name, KNAV_NAME_SIZE - 1, GFP_KERNEL);
+	if (!pool->name) {
+		dev_err(kdev->dev, "failed to duplicate for pool(%s)\n",
+			name);
+		ret = -ENOMEM;
+		goto err_name;
+	}
 	pool->kdev = kdev;
 	pool->dev = kdev->dev;
 
@@ -864,6 +870,7 @@ void *knav_pool_create(const char *name,
 	mutex_unlock(&knav_dev_lock);
 err:
 	kfree(pool->name);
+err_name:
 	devm_kfree(kdev->dev, pool);
 	return ERR_PTR(ret);
 }
