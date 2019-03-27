Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD39C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A912082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1h8ErLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732298AbfC0A4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:56:30 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43359 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfC0A43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 20:56:29 -0400
Received: by mail-qk1-f194.google.com with SMTP id c20so8891721qkc.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 17:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=A9mw3YqoaCKpOM09oY8exgctLd5NEjv3YH6a6QF+6us=;
        b=e1h8ErLq3CDYegPt5vXNcPOC6+WBOUrro9ITrUbB2okDZ+jCvVQJU5yCPZeGZekdtq
         rBXnS7nRDkE/wYDW2gGx5JxmDEo+0WWRyh7d668NysMsI2Tc8FKIGPTALgNs//V4Mstz
         7jbmsdBEYS02jPSmQFm1ALTYbntv2Z/gq9bmtFxYXYXro94ozql+AoIYYAR8szZf1kxt
         AQx03evkBlo0TYhcsu3iHbdud6LiHdqJ8ZVvzK/vIW+SS4SYMy0xZq8RpKkAX+C9Bf8w
         1iOJGv2fRh67mYGo2iOxvymUYI4RzJdPYk9vHqX8CnBHPPRMjprpWpHaOsf1RQwVen+k
         zTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A9mw3YqoaCKpOM09oY8exgctLd5NEjv3YH6a6QF+6us=;
        b=EX92oq+HfjFKvmLpTTI++RusuqjtcMY7rfiqotbn65ebCEnzy5XqcjCO/BOpKPHsP+
         s/Iv/gaG2Z+oLhRmbGf+ObFI/4aw4e7cswTo0do/5JOO/xvt8GBsr7fomG/Xs/edilJ1
         lSbUgCIQddx9SmP6RIiS+hPlR8H3yf6xLyhJdIeCV+DIfUMru8SGTnaEiHvZGf+TWbQH
         0siSgZMP42xbOTB1Yhzu7/n/Ng+8o3kFdlgBgTyCAXZoIH5Vn3YEzOfZW32rOrtmwA4N
         rOde8ch4EyaY6rdSBelknvLs3mXwrawhDibTpYUP2Uw8NPNcAufGQ0bIXTtfltiOAu5X
         DNmg==
X-Gm-Message-State: APjAAAVbgKPs/PiKx9p7BFESq8dmyqWByx0mSHZVESL4CTDrVQ2+SA/Z
        HvldJxxwaQjnCmxK+lMNz5U4j3i0
X-Google-Smtp-Source: APXvYqz3zVhgngbLho3WJIQ7b70v8fVtS3fRatH3goDuaoAccO4ybHA4X7Eu+tdDEN5AZkBpkQ5DOg==
X-Received: by 2002:ae9:e313:: with SMTP id v19mr25888259qkf.153.1553648188939;
        Tue, 26 Mar 2019 17:56:28 -0700 (PDT)
Received: from gravicappa.gravicappa.info (pool-72-74-132-209.bstnma.fios.verizon.net. [72.74.132.209])
        by smtp.gmail.com with ESMTPSA id e4sm1533229qkg.6.2019.03.26.17.56.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 17:56:28 -0700 (PDT)
From:   Vitaly Mayatskikh <v.mayatskih@gmail.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] vhost: zero vhost_vsock memory on allocation
Date:   Tue, 26 Mar 2019 20:56:14 -0400
Message-Id: <1553648174-24913-1-git-send-email-v.mayatskih@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes OOPS when using under-initialized vhost_vsock object.

The code had a combo of kzalloc plus vmalloc as a fallback
initially, but it has been replaced by plain kvmalloc in
commit 6c5ab6511f71 ("mm: support __GFP_REPEAT in kvmalloc_node for >32kB")

OOPS is easy to reproduce with open/ioctl after trashing the RAM.

Signed-off-by: Vitaly Mayatskikh <v.mayatskih@gmail.com>
---
 drivers/vhost/vsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index bb5fc0e..9e7cb13 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -512,7 +512,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	/* This struct is large and allocation could fail, fall back to vmalloc
 	 * if there is no other way.
 	 */
-	vsock = kvmalloc(sizeof(*vsock), GFP_KERNEL | __GFP_RETRY_MAYFAIL);
+	vsock = kvzalloc(sizeof(*vsock), GFP_KERNEL | __GFP_RETRY_MAYFAIL);
 	if (!vsock)
 		return -ENOMEM;
 
-- 
1.8.3.1

