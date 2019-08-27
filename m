Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C5AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853AD21883
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892374;
	bh=HKWTmzBr6QwxBD6e2SZEEs4GDcyNy+TTL8HR53n/OQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ug4UGQK/NBYkILmdmxHrpvxS0lRTYxAIn+Wk5Swy/aLTSySB1HPRXlJHXgENY5iXB
	 Kqvtf7xbh4LeCv92fAZ6DsPkUSKjGI2EAoB3Rsgg2opWJqt2456/6CxzGfW5PZzcl7
	 vkqaJgtHYyb8zT+x7jHBHI9xHX9s7egxG5BopQwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbfH0Hwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:52:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729596AbfH0Hwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:52:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3161223406;
        Tue, 27 Aug 2019 07:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892368;
        bh=HKWTmzBr6QwxBD6e2SZEEs4GDcyNy+TTL8HR53n/OQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=av7tgDEO/GqWpYQrI9UGrHrB2I1TitCM/xZOwkfmDXNBQZI6/iNrYxkLz6OEiMwcK
         3Uf+v4i0GRHMmwsuTVz3XUI3EfiGz3/vA+/CRAfmaKHljcjpJHpUY/tM0RvRenKqqT
         YDwT+8fxwik2lQX8mCel5ymg7aNl67tathhOPIhM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Deepak Rawat <drawat@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 31/62] drm/vmwgfx: fix memory leak when too many retries have occurred
Date:   Tue, 27 Aug 2019 09:50:36 +0200
Message-Id: <20190827072702.539257121@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072659.803647352@linuxfoundation.org>
References: <20190827072659.803647352@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 6b7c3b86f0b63134b2ab56508921a0853ffa687a ]

Currently when too many retries have occurred there is a memory
leak on the allocation for reply on the error return path. Fix
this by kfree'ing reply before returning.

Addresses-Coverity: ("Resource leak")
Fixes: a9cd9c044aa9 ("drm/vmwgfx: Add a check to handle host message failure")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Deepak Rawat <drawat@vmware.com>
Signed-off-by: Deepak Rawat <drawat@vmware.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index 97000996b8dc5..50cc060cc552a 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -300,8 +300,10 @@ static int vmw_recv_msg(struct rpc_channel *channel, void **msg,
 		break;
 	}
 
-	if (retries == RETRIES)
+	if (retries == RETRIES) {
+		kfree(reply);
 		return -EINVAL;
+	}
 
 	*msg_len = reply_len;
 	*msg     = reply;
-- 
2.20.1



