Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72D0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A3C21917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254730;
	bh=bT2w9UDiKyQXi0TjLSmilae1Y5+rO/AnBT3xOyffKxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R4F8VvDkVh9cBqnik/rjJYtOoz8t4Nvtckp0uKhVHcrE/vZ4Sv9X2ysfWFRtVp3jI
	 +cyC6ru0tC+v+d/rmarCLJ9ROQZgQMxLeZnfI7W9XuPElLgZo7ycVgSpb5MuJWQ1kx
	 EcYdQF1/fFrOERdBvqDUA7BQFLZ2SUrSjuVCMlYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbfCVLit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:38:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731021AbfCVLiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:38:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8A2E2082C;
        Fri, 22 Mar 2019 11:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254725;
        bh=bT2w9UDiKyQXi0TjLSmilae1Y5+rO/AnBT3xOyffKxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LkHOK2tKLuywZ4vsBs019dx/7P0SoYZeTMRPWjhnku2wtDYLjzYPdk9UJTqK6PDb+
         6Jofm4kcVUi7RVQyCJqobm0biWtYDUl7Io2oe6EXoYviijYu8LZDqk7RaWKTNptk2j
         Ola/c/jjL6UY0PYU/bVuUTAgoC9H6xWd4yGaO1ZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joseph Qi <joseph.qi@linux.alibaba.com>,
        Yihao Wu <wuyihao@linux.alibaba.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.4 223/230] nfsd: fix wrong check in write_v4_end_grace()
Date:   Fri, 22 Mar 2019 12:16:01 +0100
Message-Id: <20190322111252.582305289@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1106,7 +1106,7 @@ static ssize_t write_v4_end_grace(struct
 		case 'Y':
 		case 'y':
 		case '1':
-			if (nn->nfsd_serv)
+			if (!nn->nfsd_serv)
 				return -EBUSY;
 			nfsd4_end_grace(nn);
 			break;


