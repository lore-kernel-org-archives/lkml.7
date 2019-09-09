Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA937C00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF1920678
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7XU/JSn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388994AbfIIIQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 04:16:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37611 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388946AbfIIIQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:16:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so7380637pgp.4;
        Mon, 09 Sep 2019 01:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tME0Q4cNinqlG8VwvZjBQfALZ3g9avp+5J7AvfOF0Ik=;
        b=O7XU/JSnZyh0ihNBIabyaeKW8xwilNoaMj+dCaSbM1saIjrQCKvE7vbjYLLm6Yza/A
         g3aXAeCoddq4Cv8leAH4E/SuQBlHWA8DuBRQKMhnlymy12LeYQwM5skDrlc5b/9e2KLU
         KsD3gSJHST7hvQ8P9IKEs/cUMeyZ/+IlxStHkRtsGqmhtqxVr6OvmdPLnhqWloNekMx5
         Zb+9CPCasy0zj0vhIs4WG/r9Ss1aGMkXimpXEydrJSdDWDd5+snjs+NSaj718h5XM6NP
         Ra1B50tYl2k9Q0kfSVUJSkB1g7rB1nTvy4I5nDiUJyX3eEyj5qcouvoeACXXAcCFgJxh
         xfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tME0Q4cNinqlG8VwvZjBQfALZ3g9avp+5J7AvfOF0Ik=;
        b=HhoEDwjGkl9/LLvPV79MQ1cQWUaBntASx7XrZAUYf+nsk+XRsSkJDhb9tIHeH6RhuV
         f83hez2z92umPmKVqQ2VTdUqfbaAryPDC/G89jz9uxjQ1M/Uyz4w26xByhzENCxNySTz
         bXamJbwGREtCf0OB1PGAXuxbwrXECq7wkFQH3IyXokUaQx8HAa7j69WTIsLVw3zIgrgu
         ByNOrbDSkaYqRp0g7wddIbs6myItE34vYEZzCjg3KW/DdHWNrgRbc1yYQ1XfFYrL809v
         /gscC6/OboVlv2snWW2DxaCwKD0WIau2TnoDDUMItSD6VsAWor3KXVwcMZDENFEeuquY
         yLnQ==
X-Gm-Message-State: APjAAAXKrfcNIJgls/JjdRwc32m8K782Man+4VmHZB54gsoQxo9/9e3E
        0YUFEYz3tPKcg25RDkw42fU=
X-Google-Smtp-Source: APXvYqzBHUwYwhNM18kBXsaeIfdEuaNX4tWsi3xnMBedSuY72okTuyhvxcUKWdN+CKWF3wtMtwryVA==
X-Received: by 2002:a17:90a:fa3:: with SMTP id 32mr24277488pjz.35.1568016971873;
        Mon, 09 Sep 2019 01:16:11 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u65sm12686669pfu.104.2019.09.09.01.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 01:16:10 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 07/13] software node: simplify property_entry_read_string_array()
Date:   Mon,  9 Sep 2019 01:15:51 -0700
Message-Id: <20190909081557.93766-8-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
References: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
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
index a0629365972d..2dfeeab919d4 100644
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
2.23.0.187.g17f5b7556c-goog

