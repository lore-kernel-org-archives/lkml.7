Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA6FC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B9E21721
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L1NZ6goC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbfFSSRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 14:17:20 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:51764 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfFSSRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:17:19 -0400
Received: by mail-pf1-f202.google.com with SMTP id 145so102528pfv.18
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 11:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=O7rv2aQ+NZXAwqWEnlsVJInaVAsSvihbId/ltqpnhno=;
        b=L1NZ6goCzBfV03VfFjkvbvXTv1TSjEjf/4k2Mk71dw+3pJ0zRjNqfHR6GkaB1rB4lh
         Vi8lL27r/YHsA6fDTXTy8wIfsLZG46ltJ1HFZ/jUsi6iVvgMk3644k3q+hs6F1ch/aic
         yECJUmwDTfpVhKZ9flqwZv5W6QcxlqtkZIWpiGDcf6DAdAwFy6qVZmsLmWSAi9nqXtcI
         Q5o0vE868amfRuXf5cwTKwHqa/pTqSZv6mp5My349i2AuauNFjLOlp3mN5QA0nGr6AhD
         xFLvIhb6Rh9xI+axDQOn6Ql1lCeaS6VQhTVEo81LPzGJBRAEzpCjLTfFPEnp9B2OPDb4
         DjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=O7rv2aQ+NZXAwqWEnlsVJInaVAsSvihbId/ltqpnhno=;
        b=dKI97PE4e5eUMsvd+SM06VhAlf5Ci1pCzy16JDorgypxVxuyAAe8su+hvMc3TdVU8t
         wg1+0Gd6LupE+15LD81gbZPAxvdL4qkxb+z/8MdXniAX9eyVxvYWK5uPeEelVi3vp7S3
         kjChTDS4OgG5P1a7XR9trzKgy4TrrtTM3Ia5VnE8PThmMneJOe4lBE5Tr8jrb3JX9iDM
         E+C1xapkD+LERfj/BU7GGCFiznUIhgjAZIqs1+QZAj3+5lB8QuAVAoKldPRe9DSO98zp
         ragR02UHQPK2TXNFSZe62315IlFTxkbFnSnsiMQmrxKUEzEFuIza1oOlU5nuvaC0sFiC
         6SGw==
X-Gm-Message-State: APjAAAWlNe39ANq26zNA76CX/v+qhs+fY7C2mTNdVDzbYpGSNyhqWBa6
        2jqrFtEh6NGZE+ZaQpApCc8stw3pSA==
X-Google-Smtp-Source: APXvYqzCqygg6fRWJ9UuWuzECpwXNQ/ze8FCSiCnGa/FlHW33doGjRIRoYNNUX56OXyeA9DOyqBhBwCO0g==
X-Received: by 2002:a63:b1d:: with SMTP id 29mr8888660pgl.103.1560968238611;
 Wed, 19 Jun 2019 11:17:18 -0700 (PDT)
Date:   Wed, 19 Jun 2019 11:17:15 -0700
In-Reply-To: <20190619084921.7e1310e0@bootlin.com>
Message-Id: <20190619181715.253903-1-nhuck@google.com>
Mime-Version: 1.0
References: <20190619084921.7e1310e0@bootlin.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2] net: mvpp2: debugfs: Add pmap to fs dump
From:   Nathan Huckleberry <nhuck@google.com>
To:     davem@davemloft.net, maxime.chevallier@bootlin.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was an unused variable 'mvpp2_dbgfs_prs_pmap_fops'
Added a usage consistent with other fops to dump pmap
to userspace.

Cc: clang-built-linux@googlegroups.com
Link: https://github.com/ClangBuiltLinux/linux/issues/529
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
Changes from v1 -> v2
* Fix typo
* Change commit prefix to debugfs
 drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
index 0ee39ea47b6b..274fb07362cb 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
@@ -566,6 +566,9 @@ static int mvpp2_dbgfs_prs_entry_init(struct dentry *parent,
 	debugfs_create_file("hits", 0444, prs_entry_dir, entry,
 			    &mvpp2_dbgfs_prs_hits_fops);
 
+	debugfs_create_file("pmap", 0444, prs_entry_dir, entry,
+			     &mvpp2_dbgfs_prs_pmap_fops);
+
 	return 0;
 }
 
-- 
2.22.0.410.gd8fdbe21b5-goog

