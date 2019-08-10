Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD528C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 04:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891D6217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 04:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGDK21aD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfHJEtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 00:49:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54098 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfHJEtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 00:49:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id 10so7513167wmp.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 21:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ulCsjp9diZ2qriE+4Cg5mruQzjkUXFDOkC4POtPmsWA=;
        b=NGDK21aDRWljP1LXoWB7S8eE+O4vZ1sRPfi/6k40/DMPybzHr7mNWtTKcHG0jjthsc
         mV6aD6OTfwuTwiXPbaIBeM1dCZR8XWtXG9Czx1qYs8W/PMQ/6bDvj9e6BSjBqdwd8c1e
         52QFjvRyIOsQ/+25KtWxSUB5hhxSKnG/Btjh34aUpDxqD9HwvhTUJBVFHi/UXJ1xCb1L
         nvhVcOSavxIpIEDynzALLMcV4JKDQ/2udmYf0Y6hLKloclHqeyBWRalaDV+/Cf6g/hrs
         VW537ESr+2HbYHILjzG/P5KZ7RuW6XQCcpErSc6c0vjbcHeOXh8OdXGznEDLtxbk9cT6
         /zDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ulCsjp9diZ2qriE+4Cg5mruQzjkUXFDOkC4POtPmsWA=;
        b=j34tGst29O84GJAsV0wyzjmodfFXBAlOn0hnYnLU1FQA3qtf1LloD8XgpeAChNzCOd
         ip0on6dNHvF6CjnwY3e5tGjMf7CUjUDanZPI28ua2Lf7A1wfajycn5xUmJOh7XTzo9Aq
         rIH/03x4xy8nN7hdOdY70zKnIWxJw+lUOSnWdY0guSKdcdM/WTb2s6nTrl7YggXC9Tbv
         LtZh5A4Hgo49QizZBOAZsqagdi9UYaHvoon7mPsYdk+2VfEHZIM3h4WaZOP051X1Nk5R
         mkEhZ2NKzgAzeLPMJhaI30C9WbJPipluuzMxIPcD2OMtz824+2zpWVivr4rJXaYPBuAk
         sPAg==
X-Gm-Message-State: APjAAAX3LMY3Z1Xc26u2AIqfDg8WwxklT/LGSMrRlfA/L0MJJd4waKQb
        27l30nHlgRonl1+MrDqxwwQ=
X-Google-Smtp-Source: APXvYqzmsiCROnIJE2KU/ceUpPoCJ5gdssn6Ej3YVxoCbp7xgJXDFAogI097PejjQ27EpheLWUvANQ==
X-Received: by 2002:a7b:c310:: with SMTP id k16mr13781272wmj.133.1565412561667;
        Fri, 09 Aug 2019 21:49:21 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id x20sm218826181wrg.10.2019.08.09.21.49.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 21:49:20 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] firmware: arm_scmi: Eliminate local db variable in SCMI_PERF_FC_RING_DB
Date:   Fri,  9 Aug 2019 21:49:10 -0700
Message-Id: <20190810044910.114015-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang warns four times:

drivers/firmware/arm_scmi/perf.c:320:24: warning: variable 'db' is
uninitialized when used within its own initialization [-Wuninitialized]
                SCMI_PERF_FC_RING_DB(db, 64);
                ~~~~~~~~~~~~~~~~~~~~~^~~~~~~
drivers/firmware/arm_scmi/perf.c:300:31: note: expanded from macro
'SCMI_PERF_FC_RING_DB'
        struct scmi_fc_db_info *db = doorbell;          \
                                ~~   ^~~~~~~~

This happens because the doorbell identifier becomes db after
preprocessing:

        if (db->width == 1)
                do {
                        u8 val = 0;
                        struct scmi_fc_db_info *db = db;
                        if (db->mask)
                                val = ioread8(db->addr) & db->mask;
                        iowrite8((u8)db->set | val, db->addr);
                } while (0);

We could swap the doorbell and db identifiers within the macro and that
would resolve the issue; however, there doesn't appear to be a good
reason for having two copies of the same variable. Eliminate the one in
the do while loop to prevent this warning and make the code clearer.

Fixes: 8f12cbcb6abc ("firmware: arm_scmi: Make use SCMI v2.0 fastchannel for performance protocol")
Link: https://github.com/ClangBuiltLinux/linux/issues/635
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/firmware/arm_scmi/perf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 2c5201c8354c..ab946ef6b914 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -294,10 +294,9 @@ scmi_perf_describe_levels_get(const struct scmi_handle *handle, u32 domain,
 	return ret;
 }
 
-#define SCMI_PERF_FC_RING_DB(doorbell, w)		\
+#define SCMI_PERF_FC_RING_DB(db, w)			\
 do {							\
 	u##w val = 0;					\
-	struct scmi_fc_db_info *db = doorbell;		\
 							\
 	if (db->mask)					\
 		val = ioread##w(db->addr) & db->mask;	\
-- 
2.23.0.rc2

