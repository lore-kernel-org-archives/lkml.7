Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74048C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4062B2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257629;
	bh=dS7olzrft4wignoBCJL7/USP0dydEswYSe273jFqkwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mueKtKu25S5gU8hvknHOeE4z0YhEk7Gotxft0rzVdEfUVtW0UELBFPlmc+Wn8bpsq
	 tZcjVSzafyxbL5OeGTg8TSqUk2Kc4C2q9iP58TdybCcRdxfZNig5sWQZK/ymF35rrv
	 cLR84rueBUMrEgYnEe4wOLq29E3Z2Twf6xiOwzGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390989AbfCVM1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:27:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389983AbfCVMVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:21:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 403A5218B0;
        Fri, 22 Mar 2019 12:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257289;
        bh=dS7olzrft4wignoBCJL7/USP0dydEswYSe273jFqkwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CRdtMH3G7z0F14Tyqnt9dpKmKYrAGofkxadRuO9oEOt3Pzr7/OkVhSPBUDn4FI3UF
         dmx79ZhhVe7BKFReoN18r6eJ/N8kKQMCQB847eY/fvUFpKgv0Tq/i6dzfH8ebh9b/t
         GBgnGaowht4NlQ3oxQNrUzNLwcDvBEkBb+qXWibk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.0 186/238] NFS: Dont recoalesce on error in nfs_pageio_complete_mirror()
Date:   Fri, 22 Mar 2019 12:16:45 +0100
Message-Id: <20190322111309.227330439@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit 8127d82705998568b52ac724e28e00941538083d upstream.

If the I/O completion failed with a fatal error, then we should just
exit nfs_pageio_complete_mirror() rather than try to recoalesce.

Fixes: a7d42ddb3099 ("nfs: add mirroring support to pgio layer")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org # v4.0+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/pagelist.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1209,7 +1209,7 @@ static void nfs_pageio_complete_mirror(s
 		desc->pg_mirror_idx = mirror_idx;
 	for (;;) {
 		nfs_pageio_doio(desc);
-		if (!mirror->pg_recoalesce)
+		if (desc->pg_error < 0 || !mirror->pg_recoalesce)
 			break;
 		if (!nfs_do_recoalesce(desc))
 			break;


