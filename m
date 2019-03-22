Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC98C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6AE218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257305;
	bh=tEEdsytJp3vlEiUSBw5+Nz/krwCyE1B3lQCaRrC3hBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pzPkKuRa6NuqnslcFQHG+fowInyQOCNAI5p4hdDl4SkecD9wcJO5mtaB/NKXVS+b3
	 w0wawH1ZSBCXZoH1ybdhArjk54pU/JrLI2xXowSaAsbDXnxf2LCQJc4LcK187gfq3q
	 ModOY/CvBK6+GEBLlzf58uUnW0YRJTG8c5sOZ7wM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390906AbfCVMVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:21:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390894AbfCVMVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:21:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBFD52054F;
        Fri, 22 Mar 2019 12:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257299;
        bh=tEEdsytJp3vlEiUSBw5+Nz/krwCyE1B3lQCaRrC3hBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=meENzX+tN0fWrgHv+G7OjHJZQBuGp9XmnxfnVnjT/Zwz8Mnaix3cpslHLfPMpHn7G
         G5m64tXeq1zHGicj1llf6qm5lGFbf08rXVraLRDX/rz7htFvJcI3IdyZQHjeULMJnA
         1F8ih8XPpmx4jMzqDhy9UiB9EL/iLKLrkUIbwX8Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joseph Qi <joseph.qi@linux.alibaba.com>,
        Yihao Wu <wuyihao@linux.alibaba.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 5.0 189/238] nfsd: fix wrong check in write_v4_end_grace()
Date:   Fri, 22 Mar 2019 12:16:48 +0100
Message-Id: <20190322111309.382569146@linuxfoundation.org>
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

From: Yihao Wu <wuyihao@linux.alibaba.com>

commit dd838821f0a29781b185cd8fb8e48d5c177bd838 upstream.

Commit 62a063b8e7d1 "nfsd4: fix crash on writing v4_end_grace before
nfsd startup" is trying to fix a NULL dereference issue, but it
mistakenly checks if the nfsd server is started. So fix it.

Fixes: 62a063b8e7d1 "nfsd4: fix crash on writing v4_end_grace before nfsd startup"
Cc: stable@vger.kernel.org
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Yihao Wu <wuyihao@linux.alibaba.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfsd/nfsctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1126,7 +1126,7 @@ static ssize_t write_v4_end_grace(struct
 		case 'Y':
 		case 'y':
 		case '1':
-			if (nn->nfsd_serv)
+			if (!nn->nfsd_serv)
 				return -EBUSY;
 			nfsd4_end_grace(nn);
 			break;


