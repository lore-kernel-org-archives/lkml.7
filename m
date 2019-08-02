Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD7CC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 01:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5422083B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 01:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCIQvDaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388721AbfHBBq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 21:46:57 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44830 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731827AbfHBBqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 21:46:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so32958061plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 18:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SbOMkR6BFbbJH4mJpHuDZSV8lHo9SN/LHTGUJZErykI=;
        b=nCIQvDaIyYgmY3S6RuaHzbI/wvqPQtLF+C8urA/9xL+tG9zaohNZI2sx3r4tiho50e
         MLMG5ec1ryLDoICDhmXEZSglzgoU4lyr+GmPPargRpDi4xWDNNxhMv3yGGjmwjBVQctj
         s/M70xaIRMcXrNLzUER9XbyYoRw5Xf75AbDRRapW6jpOhJnaQvN5fsfcEGhZsHMNFWsM
         qML3lafZKrB/ChIxVzJmuxfQNx/UantugZHYx1xVBSbtqjAjv4J4VgslA4GBj1di3dbd
         3eYTRhUotZHfp9P0CAJnUuhbjO9XvbpgOwWTuqeKymlkqGyu89GAbALC7FN9A/y7OywI
         k/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SbOMkR6BFbbJH4mJpHuDZSV8lHo9SN/LHTGUJZErykI=;
        b=ZIy9OoDmhzDtxQ7rM+gY4aLJg6vM1M1fTu9CJe1MBudauEu0CQdofWXxpz1cTeSM/K
         7WBjHPzpWsX7ZQ4g8aTWGZaynYVB+Wu6PuyKt0ZXVX+MO2zl5G2KPIZj0+Uu5w1UAMVI
         NnvE9qA6tz1vgSuhd/0dUctg9iXI2yFUSXPZPB+aXoYIy+qewaDv8w+T2ruQG1xTtWiw
         f+E1REfx/lvb7PObPuPnGeVbpq8RjYDIVSVILQH824PGKF148oPyn2enQb+JiwXndwj6
         TcZYBe9CaxcEQ+f+l3QyyDglF0tuH0QFYTqpHIrS1t8sbYarwfnBRlM5+l3mjthc7AIR
         nbWA==
X-Gm-Message-State: APjAAAVWOOsqDMvry97q7O2Bo+5ql3WNUQMN47ZLSI26CiRmC01Y8EPv
        uGExsYXwrkxxlb027uqPbpI=
X-Google-Smtp-Source: APXvYqx3gI6bOxvFU8GIKBltxJjesjIhZ+4BvBbLvBrMaGouWSYu6wwD/PftC7SFIAdDmmnWgCXkdQ==
X-Received: by 2002:a17:902:5c3:: with SMTP id f61mr119559634plf.98.1564710414653;
        Thu, 01 Aug 2019 18:46:54 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id r27sm79763441pgn.25.2019.08.01.18.46.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 18:46:54 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2 02/10] gcov: Replace strncmp with str_has_prefix
Date:   Fri,  2 Aug 2019 09:46:50 +0800
Message-Id: <20190802014650.8735-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncmp(str, const, len) is error-prone because len
is easy to have typo.
The example is the hard-coded len has counting error
or sizeof(const) forgets - 1.
So we prefer using newly introduced str_has_prefix
to substitute such strncmp.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Revise the description.

 kernel/gcov/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/gcov/fs.c b/kernel/gcov/fs.c
index e5eb5ea7ea59..67296c1768b4 100644
--- a/kernel/gcov/fs.c
+++ b/kernel/gcov/fs.c
@@ -354,7 +354,7 @@ static char *get_link_target(const char *filename, const struct gcov_link *ext)
  */
 static const char *deskew(const char *basename)
 {
-	if (strncmp(basename, SKEW_PREFIX, sizeof(SKEW_PREFIX) - 1) == 0)
+	if (str_has_prefix(basename, SKEW_PREFIX))
 		return basename + sizeof(SKEW_PREFIX) - 1;
 	return basename;
 }
-- 
2.20.1

