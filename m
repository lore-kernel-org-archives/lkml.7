Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1426BC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 03:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC778214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 03:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j7FjqYqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733081AbfKGDUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 22:20:35 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38472 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbfKGDUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 22:20:35 -0500
Received: by mail-pf1-f194.google.com with SMTP id c13so1282962pfp.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 19:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2oC3yJJXBDl4Wr0A5jeoRouH5CPSnlYcDExtnV2jGKQ=;
        b=j7FjqYqYchtyDbwjW7ryF1WpehF5qoKiuEYjAahXifGnYIAPnQfZmD1p6vxvfB6Xlj
         CrL4M5oduRqpQcWyDaO5DOqU+GIGt9NJQaatkqIuwJL+s0jVd+rZOh8+T7eWpZ/L3ELn
         VLACicXal+IJHmJUtphKMXgviaJXuETGgbjXkI+RZE8GtZMHKb61wYvecNrdr4CVTx0q
         FWg7Y2px83ntq+Y1F5gtjh15O5g0/As2XUQPDRBMLGMoY2bCu9iw+YbV2nC0A7RrmzKc
         8Y2Ms8pzDjl6Fpw/ySvXByeADgsCSIhG9qMrMhYALp0kIXnjXdbidxA6wB8M+NHjiONq
         7Kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2oC3yJJXBDl4Wr0A5jeoRouH5CPSnlYcDExtnV2jGKQ=;
        b=aT629UjaF5eoIHhEsud9TYDslSXjtpsgacKjom8Swf3APrfHstl7IuQxj4zyHaGUwc
         VhPTdJMiKSXZC1Vd4RGMP6kcZCdj79yrJbz5ZDQ49L7ixq12hYGLoWu1zjY1CR8tUloZ
         zO5URYVV/AlFnFfOmEIRzrWTrPHSWx3xgEW/pMeZj5bps0QWIhxlzoJH2TROr/r7zUdk
         pYdSWikGGgNphFlJoFicaA5WTOxfEOkhs0TXqpIm9UY31z+Kyf0faispF1Bij4iql1gk
         bmr+n6GtP7K0BrxgzPzfr0608S0YK4FBTBIhXgfYt2yAbBDc5NQA2TKu0ZtkBNvh6wPb
         B3mQ==
X-Gm-Message-State: APjAAAUMmOq3AkidBM2w6fGdsyg/UORgZ/2nnX5M2llJI0zKw9zyP2FN
        A1ZEDGSM1rT/uxZHRAnRc2E97sJtt5o=
X-Google-Smtp-Source: APXvYqz0puT+Kdua5STtrjcl24wC8akQcYeHP6/4jA+rq9BMZhcU+xIEkwN6yi7p0uDufuX966jCOA==
X-Received: by 2002:a17:90a:a598:: with SMTP id b24mr1989317pjq.46.1573096834829;
        Wed, 06 Nov 2019 19:20:34 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id x20sm441541pfa.186.2019.11.06.19.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 19:20:34 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IB/qib: Validate ->show()/store() callbacks before calling them
Date:   Thu,  7 Nov 2019 08:50:25 +0530
Message-Id: <d45cc26361a174ae12dbb86c994ef334d257924b.1573096807.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The permissions of the read-only or write-only sysfs files can be
changed (as root) and the user can then try to read a write-only file or
write to a read-only file which will lead to kernel crash here.

Protect against that by always validating the show/store callbacks.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/infiniband/hw/qib/qib_sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/hw/qib/qib_sysfs.c b/drivers/infiniband/hw/qib/qib_sysfs.c
index 3926be78036e..568b21eb6ea1 100644
--- a/drivers/infiniband/hw/qib/qib_sysfs.c
+++ b/drivers/infiniband/hw/qib/qib_sysfs.c
@@ -301,6 +301,9 @@ static ssize_t qib_portattr_show(struct kobject *kobj,
 	struct qib_pportdata *ppd =
 		container_of(kobj, struct qib_pportdata, pport_kobj);
 
+	if (!pattr->show)
+		return -EIO;
+
 	return pattr->show(ppd, buf);
 }
 
@@ -312,6 +315,9 @@ static ssize_t qib_portattr_store(struct kobject *kobj,
 	struct qib_pportdata *ppd =
 		container_of(kobj, struct qib_pportdata, pport_kobj);
 
+	if (!pattr->store)
+		return -EIO;
+
 	return pattr->store(ppd, buf, len);
 }
 
-- 
2.21.0.rc0.269.g1a574e7a288b

