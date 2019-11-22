Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF3EC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDE52070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420873;
	bh=Nbm+0sMkxlk6HRLaRQOFwTLW1an+JMQpxxCNSerK81o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EQbKPSqeKQKewgQmxoVVlbZTDvbj0K6qJmqOzrIX3SE9/aYk8ehE1Jdcef+Y09pGS
	 AYhxuCc0r1Klpi+I2KYZGuKFKWH81qdLT+eNwdlywI8vJxzLHpMtVauFAYX60rUYcY
	 ekrozKrMuQM1RNS8/cgAbPyC9g9IRBeh6p0XhJSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbfKVLHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:07:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:32992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731043AbfKVLF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:05:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 203582075E;
        Fri, 22 Nov 2019 11:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420726;
        bh=Nbm+0sMkxlk6HRLaRQOFwTLW1an+JMQpxxCNSerK81o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GbDfBdziNQxr1UDGKg43lIPoFey3MOj8yZDcn0VHN/n5G8BKGgMJxxxJaXDD8jXsx
         eJmER9oRMaCtoBK0SHQX+imHa0Sudw5SJALf7d0dSKposYQz7y3/DWCGQQQO8xPnph
         hH8Kck7DlV4BjqE7ejpUJlZo3taIaNdHzXpW0JoI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Machata <petrm@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 204/220] selftests: forwarding: Have lldpad_app_wait_set() wait for unknown, too
Date:   Fri, 22 Nov 2019 11:29:29 +0100
Message-Id: <20191122100928.511539235@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Machata <petrm@mellanox.com>

[ Upstream commit 372809055f6c830ff978564e09f58bcb9e9b937c ]

Immediately after mlxsw module is probed and lldpad started, added APP
entries are briefly in "unknown" state before becoming "pending". That's
the state that lldpad_app_wait_set() typically sees, and since there are
no pending entries at that time, it bails out. However the entries have
not been pushed to the kernel yet at that point, and thus the test case
fails.

Fix by waiting for both unknown and pending entries to disappear before
proceeding.

Fixes: d159261f3662 ("selftests: mlxsw: Add test for trust-DSCP")
Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/forwarding/lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index ca53b539aa2d1..08bac6cf1bb3a 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -251,7 +251,7 @@ lldpad_app_wait_set()
 {
 	local dev=$1; shift
 
-	while lldptool -t -i $dev -V APP -c app | grep -q pending; do
+	while lldptool -t -i $dev -V APP -c app | grep -Eq "pending|unknown"; do
 		echo "$dev: waiting for lldpad to push pending APP updates"
 		sleep 5
 	done
-- 
2.20.1



