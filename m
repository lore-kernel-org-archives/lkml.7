Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D433C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5FF2073D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uk6JlHwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733030AbfHBG0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 02:26:03 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:35956 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732127AbfHBG0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 02:26:02 -0400
Received: by mail-pl1-f170.google.com with SMTP id k8so33260326plt.3;
        Thu, 01 Aug 2019 23:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bYz2zjlmuoUx8fz7ph0W6vocNPa4yLLWG/oBEqims+s=;
        b=Uk6JlHwJ5rA6oxdi4JAnrY+bbHXdnkLgmd10LOtF4eLcLf2VyOXf0ti2Gfe5BP8ddy
         YV3th702Ym2sx95MKI9tY4qslxArrdlG7jQkwhn+HHGiLoi5hw+hx2iWaNQOqkBkyC7v
         jpTJFiwa8Wi59DaRV6+6GhC5/CmOhH1CdRyMN5e4Krzj8tSP3bMbyknE4ac+3JJ8oWNb
         459mRlaES8d+ASl0JN6CYr0QWF+zX2U0s6MJygLu4E8NyxROi6e+85lNxQhwSzuEFBrl
         MHZqqkM5JCUnBNw4x24BGkoBmnp75k1gXnjt09tBguwTHEHHx0OsKIl1IFV+p4TMIqMQ
         lXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bYz2zjlmuoUx8fz7ph0W6vocNPa4yLLWG/oBEqims+s=;
        b=ARWHoa359jUiY1OzldfdZpw5+bonzT8F6AvXV6+5x/tCHGHVUz+iNCQpGJCSKqSkxw
         CEc++uh0y4bfgk097ZvBMoQUU5BcqGqIjI9EZd7M4buw2d4pBZWw6nrAqZ740VosyimN
         r++oI9ynQuGPSJbUlyTER+8a6Cufl+hm/DIYvTdFGQfe6qU0IabU+eTUbJD26glum7je
         hN57NP2vgVf0lycnDQ64+UHki+CiXPJxYSorxBYhgjG02Lok/oTjVhNqoIlBfETw+dYX
         REhfurZxhjqz4VjHlLv3kFMegQ1aeXjU2tvhd+4N3T8ouV/0ErwZhqDaq1jKgPz6al/F
         UCUA==
X-Gm-Message-State: APjAAAWh62Ut/52/6K51S7QQtTA9WwsvTR/GpHb7M5wPZzivP72WrIhW
        kKDfRHii6f3oIgY5ShoSxcw=
X-Google-Smtp-Source: APXvYqy7LvIbDxwGr8HTYZI8mucWvnBpQn1BTFB8FCSqImzxnyTdeKKeGmeuvTffKnTb2C1P8Qj9nA==
X-Received: by 2002:a17:902:7781:: with SMTP id o1mr129601537pll.205.1564727161951;
        Thu, 01 Aug 2019 23:26:01 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id m4sm85470823pgs.71.2019.08.01.23.25.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 23:26:01 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] Documentation/checkpatch: Prefer str_has_prefix over strncmp
Date:   Fri,  2 Aug 2019 14:25:37 +0800
Message-Id: <20190802062537.11510-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add strncmp() to Documentation/process/deprecated.rst since
using strncmp() to check whether a string starts with a
prefix is error-prone.
The safe replacement is str_has_prefix().

Also add check to the newly introduced deprecated_string_apis
in checkpatch.pl.

This patch depends on patch:
"Documentation/checkpatch: Prefer stracpy/strscpy over
strcpy/strlcpy/strncpy."

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 Documentation/process/deprecated.rst | 8 ++++++++
 scripts/checkpatch.pl                | 1 +
 2 files changed, 9 insertions(+)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 56280e108d5a..22d3f0dbcf61 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -109,6 +109,14 @@ the given limit of bytes to copy. This is inefficient and can lead to
 linear read overflows if a source string is not NUL-terminated. The
 safe replacement is stracpy() or strscpy().
 
+strncmp()
+---------
+:c:func:`strncmp` is often used to test if a string starts with a prefix
+by strncmp(str, prefix, length of prefix). This is error-prone because
+length of prefix can have counting error if using a constant length, or use
+sizeof(prefix) without - 1. Also, if the prefix is a pointer, sizeof(prefix)
+leads to a wrong size. The safe replacement is str_has_prefix().
+
 Variable Length Arrays (VLAs)
 -----------------------------
 Using stack VLAs produces much worse machine code than statically
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 0ae9ae01d855..38e82d2ac286 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -609,6 +609,7 @@ our %deprecated_string_apis = (
 	"strcpy"		=> "stracpy or strscpy",
 	"strlcpy"		=> "stracpy or strscpy",
 	"strncpy"		=> "stracpy or strscpy - for non-NUL-terminated uses, strncpy dest should be __nonstring",
+	"strncmp"		=> "str_has_prefix",
 );
 
 #Create a search pattern for all these strings apis to speed up a loop below
-- 
2.20.1

