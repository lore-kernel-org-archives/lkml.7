Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47198C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 04:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC5A2245C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 04:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m7uCB6fK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfKTEAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 23:00:53 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:46346 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbfKTEAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 23:00:52 -0500
Received: by mail-pg1-f201.google.com with SMTP id l5so17097420pgu.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 20:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=A9SfB3u5DRzR9VvNYS3sJfx8KGuaRQunQS/2L5xIff8=;
        b=m7uCB6fKLgvWJlZTvId99mrDEWFo74IPG1IrhJnxsK4JVba7jegBh/VcOKvAfijHhX
         mmON50cv8d2l0QFvd0vuXuqUcvv0O5HAjsfcEaZvzC4LfnP0XEdFV7qTWEMyOe42Sw7P
         YommhwaMrRaBQ9ep6QMo4BWw7Nvyjxcez5ImrtHHNx3zWzb/dOm7dClGZo7VpRKYOH2D
         dZuNlbF4mtw6ZB5xygi89qnQusZnmbMXhRWQqXvs0JlNyOtV9/F3Nq9iy7AhnyRpwd/m
         XFISw7o+LcDo8unUAKs3qn95wKX+5qQqyJqjQtWJbbIHYqk6esijQHPmWoFoS4SNy/pd
         q53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=A9SfB3u5DRzR9VvNYS3sJfx8KGuaRQunQS/2L5xIff8=;
        b=HE/zAkZKgaFQFbbJ/y4cOezBj4VI3Ib7rR8WySxgFMkOja6gIvdsTvanIEoL45X/fH
         LBYC/MX07Yr28VKTbIz7rD7+131GLpsFeZfS/si/kzIhUQ7ZZtDblOhbv1iEG2TAWxBO
         4fbID+L02PB8QiYpo5dq9xw7K9BMWzrI6J2agef1hIpOLpK48Pi8TUw9jFZuaCKTpGQI
         IiuOuT3KzXb+9pqRzO09jFGbvf2ijqnBa4jZPhespzVNmrU5je0txv/QWkmNwcR2SeAH
         /ONoNguxxqVGvkKZhjrODKIlz7Y0sAcC4sGIWpoTLylu8fYozvkkQbJmgCdKyFEHV74E
         N6Qg==
X-Gm-Message-State: APjAAAWPXh3zI5KW7uElUrZaQ/en+umq0L25R59OV8SIRaYJt3AFz1+p
        GlhcKFn8z5KUU99iYT5A2NO0Z9WDmh8xajA=
X-Google-Smtp-Source: APXvYqxsUvVNxqH5VyyRNcQBRC8b8WlZl3yStph+gE6eQAgX+YO3RyQ8wNSeG7sfJOmGM4QFXqYVrcWDbNPdO0A=
X-Received: by 2002:a65:4506:: with SMTP id n6mr753853pgq.105.1574222449984;
 Tue, 19 Nov 2019 20:00:49 -0800 (PST)
Date:   Tue, 19 Nov 2019 20:00:45 -0800
Message-Id: <20191120040045.81115-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH] of: Reduce log level of of_phandle_iterator_next()
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These error messages are mostly useful for debugging malformed device
tree data. So change these messages from error to debug messages to
avoid spamming the end user. Any error messages that might actually be
useful to the user is probably going to come from the caller of these
APIs. So leave it to them to decide if they need to print any error
messages.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/base.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 1d667eb730e1..4762e826f13e 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1335,8 +1335,8 @@ int of_phandle_iterator_next(struct of_phandle_iterator *it)
 
 		if (it->cells_name) {
 			if (!it->node) {
-				pr_err("%pOF: could not find phandle\n",
-				       it->parent);
+				pr_debug("%pOF: could not find phandle\n",
+					 it->parent);
 				goto err;
 			}
 
@@ -1350,10 +1350,10 @@ int of_phandle_iterator_next(struct of_phandle_iterator *it)
 				if (it->cell_count >= 0) {
 					count = it->cell_count;
 				} else {
-					pr_err("%pOF: could not get %s for %pOF\n",
-					       it->parent,
-					       it->cells_name,
-					       it->node);
+					pr_debug("%pOF: could not get %s for %pOF\n",
+						 it->parent,
+						 it->cells_name,
+						 it->node);
 					goto err;
 				}
 			}
@@ -1366,9 +1366,9 @@ int of_phandle_iterator_next(struct of_phandle_iterator *it)
 		 * property data length
 		 */
 		if (it->cur + count > it->list_end) {
-			pr_err("%pOF: %s = %d found %d\n",
-			       it->parent, it->cells_name,
-			       count, it->cell_count);
+			pr_debug("%pOF: %s = %d found %d\n",
+				 it->parent, it->cells_name,
+				 count, it->cell_count);
 			goto err;
 		}
 	}
-- 
2.24.0.432.g9d3f5f5b63-goog

