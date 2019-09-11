Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61224ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3566821D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJt1wbxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfIKFNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 01:13:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43074 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfIKFMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 01:12:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id u72so10881640pgb.10;
        Tue, 10 Sep 2019 22:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Quna5dhwEKx+rAq2g69EwnMLgIT5ImG5uNLk/TAdGE4=;
        b=FJt1wbxcOvsw1NxaBU/dPTHar140OLodCaSHmQbWZHNYlFmBwM78EnU1Tu5fKNNpO7
         A2jihYwwI4L7XryVJjoKZBunJc4LF2LiXXxeHCRuHxnE0adivvy5pi84dXTTfsTh2xzf
         mEBJyn1zwlQDi2Ht7SLZpVRu1t/xa5I60cE2ifJEW/XV5sosOa94vyaH59aWrLM/ho2u
         90aKOWIsEp0YOrYWTV5ZfCU8Y3IIytiTzWVrtgyxBeuDlFunuItxKwBRqMqencksQ8mJ
         uJd1u2jOnmLUXpMaGnDxTa7937ZWio350zwQ7ye2G7OcPlI1ZSBakJmSd2T5X7HMe9fz
         i7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Quna5dhwEKx+rAq2g69EwnMLgIT5ImG5uNLk/TAdGE4=;
        b=CbiyYntYbDgahHWn4BclVmHqNuj1arVoa1kTWKXaOzZ8KQJBlnNYoVI09+WYGSr8Wb
         7YheKUKHwyykUNy0MP5kqQXyG3pc6+VHdND+DlSC5VA5p7qZBV4NKiKExXX1RiLq4CvD
         21DuqoHVJOPAV2trt4M/rKtCe9FB0frVgTgBOLU8jWdM0ddSV1GoT4lpVkgy6x1XxPga
         UTEvCI/2KcccW9YO+rvtldDOsv5ORWBmwl0IuTqDI754wJ6lJKt4mQ1e4fx0b2wOhhMu
         efLyb1/mM0/be8dsoaA2DX7LMN1Z/DEkOHcAOIqCytHGHMv3I+AjiZ3DX5lPPYGXaR3L
         2nrQ==
X-Gm-Message-State: APjAAAW70JKdrISLP2QPA9Dy1d5tPKI3eYIAVIIUK/2GbLcX7G5Ub/ir
        DXjdd667b/iRxcyIesAoMoM=
X-Google-Smtp-Source: APXvYqw2AREs9xiEQAGYIQXwEB31ZMDQbSji6wbL9i8RjBUltOK8HlwMdV/h44zH9lwK+kXoavYqIw==
X-Received: by 2002:a62:1a4d:: with SMTP id a74mr4708634pfa.179.1568178767612;
        Tue, 10 Sep 2019 22:12:47 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id p11sm22011149pff.136.2019.09.10.22.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 22:12:46 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 09/14] software node: simplify property_entry_read_string_array()
Date:   Tue, 10 Sep 2019 22:12:26 -0700
Message-Id: <20190911051231.148032-10-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
In-Reply-To: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
References: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to treat string arrays and single strings separately, we can go
exclusively by the element length in relation to data type size.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/swnode.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index a019b5e90d3b..9c3e566c753e 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -173,28 +173,21 @@ static int property_entry_read_string_array(const struct property_entry *props,
 					    const char *propname,
 					    const char **strings, size_t nval)
 {
-	const struct property_entry *prop;
 	const void *pointer;
-	size_t array_len, length;
+	size_t length;
+	int array_len;
 
 	/* Find out the array length. */
-	prop = property_entry_get(props, propname);
-	if (!prop)
-		return -EINVAL;
-
-	if (prop->is_array)
-		/* Find the length of an array. */
-		array_len = property_entry_count_elems_of_size(props, propname,
-							  sizeof(const char *));
-	else
-		/* The array length for a non-array string property is 1. */
-		array_len = 1;
+	array_len = property_entry_count_elems_of_size(props, propname,
+						       sizeof(const char *));
+	if (array_len < 0)
+		return array_len;
 
 	/* Return how many there are if strings is NULL. */
 	if (!strings)
 		return array_len;
 
-	array_len = min(nval, array_len);
+	array_len = min_t(size_t, nval, array_len);
 	length = array_len * sizeof(*strings);
 
 	pointer = property_entry_find(props, propname, length);
-- 
2.23.0.162.g0b9fbb3734-goog

