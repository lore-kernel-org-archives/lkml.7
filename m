Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C7DC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 06:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1338720871
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 06:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+DDKIlz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfKRGsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 01:48:00 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40743 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfKRGr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 01:47:58 -0500
Received: by mail-pf1-f194.google.com with SMTP id r4so9890332pfl.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 22:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kRhUk7AWfNdOS4uOw9CX4n7UGKrHJ9sU+S6JsF/zZK4=;
        b=K+DDKIlzQaKddVs/4oCOM40PK8x+T06naKppo/2f+6j4yjyyoSjypU6pvVs6/0E3T9
         hlPGuLpZnSTPEUNXrC4Lb2+l1u1c/u93U1IV2zUoRSP03s/53FOJAVl4amxiqDiq40v7
         GBF42mdVUDwVjJBePRrLe4j7UBCwhWHE5AR9LV5XF0XtePQLgHaCZTkPMyKB8S7db+72
         YIiJh2BCe3HWiWHuMc3QXKJX5+FIzUV2FKymGvq6+hAvEu6nvn/f0fA8su30E1ivQpPK
         uZbstSPfep7f5dEonpxpKTiTSku65PH20ENFNUxuKn8QlQzcT8tiGMr7KFD9q1flPF0l
         4cOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kRhUk7AWfNdOS4uOw9CX4n7UGKrHJ9sU+S6JsF/zZK4=;
        b=bqMqzvHydfNR40SUa5qbh/wjH7sCPPpN1UXabPpUmZSS7NgcdSmccPFGxoSc5R1Ufe
         CMpF5bG4Cvmjv3VmP0F/2WZsVp3dou3dIBcqbwKbYQq0gFFqmUthVxxVh7I0qFF2NEYT
         QfuQuT89ozsU+o1pqm1RtCmMcwUMqN97YzBXwdP/DeJqnSeS5QQNW0+PvGlMGT6aiPzp
         tSk4atp6DkVNksdMMWsg6fYP8MflcT/P+0JjapDlfUCj1sAAO9+63rRK6SchX8NaVUgS
         6tZYg4MSFXKsb6TQ52pYCaD7K46cpGZ2mym3vocdNvYoaM62vUyEY6G1iblX/DHiOWB6
         D76w==
X-Gm-Message-State: APjAAAV91mcKTo41mkaXt2cMvf2ApuC7leuPcRZJtH3t4pH+p5Zum1wU
        Y3GOsjkgZbQYHvg2rieneuI=
X-Google-Smtp-Source: APXvYqymP9/XCwDVga5DlkU9FmL8YvllouhXfCPtkz8dL9lyMmwZMvR0NEuIRzIvSTozC7XY8oVNmw==
X-Received: by 2002:a63:4961:: with SMTP id y33mr16464976pgk.264.1574059677589;
        Sun, 17 Nov 2019 22:47:57 -0800 (PST)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id v3sm21728403pfi.26.2019.11.17.22.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 22:47:57 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Adrian Reber <areber@redhat.com>, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 2/3] selftests/clone3: report a correct number of fails
Date:   Sun, 17 Nov 2019 22:47:49 -0800
Message-Id: <20191118064750.408003-2-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191118064750.408003-1-avagin@gmail.com>
References: <20191118064750.408003-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In clone3_set_tid, a few test cases are running in a child process.  And
right now, if one of these test cases fails, the whole test will exit
with the success status.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 tools/testing/selftests/clone3/clone3_set_tid.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
index e93369dcfe3b..9c19bae03661 100644
--- a/tools/testing/selftests/clone3/clone3_set_tid.c
+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
@@ -316,7 +316,7 @@ int main(int argc, char *argv[])
 		 */
 		test_clone3_set_tid(set_tid, 3, CLONE_NEWPID, 0, 42, true);
 
-		child_exit(ksft_cnt.ksft_pass);
+		child_exit(ksft_cnt.ksft_fail);
 	}
 
 	close(pipe_1[1]);
@@ -366,12 +366,8 @@ int main(int argc, char *argv[])
 	if (!WIFEXITED(status))
 		ksft_test_result_fail("Child error\n");
 
-	if (WEXITSTATUS(status))
-		/*
-		 * Update the number of total tests with the tests from the
-		 * child processes.
-		 */
-		ksft_cnt.ksft_pass = WEXITSTATUS(status);
+	ksft_cnt.ksft_pass += 4 - (ksft_cnt.ksft_fail - WEXITSTATUS(status));
+	ksft_cnt.ksft_fail = WEXITSTATUS(status);
 
 	if (ns3 == pid && ns2 == 42 && ns1 == 1)
 		ksft_test_result_pass(
-- 
2.23.0

