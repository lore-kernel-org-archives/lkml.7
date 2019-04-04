Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62330C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BDD20693
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369911;
	bh=/ocC5xg3KNDsUnA0nYsevVcvv/cNqpQ+cY1V//AU6DA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UB+ZadN5RHaGdoU8hOEcpjkf1U92W749deF+OakVZYMnRP7kriieOzrm4foa8mvMs
	 xAICGvwsGT07nGYAjW1EfkOkGWBW0ozLg1U5K2rPekp7N02XYA1CxnZ2R+5QUC1VA8
	 0/KmcJ5tQJtJNMOkBpRqmQdSYlA23Jx+G0Nq16r8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387646AbfDDJZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387463AbfDDJOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:14:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DE7A20643;
        Thu,  4 Apr 2019 09:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369245;
        bh=/ocC5xg3KNDsUnA0nYsevVcvv/cNqpQ+cY1V//AU6DA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SPHKm/58E9YMld9fFCvRibHTLqxQCGMDBf3ir0g2upn+abUqb0XsoftA+A9B18CJO
         vnWInBJYX5q/7jeUXrAlT5gUXvO/wJRYFzFfCAN4fxERVNA63qDRxZSmSRwsus5Jet
         8KVFX4wJOhCE/gEnVmH1X45rtcQVOP9dbYc4O7hI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 151/246] bcache: fix input overflow to sequential_cutoff
Date:   Thu,  4 Apr 2019 10:47:31 +0200
Message-Id: <20190404084624.456950987@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8c27a3953e92eb0b22dbb03d599f543a05f9574e ]

People may set sequential_cutoff of a cached device via sysfs file,
but current code does not check input value overflow. E.g. if value
4294967295 (UINT_MAX) is written to file sequential_cutoff, its value
is 4GB, but if 4294967296 (UINT_MAX + 1) is written into, its value
will be 0. This is an unexpected behavior.

This patch replaces d_strtoi_h() by sysfs_strtoul_clamp() to convert
input string to unsigned integer value, and limit its range in
[0, UINT_MAX]. Then the input overflow can be fixed.

Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 3b287f974fd9..f98cda32065d 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -299,7 +299,9 @@ STORE(__cached_dev)
 		dc->io_disable = v ? 1 : 0;
 	}
 
-	d_strtoi_h(sequential_cutoff);
+	sysfs_strtoul_clamp(sequential_cutoff,
+			    dc->sequential_cutoff,
+			    0, UINT_MAX);
 	d_strtoi_h(readahead);
 
 	if (attr == &sysfs_clear_stats)
-- 
2.19.1



