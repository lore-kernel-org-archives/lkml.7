Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969D9C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEFE217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560544162;
	bh=0gs+mJ6GRnFjxn0TGwgB/OBpyxDh7oPRNYR3bdnWLmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yYli/DMtCioub0yDlASas/4vjOIbUE3Esw97pchNbgVJaw4nzeUGmqwuzZOFby8ec
	 +Vjwlzc0F73BU/puBMfgxAdJcbLmJ3E8jmB2Lpi3Q1pBtuKhZXJx1uJGt6mq0USwA9
	 hH9TTOprFU2RiEkX8p9BHBUXMHDMukvmQJ0TO8gw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfFNU3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:29:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfFNU3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:29:17 -0400
Received: from sasha-vm.mshome.net (unknown [131.107.159.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C3022184D;
        Fri, 14 Jun 2019 20:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560544157;
        bh=0gs+mJ6GRnFjxn0TGwgB/OBpyxDh7oPRNYR3bdnWLmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BBinhT4HPwkGF8BEkym5FLve9VrPJz7QMh6hHGMmbiEiWdW1bTCXRbZ0W6WIiIBwZ
         qcO9TYsPRoenriP80mFAr7kJ1PVAAVvXsGZsuHqmo6bmNkbdE1clRXYN528Wpb64/2
         Qmw50+awBvxb1Si5UEieLSXT7fwyp8sL4m0sALag=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alakesh Haloi <alakesh.haloi@gmail.com>,
        Peter Xu <peterx@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 31/59] userfaultfd: selftest: fix compiler warning
Date:   Fri, 14 Jun 2019 16:28:15 -0400
Message-Id: <20190614202843.26941-31-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614202843.26941-1-sashal@kernel.org>
References: <20190614202843.26941-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alakesh Haloi <alakesh.haloi@gmail.com>

[ Upstream commit 98a13a8d253999cf25eb16d901c35fbd2a8455c4 ]

Fixes following compiler warning

userfaultfd.c: In function ‘usage’:
userfaultfd.c:126:2: warning: format not a string literal and no format
	arguments [-Wformat-security]
  fprintf(stderr, examples);

Signed-off-by: Alakesh Haloi <alakesh.haloi@gmail.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/vm/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 5d1db824f73a..b3e6497b080c 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -123,7 +123,7 @@ static void usage(void)
 	fprintf(stderr, "Supported <test type>: anon, hugetlb, "
 		"hugetlb_shared, shmem\n\n");
 	fprintf(stderr, "Examples:\n\n");
-	fprintf(stderr, examples);
+	fprintf(stderr, "%s", examples);
 	exit(1);
 }
 
-- 
2.20.1

