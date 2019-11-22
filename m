Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BB3C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEF82071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420309;
	bh=/fJ3JwL9yOylSX2pobd1DuKQQvxvmJdnycp9EphWstk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O6cCdRMb29yZ7GoyXNa9PWSPxrZ9HPOyp/aKJIaVfIA8qMUPp35TX1M+Oua5RimI5
	 /D2Bzmp/yVlwMGPITzEsQf8C7AcUKUXqxARUYYLFHIWSyCF8nx0ELRBZxQrG9A7xNe
	 /+50W03NXajvKFe2JwE6c65WQlQM6SwNn/MMyAdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbfKVK62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:58:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:48312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730316AbfKVK6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:58:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C94F20706;
        Fri, 22 Nov 2019 10:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420303;
        bh=/fJ3JwL9yOylSX2pobd1DuKQQvxvmJdnycp9EphWstk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T9bIRhW7jhvDMaFolR+S9wzG7HUrY5AOWVJVJuLgcMaYY7awQszBbHpwoBB4aHfhs
         CrjNVY+sB1iYxGa5IQPQo9+ItRAl62T5cTXj8o5lqdnd4JD3ugX3Oce1pJ+mKUPyCj
         l6x74snYgMrHJxH3kNOUvLUBmHZbyCEff73O5YFY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
        Theodore Tso <tytso@mit.edu>,
        Lukas Czerner <lczerner@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 060/220] ext4: fix build error when DX_DEBUG is defined
Date:   Fri, 22 Nov 2019 11:27:05 +0100
Message-Id: <20191122100916.410926069@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.co.uk>

[ Upstream commit 799578ab16e86b074c184ec5abbda0bc698c7b0b ]

Enabling DX_DEBUG triggers the build error below.  info is an attribute
of  the dxroot structure.

linux/fs/ext4/namei.c:2264:12: error: ‘info’
undeclared (first use in this function); did you mean ‘insl’?
	   	  info->indirect_levels));

Fixes: e08ac99fa2a2 ("ext4: add largedir feature")
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 61dc1b0e4465d..badbb8b4f0f17 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2284,7 +2284,7 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 			dxroot->info.indirect_levels += 1;
 			dxtrace(printk(KERN_DEBUG
 				       "Creating %d level index...\n",
-				       info->indirect_levels));
+				       dxroot->info.indirect_levels));
 			err = ext4_handle_dirty_dx_node(handle, dir, frame->bh);
 			if (err)
 				goto journal_error;
-- 
2.20.1



