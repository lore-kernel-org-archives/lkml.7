Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA9CC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995B8214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565748973;
	bh=KbEKVT02qESa8FCLgt3PGP+TDpILOUbdE9UvKXRpwT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1sVum/p0muASWOZXQj+4LDEinXAqQZ5BJ7Wy3FOOf9AI/jqzBrYQfk4EFg+ahUx8P
	 tKy1ngr4vJ7cEYVnAxClJXnrgHpQJVV1TwJ0CG7/7yrLi+R1afJhI6O1mARQ3yzsO0
	 hZBAU0wx4TO+nrF0iWw2UNsKO2L26kuTS178bulk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfHNCQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:16:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728937AbfHNCQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:16:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11D7A208C2;
        Wed, 14 Aug 2019 02:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565748967;
        bh=KbEKVT02qESa8FCLgt3PGP+TDpILOUbdE9UvKXRpwT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kHqy2PKxqLoZfP3j6ZgCLNPfGQ2iZIgQx63Z5ydgru5wx1Auv84p0HK0BpSdtUrTK
         OaZR/GTXvnYCAGK1H5wLQbApz1hMaG6jWPcnDFAvl5RhXc/KQ/G+lqKSC2YqePYLvi
         l3+BPgsyuahTI8TK6UfvBteGs1Crbae9+uuj0eyw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ido Schimmel <idosch@mellanox.com>,
        Stephen Suryaputra <ssuryaextr@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 11/68] selftests: forwarding: gre_multipath: Enable IPv4 forwarding
Date:   Tue, 13 Aug 2019 22:14:49 -0400
Message-Id: <20190814021548.16001-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021548.16001-1-sashal@kernel.org>
References: <20190814021548.16001-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit efa7b79f675da0efafe3f32ba0d6efe916cf4867 ]

The test did not enable IPv4 forwarding during its setup phase, which
causes the test to fail on machines where IPv4 forwarding is disabled.

Fixes: 54818c4c4b93 ("selftests: forwarding: Test multipath tunneling")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-by: Stephen Suryaputra <ssuryaextr@gmail.com>
Tested-by: Stephen Suryaputra <ssuryaextr@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/forwarding/gre_multipath.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/gre_multipath.sh b/tools/testing/selftests/net/forwarding/gre_multipath.sh
index cca2baa03fb81..37d7297e1cf8a 100755
--- a/tools/testing/selftests/net/forwarding/gre_multipath.sh
+++ b/tools/testing/selftests/net/forwarding/gre_multipath.sh
@@ -187,12 +187,16 @@ setup_prepare()
 	sw1_create
 	sw2_create
 	h2_create
+
+	forwarding_enable
 }
 
 cleanup()
 {
 	pre_cleanup
 
+	forwarding_restore
+
 	h2_destroy
 	sw2_destroy
 	sw1_destroy
-- 
2.20.1

