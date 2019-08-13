Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D9EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6389520665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTXyAVbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfHMH4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 03:56:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39567 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbfHMH4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:56:12 -0400
Received: by mail-pl1-f196.google.com with SMTP id z3so2129485pln.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 00:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h+Z7GdmKyN86mzegYGQq2TLQN0XZVaQV18q5hjkA4xg=;
        b=LTXyAVbhb3SEvPydQz1X+raCFPgwJyBB49RiP2qTc5K4/k5PDnJIxld642kBvPFBg1
         LBdHrKqKA750ez550nxXWAEOW3/BZwkZypcQb5BYSFiqrudwrKBoeXAaxI4JJvoA4P7t
         LOcq+dNCjRXwOR/qu3dB3FoTUSuwrJDYzCrb1th0qVQ6H2khKgCjZvcbQf3XmGDeGj9o
         NlQSL/YR8GsAobDyK0ac7wY0t1m6S2gOuyM6AU2hXN4RezkwHV6kZsMG9NMI94DKBTP+
         01+rf0oe63RSuHYI1MrRRB4x5IIejLCj+F/Q3gNOnvYidRjevwVy7h0JTAGZzwz1C25d
         RgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h+Z7GdmKyN86mzegYGQq2TLQN0XZVaQV18q5hjkA4xg=;
        b=q9y1EhkZ6R2Tq/f/bkTMu4YzxD21c7owLQaFemBzui1vj3xg2GONRizCCMalc6qg7a
         qdrvawSBbXcosG8qVhsEgltMsY73gWHpl/bic9nTJ0MQVJ5X2ppI+lG4ANwvwtliEmPH
         c+Ow6EH7I7yubjmM3tYo2NW3ufyglamUlF6pfMy3YFdIQuMUjWUWePCYFfyf5eyc8BC3
         X6UNj3mzjCVbxn3C3Fxbps1BNGgXdcNJMIj1TG0q9AZxQXIr+3fyw61ksZog+cDKqCl0
         b0TURGg7HKP7ydvabo6EAAexRaqdBkl39YusCaNOYFwt1Br9JzKeLsDIobAJa/CkfZiU
         2+cg==
X-Gm-Message-State: APjAAAUJuW0mnfjzNvqlj8WPl6H2oTIPJih/IPyK+m14zv8Aqlidp0qo
        pFv2VdvlBbtCmjhG1M6dMCN2nzdr
X-Google-Smtp-Source: APXvYqz7Cg27UpGkbl5jF9+BN4LBJMO9LR7W3KFgO7J+PsiMZLznjsVyqKZafCLA8Wn0wRUxKWXtnQ==
X-Received: by 2002:a17:902:74c4:: with SMTP id f4mr35054352plt.13.1565682971742;
        Tue, 13 Aug 2019 00:56:11 -0700 (PDT)
Received: from localhost.localdomain ([122.163.110.75])
        by smtp.gmail.com with ESMTPSA id y16sm10713834pfc.36.2019.08.13.00.56.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 00:56:11 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     tony@atomide.com, rogerq@ti.com, linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH v3 2/2] bus: ti-sysc: sysc_check_children(): Change return type to void
Date:   Tue, 13 Aug 2019 13:25:53 +0530
Message-Id: <20190813075553.2354-2-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190813075553.2354-1-nishkadg.linux@gmail.com>
References: <20190813071714.27970-1-nishkadg.linux@gmail.com>
 <20190813075553.2354-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change return type of function sysc_check_children() from int to void as
it always returns 0. Remove its return statement as well.
At call site, remove the variable that was used to store the return
value, as well as the check on the return value.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
- This is a new patch; labelled v3 only because it is in the same series
  as the previous patch.

 drivers/bus/ti-sysc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 9c6d3e121d37..a2eae8f36ef8 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -628,14 +628,12 @@ static void sysc_check_one_child(struct sysc *ddata,
 	sysc_parse_dts_quirks(ddata, np, true);
 }
 
-static int sysc_check_children(struct sysc *ddata)
+static void sysc_check_children(struct sysc *ddata)
 {
 	struct device_node *child;
 
 	for_each_child_of_node(ddata->dev->of_node, child)
 		sysc_check_one_child(ddata, child);
-
-	return 0;
 }
 
 /*
@@ -788,9 +786,7 @@ static int sysc_map_and_check_registers(struct sysc *ddata)
 	if (error)
 		return error;
 
-	error = sysc_check_children(ddata);
-	if (error)
-		return error;
+	sysc_check_children(ddata);
 
 	error = sysc_parse_registers(ddata);
 	if (error)
-- 
2.19.1

