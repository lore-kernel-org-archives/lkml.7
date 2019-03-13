Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B81C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6772A2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504375;
	bh=1c3qADhncljUBQOHqPQD6kj4YkiNWpprGkkuIeWg+6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1nnT4GgtyuPRGwRUlRvawUY54RJctA/OnVbbcjH49mQ2+s4nry52C7NfhwbKqs8ZI
	 7RAu1vJRoF4QXcztVoIw+SD9Psi7GeTfqtKiUGRAl40GJ0dx1pVNwDy/d0hEoLuXNI
	 GtyoBMrOVIBYkC/6coNlcbqKRUjLYxkNGx9CVVdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfCMTMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbfCMTMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:12:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0E7B2075C;
        Wed, 13 Mar 2019 19:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504368;
        bh=1c3qADhncljUBQOHqPQD6kj4YkiNWpprGkkuIeWg+6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0pJVwmRZ8ZiofAzlxgzR1MeYL5BqSLlWmIwE66e8CObkOcpnOu4PJLKz0YcYCJDtS
         q3ZshFDIeUKresS2Ti3YT4jQxG67bgLNOoDl0OSwpCc/PrSocVWqUT3wHWFVDxW+Tz
         Y4imLy5qvQLwIFa4gKWCLmfsgggFH+/GgHY2DFtI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        David Ahern <dsahern@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 60/60] selftests: fib_tests: sleep after changing carrier. again.
Date:   Wed, 13 Mar 2019 15:10:21 -0400
Message-Id: <20190313191021.158171-60-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

[ Upstream commit af548a27b158d548d41e56255e6eaca1658cc3be ]

Just like commit e2ba732a1681 ("selftests: fib_tests: sleep after
changing carrier"), wait one second to allow linkwatch to propagate the
carrier change to the stack.

There are two sets of carrier tests. The first slept after the carrier
was set to off, and when the second set ran, it was likely that the
linkwatch would be able to run again without much delay, reducing the
likelihood of a race. However, if you run 'fib_tests.sh -t carrier' on a
loop, you will quickly notice the failures.

Sleeping on the second set of tests make the failures go away.

Cc: David Ahern <dsahern@gmail.com>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/fib_tests.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 802b4af18729..1080ff55a788 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -388,6 +388,7 @@ fib_carrier_unicast_test()
 
 	set -e
 	$IP link set dev dummy0 carrier off
+	sleep 1
 	set +e
 
 	echo "    Carrier down"
-- 
2.19.1

