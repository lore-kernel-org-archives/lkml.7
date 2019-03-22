Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F8BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DFC218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255157;
	bh=3rkzSyhoITrWNjo8Cyk3oURiGCXgshe3dy/q+9ABUOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oB+N25ymETqSw1iCIuF6bYWfvVTZh5r/CeU1HqRbT83E8+XwkpeZVaeAvDQHkQ6ef
	 FYC2iyy3Vo/B8JEpKMCSSNWAmeZX/7Wq6rHU6lhs7HuGDTMcwT2EiN4O4P0Ie2foBP
	 2ChAn9Fkcf8OvJChQE3GAKYwH7wSpc+a+C/F/i2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732000AbfCVLpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:45:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731799AbfCVLpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:45:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B0F9218B0;
        Fri, 22 Mar 2019 11:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255152;
        bh=3rkzSyhoITrWNjo8Cyk3oURiGCXgshe3dy/q+9ABUOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F9Ofi5Lfoky1oq6opYvv/5BjWXwKXyRVdLru1FiPuf2y+zDHkr9K250MFwAwu3qIn
         VYklDQOfkgRZDhXx+4HjKvuRMh+w4FO+y7OQ0Tlt9dgR4DjZwAoaTdHtHum56+LAO+
         X6bpoFs9PeA2X6yj1siPFdcn+pE/vpsKkPcqbx5c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joseph Qi <joseph.qi@linux.alibaba.com>,
        Yihao Wu <wuyihao@linux.alibaba.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.9 105/118] nfsd: fix wrong check in write_v4_end_grace()
Date:   Fri, 22 Mar 2019 12:16:17 +0100
Message-Id: <20190322111223.754571472@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1103,7 +1103,7 @@ static ssize_t write_v4_end_grace(struct
 		case 'Y':
 		case 'y':
 		case '1':
-			if (nn->nfsd_serv)
+			if (!nn->nfsd_serv)
 				return -EBUSY;
 			nfsd4_end_grace(nn);
 			break;


