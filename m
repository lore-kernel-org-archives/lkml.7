Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9A9C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E85C2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgsPjR6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfG2Io7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:44:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35693 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfG2Io6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:44:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so27236379plp.2;
        Mon, 29 Jul 2019 01:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/+k1cCW3hB4jfxvc/1cVEskjGWMvsmOcHLSENoPU7GI=;
        b=QgsPjR6+2ydKYWsEeSqNt36OdA3VK9LDM1mcbMdX+VeR9RlzAB+rXipZBmLJslJbsa
         vMxQgFbpOsNmF0weY6+7gMWlI23LQF3u5avrnO5ZqFizWofBu8EkUh46zTz9HSa27Ow1
         SuMynRhriZQhm2/9OWniLJIWyR0jNrQBk/nd9cj+/DIFqgcMLw/ZZbhA5V9sjXAMlv4m
         Gt7cy7gLcAFFCuLj1okXKOfaJ88ACvERBS9x9vB/Z/nM8ZVQBTWtmnPs1oCr5bxrA0+Z
         Tk5QLMNegGTf5X2MxJ49oC0HGhoOtPmiKeZfLfqyZnkV8klD1p4sFfFe6S4LGJkcgNiO
         xyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/+k1cCW3hB4jfxvc/1cVEskjGWMvsmOcHLSENoPU7GI=;
        b=I1dUICZd5gsrbv1qqwbUDQAY2zO5cLjcNOdyJRqQyy1adrKE5wqGQm5r4Tcsv6R52B
         fObljxWdE427Pg+haWpwC4muYbzwqxM2Hx/H5VcI8SyeEppWILpuB3RYO0YDniYzDNfG
         jTgCNV5dQdHPhGBSmXweAlY+5AHqDWdFkqbt/vSNrGK4mQlDigQvKdjHvaapuBWSRyTv
         oCFzmUbrRe28OU98Xzp3yaemisd0sMe6MzN+GNL+GIrE7MoDOpyNx7x+24DkBdo7XMq3
         2li8WkPANhPuY8Xwm9o7r5q9E2DN3gduR5iUgDIf9eNvI8x6AGL9ONdaAyL9oFFuoQ57
         BlQw==
X-Gm-Message-State: APjAAAVwrYuzjpNMcN34ujU6rahr+89MgBDV+dRJKf05Oi680tmS9tFt
        F6XzSPip0t2TpenAAMIsXjw=
X-Google-Smtp-Source: APXvYqxyUGjlnANrB+Ew505+Qs1f/ObGsAHz6lT1EZ8qVfUnG5Da+47G4eaBso7cvhU+OQUPkrXhFA==
X-Received: by 2002:a17:902:6a85:: with SMTP id n5mr101625957plk.73.1564389898217;
        Mon, 29 Jul 2019 01:44:58 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id r18sm59992863pfg.77.2019.07.29.01.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 01:44:57 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     qla2xxx-upstream@qlogic.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] scsi: qla2xxx: Fix possible null-pointer dereferences in qla2x00_alloc_fcport()
Date:   Mon, 29 Jul 2019 16:44:51 +0800
Message-Id: <20190729084451.29290-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In qla2x00_alloc_fcport(), fcport is assigned to NULL in the error
handling code on line 4880:
    fcport = NULL;

Then fcport is used on lines 4883-4886:
    INIT_WORK(&fcport->del_work, qla24xx_delete_sess_fn);
	INIT_WORK(&fcport->reg_work, qla_register_fcport_fn);
	INIT_LIST_HEAD(&fcport->gnl_entry);
	INIT_LIST_HEAD(&fcport->list);

Thus, possible null-pointer dereferences may occur.

To fix these bugs, qla2x00_alloc_fcport() directly returns NULL 
in the error handling code.

These bugs are found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/scsi/qla2xxx/qla_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 4059655639d9..da83034d4759 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -4877,7 +4877,7 @@ qla2x00_alloc_fcport(scsi_qla_host_t *vha, gfp_t flags)
 		ql_log(ql_log_warn, vha, 0xd049,
 		    "Failed to allocate ct_sns request.\n");
 		kfree(fcport);
-		fcport = NULL;
+		return NULL;
 	}
 
 	INIT_WORK(&fcport->del_work, qla24xx_delete_sess_fn);
-- 
2.17.0

