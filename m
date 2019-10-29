Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5725FCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2473B2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tmcwFGeF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfJ2UAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:00:37 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41518 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfJ2UAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:00:36 -0400
Received: by mail-io1-f66.google.com with SMTP id r144so16187733iod.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 13:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aH3AU05nf0xdpjOXyvnnp6BI31EQy+5h/T1U88JVRB0=;
        b=tmcwFGeFNAgNEjKRDvXyOToWMhFX+4Uab8QVnW2hsqDat0FF/5HBRjJZCJfjaaVZ71
         IccfSODqItTULEMSco1i91wvM15hL41Z2/MIlK/CiFDjNHiUgzCxD3Ngf60Bbgj+ejAL
         r2mvhUruOGuXkLff0i2Tt9lIxVabSwlVYC04MVGjbw5dUBi9bKDZ/nl+r3A/Po38b6Nt
         MzaMlFWwduYfvPIE41CTPQ1c0gKaJ/bhmM4LHS4H9U3Fkcfbqzia6fKpEbP3ESlz5Po+
         c+hs+2FCNiw+KHZcx6rjZAEIowwaEKyMRWMZ5J3rYBVouaJE4amMm/BGJPrrsnyZGk7f
         Tlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aH3AU05nf0xdpjOXyvnnp6BI31EQy+5h/T1U88JVRB0=;
        b=arwVEORod9bzArLOL+f6WHyx8dVwYtqKcfngeWGHWh7O7LPhDW95MCTqaOE924+85y
         IKgqgsMrf+MjTF4ckgVA0BwdXBXIi5VT563PF0O7lJ4um+K2uxpqDPEzHEm05IzTi40v
         7PUDimrZDhJeJ5k4a/FSTbbTr/yeUqYf2CzSUcDylNdmWRnLHy/aYcYPVCQDGekZymsF
         CGduxYyOnVnQFFhrwR3yJGwBSPetLzw8SoKvxgOgmlr3KeUHGjd9UI+s98XEEaQ7+GEK
         4nkQFR+dULQcyiOspNAw8R+NNYaX/fa/TjiXYr9bDIec67uU6+OjN8msTSxuc2aYRZeT
         19Tg==
X-Gm-Message-State: APjAAAU7+9tqrTRXYkr1kBq7EQb9P1t7uUSyAqDktxTPC25sP+WzB2ip
        FOUjVWhAWSf1MA3Zdc2ZdhgZlc2lCXE=
X-Google-Smtp-Source: APXvYqyv8Qd5PyAvkOKQC8o7+PeZe52HZM3CAFtL/00YyfZU/vTYuA3ZyxZT0XuzxbZIdpkTEuU/bA==
X-Received: by 2002:a02:840a:: with SMTP id k10mr459894jah.26.1572379234735;
        Tue, 29 Oct 2019 13:00:34 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id j21sm1571404ioj.86.2019.10.29.13.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 13:00:33 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 05/16] dyndbg: parse flags last, restore original behavior
Date:   Tue, 29 Oct 2019 14:00:30 -0600
Message-Id: <20191029200030.9839-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 85f7f6c0edb84, I moved flags parsing before the query
parsing.  For error reporting, its more natural to parse in normal
reading order.  So restore previous behavior.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6eec5bd559fe..540ca0861cf0 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -445,15 +445,14 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		pr_err("tokenize failed\n");
 		return -EINVAL;
 	}
-	/* check flags 1st (last arg) so query is pairs of spec,val */
-	if (ddebug_parse_flags(words[nwords-1], &flags, &mask)) {
-		pr_err("flags parse failed\n");
-		return -EINVAL;
-	}
 	if (ddebug_parse_query(words, nwords-1, &query, modname)) {
 		pr_err("query parse failed\n");
 		return -EINVAL;
 	}
+	if (ddebug_parse_flags(words[nwords-1], &flags, &mask)) {
+		pr_err("flags parse failed\n");
+		return -EINVAL;
+	}
 	/* actually go and implement the change */
 	nfound = ddebug_change(&query, flags, mask);
 	vpr_info_dq(&query, nfound ? "applied" : "no-match");
-- 
2.21.0

