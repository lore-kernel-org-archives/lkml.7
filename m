Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC2BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9F720862
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558555323;
	bh=NiqXvwojC1D7C1RXV3saA1gnnXcxvKec8v+zqiUIXuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ExHJjxbILiA6HuqCV18mOhZF2IqqC6CsG97HhL1B4KoxxZh/pkh5cMzFmZv+k+as2
	 hGuokjP3WLO65zcChFFLxCebzQO84dKXNo9JTsFmpJt2bfQgfwP92+m+iuwrjOxt1p
	 /3OduUupiNe1q+YtOOQugVI1AnZRGhAq0FpzInnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbfEVTWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:22:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730318AbfEVTWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:22:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8ED82177E;
        Wed, 22 May 2019 19:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558552929;
        bh=NiqXvwojC1D7C1RXV3saA1gnnXcxvKec8v+zqiUIXuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UhCt7dsjboRV7nV70hESEq0aOoDzXQKlhTn43fLiEsAfGZhUkg3Z6QfV9eA5lLLyB
         tWmbS/yORaY7wHjsujgqu7sOClsrBVexynmCo9/Hw7DridSZmgqu6Pq5gHj8Rzc2PE
         crv7P8Q+kBZIfXq+OVMfDCttfnmRPThO119Y8YMc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bo YU <tsu.yubo@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.1 035/375] powerpc/boot: Fix missing check of lseek() return value
Date:   Wed, 22 May 2019 15:15:35 -0400
Message-Id: <20190522192115.22666-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192115.22666-1-sashal@kernel.org>
References: <20190522192115.22666-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bo YU <tsu.yubo@gmail.com>

[ Upstream commit 5d085ec04a000fefb5182d3b03ee46ca96d8389b ]

This is detected by Coverity scan: CID: 1440481

Signed-off-by: Bo YU <tsu.yubo@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/boot/addnote.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/addnote.c b/arch/powerpc/boot/addnote.c
index 9d9f6f334d3cc..3da3e2b1b51bc 100644
--- a/arch/powerpc/boot/addnote.c
+++ b/arch/powerpc/boot/addnote.c
@@ -223,7 +223,11 @@ main(int ac, char **av)
 	PUT_16(E_PHNUM, np + 2);
 
 	/* write back */
-	lseek(fd, (long) 0, SEEK_SET);
+	i = lseek(fd, (long) 0, SEEK_SET);
+	if (i < 0) {
+		perror("lseek");
+		exit(1);
+	}
 	i = write(fd, buf, n);
 	if (i < 0) {
 		perror("write");
-- 
2.20.1

