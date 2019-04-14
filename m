Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277CDC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 19:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CF62082E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 19:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJxBhi1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfDNTTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 15:19:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45931 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfDNTTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 15:19:20 -0400
Received: by mail-pl1-f194.google.com with SMTP id bf11so7463614plb.12;
        Sun, 14 Apr 2019 12:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RCjdcXqVKmDr2YZXcPPtjcIsCYb0PHt5vm/dHAsQTX8=;
        b=kJxBhi1SEC9X7gOpdRrj1hnpRaAeGAznii+jBe021+L2ebGSkajp4BSPoHxi4BBu4h
         fY6U5KXzPA1kPv1Hidv2GXMO1qoJsypzrv35aBRp/Im+iqAIBOvZhgkoFtEr7d3Lgh69
         ReY8iN0MKDu10v6dZPyJ66f3KlznlRf5LBD9hEJTIUXmiemuhL0l+AmUZPGVPQhzw6sk
         JizKGeZTIK3BvDK9FywU8UFU4yZxZRvNxgWbDz9fLxKAZTUAGCvAnjdaAf1KL4mTlFU0
         vVWH30nEXxTIQC9tIutq2fW5YHJEzoGctAHXT5KWkHqyYqQ63VzhIXXXD8iioMqh1OmB
         Xy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RCjdcXqVKmDr2YZXcPPtjcIsCYb0PHt5vm/dHAsQTX8=;
        b=jDyG7DWQ0TYewsAstvnpz+gVlzC6k/TmdQZ9015N/zNi4EM0mEixZMANx1C4QOgImX
         oi/aoifwriqvinvZ46tEeCwK6rDybM5wC0cDe/SkV7+2r4hcAYuDRkkRSAvnzjgd60uY
         MLOJNx/iUHrdzherCSpxQ+5pYuRbFyd/9M540KzfOYIkztpgzqMDR48sVoHDhcwPwj6u
         6/ZGLVUlyvMRFHrhB/C+CIuJqoV47d+mYi5bkRX5oRON3t4E70z+zAijH+JMCW/u0wzv
         UxefixeHRmbUmzfsBI69CfuVIxcS3J6+nW3op0LMRXOyg7E6Jq2BVn6Yt5Gy+H41wlwW
         ZrZA==
X-Gm-Message-State: APjAAAU6/S6Zx4f5BN0xeXIupW+/n+Ciss3Po61ZovvG7TOO7H8qDOye
        dLejW/YYgb7TpLO/JJIvjaHElMXw
X-Google-Smtp-Source: APXvYqwTEaEY5jOYLWBDfL04eGhA2wfOElC+nICerOFPcnBvfNujYlVjwRzGG/ZZI2EPsSF5itQunA==
X-Received: by 2002:a17:902:7c8c:: with SMTP id y12mr70595660pll.209.1555269559825;
        Sun, 14 Apr 2019 12:19:19 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.31])
        by smtp.gmail.com with ESMTPSA id k186sm65482805pfc.137.2019.04.14.12.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 12:19:19 -0700 (PDT)
Date:   Mon, 15 Apr 2019 00:49:13 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/namespace.c: Make to_mnt_ns static
Message-ID: <20190414191913.GA11798@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the sparse warning:
"warning: symbol 'to_mnt_ns' was not declared. Should it be static?"

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c9cab30..b39a3ec 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1732,7 +1732,7 @@ static bool is_mnt_ns_file(struct dentry *dentry)
 	       dentry->d_fsdata == &mntns_operations;
 }
 
-struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
+static struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
 {
 	return container_of(ns, struct mnt_namespace, ns);
 }
-- 
2.7.4

