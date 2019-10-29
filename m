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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1057CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9431A20656
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/YPCW/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfJ2UBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:01:34 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:39018 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfJ2UBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:01:33 -0400
Received: by mail-il1-f193.google.com with SMTP id i12so18197ils.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 13:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mNLccYcZkIn8UAKxO85u+OA0TLw/V1dQswW4vxScbHs=;
        b=g/YPCW/NPci2VczE3231r3K0Ef9CBZuaxK9ZtXbkC8gP2dVtPqAztBq6ppjFAqtbFy
         r8jtspPHfswtsjCP8ULpRyehkcwFlEfiqMUoo4Fl8jmOCHGOzXtSH+6uwEGHRTQW6/Ub
         4I3Hvh9v725BTDGMsmSUj1tw/kRsUPC5Xx4yUWVBYep73Ab/nITRXovNriYNvkS9+63t
         OTEOygBsV+wQV2CS2csf8HKzWiP9AmIY2SXoYUDanAWUca1j43oRSuvusO6oGQgNAtJr
         VuxWKc9uEq3L6eO2LvO3fdTEMx5eoq7KDoFiz3QYFtVuDHvUna84C0GC6AV2ysOeeMq6
         cWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mNLccYcZkIn8UAKxO85u+OA0TLw/V1dQswW4vxScbHs=;
        b=EeLCdWz/USmWgb73HC3PaJo9R5EFffjaTviGGU6zHcSGJX6yyQbk+ErI/Cjj/M4EYX
         AtkqDn0ypqgqPQEEpYIhFDJv6GgEk7oskvWSqaS39IL/Rwxll1uRVAdg8yPCjvI2mbpN
         YeeCyA22zoP7uxqUXbDA+saHcSswgfCHLs5peWJE9BcWpi6fEDLpwlgAhXbtNJ9vaRXR
         4/1xr5Vh/sS6/M1Rvy+4YvUh4AwF2IAynes9u4uaUM5ygeKouyA/8xXRNCA/wv4TThRz
         tyfhgx8NC+GmsAw2uskCCC4z8JmxyrXbA9Z/LCtPmaSKWGyVHEsJRIe26J7oXn+UaYMq
         dvZA==
X-Gm-Message-State: APjAAAUbLDWK8AaOQCYCd9MJNPIVd3nLQMqx3/WMDfOkGqv42bQK1wpu
        miGrBkxN1XM1g7lnSKAaKW8=
X-Google-Smtp-Source: APXvYqzYYrpIwbRM2jejSrX9bDRunPJMdSwk4InF5ebYcrS9FmvqFAlvYLorxG1uK0zTO+KvVRyILg==
X-Received: by 2002:a05:6e02:d8b:: with SMTP id i11mr30934359ilj.81.1572379293050;
        Tue, 29 Oct 2019 13:01:33 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t16sm2734iol.12.2019.10.29.13.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 13:01:32 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 14/16] dyndbg: prefer declarative init in caller, to memset in callee
Date:   Tue, 29 Oct 2019 14:01:29 -0600
Message-Id: <20191029200129.10315-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drop memset in ddebug_parse_query, instead initialize the stack
variable in the caller.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c6273fabe52c..4369afeb52f0 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -358,7 +358,6 @@ static int ddebug_parse_query(char *words[], int nwords,
 		pr_err("expecting pairs of match-spec <value>\n");
 		return -EINVAL;
 	}
-	memset(query, 0, sizeof(*query));
 
 	if (modname)
 		/* support $modname.dyndbg=<multiple queries> */
@@ -479,7 +478,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 {
 	struct flagsettings mods = {};
 	struct flagsettings filter = {};
-	struct ddebug_query query;
+	struct ddebug_query query = {};
 #define MAXWORDS 9
 	int nwords, nfound;
 	char *words[MAXWORDS];
-- 
2.21.0

