Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FFFC2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C563824682
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576780550;
	bh=5A49wJRtVTYGGyfDsBCz6MW0Oo8TutOFrNwdDWvDK/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gtzEhlGDNDDvQ9o2HzxKKo3XIUuBs3Aa6ceFGTmdFrS19u1KykI0NA0eKuxpTcnvN
	 ItGFk6m39mWGvX4QjdLzzMayjtyiRrW0mKMyHXfEgATeNzmFyzd3v+v8n104Uy1W3n
	 vXmRJukj7+5Acbk+oDbDqMJ8gqU3XnQe1LJy7UlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfLSSfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:35:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:52486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfLSSfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:35:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9947524682;
        Thu, 19 Dec 2019 18:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780547;
        bh=5A49wJRtVTYGGyfDsBCz6MW0Oo8TutOFrNwdDWvDK/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HxM7nvq/ob3vgy/HyPxzJW1kDrfqaBTmU9kL/L1CJ0YhF9pPx8CW0R0zsAIq/4d14
         y2N+38UeIwsSOoVowhpHpnuPjlcGKQXa4ceQ6F/MaTo6XCUMDt2rZMFIgMNsjePhNp
         MlteXVhSRRz+WPVOYfxLypC5ejYlhsTKc14zwlcE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 019/162] dlm: fix missing idr_destroy for recover_idr
Date:   Thu, 19 Dec 2019 19:32:07 +0100
Message-Id: <20191219183207.761475489@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Teigland <teigland@redhat.com>

[ Upstream commit 8fc6ed9a3508a0435b9270c313600799d210d319 ]

Which would leak memory for the idr internals.

Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/lockspace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 30e4e01db35a3..b14bb2c460426 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -800,6 +800,7 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 
 	dlm_delete_debug_file(ls);
 
+	idr_destroy(&ls->ls_recover_idr);
 	kfree(ls->ls_recover_buf);
 
 	/*
-- 
2.20.1



