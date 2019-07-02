Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB9EC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 18:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB722184C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 18:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjaLW/hm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfGBScm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 14:32:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38487 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGBScm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 14:32:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id y15so8692689pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 11:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=BgFYEpI9Vf37MkAJvUbJgnA2AnUZ8zhFoQhGn0OdidQ=;
        b=UjaLW/hml7wdTUzn9k/Tvn08ZqMRJej+B/NUDQPLOFTBfVXol/+2xrYqn7ODbF1owh
         O/tWLo6ycZNu08wIvGzZzXJTur2JcISAieIKsFHkeO1bSRQAjFeyMpDzIwEXhf8c9BUx
         W7vxU5e+PIpgJWkjDVbFlB1eLI/oIBpXZZw5tqg04e6R723ta5vZ41quarhycoX0GqTL
         2KLnKMlH5alqBkJBRy8/9xAZ+wSjPcR4v7PhS6up9NZeDDNyn0fgeVoagCh/GB8yDZlY
         bitxpmWbzn06xev0by3aaHa28hN26g51cKmUqusxJ87eMiOS/09g6CI3ruyhG+e++HV5
         So4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=BgFYEpI9Vf37MkAJvUbJgnA2AnUZ8zhFoQhGn0OdidQ=;
        b=XQGZWXam3O386WpD52v7OqULvNGXmzR8biPzXx/ghfJTv5GSE0m8AZIMMszeA2APHS
         DI7rYIKjU5gJvnXwQrQjmhgyuy+gcXBi44/3iylOSGwxArmiKBx65U7LORPo5Lu/0f+7
         elOkzCTV5srjWkTvbU5jROASfPIcNy8FjriFmambnjVs+g7UN0R/SCWTyl8YPL5+l5wQ
         rHiTOQyy0xs7td6vk/eQhBExB9jBtQlzZfgv7CEMSxD06m7+uKxM1hVzBlPI7xkkuIf1
         Tqh31hv85RN1HvJKUzyOBlCz0kqIKtxA08aOyfnYQmS+mdd7F6Zsho2rWfpsvQTmaRI+
         OGIw==
X-Gm-Message-State: APjAAAUaDwR4KSV969Zns0JS0WzZQ17dw2nq17oy5/DMBDp0W8QX0eUD
        sjBmkERPW6kyHnLpFm0cUzzvtE1W
X-Google-Smtp-Source: APXvYqwM6aK86vx61ENY6jxNZsYcwfEFmF59TwCTWG1GaDSWwUWK6UXZ36xR+H9fI8sKUfKkIyDvbA==
X-Received: by 2002:a17:90a:ac0e:: with SMTP id o14mr7276481pjq.142.1562092361630;
        Tue, 02 Jul 2019 11:32:41 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id h1sm22199164pfg.55.2019.07.02.11.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 11:32:41 -0700 (PDT)
Date:   Wed, 3 Jul 2019 00:02:37 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: ocfs2: dlmglue: Unneeded variable: "status"
Message-ID: <20190702183237.GA13975@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below issue reported by coccicheck
fs/ocfs2/dlmglue.c:4410:5-11: Unneeded variable: "status". Return "0" on
line 4428

We can not change return type of ocfs2_downconvert_thread as its
registered as callback of kthread_create.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 fs/ocfs2/dlmglue.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index dc987f5..1420723 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -4407,7 +4407,6 @@ static int ocfs2_downconvert_thread_should_wake(struct ocfs2_super *osb)
 
 static int ocfs2_downconvert_thread(void *arg)
 {
-	int status = 0;
 	struct ocfs2_super *osb = arg;
 
 	/* only quit once we've been asked to stop and there is no more
@@ -4425,7 +4424,7 @@ static int ocfs2_downconvert_thread(void *arg)
 	}
 
 	osb->dc_task = NULL;
-	return status;
+	return 0;
 }
 
 void ocfs2_wake_downconvert_thread(struct ocfs2_super *osb)
-- 
2.7.4

