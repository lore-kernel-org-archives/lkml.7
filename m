Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B10C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42306205ED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483966;
	bh=zDOciEiGB5QmHT/IAV9i2f1nWIB5IZWqNAdqENCet2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZqotU3kiq19VYeecGTmkY5RrJjHibG5Z0M55yNZLiUx2yXYFfFCUtCxuVzlzg0kVr
	 cmQ55fuLAchDrcl3q5auyyYhwgoiTk1SHl784Cv1VJdkR71OrVojd2V8sawERQoeca
	 xUxLBxJ00WjR+KFBJwVAkZI3nxm8otkdWB0temq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbfLDS0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:26:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729284AbfLDSAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:00:12 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 262192073B;
        Wed,  4 Dec 2019 18:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482411;
        bh=zDOciEiGB5QmHT/IAV9i2f1nWIB5IZWqNAdqENCet2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dbYu+9ta0U0DOV5JjoGUajomgVc6PNHgfhRyK9O5EI0xnjZwQT1jK1ryM72LNOCod
         8gIOPW+7wATq0T+DdjORIyDSfRfWZ33PF+HXXamySe6y7/qi5obLKqRyJSYFIhEDrQ
         CDjmBlM17SUToCXhX1ggQzzNdk1Kl9fLne1OFlgU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Boris Brezillon <bbrezillon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 76/92] mtd: Remove a debug trace in mtdpart.c
Date:   Wed,  4 Dec 2019 18:50:16 +0100
Message-Id: <20191204174334.827696029@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204174327.215426506@linuxfoundation.org>
References: <20191204174327.215426506@linuxfoundation.org>
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
index 9b48be05cd1af..59772510452a5 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -624,7 +624,6 @@ err_remove_part:
 	mutex_unlock(&mtd_partitions_mutex);
 
 	free_partition(new);
-	pr_info("%s:%i\n", __func__, __LINE__);
 
 	return ret;
 }
-- 
2.20.1



