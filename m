Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68022C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C50721555
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888393;
	bh=XR5WvofJzj0e2g0fbgE8Wpx6sS5fNscbX+8F20oWjZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rrkXqxjJZanjrggkPcIpcYp63pN9u5M1M5jcYFn27nvDRqzWPv2McXGg84PFRpKDV
	 PIB3vRzJxiLYy3+cy3+eMtyS+muNLoXoQSiYDOOdKIQkfeplE1YVaUdZs57GVipqil
	 3zWMJkXAd22AhhuqIJOh3k/KgoVWI4l5cqMCP50c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbfK0U7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:59:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:51400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731463AbfK0U7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:59:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ECDE20678;
        Wed, 27 Nov 2019 20:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888386;
        bh=XR5WvofJzj0e2g0fbgE8Wpx6sS5fNscbX+8F20oWjZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pw+nP5LSek+5ZJs5aMQRfnTtzGypL5ZrXbiQwkJbGa/nduK22pwZLAlgCDddhcbM3
         8lRLsbGeLJ5pPbPFxlBS7nY658/Rd833yW1P/xYbJXQtpgoyXDi53SoccDsHGDR2FR
         HYnfJ4cgyOm33XcDqXr1xp45kVQVgyhp2lkgjikE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 115/306] selftests/bpf: fix return value comparison for tests in test_libbpf.sh
Date:   Wed, 27 Nov 2019 21:29:25 +0100
Message-Id: <20191127203123.587919103@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Monnet <quentin.monnet@netronome.com>

[ Upstream commit c5fa5d602221362f8341ecd9e32d83194abf5bd9 ]

The return value for each test in test_libbpf.sh is compared with

    if (( $? == 0 )) ; then ...

This works well with bash, but not with dash, that /bin/sh is aliased to
on some systems (such as Ubuntu).

Let's replace this comparison by something that works on both shells.

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_libbpf.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_libbpf.sh b/tools/testing/selftests/bpf/test_libbpf.sh
index 8b1bc96d8e0cc..2989b2e2d856d 100755
--- a/tools/testing/selftests/bpf/test_libbpf.sh
+++ b/tools/testing/selftests/bpf/test_libbpf.sh
@@ -6,7 +6,7 @@ export TESTNAME=test_libbpf
 # Determine selftest success via shell exit code
 exit_handler()
 {
-	if (( $? == 0 )); then
+	if [ $? -eq 0 ]; then
 		echo "selftests: $TESTNAME [PASS]";
 	else
 		echo "$TESTNAME: failed at file $LAST_LOADED" 1>&2
-- 
2.20.1



