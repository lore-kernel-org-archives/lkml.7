Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3949EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030232075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGaSlM8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbfCZWGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 18:06:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39922 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731621AbfCZWGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 18:06:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id p20so11744999eds.6;
        Tue, 26 Mar 2019 15:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5MdKqKbJ1H9K3go0faNGUFSsTsQMopuv6/EZSh5qpkQ=;
        b=rGaSlM8QYC8HT6DAZMz4IAlmqpzixVMNRslwW/vCokt6thUttO8cMlqZziX7Bl8fnD
         DJakDIlJQgO4rfa/VROWtLHRqZJOhzVbyopOpyppo+7GxTiJ9BOY/An2jwBagxoudTAs
         i563oZXqMcWjNeen2Ec8NZulUykY9ESjehb9CMgki824A4nAZkCp9c1o70kDisYeFPAp
         9vr8BBQUM2QiNECYggHPs0DXT1Vj7xC0Lnhjqa7/yPZmla3+t5iOuEfO7yjpMyJR53J8
         RKo6+H66w0viU6qU6OgmlN8T3760I09kaHf/0hScx0T4KzmEvgr6lCsN1V4JgtDZzmyl
         FJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5MdKqKbJ1H9K3go0faNGUFSsTsQMopuv6/EZSh5qpkQ=;
        b=koXvc8H8j7ewH2m1pBbc4jd+Re37Y980+TRw2M3wB0/+NAALpmdVwbDPiySamaUHML
         KV+mn3v3oIH9qNMAvCQ1XLGtnvJtE8zsGDg6olS8y3BW6tDGfhI/JQy42SkC/wV+JAeu
         7baeBCtOGkhatvhU3/q7h6dRXAAKmmykCFzmo/ZdStyVt3BMmvlDHbmDB/B2Fd/E7jSg
         VSjH/3TVZPrC3QXqbfE9cIL8oA1rd64UX4VXQzXurFcMXxV9pLjnC1crUhyfhVsG0j3f
         7R/LFBnouWzjQe8DrELc5yvSQCAfmpokT5DLXQjTqSJx+tEYcoPGZAdQigGsqFvZtVUy
         Q+FA==
X-Gm-Message-State: APjAAAWKiZlzbXUZTjAmLcF5zyCpvQFvq6jyTHQXM/Z+J0UZJWUv8Six
        RvH5kfAroTrVNLBH2gGIKvM=
X-Google-Smtp-Source: APXvYqwcVMmi1Ug4VI9BR6QlweaCtzd/hGwKEEzKckanY4aol6dA6GPL6Qhah4wZc4zmy8HoPhqIXQ==
X-Received: by 2002:a50:c201:: with SMTP id n1mr10327552edf.244.1553638001329;
        Tue, 26 Mar 2019 15:06:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id f5sm6864367ede.94.2019.03.26.15.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 15:06:40 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Joe Carnuccio <joe.carnuccio@cavium.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        qla2xxx-upstream@qlogic.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] scsi: qla2xxx: Simplify conditional check again
Date:   Tue, 26 Mar 2019 15:04:46 -0700
Message-Id: <20190326220444.10040-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190320163315.12740-1-natechancellor@gmail.com>
References: <20190320163315.12740-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when it sees a logical not on the left side of a
conditional statement because it thinks the logical not should
be applied to the whole statement, not just the left side:

drivers/scsi/qla2xxx/qla_nx.c:3703:7: warning: logical not is only
applied to the left hand side of this comparison
[-Wlogical-not-parentheses]

This particular instance was already fixed by commit 0bfe7d3cae58 ("scsi:
qla2xxx: Simplify conditional check") upstream but it was reintroduced
by commit 3695310e37b4 ("scsi: qla2xxx: Update flash read/write
routine") in the 5.2/scsi-queue.

Fixes: 3695310e37b4 ("scsi: qla2xxx: Update flash read/write routine")
Link: https://github.com/ClangBuiltLinux/linux/issues/80
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Reword commit message so make it clear this is just a reapplication of
  a commit that is already in mainline, as suggested by Nick.

* Include the authors who reintroduced this warning.

 drivers/scsi/qla2xxx/qla_nx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_nx.c b/drivers/scsi/qla2xxx/qla_nx.c
index e0b4387fd6ba..359ebb634d96 100644
--- a/drivers/scsi/qla2xxx/qla_nx.c
+++ b/drivers/scsi/qla2xxx/qla_nx.c
@@ -3700,8 +3700,8 @@ qla82xx_chip_reset_cleanup(scsi_qla_host_t *vha)
 		spin_unlock_irqrestore(&ha->hardware_lock, flags);
 
 		/* Wait for pending cmds (physical and virtual) to complete */
-		if (!qla2x00_eh_wait_for_pending_commands(vha, 0, 0,
-		    WAIT_HOST) == QLA_SUCCESS) {
+		if (qla2x00_eh_wait_for_pending_commands(vha, 0, 0,
+		    WAIT_HOST)) {
 			ql_dbg(ql_dbg_init, vha, 0x00b3,
 			    "Done wait for "
 			    "pending commands.\n");
-- 
2.21.0

