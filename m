Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F09BC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1C4206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576518807;
	bh=XOTApJkCiuammR73DmCm1PlS4Vhi+iv3evwzFFAsCI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tZ4zmhL77XcocytOq+QG7b5TYEOQX1QYBzaGu54qMTnGaFUX+MKHiYIwQ+ZFTG2br
	 4xewbY6+rQA8oLKqpVpPVskfOlViyGlpP8bbNolLeDJlUxh2OOkCLZSqA/6HXndpR+
	 TStnvVtpjACOXH3eDKChK/j5/LxZAB9vX2iCFWY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfLPRx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:53:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:47012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727726AbfLPRxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:53:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAB4B2166E;
        Mon, 16 Dec 2019 17:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518799;
        bh=XOTApJkCiuammR73DmCm1PlS4Vhi+iv3evwzFFAsCI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b4I0oztdaeZ3cS2uk/3U4x/YBMWQcjiU9OFwZWGFigdLVXdjUgzGtgf63O20vVKpK
         k2ArtyCDjykAog8zwUqdLeL1JrHxG1okcmZrJy+IBqnwPWxXscbIofr5FuW3one1SB
         xug0j53oaJJw0yozYOok9AGkLW5ky6zwokoZf2DE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 072/267] altera-stapl: check for a null key before strcasecmping it
Date:   Mon, 16 Dec 2019 18:46:38 +0100
Message-Id: <20191216174856.598207705@linuxfoundation.org>
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

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 9ccb645683ef46e3c52c12c088a368baa58447d4 ]

Currently the null check on key is occurring after the strcasecmp on
the key, hence there is a potential null pointer dereference on key.
Fix this by checking if key is null first. Also replace the == 0
check on strcasecmp with just the ! operator.

Detected by CoverityScan, CID#1248787 ("Dereference before null check")

Fixes: fa766c9be58b ("[media] Altera FPGA firmware download module")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/altera-stapl/altera.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/altera-stapl/altera.c b/drivers/misc/altera-stapl/altera.c
index f53e217e963f5..494e263daa748 100644
--- a/drivers/misc/altera-stapl/altera.c
+++ b/drivers/misc/altera-stapl/altera.c
@@ -2176,8 +2176,7 @@ static int altera_get_note(u8 *p, s32 program_size,
 			key_ptr = &p[note_strings +
 					get_unaligned_be32(
 					&p[note_table + (8 * i)])];
-			if ((strncasecmp(key, key_ptr, strlen(key_ptr)) == 0) &&
-						(key != NULL)) {
+			if (key && !strncasecmp(key, key_ptr, strlen(key_ptr))) {
 				status = 0;
 
 				value_ptr = &p[note_strings +
-- 
2.20.1



