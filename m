Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DD6C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A0E217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gUnX3uWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbfGQWYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 18:24:11 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:55042 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730921AbfGQWYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 18:24:07 -0400
Received: by mail-vk1-f201.google.com with SMTP id w137so11793864vkd.21
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 15:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DiFJ3QV0jm1YQeH6o85iwOHAT3O/cgKmhpXPhBt1zRY=;
        b=gUnX3uWKzKk0PdpWQOACtbCTUosGhC+9X0hmQ8V9U0YJgXRqIB7VQ82FCFG0UaJZgc
         ANHsa7Am/jr3H95GksDN+aZmOygrs8L74TDbC8/XgptqkBFsTMsk6GligRGiGe/KnInP
         EDr4mxKVQAhQcthiTTFSxY0rADMAj9jGZYOVzO2PbcLzkZNoEvYe9g0z5YqmuKJ89dF3
         B4ByPzdiT6Yhd+AWM6x8lr87ib5BFJAatlvOE+TvhbUy1qN12S/0oJE91nD/HkU6v/JH
         KT24Fj55t1N5sXs0DGIBl8CjLkb4WmGcxMtiCWEMcGYeR+kD2kDk3oqQVNP3YLiLa6aq
         sBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DiFJ3QV0jm1YQeH6o85iwOHAT3O/cgKmhpXPhBt1zRY=;
        b=Sjw4rfB2ZyhZJE2MGRQHnUhV1svCDWUnjroTvdA5EV7GzEETGZPlhhrN/BsGjiOV3W
         koQVFq4BJa12PyV2xUuFaQe+ctRDyZpnHVke9eFmfl5AuoEKMpnJeGq2oCuxrWR7WPxD
         nWFsk9g7Ah9dg0MS1arofQDlJDhgVJjGnUl7cmD2NUQSZ9YF0NRl2UOFFqQC1s28ULye
         pNcofpoUt+YAgXD+VW8ywGWF8TGu1JwOgmyDB8qes40vFT9deASqpVtufyp6HQQmT+zZ
         T81WwOnDsAwy7i3bhvAVC+GJvJ3+p47pDy7Lj6J7hHvJOS/P9v7M3u+bG/KEVv6TWWUH
         0l9g==
X-Gm-Message-State: APjAAAUPl6g3OedliKZ6Gm3873ywuWgk5FldobV9z91KyctuD8vugNzn
        n+KE5cWe+caDeJEKFsIgr0sLq2Y85sKhkb8=
X-Google-Smtp-Source: APXvYqy3zbgHJTqW4oLLmWuWgsYaMIERwR4ozjSI+WlW5wAorsi4CAIdlvBrgoJK7UM67//EQe4dWRuDxbj9++c=
X-Received: by 2002:ab0:7457:: with SMTP id p23mr4958003uaq.138.1563402246655;
 Wed, 17 Jul 2019 15:24:06 -0700 (PDT)
Date:   Wed, 17 Jul 2019 15:23:40 -0700
In-Reply-To: <20190717222340.137578-1-saravanak@google.com>
Message-Id: <20190717222340.137578-6-saravanak@google.com>
Mime-Version: 1.0
References: <20190717222340.137578-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v3 5/5] PM / devfreq: Add required OPPs support to passive governor
From:   Saravana Kannan <saravanak@google.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        Sibi Sankar <sibis@codeaurora.org>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Look at the required OPPs of the "parent" device to determine the OPP that
is required from the slave device managed by the passive governor. This
allows having mappings between a parent device and a slave device even when
they don't have the same number of OPPs.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/governor_passive.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 58308948b863..24ce94c80f06 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -19,7 +19,7 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 			= (struct devfreq_passive_data *)devfreq->data;
 	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
 	unsigned long child_freq = ULONG_MAX;
-	struct dev_pm_opp *opp;
+	struct dev_pm_opp *opp = NULL, *p_opp = NULL;
 	int i, count, ret = 0;
 
 	/*
@@ -56,13 +56,20 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	 * list of parent device. Because in this case, *freq is temporary
 	 * value which is decided by ondemand governor.
 	 */
-	opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
-	if (IS_ERR(opp)) {
-		ret = PTR_ERR(opp);
+	p_opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
+	if (IS_ERR(p_opp)) {
+		ret = PTR_ERR(p_opp);
 		goto out;
 	}
 
-	dev_pm_opp_put(opp);
+	if (devfreq->opp_table && parent_devfreq->opp_table)
+		opp = dev_pm_opp_xlate_opp(parent_devfreq->opp_table,
+					   devfreq->opp_table, p_opp);
+	if (opp) {
+		*freq = dev_pm_opp_get_freq(opp);
+		dev_pm_opp_put(opp);
+		goto out;
+	}
 
 	/*
 	 * Get the OPP table's index of decided freqeuncy by governor
@@ -89,6 +96,9 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	*freq = child_freq;
 
 out:
+	if (!IS_ERR_OR_NULL(opp))
+		dev_pm_opp_put(p_opp);
+
 	return ret;
 }
 
-- 
2.22.0.510.g264f2c817a-goog

