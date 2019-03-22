Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7053FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483E3218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfCVPqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:46:04 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:55939 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfCVPqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:46:04 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M89TB-1h3FUl0ZQx-005ERN; Fri, 22 Mar 2019 16:45:56 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Chuanxiao Dong <chuanxiao.dong@intel.com>,
        Yuan Juntao <juntaox.yuan@intel.com>,
        Pawel Wodkowski <pawelx.wodkowski@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.4.y 05/25] mmc: debugfs: Add a restriction to mmc debugfs clock setting
Date:   Fri, 22 Mar 2019 16:43:56 +0100
Message-Id: <20190322154425.3852517-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rNgMA6KuyisLXRfCfenSe1Wq9wIOuO34n904IfRUOVdG701BO8N
 BsWka5aFdovs3ew+Atu2vZWxg2WBWaFa1PfkL7gqK4/urtKXNZzjMx9p075htozU3cz4MKv
 FDXFRMP33vZohqA/5KGjaaY7zwUXCbtHbvArBIyuJz8TESWvwKg1hI3Y9EYIK7NlLkcV+kx
 xRhUoIfRl9jIlvCxXAU8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zFe/6JXOYhA=:acYPAqDC7pVn98rLvZMSES
 4THsCAGfnVUZdV33tqRBRvFIdFNieDIkxhcrQQmTL0gXyMx6EH2BfZgj8Tg2/NqHFf6H3Pza4
 MK31PMRC6MqlDc7CUs4xJb/10ChMv7QPJcTUORNK/WBxCTgD/o05lWUCkAbHIZzXBaRlCvkue
 43jgkIU2E/aa44EpNzMUNO7FeUzKejJANjDiJYfj8IAR96i0XVy6hsUOVErbkS1cxJvf6c63f
 8JIp321mrCl9VEDUC3mCZLKOhlnWnOeIR7Y+6vzwOh4zLVxUaiDnZNN/8MSlo6SUlxbpcPKWF
 RTLuMKwEWX31ao4qqHM1rbxVTcbUW9Ph9TW5rngLeVnO4netSEkBLP5Wx8Pa2zkeBetw7ItYu
 N770UisrdkNy06VMvXGwN9ijs/9ZONfFxkgy/MgxdWeKEERG9h436seFiUcBJeh2CxEqtB2pg
 1iJ39mxln+0S/JO6NLFc2op1X9h0I0M+20Q+MacNGiErMRDTaEgKCoE1XlyflqJ2VWO/tmPJL
 jS2h6VyEGIfk9h1wTFrz+4hPpr9hCbK7XAnsr7vBRTTVtGIATQ3QmoJ4I1n6hLH9T0qGO+5Mu
 K2t50KugpzaJHaXx7bXoZ4RYZEFwKqhNJTpkoMImgnMOvc6jx41jL+lbdzPbSQhQ4ReXioBD6
 qs0JyYJzNuTowuraliXuZWmWRYTrk/YJkiFIzH/H1FDkjhDxijpZFpZL5b/y8rclYyNZ7XZ75
 EgYpTtfyCOntmVn61fyx4BrT+qMzBbRmE9UUeA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuanxiao Dong <chuanxiao.dong@intel.com>

Clock frequency values written to an mmc host should not be less than
the minimum clock frequency which the mmc host supports.

Signed-off-by: Yuan Juntao <juntaox.yuan@intel.com>
Signed-off-by: Pawel Wodkowski <pawelx.wodkowski@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit e5905ff1281f0a0f5c9863c430ac1ed5faaf5707)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/core/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 154aced0b91b..705586dcd9fa 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -220,7 +220,7 @@ static int mmc_clock_opt_set(void *data, u64 val)
 	struct mmc_host *host = data;
 
 	/* We need this check due to input value is u64 */
-	if (val > host->f_max)
+	if (val != 0 && (val > host->f_max || val < host->f_min))
 		return -EINVAL;
 
 	mmc_claim_host(host);
-- 
2.20.0

