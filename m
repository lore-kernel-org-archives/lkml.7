Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D210EC3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 03:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B304F2173B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 03:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfHQD6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 23:58:37 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35812 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfHQD6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 23:58:36 -0400
Received: by mail-yb1-f196.google.com with SMTP id c9so2633264ybq.2;
        Fri, 16 Aug 2019 20:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e15dOmbpA8wIpFGMmENC5OPVg5eKR3YlOR31gP+EdrU=;
        b=jnEJ7bIuyQGx3v1YxbTnOPFUe1Fc5T405W3abXkoNW0aLkJf9jAFQXDfldmtr/+4ya
         2VtmI9HFlMTaJ0YnYNsgICLf+1b85weCVp8MPdeKgtdUmKO5DX5fwESkcNMzdKmvJLkU
         QemP6kC44lG0wuK6RTN0kIcMCwzuhn7PIT2RocEO92w0Zn4Pu73i+InVUgneAzJX7OuL
         yC706eyR6GCnx3Pz8MRWx7Am4DKmnbv347ldO/9PkwpCnufe7+SKB30+pWAOeeQvZG7V
         /mEAxEE6DykvG8GPkcWJ0rAClanzD+Yu+1m/hW7mphYPEUx3BAxjYYxk65MlOEXVy0kO
         ipTw==
X-Gm-Message-State: APjAAAXDDhed1os8lx6HnE0d9Q/W6GTsCt36Z2swrM3Ob7eso8X1oSj3
        J31jJUtBUkDwwoTCK8QFG7M=
X-Google-Smtp-Source: APXvYqzxD/Q6I7jQjWxJfDbQ69ml+DUE3eucbT5edzZQbp/Uq8NB2P+FjdoEMri1AjCedcAQozWiig==
X-Received: by 2002:a25:97c1:: with SMTP id j1mr9979564ybo.349.1566014315893;
        Fri, 16 Aug 2019 20:58:35 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id j3sm1656183ywk.21.2019.08.16.20.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Aug 2019 20:58:35 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] libata: Fix a memory leak bug
Date:   Fri, 16 Aug 2019 22:58:29 -0500
Message-Id: <1566014309-3045-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ata_init(), 'ata_force_tbl' is allocated through kcalloc() in
ata_parse_force_param(). However, it is not deallocated if
ata_attach_transport() fails, leading to a memory leak bug. To fix this
issue, free 'ata_force_tbl' before go to the 'err_out' label.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/ata/libata-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 28c492b..185dd69 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -7040,6 +7040,7 @@ static int __init ata_init(void)
 	ata_scsi_transport_template = ata_attach_transport();
 	if (!ata_scsi_transport_template) {
 		ata_sff_exit();
+		kfree(ata_force_tbl);
 		rc = -ENOMEM;
 		goto err_out;
 	}
-- 
2.7.4

