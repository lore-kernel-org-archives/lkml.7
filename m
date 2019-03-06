Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2382C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A325520663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="aNAf0fyk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbfCFUOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:14:44 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37460 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730509AbfCFUOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:14:43 -0500
Received: by mail-yw1-f68.google.com with SMTP id k14so11154162ywe.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 12:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G0zMQ/6cExYamIMb4POA2/0GG6eFLcdSFH8y7vnqv2Y=;
        b=aNAf0fykzHgqnwL3eAAah+cxE7C0xjjV60kNnYX98sVbli/N7KtuVx6kD7BTwHuD9F
         etTBXMqn7NbxYueHEyNXYvp2NBWyP/3PzRgZrh1yhzz8//x+Kx9mNBIv2Vj9imPrOLdK
         awE9TJBa9qyNcCB03UMXxS2MHJjX/Zq5+eKbindiLijnPehERgtNafI/yzmeGEjnnky8
         r9yQHzt+jvVfqCPk/mnNSClnw+sf4UI9Dp98pE3pgMtGfooqY4Iao730/JMp9X5o26xc
         Gs4HPxbvx1xD4dpvO+5hVdMtpaJxGCx4WKXbydLw1XPnsJjwTf0wSIe97/WL9koMAG0P
         XrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G0zMQ/6cExYamIMb4POA2/0GG6eFLcdSFH8y7vnqv2Y=;
        b=N4CFsc9uCeOLw9gdVk3xHzkcLNsAsoFBNMZ1WBAlcVFEiiqG874KFYDrm/EPkvh2ji
         6x+epRJda/Ia2L/IWf3Xf+YerqtLwpTWvjhkKsnbE4Hku3zRLXa2b/jul1KiOcUzSzBK
         FcFRajA2QKBKfhPhqQXbodJ2JB/mbqfFakCvz5W0fBRvjD3efqDJgtpvehRkR1jWT2/f
         myw9sB282EzScc4QtjdY0PcmvyL/QtM1o9CJhkIxehir75e9kCvfD2kaJJDCMRPzXCRh
         bXLZ7cEocoDpvW87M6bfvGn7O8cFi7QjwDxieBsiMARGDZDeRCgn4ul/PhicAfmyRHBE
         Ejvg==
X-Gm-Message-State: APjAAAWQKgD/mrWrmR0BZX6oKdG7LqqZM+6rkSqAiEgAMRvP5/IZUKeR
        mNEZNMoZQLFn9zCqNE7fxZlzjg==
X-Google-Smtp-Source: APXvYqx8JekV4k5xSgYisFq9ohxPqIO1TKAJWZywd+i8xpG0rGyXDZhKSo2aLuDSr7dcxkr1vHM8bQ==
X-Received: by 2002:a25:6601:: with SMTP id a1mr8591249ybc.467.1551903281939;
        Wed, 06 Mar 2019 12:14:41 -0800 (PST)
Received: from cisco.hsd1.co.comcast.net ([2601:282:901:dd7b:316c:2a55:1ab5:9f1c])
        by smtp.gmail.com with ESMTPSA id s5sm893015ywg.108.2019.03.06.12.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 12:14:41 -0800 (PST)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH 1/2] seccomp: fix up grammar in comment
Date:   Wed,  6 Mar 2019 13:14:12 -0700
Message-Id: <20190306201413.14153-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This sentence is kind of a train wreck anyway, but at least dropping the
extra pronoun helps somewhat.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 kernel/seccomp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index e815781ed751..d0d355ded2f4 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -329,7 +329,7 @@ static int is_ancestor(struct seccomp_filter *parent,
  * Expects sighand and cred_guard_mutex locks to be held.
  *
  * Returns 0 on success, -ve on error, or the pid of a thread which was
- * either not in the correct seccomp mode or it did not have an ancestral
+ * either not in the correct seccomp mode or did not have an ancestral
  * seccomp filter.
  */
 static inline pid_t seccomp_can_sync_threads(void)
-- 
2.19.1

