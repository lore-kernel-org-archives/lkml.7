Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D084C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7497720730
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ee4cbJHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfKVP1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 10:27:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40485 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbfKVP1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 10:27:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id 4so5772444wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 07:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eweICdklgtftJBxCro04D547skXpMw40lN0wG851Q8Y=;
        b=Ee4cbJHqmAb7pyy2MpzCOQm8pAD4EZdA9GpnkGAu00Qo6T6NoW6AyF8/fgzxC/5slv
         5iRVO0Wr82T9F1XXz/1vTI6AXz7ta3qUDkp3B41/q5RJAta1wKh73G9ySad/CPZzyX3v
         UVkshIEEiIb11rkciVTahVMKB7z4j6t6tZzhd5g4qDIVQWlHLYBBr1FMgw4ZlF3JOK3S
         BFHI4O+1kJ5kAfn1NqotmKfJc2wMtESn9EB7YSvPnGFIq5VcJBLG8FOsQorCvFCWehrw
         IzioRR4M860jpSOOiFt6ZmMiH5a1a1Fjh/7qum6Civz6CPeLoH19PWCGWpWJWFThANtg
         AqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eweICdklgtftJBxCro04D547skXpMw40lN0wG851Q8Y=;
        b=osGtuw3giD3Y2wh91LEgGhRqadnKptb7YbC0WKIUfK1rjFADUO50gdpBOpMNUWt/4h
         h9ujUKehfKWMbeGUmn7v9V+KjxgPbb0XiUOdWz1N1xgx4xadiyGH+kMQ2N2d9HcYBD3O
         Chsq0W3Z5tTPib3fuIa9v5LUBnncGEskeEspb8EljnSfCHtb5CLT6eFF8R720Ljb9U71
         e62SyqRsP90NaJUyG6MpyQ5Nt5TAeSLLSLvHDWnp5rrQ9zEcgsEu8+17+VhtASAcKJtA
         2egS4jmCYlYgiqoRwunRF6e9zgx3OOFaKJ3cgRe7PA5kfiFuFruzTAWYvzvMmY5lpq6l
         RUKA==
X-Gm-Message-State: APjAAAW+g18sO/I0wb9Es2fE1ivVrZnleb9iSFCJLtOC2FQrjd4Agl92
        0Ks57Rk2ppeK8BJ9mjE0SI7A/w==
X-Google-Smtp-Source: APXvYqxyLgrpG1CNItLEZ8lsMfMwN8Lz3v0Z8pAzTXjVib3+blzMHQx9v9FBAhIYDtIgyEIu2HLh8g==
X-Received: by 2002:adf:e911:: with SMTP id f17mr19085504wrm.300.1574436437060;
        Fri, 22 Nov 2019 07:27:17 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a206sm4061081wmf.15.2019.11.22.07.27.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Nov 2019 07:27:16 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        evgreen@chromium.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v3 2/3] interconnect: Add a name to struct icc_path
Date:   Fri, 22 Nov 2019 17:27:11 +0200
Message-Id: <20191122152712.19105-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122152712.19105-1-georgi.djakov@linaro.org>
References: <20191122152712.19105-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When debugging interconnect things, it turned out that saving the path
name and including it in the traces is quite useful, especially for
devices with multiple paths.

For the path name we use the one specified in DT, or if we use platform
data, the name is based on the source and destination node names.

Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c     | 18 +++++++++++++++---
 drivers/interconnect/internal.h |  2 ++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index b06ed180bae3..1ddad8ef3cf0 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -356,9 +356,17 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
 
 	mutex_lock(&icc_lock);
 	path = path_find(dev, src_node, dst_node);
-	if (IS_ERR(path))
-		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
 	mutex_unlock(&icc_lock);
+	if (IS_ERR(path)) {
+		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
+		return path;
+	}
+
+	if (name)
+		path->name = kstrdup(name, GFP_KERNEL);
+	else
+		path->name = kasprintf(GFP_KERNEL, "%s-%s",
+				       src_node->name, dst_node->name);
 
 	return path;
 }
@@ -481,9 +489,12 @@ struct icc_path *icc_get(struct device *dev, const int src_id, const int dst_id)
 		goto out;
 
 	path = path_find(dev, src, dst);
-	if (IS_ERR(path))
+	if (IS_ERR(path)) {
 		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
+		goto out;
+	}
 
+	path->name = kasprintf(GFP_KERNEL, "%s-%s", src->name, dst->name);
 out:
 	mutex_unlock(&icc_lock);
 	return path;
@@ -519,6 +530,7 @@ void icc_put(struct icc_path *path)
 	}
 	mutex_unlock(&icc_lock);
 
+	kfree(path->name);
 	kfree(path);
 }
 EXPORT_SYMBOL_GPL(icc_put);
diff --git a/drivers/interconnect/internal.h b/drivers/interconnect/internal.h
index 5853e8faf223..bf18cb7239df 100644
--- a/drivers/interconnect/internal.h
+++ b/drivers/interconnect/internal.h
@@ -29,10 +29,12 @@ struct icc_req {
 
 /**
  * struct icc_path - interconnect path structure
+ * @name: a string name of the path (useful for ftrace)
  * @num_nodes: number of hops (nodes)
  * @reqs: array of the requests applicable to this path of nodes
  */
 struct icc_path {
+	const char *name;
 	size_t num_nodes;
 	struct icc_req reqs[];
 };
