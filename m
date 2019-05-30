Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228CFC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAEC4246F6
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191651;
	bh=NyQG9Ck0an3Dh7dq3z/tb5rtl6XFYUhM2ZD9J8wXdzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SRepPlJCmuwf6y5QxzRVZ0IhrdQBBe3TNK1dPQN1wM7jeKhW8NkWFYYVEeiAzy7ym
	 Z9DFWIb+HCHm6eo1Hf9EQSM2yBZ9zet9HyQsTlI7OO36cgnUC5H/JaosOqBTYTDyGA
	 d4pTDpkFt0sqoGqypEOkSDOG9AnDeA2IvcFaj9pg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfE3Era (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:47:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728589AbfE3DLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:11:32 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A29A244A6;
        Thu, 30 May 2019 03:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185892;
        bh=NyQG9Ck0an3Dh7dq3z/tb5rtl6XFYUhM2ZD9J8wXdzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YL/gV3S/NJFx4Fvldfe+oAE+ES1cF8RgVb0Livtc32VDaQRe9O+3UStUAKDI2LZPy
         s7+CAecq36U6qek9QHl00+AnCYb8k3L4nqbAVKyj6oeIOGe0uZwc9RjNYnSOQO5Ff7
         ADlPNkdejrQCGgbJb4d2RY9V16ZOXGlgbuzS5+hg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 237/405] regulator: core: Avoid potential deadlock on regulator_unregister
Date:   Wed, 29 May 2019 20:03:55 -0700
Message-Id: <20190530030553.004381428@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 063773011d33bb36588a90385aa9eb75d13c6d80 ]

Lockdep reports the following issue on my setup:

Possible unsafe locking scenario:

CPU0                    CPU1
----                    ----
lock((work_completion)(&(&rdev->disable_work)->work));
                        lock(regulator_list_mutex);
                        lock((work_completion)(&(&rdev->disable_work)->work));
lock(regulator_list_mutex);

The problem is that regulator_unregister takes the
regulator_list_mutex and then calls flush_work on disable_work. But
regulator_disable_work calls regulator_lock_dependent which will
also take the regulator_list_mutex. Resulting in a deadlock if the
flush_work call actually needs to flush the work.

Fix this issue by moving the flush_work outside of the
regulator_list_mutex. The list mutex is not used to guard the point at
which the delayed work is queued, so its use adds no additional safety.

Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 6da41207e479a..35a7d020afecd 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5062,10 +5062,11 @@ void regulator_unregister(struct regulator_dev *rdev)
 		regulator_put(rdev->supply);
 	}
 
+	flush_work(&rdev->disable_work.work);
+
 	mutex_lock(&regulator_list_mutex);
 
 	debugfs_remove_recursive(rdev->debugfs);
-	flush_work(&rdev->disable_work.work);
 	WARN_ON(rdev->open_count);
 	regulator_remove_coupling(rdev);
 	unset_regulator_supplies(rdev);
-- 
2.20.1



