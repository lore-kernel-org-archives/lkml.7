Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91583C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DA420868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHCbzBHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfDPHGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:06:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40978 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfDPHGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:06:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id 188so9911002pfd.8;
        Tue, 16 Apr 2019 00:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=srOiuYPynm8whZsr4VGN+NQoAjdGyBARdJGDQoQaAoA=;
        b=mHCbzBHjRLIocuokio5qQ8LzqXVulyMgEF8/t74TStwd8BFec+UZBLJ1uvIDf6f6Ej
         0AUEIlP5MZeA99Ue7ZrRFCUqT91OWIBf5vt5ph2RcUY0SDbV6KqHoYHnrpFntHn5ovDA
         /BEzxWNBgIFfziayIUU8CRk7548/tLrIHdsW3XrJAyti+8T4IWohCy67Ub59BlZ5hDfn
         k+7AUxcU/cx551sw9NXj9XKEQMT8jVgVt2FT0eYktUqeu3vfdR2E3WleKzKr6tA+GeOq
         c3rfpavVx5MVKtu6nrVs7k9yePX9IfcHCIbPsdo4GlmUUKO8VwTX5AFBPDlDN9ZMnp1v
         C2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=srOiuYPynm8whZsr4VGN+NQoAjdGyBARdJGDQoQaAoA=;
        b=JlVbSwaWNZVkLSdI58JRukU0iHxm9WjgeNwUtvDUc4OfXSmQ45mJcHvQ44KZWapmnS
         NWNgWXK+oLCpWguA1+7soQHeAMhAIvGurDCtOoQNYsy7Z+JKOIt4mfIb4uTwiYVXN/CR
         woXubJEyjxc63CywT/0caG8Gm7uw+ezTtp76+TwSqSHzUlJEKm8ZYLmCZjcGgDMY95Aq
         SOuC5zx18pZf31tKpJzlnscTbUWTIb6Fi4DEjojYrR4K6DcpDSE2ZnoJHfR3buaDUH2q
         liM5NzeJbeAekDMuB+4+9ykq+HvuSau3G3okUGppabx+D7pYpUD/iMkdK1YBIJO4qihv
         KZwg==
X-Gm-Message-State: APjAAAWdIuutrkMkx31bdjc/c4bK13HiFv+fg+m9aIUCYNPOfbWYXV+Q
        /hvKJEnatQhTbecTA2SD1Zo50jWXTbk=
X-Google-Smtp-Source: APXvYqxEHuNTuVpXNuA0v+snR+j8C4ehMpqQe2vCwzO1GwrsmR+QPSsxC1Bst9Ts0loefMMHO8uUGA==
X-Received: by 2002:a63:1203:: with SMTP id h3mr76094675pgl.164.1555398405048;
        Tue, 16 Apr 2019 00:06:45 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id e23sm70924974pfd.11.2019.04.16.00.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 00:06:44 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     stable@vger.kernel.org, gregkh@linuxfoundation.org,
        Fuqian Huang <huangfq.daxian@gmail.com>,
        Subbu Seetharaman <subbu.seetharaman@broadcom.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4.14] scsi:be2iscsi: Fix a kernel address leakage in be_main.c
Date:   Tue, 16 Apr 2019 15:06:34 +0800
Message-Id: <20190416070634.13421-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Outputting kernel addresses will reveal the locations of kernel code
and data. And there is no need to print the address of a global object 
beiscsi_iscsi_transport in beiscsi_module_init.
This case is similar to CVE-2018-7273[1].
Just remove the print statement.

[1] https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-7273

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/scsi/be2iscsi/be_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index b4542e7..f0dcd1f 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -5844,8 +5844,6 @@ static int __init beiscsi_module_init(void)
 		       "beiscsi_module_init - Unable to  register beiscsi transport.\n");
 		return -ENOMEM;
 	}
-	printk(KERN_INFO "In beiscsi_module_init, tt=%p\n",
-	       &beiscsi_iscsi_transport);
 
 	ret = pci_register_driver(&beiscsi_pci_driver);
 	if (ret) {
-- 
2.11.0

