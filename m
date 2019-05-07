Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0786C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C8E20675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557209034;
	bh=4awd9NLNSTDlyZDQlIvACymYmEBLRhsDM92GCE3UBXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oKri62+wW1GDHCmhcK22OiaiChmrq5Bvel9mm0J800wff2HSHYdS3ELvguYeKBqsV
	 8viu1QSYXkQn2krmbkF1NQJjNScz8Vd9oiQVD91Abiewpr0NeXZElw/G7a0Lhqk/ys
	 GL6RKLKFjFxLz7euJwKXfFeyivIwN9SW3J89beFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfEGGDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:03:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbfEGFfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:35:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17647214C6;
        Tue,  7 May 2019 05:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207302;
        bh=4awd9NLNSTDlyZDQlIvACymYmEBLRhsDM92GCE3UBXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mufxCoCqKpRM7AOqZIw96SuSG8RQhj/1j4yNYglvNR0/CPT/RYvjI26rEXaAKYywa
         goa8/zyeohy5bQqWDS4+2lMI7liXXjurOecdeVNFZ9qQDqr699qAzbvSO+uErGifMD
         3tRWrYh2eqETwVfE2Mku1I3+DMvl/oWjPFmpzjtg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Po-Hsu Lin <po-hsu.lin@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 73/99] selftests/net: correct the return value for run_afpackettests
Date:   Tue,  7 May 2019 01:32:07 -0400
Message-Id: <20190507053235.29900-73-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053235.29900-1-sashal@kernel.org>
References: <20190507053235.29900-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Po-Hsu Lin <po-hsu.lin@canonical.com>

[ Upstream commit 8c03557c3f25271e62e39154af66ebdd1b59c9ca ]

The run_afpackettests will be marked as passed regardless the return
value of those sub-tests in the script:
    --------------------
    running psock_tpacket test
    --------------------
    [FAIL]
    selftests: run_afpackettests [PASS]

Fix this by changing the return value for each tests.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/run_afpackettests | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/run_afpackettests b/tools/testing/selftests/net/run_afpackettests
index 2dc95fda7ef7..ea5938ec009a 100755
--- a/tools/testing/selftests/net/run_afpackettests
+++ b/tools/testing/selftests/net/run_afpackettests
@@ -6,12 +6,14 @@ if [ $(id -u) != 0 ]; then
 	exit 0
 fi
 
+ret=0
 echo "--------------------"
 echo "running psock_fanout test"
 echo "--------------------"
 ./in_netns.sh ./psock_fanout
 if [ $? -ne 0 ]; then
 	echo "[FAIL]"
+	ret=1
 else
 	echo "[PASS]"
 fi
@@ -22,6 +24,7 @@ echo "--------------------"
 ./in_netns.sh ./psock_tpacket
 if [ $? -ne 0 ]; then
 	echo "[FAIL]"
+	ret=1
 else
 	echo "[PASS]"
 fi
@@ -32,6 +35,8 @@ echo "--------------------"
 ./in_netns.sh ./txring_overwrite
 if [ $? -ne 0 ]; then
 	echo "[FAIL]"
+	ret=1
 else
 	echo "[PASS]"
 fi
+exit $ret
-- 
2.20.1

