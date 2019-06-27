Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60C8C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F3320644
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6LC9hZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfF0Roa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:44:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42913 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfF0Ro2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:44:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so1583459pff.9;
        Thu, 27 Jun 2019 10:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SBYZqfoyt3K/CiQ07Hd+w3JcvKRR1GsSR4h2B9nj7xg=;
        b=T6LC9hZenINjqqDXUyOQ8cpWIotOtfsGNBmVYBfyibVD1fEoRavsY5Vge//7qZVKcK
         bwx1l6dnQfLhaSrdxzw3QhFwp6OJhXkkNRBneMosZ4CYyOv6TMV6jgXkONMSH8FYJTC/
         p2rVBMrjgLv/DwQiDJVLLK/UpGZUyhAD0RR330lwN49Lm+TzWNoANXeLciBUG3D+ujCs
         8wNVTOeN3kLutE6dvBbWfgO6Bj7/4RREgmzhuK5E9SWz9+stX9DSR4YZ+wF5PUFHSIZ2
         QPG9iihcOOV7Tz81M1OrN2g8mnvTsesUffKMvkDCUgPvFRp80EwnQWdLIrp+X2mvDkly
         q4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SBYZqfoyt3K/CiQ07Hd+w3JcvKRR1GsSR4h2B9nj7xg=;
        b=RxybbMHo3+rx1YmB6dvUVBIK9Q844owmRxBGQ1pLad2e0fE6E9eftdGqXebXewgoGD
         AplGKlnPV1DjdhMsCjHESew5nbfj3OphslCnI2dpsrgWSnNzJBqcyL6JciOAfIYIgc7w
         SWxN+XLrbeDYXeCFnQv8KXj/bXlB1EpLdn+RVKu77qR7OtfSbi9Lzb3+SrigfEBycrYA
         54Rzhf2mtYIoxYGKWmDZzZIygrRljNKS0Ktxli1Ap4jwC5X3mV13FhC4hEzwHtVpgkaG
         YCmwU/vnW4WLytmuSfHZmTyc1KMBuNoJvH87tndETntnQY/CzcpjEIGqmHbK6sutXW2p
         XtIg==
X-Gm-Message-State: APjAAAU6JQr134+ZbZm42AVinxCneSgMSCcO11Kyy1H3HM1UND6+eKjh
        Bz4Ez8NJQsGVC0bGwibqNfc=
X-Google-Smtp-Source: APXvYqwE7v/Y/QRUQ3xwREW6I4PY0Fav0OD7fG5EREhwO0AnfYmtHTMxD60KAXBzvjSzya4y8RtTOQ==
X-Received: by 2002:a63:e53:: with SMTP id 19mr4815445pgo.137.1561657467705;
        Thu, 27 Jun 2019 10:44:27 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id q1sm3962760pfg.84.2019.06.27.10.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:44:27 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 60/87] scsi: megaraid: remove memset after kcalloc
Date:   Fri, 28 Jun 2019 01:44:20 +0800
Message-Id: <20190627174420.5466-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kcalloc already zeros the memory.
memset is unneeded.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 3dd1df472dc6..342b39bc9210 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -4141,8 +4141,6 @@ int megasas_alloc_cmds(struct megasas_instance *instance)
 		return -ENOMEM;
 	}
 
-	memset(instance->cmd_list, 0, sizeof(struct megasas_cmd *) *max_cmd);
-
 	for (i = 0; i < max_cmd; i++) {
 		instance->cmd_list[i] = kmalloc(sizeof(struct megasas_cmd),
 						GFP_KERNEL);
-- 
2.11.0

