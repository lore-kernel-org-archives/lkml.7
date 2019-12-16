Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64474C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D73F218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576518821;
	bh=o0097HBGczPpjO6uj/IUnUpcuRfOFsYqRgOdD/t3OHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cNa1nWIij69hAcWFun+RXPhxythjp6/JEeMbaUJCaOSo+w45itEFdu1OvdLlM3Fs9
	 +ksx8FGXijqTbekikeHdQ3vCR7rlaoYvtXWb2OgpZBiz0QENrfPsJkfqueA5Zm2+0T
	 HryPH9M3JzR2hA9lK9kuBiJ1AXF6tooUlWm8nWTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfLPRxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:53:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:47882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbfLPRxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:53:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8553D206D3;
        Mon, 16 Dec 2019 17:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518816;
        bh=o0097HBGczPpjO6uj/IUnUpcuRfOFsYqRgOdD/t3OHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jzwITC/9nB5LB2oaFm9lFi7NEx13D3IqRPVT65PnxbWZ6WUXgWSbrHmyuf+SXzQSo
         /zmO85Ypb7m9siDPAwglCNCNg02BpTFcEjoeYFdnZdykBHGPFI77XzybFhL2ZJXKH7
         c5TAXeSVoLniruyMqNzE/V3Bdn5kEUydmS0pK5II=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 079/267] dlm: NULL check before kmem_cache_destroy is not needed
Date:   Mon, 16 Dec 2019 18:46:45 +0100
Message-Id: <20191216174857.186563418@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

[ Upstream commit f31a89692830061bceba8469607e4e4b0f900159 ]

kmem_cache_destroy(NULL) is safe, so removes NULL check before
freeing the mem. This patch also fix ifnullfree.cocci warnings.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/memory.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/dlm/memory.c b/fs/dlm/memory.c
index 7cd24bccd4fe5..37be29f21d04d 100644
--- a/fs/dlm/memory.c
+++ b/fs/dlm/memory.c
@@ -38,10 +38,8 @@ int __init dlm_memory_init(void)
 
 void dlm_memory_exit(void)
 {
-	if (lkb_cache)
-		kmem_cache_destroy(lkb_cache);
-	if (rsb_cache)
-		kmem_cache_destroy(rsb_cache);
+	kmem_cache_destroy(lkb_cache);
+	kmem_cache_destroy(rsb_cache);
 }
 
 char *dlm_allocate_lvb(struct dlm_ls *ls)
@@ -86,8 +84,7 @@ void dlm_free_lkb(struct dlm_lkb *lkb)
 		struct dlm_user_args *ua;
 		ua = lkb->lkb_ua;
 		if (ua) {
-			if (ua->lksb.sb_lvbptr)
-				kfree(ua->lksb.sb_lvbptr);
+			kfree(ua->lksb.sb_lvbptr);
 			kfree(ua);
 		}
 	}
-- 
2.20.1



