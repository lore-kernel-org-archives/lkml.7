Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E24C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C9921473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139970;
	bh=OdW4+1iIZqwdCg6++NJNQEwqcwQZ7/gL7hZQasbqCFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TKvBry3iAbR2dR4duoB1SKZGVcJaZtgmTWmNFFLyWQ9Emx9WS6XRPD9lhY4IkOTKA
	 yZehkbIyTy+318vFRYO0Gz3k9gzL5EB8dPn+3FL2KvlIywBQjRkd6UfaQzJxjUZuC5
	 +LKjcCzt3V6+brAV6drPJ5PuR7mblZqRSr0tSax8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387534AbfDARct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732841AbfDARcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:32:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66F452146E;
        Mon,  1 Apr 2019 17:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139965;
        bh=OdW4+1iIZqwdCg6++NJNQEwqcwQZ7/gL7hZQasbqCFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dZpMZISWKZlDdV+Z/Kd1z1SPrKPSHzveuXtGgytDqLTJ66MSWKQFHxWqjBdiU30iM
         L3o6eXwkR/oRX0BYShbCVqyUG7pjCXrTogb//c2FWiWbufWNehpwAGsmdPOUkwWJ+u
         KXSnXYEJP/Nstcy059LE/lfkhTmzr2gMAityVfLs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Long <eric.long@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 066/131] coresight: "DEVICE_ATTR_RO" should defined as static.
Date:   Mon,  1 Apr 2019 19:02:16 +0200
Message-Id: <20190401170057.736368951@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit bf16e5b8cdeabc1fe6565af0be475bb2084dc388 ]

"DEVICE_ATTR_RO(name)" should be defined as static. And
there is an unnecessary space at the front of the code.

The sparse tool output logs as the following:
coresight-etm4x.c:2224:1: warning: symbol 'dev_attr_trcoslsr' was
not declared. Should it be static?
coresight-etm4x.c:2225:1: warning: symbol 'dev_attr_trcpdcr' was
not declared. Should it be static?
coresight-etm4x.c:2226:1: warning: symbol 'dev_attr_trcpdsr' was
not declared. Should it be static?
And the smatch tool output logs as the following:
of_coresight.c:89 of_coresight_alloc_memory() warn:
inconsistent indenting

Signed-off-by: Eric Long <eric.long@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 2 +-
 drivers/hwtracing/coresight/of_coresight.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index a6707642bb23..1ec6798b21e8 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -2219,7 +2219,7 @@ static ssize_t name##_show(struct device *_dev,				\
 	return scnprintf(buf, PAGE_SIZE, "0x%x\n",			\
 			 readl_relaxed(drvdata->base + offset));	\
 }									\
-DEVICE_ATTR_RO(name)
+static DEVICE_ATTR_RO(name)
 
 coresight_simple_func(trcoslsr, TRCOSLSR);
 coresight_simple_func(trcpdcr, TRCPDCR);
diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 7d2bb1549608..fb7597b1c66f 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -86,7 +86,7 @@ static int of_coresight_alloc_memory(struct device *dev,
 		return -ENOMEM;
 
 	/* Children connected to this component via @outports */
-	 pdata->child_names = devm_kzalloc(dev, pdata->nr_outport *
+	pdata->child_names = devm_kzalloc(dev, pdata->nr_outport *
 					  sizeof(*pdata->child_names),
 					  GFP_KERNEL);
 	if (!pdata->child_names)
-- 
2.19.1



