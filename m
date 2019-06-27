Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEA3C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D208120B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgJp0l9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfF0RpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:45:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43377 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfF0RpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:45:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so1579412pfg.10;
        Thu, 27 Jun 2019 10:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Az20ntNgOiNfE75TLIeOz+3xo6iXHd7mcZEjc88o7WM=;
        b=rgJp0l9R/1IGDTNpD1iIEL3CbrCaoRTb5rAvLPTABF1tfUO/2GDz5E+UafnsvI/64I
         KAw1+4bIzVJLUG9HzSdxC1/9OEE3cJQQGduZy/FkQFHgO1V+SzaUDbO6Z5Yv823aLVEl
         Lp929nbuyGf5RWJai+luwBoS+OUF4aoMRPfLy6VlgeiffPD9xwWWZaLZZd0if5GHFKx/
         linRSeB7LgKWAqacJ8nGoqCsU4nwAUwL33qansQaNSqcABJr9m88/fsMbtgvb+09lPms
         BT0wicM3hM+DUspfjFs2SWn1UiaLUuaIaFQTp43tQtjr/fFwNzKf9HHQJznDIClSz6Ik
         QLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Az20ntNgOiNfE75TLIeOz+3xo6iXHd7mcZEjc88o7WM=;
        b=qGQGm4GZ3mTZXkF5+ywoDtm1+kpsMILQ5It1A20Q55Kgyxn2V/UqhavIox1n0HdfbL
         EdTsrHSlyIpaUhex/44NovUhM1VKG6kM/I5uWO9Ebm5PgxcdSqF0hBACkTp9DbyiCu1c
         CwKQEVcUT5/XIGbtKPPw0zl5gFR6XHXVZfp5POY1KkrUbWEvQbQJX9yTife0bH5dcriy
         /vtYE9RWGS9p8MOqvUoK4eAH+VHFzoi/ImijrV1IMnAYQudha/rHAQbS0hqGEKXenZlJ
         liFYKqYjvBzC8xv44Qtlez1SEuv3krln10De23dzTNuIupIq2dUEIU9WjUzNtW5HnysZ
         t2SA==
X-Gm-Message-State: APjAAAUCG279hk5UGrfzwSsCI4aKMJLsSg42XWof7Sl7Gts42Luq1QMK
        w4ESEwgU+TbxOTIl/9OwM3w=
X-Google-Smtp-Source: APXvYqwWBHozb7Z4b0OqpDej8q3pFQfqKIYxsvHl5L16ci4Aot2GeuALHwIW1AiLxcKCMZ7ThIiMXw==
X-Received: by 2002:a17:90a:8c18:: with SMTP id a24mr7231560pjo.111.1561657515034;
        Thu, 27 Jun 2019 10:45:15 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id z20sm7877761pfk.72.2019.06.27.10.45.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:45:14 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Bradley Grove <linuxdrivers@attotech.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 64/87] scsi: esas2r: remove memset after dma_alloc_coherent
Date:   Fri, 28 Jun 2019 01:45:08 +0800
Message-Id: <20190627174508.5782-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/scsi/esas2r/esas2r_init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/esas2r/esas2r_init.c b/drivers/scsi/esas2r/esas2r_init.c
index 950cd92df2ff..67e7a78f408b 100644
--- a/drivers/scsi/esas2r/esas2r_init.c
+++ b/drivers/scsi/esas2r/esas2r_init.c
@@ -390,7 +390,6 @@ int esas2r_init_adapter(struct Scsi_Host *host, struct pci_dev *pcid,
 		     a->uncached,
 		     upper_32_bits(bus_addr),
 		     lower_32_bits(bus_addr));
-	memset(a->uncached, 0, a->uncached_size);
 	next_uncached = a->uncached;
 
 	if (!esas2r_init_adapter_struct(a,
-- 
2.11.0

