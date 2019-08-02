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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FB5C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 01:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE859206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 01:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2yaFF4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390638AbfHBBrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 21:47:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45545 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbfHBBrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 21:47:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so35178134pgp.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 18:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iq2Oofr0Gl/QXG71RCvyorbUHlM5X2J3tGq+6DkFErQ=;
        b=e2yaFF4RWbkfUO1QTe/GDUHUpJSDfgDyYAIWk48MdUvp5QrvvaUQ6P/FVAQDGa+299
         JOljzkOXkDdiCitVXPbnl+Ck0/SO4chaRleTHKKlGV8WVVCUn9aBOfk/i102nO37OrgF
         278Xh/W+vjFHrksBgLaRfT302DmiCnZrW89qLs3Of2eMCG6H58gm7wo8xqT3XS309JH+
         LBG7rfz8JPA9gkiRjfJC5Gy/UR3j4Gxc7h8m0UQbfwpfa477PBa4K1oWxStVlAZg5jWm
         bl5+a0DUnWxqzX+MrzFNxTCPCKvMS9snPerBRUyXrNx7yUG9JP3dR+GLNqlCoGY0gqd5
         0CBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iq2Oofr0Gl/QXG71RCvyorbUHlM5X2J3tGq+6DkFErQ=;
        b=DCkm6/OZ7Yo7uKElXkxKUzyLJL/5rL4VTuJBiAmsRicSIsh2s46TdG1a+HbSPcpR2r
         zaIjeu23W+6QSFjGmLiBg3QZDMNocSjHriwqWPs5BWVyrrOH/pW3fItGsgYRcoMYe+eg
         y3/VAryEAkH3X7Sb6r0PymKYR0jcG6xflayTcNNBpsW8JzoVbu4wiH9Ko/39G8OpYsfI
         eQXjja+o6yrqJo5nbv+ySTY143Fq0AKbsF6PseZ9ZAJBDf+KxOfkoGuFOStVb75A95SL
         dcyGYny7H0QpxPs51fHlHQjTgnqE0a/HaXeA7HLdgmaQdsvf8Aa7t/LZyPpmeAziAq0R
         3Scw==
X-Gm-Message-State: APjAAAUUPsPM22WvmBYlOsvuJXhgxa2JM1tkJd37UoHF49O6eIQfM1wp
        fo7YdaEs2htCI33O+hQQCYksiZ8BIY2jfg==
X-Google-Smtp-Source: APXvYqylsE993p8HGmSRYjY+kGu9oOVZpU+iKAj7W9WmiHyNUNaM2KM1gYLrbUtmFLBOzkTT6PIRtA==
X-Received: by 2002:a62:6d84:: with SMTP id i126mr55568288pfc.129.1564710464729;
        Thu, 01 Aug 2019 18:47:44 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id w2sm63002010pgc.32.2019.08.01.18.47.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 18:47:44 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2 09/10] userns: Replace strncmp with str_has_prefix
Date:   Fri,  2 Aug 2019 09:47:39 +0800
Message-Id: <20190802014739.9114-1-hslester96@gmail.com>
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
  - Utilize str_has_prefix's return value to
    eliminate some hard codes.

 kernel/user_namespace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 8eadadc478f9..e231e902df8a 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1138,6 +1138,7 @@ ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
 	char kbuf[8], *pos;
 	bool setgroups_allowed;
 	ssize_t ret;
+	size_t len;
 
 	/* Only allow a very narrow range of strings to be written */
 	ret = -EINVAL;
@@ -1153,12 +1154,11 @@ ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
 
 	/* What is being requested? */
 	ret = -EINVAL;
-	if (strncmp(pos, "allow", 5) == 0) {
-		pos += 5;
+	if ((len = str_has_prefix(pos, "allow"))) {
+		pos += len;
 		setgroups_allowed = true;
-	}
-	else if (strncmp(pos, "deny", 4) == 0) {
-		pos += 4;
+	} else if ((len = str_has_prefix(pos, "deny"))) {
+		pos += len;
 		setgroups_allowed = false;
 	}
 	else
-- 
2.20.1

