Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A18CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD68E206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714581;
	bh=PYJunr7DZonYf/OZbjaiM+S8S8YjIl8g6WUtZd3wjXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QfzIoeNKnMHewEGOOrHCchFt8p1x5vHOn0cCV0pFrgC9R87w1FRRp9Us3zeRpO6Dj
	 eLsdKrIZcz9T4RWfZRI4UPWUnF5WvRLlH5flneig1v8SJ3vvkx8Rueo2yXowbN1/d4
	 uqTK9V8kHAMjxywu0hkpiw0idNUQrL1Z7wMbfkG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfC0TXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:23:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388086AbfC0SHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:07:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B7F721850;
        Wed, 27 Mar 2019 18:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710025;
        bh=PYJunr7DZonYf/OZbjaiM+S8S8YjIl8g6WUtZd3wjXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uBJfKnAEUdTUJVhUU9SSa6U2UqUSS9dETjBNpBW4SCCCUY6wo+mLxwHXKh9dcMTsw
         o9bwc90cvsKX7hjGN3pM04eUG/7eW792mQc4xC5Podb8rN+ronIHJu0i96tpG9G3ch
         2FrV7ovPmIKGG5Qn5LxmNV/BIiz/0NEqg1BKoiWM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-bcache@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 162/262] bcache: fix potential div-zero error of writeback_rate_i_term_inverse
Date:   Wed, 27 Mar 2019 14:00:17 -0400
Message-Id: <20190327180158.10245-162-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Coly Li <colyli@suse.de>

[ Upstream commit c3b75a2199cdbfc1c335155fe143d842604b1baa ]

dc->writeback_rate_i_term_inverse can be set via sysfs interface. It is
in type unsigned int, and convert from input string by d_strtoul(). The
problem is d_strtoul() does not check valid range of the input, if
4294967296 is written into sysfs file writeback_rate_i_term_inverse,
an overflow of unsigned integer will happen and value 0 is set to
dc->writeback_rate_i_term_inverse.

In writeback.c:__update_writeback_rate(), there are following lines of
code,
      integral_scaled = div_s64(dc->writeback_rate_integral,
                      dc->writeback_rate_i_term_inverse);
If dc->writeback_rate_i_term_inverse is set to 0 via sysfs interface,
a div-zero error might be triggered in the above code.

Therefore we need to add a range limitation in the sysfs interface,
this is what this patch does, use sysfs_stroul_clamp() to replace
d_strtoul() and restrict the input range in [1, UINT_MAX].

Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index f98cda32065d..28e0d5a5e25b 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -287,7 +287,9 @@ STORE(__cached_dev)
 	sysfs_strtoul_clamp(writeback_rate_update_seconds,
 			    dc->writeback_rate_update_seconds,
 			    1, WRITEBACK_RATE_UPDATE_SECS_MAX);
-	d_strtoul(writeback_rate_i_term_inverse);
+	sysfs_strtoul_clamp(writeback_rate_i_term_inverse,
+			    dc->writeback_rate_i_term_inverse,
+			    1, UINT_MAX);
 	d_strtoul_nonzero(writeback_rate_p_term_inverse);
 	d_strtoul_nonzero(writeback_rate_minimum);
 
-- 
2.19.1

