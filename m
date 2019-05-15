Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F164C04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D3C20818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919385;
	bh=/d9PVLH/lgj6KLU9qXfdf0QWirSWnEW5nYPk3uGDmg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rJ4Z9pbjxTMaTHPtLXJtKAcSN3PJLVOEr6uPhbksbFr1s2pUQlQ0eKCuSFs+ElbYn
	 Ft1lS12axtDOGdICHPqkeFFC9eS8O+DkCT++yTUAIHoruct4BMBPBgaOslbJZGcShJ
	 XaB70VsCevips5pm+p4Rd7UjIx7VtB/n+Qo2IUSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbfEOLXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:23:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731285AbfEOLXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:23:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F06ED20818;
        Wed, 15 May 2019 11:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919380;
        bh=/d9PVLH/lgj6KLU9qXfdf0QWirSWnEW5nYPk3uGDmg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GPQUNDgm6s5fVX+QAA5X3e90XJB38OrPQUbtBMs1z1udo7t8aUm0oEKiqYVzg/mR9
         dVs5tOFsNExe687RP0zxl0bqXzreXVaVMxjVlWuEL1yg4iEAq9OV9oVMaQIisCM26E
         phSo+w1Yja/XvLHXh4jXtOXS2QErCgy5vyyajGyY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Po-Hsu Lin <po-hsu.lin@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 054/113] selftests/net: correct the return value for run_netsocktests
Date:   Wed, 15 May 2019 12:55:45 +0200
Message-Id: <20190515090657.731000591@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090652.640988966@linuxfoundation.org>
References: <20190515090652.640988966@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 30c04d796b693e22405c38e9b78e9a364e4c77e6 ]

The run_netsocktests will be marked as passed regardless the actual test
result from the ./socket:

    selftests: net: run_netsocktests
    ========================================
    --------------------
    running socket test
    --------------------
    [FAIL]
    ok 1..6 selftests: net: run_netsocktests [PASS]

This is because the test script itself has been successfully executed.
Fix this by exit 1 when the test failed.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/run_netsocktests | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/run_netsocktests b/tools/testing/selftests/net/run_netsocktests
index b093f39c298c3..14e41faf2c574 100755
--- a/tools/testing/selftests/net/run_netsocktests
+++ b/tools/testing/selftests/net/run_netsocktests
@@ -7,7 +7,7 @@ echo "--------------------"
 ./socket
 if [ $? -ne 0 ]; then
 	echo "[FAIL]"
+	exit 1
 else
 	echo "[PASS]"
 fi
-
-- 
2.20.1



