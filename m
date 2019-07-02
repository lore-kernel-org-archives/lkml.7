Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D66FC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7020021479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pAqorpLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfGBIAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:00:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39806 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfGBIAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:00:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so8729377pls.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 01:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0upPyxx9/9vSja6hcZnmpaxw7C3Lr5c7Oi1prKW6IhE=;
        b=pAqorpLY9WLicIJkKVrn+cmwcRCLmEd7/GAyMbT5hQODcFgre0Wr29afd+2bMzLQpu
         7dpcKBJwgY6rrwoxJd6UzRgLHTTIFVzYBvFGwgZzQmRi8QYwhH+iyXpW69W/Zjyc47XC
         8rFr5aXkU2kwHdavNRJhu92cSJ0L6kNaKejQVqtcgXMsrbPseVilj3oKilh9skkS5TYT
         noaX15RaB5VvxlYKPySezv8G0DTN0wsYv3dtnqarzWy7YSPPMta6oW8wI90+YrlWjLff
         4D/xfOOP9AdwUEYtDdMBua9JtQ9xProT+G63+zCzRx1icppgUf5chC3Luzj6JHO8F+CC
         NPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0upPyxx9/9vSja6hcZnmpaxw7C3Lr5c7Oi1prKW6IhE=;
        b=dEI6i72KUjVauZTU6s+9l16pY7tr0HcoyMz0xgU5NJscrlkhFQbjW/fca1U6URMtTw
         9thfUUIIY+a/tBgi+p6e2+985CYWXUe5K8JnUOxwXAzvRfsczDRP/uehnjusHX1aBulc
         BnJHKLrqBRuDj6H6KTYtj/jd/dP/TOfSqedI0fnmlRNoBnOB8CEvDanm71IQ2se8PheN
         DIISljw4JELhOUdPVBt388vCIauCRkLNNspPwgBb1Ji3m37TjDtTyx0dZQsD8aDJq+SV
         ckPYAUbIhDkqhLkxUryatnONTSWZqFqmVhe5cD5t3BXqbIeVwCzNF5ht5o0+Uxq23KS0
         TLsA==
X-Gm-Message-State: APjAAAVvYUH9gwKtAgJJLduNtMZHbVD9rnJOhUOJ6P5b/2ogOthXu9Ng
        ++WBdPbcMPXyAR6GHlZb+0dVu7VNRn0=
X-Google-Smtp-Source: APXvYqxToQKmItsfEQ3280hNqbC/cX7eFFe1LCdC1dhxv8XjbZ2arZLGFKvEZ4jaxUaSVEx0AVLSUQ==
X-Received: by 2002:a17:902:a606:: with SMTP id u6mr10932763plq.275.1562054417034;
        Tue, 02 Jul 2019 01:00:17 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id v28sm11063130pga.65.2019.07.02.01.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 01:00:16 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 26/27] sound: oss: use kzalloc rather than kmalloc with memset
Date:   Tue,  2 Jul 2019 16:00:10 +0800
Message-Id: <20190702080010.24724-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use zeroing allocator instead of using allocator followed
with memset with 0.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Resend

 sound/core/seq/oss/seq_oss_init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/core/seq/oss/seq_oss_init.c b/sound/core/seq/oss/seq_oss_init.c
index 6dc94efc19c9..6e8020d4368a 100644
--- a/sound/core/seq/oss/seq_oss_init.c
+++ b/sound/core/seq/oss/seq_oss_init.c
@@ -66,7 +66,7 @@ snd_seq_oss_create_client(void)
 	struct snd_seq_port_info *port;
 	struct snd_seq_port_callback port_callback;
 
-	port = kmalloc(sizeof(*port), GFP_KERNEL);
+	port = kzalloc(sizeof(*port), GFP_KERNEL);
 	if (!port) {
 		rc = -ENOMEM;
 		goto __error;
@@ -81,7 +81,6 @@ snd_seq_oss_create_client(void)
 	system_client = rc;
 
 	/* create annoucement receiver port */
-	memset(port, 0, sizeof(*port));
 	strcpy(port->name, "Receiver");
 	port->addr.client = system_client;
 	port->capability = SNDRV_SEQ_PORT_CAP_WRITE; /* receive only */
-- 
2.11.0

