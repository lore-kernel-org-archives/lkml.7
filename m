Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADD3C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCDE20815
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920007;
	bh=LZp/NX6ULwok7KISCfKKkJI5x6JyKuh3DkWBM1uLWIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z/5LRrT4+lVbhSGy2Q7kVqDCu5lRoHpgGtfVg/CzyPkn56WthWSAvDRsjZc80caSQ
	 BOTpNIlslOwj8gAAwrOB7op4lyw/9IwA2d9T2dTXmeLDPwNQ1EWEzfqOP7QJfu7rMO
	 0ygdjC4VP/updfPxvoqSsrPNZXg5QPkOs4gSCbG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbfKPQAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:00:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:34898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731285AbfKPPxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:53:43 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84F7421903;
        Sat, 16 Nov 2019 15:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919622;
        bh=LZp/NX6ULwok7KISCfKKkJI5x6JyKuh3DkWBM1uLWIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KHg2Qq9wpMDt7/n5xUloUr0S3V3HxuR60pledreMpnXa6O3ojUmMWOnWb2qMk+UPe
         hlyzbVO1ewdG9ZgtF0bizLqDHhxTPVZWFVfZVmEbe2+fC6CuLdKLTpvb6EZvlSojtj
         WSPPyAr4FI2lb494IktaNBd2pGJfhFSCN7aJL6wY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.4 05/77] powerpc: Fix signedness bug in update_flash_db()
Date:   Sat, 16 Nov 2019 10:52:27 -0500
Message-Id: <20191116155339.11909-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116155339.11909-1-sashal@kernel.org>
References: <20191116155339.11909-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 014704e6f54189a203cc14c7c0bb411b940241bc ]

The "count < sizeof(struct os_area_db)" comparison is type promoted to
size_t so negative values of "count" are treated as very high values
and we accidentally return success instead of a negative error code.

This doesn't really change runtime much but it fixes a static checker
warning.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Geoff Levand <geoff@infradead.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/ps3/os-area.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/ps3/os-area.c b/arch/powerpc/platforms/ps3/os-area.c
index 3db53e8aff927..9b2ef76578f06 100644
--- a/arch/powerpc/platforms/ps3/os-area.c
+++ b/arch/powerpc/platforms/ps3/os-area.c
@@ -664,7 +664,7 @@ static int update_flash_db(void)
 	db_set_64(db, &os_area_db_id_rtc_diff, saved_params.rtc_diff);
 
 	count = os_area_flash_write(db, sizeof(struct os_area_db), pos);
-	if (count < sizeof(struct os_area_db)) {
+	if (count < 0 || count < sizeof(struct os_area_db)) {
 		pr_debug("%s: os_area_flash_write failed %zd\n", __func__,
 			 count);
 		error = count < 0 ? count : -EIO;
-- 
2.20.1

