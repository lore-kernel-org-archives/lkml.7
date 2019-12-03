Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC4CC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4335F20865
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413897;
	bh=BH4XAfgjaFQtLYstBfkAK9thIvuj0N1Wx9HIRQw3V8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0fzS0b7qBumPtVOrkxoPcvYV5VBwqXC3sxWavKRaPY9El+GEt8hUe22a2HwFC+5Ab
	 CSRU8IQHFOueudnZA2siL1zr6ZUskznxR6oaR5q10rlqKVUMA+/u6wMSHWlk7mAsfr
	 EHIR6XevP/QkdxzpjEBdkQ6xefGSmm2Jl9azg8go=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730634AbfLCW6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:58:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:54468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbfLCW6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:58:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F29B21789;
        Tue,  3 Dec 2019 22:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413891;
        bh=BH4XAfgjaFQtLYstBfkAK9thIvuj0N1Wx9HIRQw3V8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i4TysKpvCY/HMy6uPxi0ykZ9ilLsZIlPxyRd8W9yAVxw3nOf9dWuP/+lklOmxVPJX
         a54oGMN0DbK+owxbSuGa7+ZnQV2IhFIGlejS1344WvbTEH8mRgqV2hs0esBIfVc4aK
         fx2E22exJIcMSvKl/wPEyiW624B1830TlAL8pM1w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Boris Brezillon <bbrezillon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 262/321] mtd: Remove a debug trace in mtdpart.c
Date:   Tue,  3 Dec 2019 23:35:28 +0100
Message-Id: <20191203223440.760013978@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <bbrezillon@kernel.org>

[ Upstream commit bda2ab56356b9acdfab150f31c4bac9846253092 ]

Commit 2b6f0090a333 ("mtd: Check add_mtd_device() ret code") contained
a leftover of the debug session that led to this bug fix. Remove this
pr_info().

Fixes: 2b6f0090a333 ("mtd: Check add_mtd_device() ret code")
Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/mtdpart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index b9b308cde0a5d..10c53364aa70c 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -626,7 +626,6 @@ err_remove_part:
 	mutex_unlock(&mtd_partitions_mutex);
 
 	free_partition(new);
-	pr_info("%s:%i\n", __func__, __LINE__);
 
 	return ret;
 }
-- 
2.20.1



