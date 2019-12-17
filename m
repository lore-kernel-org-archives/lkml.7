Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0F5C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 22:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2C321582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 22:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="ftYRHw2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfLQWuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 17:50:54 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:58936 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfLQWux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:50:53 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 47ctf46Xg9z9vYVN
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 22:50:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VwAi-iUp865J for <linux-kernel@vger.kernel.org>;
        Tue, 17 Dec 2019 16:50:52 -0600 (CST)
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com [209.85.219.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 47ctf45PFTz9vYVK
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 16:50:52 -0600 (CST)
Received: by mail-yb1-f200.google.com with SMTP id k190so5448yba.15
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 14:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WQI/3o46QTkpBu3QKMA5BleVhXZfhU7Xm3Wn0FysZY8=;
        b=ftYRHw2iSFBHJUU538asJywbx36G+pFGYfFVcK7r1aZ0bpi9oWu19KGOSNibZm4HgV
         eUFdEqVmriCVgmFK3wBwHnMkDHSW5SL9DKBz5YJS5wdzok2WwSunIHhYV0blLgbNZ8Sl
         00L5ZzydanXqYkYq17yH1nE61gMimzYCgsROikcNLQ39Jy6go8Q8nXV0VMQrD5RnSrxA
         rpK6Of24PFGXgH5VYzcbcQvBxX5pnJj1qozaaYZEx1Q3Bog6nwT2QoZOA+0OMrNwwbj7
         mlOQABHdojh2+Fg2WHUECH7K9IfE9m2rLC8K5x5F0Mam0YXfNCY+X9TiBGDDzCjsauX7
         Gm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WQI/3o46QTkpBu3QKMA5BleVhXZfhU7Xm3Wn0FysZY8=;
        b=pqbg5Bj4Nj4UaDDPUmYrPFeM9niN7iX3wONu1wvLp7xwl4StpYcNjcRE2aUh2zjWHT
         aId0VcWG7empiBoh2RZUHdaPBF0ocyagUUb5F0TUqCosVPCGYPkUTulZdBOb8VuSDH5B
         JXjTF0uZXxea6sBq5fDKaX993Qm33tOSL5yCP3NLZkwubxEXfgjIT3eFxvTwlAqZJOyE
         ztJ9KMjqoewk4RFHfHNbNFiIROMrzKU3UjZipqoco95rLPc0S8OjfbVeDXSOw12xiuP3
         1tV2rzM+8QoqqZGnr/HmLr/J4mWD6QU2ovKl6rY2fIYUip9uDNZLRfijgMhuborJqMr7
         wYCg==
X-Gm-Message-State: APjAAAW3mMdnbledFFakwThKdvrYU6B/mwdZtuS92nAFeXjZ5PSiYG/3
        zXKAnsH/MvcsXT8ciL5cqdmm6VfD3vUoQqapOxHjOvnqCPV7EaN7s9TzTnW9Mw85R9RMcBPuazm
        gt0GDUxYeOl/flM82qh766Dzb4fe4
X-Received: by 2002:a25:7451:: with SMTP id p78mr472597ybc.22.1576623052025;
        Tue, 17 Dec 2019 14:50:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqxcdfKJfOCr5lNQA1daYm5XnEIRWKbkgY77t7JSl9qjnnSLaxc3Sj0TtYDq+OzJoTelJ+SaBg==
X-Received: by 2002:a25:7451:: with SMTP id p78mr472586ybc.22.1576623051796;
        Tue, 17 Dec 2019 14:50:51 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id p191sm114665ywp.86.2019.12.17.14.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 14:50:51 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd: remove unnecessary assertion in nfsd4_encode_replay
Date:   Tue, 17 Dec 2019 16:50:47 -0600
Message-Id: <20191217225048.3411-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The replay variable is set in the only caller of nfsd4_encode_replay.
The assertion is unnecessary and the patch removes this check.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 fs/nfsd/nfs4xdr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index d2dc4c0e22e8..fb2433676376 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4500,8 +4500,6 @@ nfsd4_encode_replay(struct xdr_stream *xdr, struct nfsd4_op *op)
 	__be32 *p;
 	struct nfs4_replay *rp = op->replay;
 
-	BUG_ON(!rp);
-
 	p = xdr_reserve_space(xdr, 8 + rp->rp_buflen);
 	if (!p) {
 		WARN_ON_ONCE(1);
-- 
2.20.1

