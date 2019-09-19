Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CBDC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFB321907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568930856;
	bh=hnqkJNqeU0GZH+MoozhkmudYBgC7N8oYscP95+s0Whg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x3smmcQBmWD9DFpv9QG5MfVv7DqipGSG44pugmUzcCtPXG9np/nk+7tMx88rPJMHn
	 rzyyjKoPE0wseA3HBoO4PxWiBlC5RJDPERTAdavp0et9ktuLPSiDJ1VDKb15MbSbsR
	 T3YVxeu2uu6okZdx9p11MrL43HVwD66Dx8rtgCAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393251AbfISWHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:07:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393235AbfISWHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:07:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6539B21907;
        Thu, 19 Sep 2019 22:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568930851;
        bh=hnqkJNqeU0GZH+MoozhkmudYBgC7N8oYscP95+s0Whg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YPCW0hgUHljNZsu+3kFauwDF4yrvbPfNSr6RM7fi3DrJytcz5v4gwIOkDh5+4Niej
         2uRhx+jnsjlBiIvCHpFPmRu6o1YY81zEOGlyNnTkDJiytRU8O6AlGcg0HT8IC2nAIX
         jQ1D4OY5YEVPlXukTE8ZCZvMrvJge6QdbGINFynU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.2 010/124] nfs: disable client side deduplication
Date:   Fri, 20 Sep 2019 00:01:38 +0200
Message-Id: <20190919214819.539230985@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214819.198419517@linuxfoundation.org>
References: <20190919214819.198419517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

commit 9026b3a973b0b0b73c15ba40aff87cd0959fd0f3 upstream.

The NFS protocol doesn't support deduplication, so turn it off again.

Fixes: ce96e888fe48e ("Fix nfs4.2 return -EINVAL when do dedupe operation")
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/nfs4file.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -187,7 +187,11 @@ static loff_t nfs42_remap_file_range(str
 	bool same_inode = false;
 	int ret;
 
-	if (remap_flags & ~(REMAP_FILE_DEDUP | REMAP_FILE_ADVISORY))
+	/* NFS does not support deduplication. */
+	if (remap_flags & REMAP_FILE_DEDUP)
+		return -EOPNOTSUPP;
+
+	if (remap_flags & ~REMAP_FILE_ADVISORY)
 		return -EINVAL;
 
 	/* check alignment w.r.t. clone_blksize */


