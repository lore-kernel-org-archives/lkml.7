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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68347C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7DB21479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6VSZAoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfGBH7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:59:32 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35614 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfGBH7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:59:31 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so8719731plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=x9cx5daqiIQ1tM3rWp5IoFUTEpi0lqApKNh4MFAdUvE=;
        b=V6VSZAoUrPJDem4nfUspCtU1FiAZbFRA5XsktzeDhc+BkarvWVY9Re5rbUyl+2oDHA
         sdAtFyLX6OhGs64u/1UReyEnelxKeDirBeKaX6m4Ux3eRFtSDT4iegPP+WpUGzI9qlcZ
         4P1bJm4aQYJM8IwQkOtGUB04CNR8RDs4kPRcTcxcPg0YDMWiehfq6kBK5szDs097C1Xd
         HUdjVTnW4URuoywCUjgaRN+unZ4+A60WcaMQpVvY53NZiHw6WCt8eiBOWS6AwWC1jdvT
         UulRgfpE5DDvQuyvn2hdHoELA3akuGjECHqqRLg6l7a+nlEob1PenR/FTWSEWDN074v0
         f4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x9cx5daqiIQ1tM3rWp5IoFUTEpi0lqApKNh4MFAdUvE=;
        b=c9d/Cd/KfV9JXE2vUHU550am1APqh07uKYLU5Xnki2jIe1CWdHG8PjcoNdrp4WSuxN
         paFAcV5KrgalkMx55JlqQcPu4/ONtlK07rOMi14V+520v/h5Dwvn0+2I/TrgQEmP+7Bu
         itAwLFCfKgUz2oYTVr2Fp0Rv6sKf/l3UMAS2QGtmfDmVZB7aPoy1hyCMlifztQ5yBl4f
         i6gR9VHdvl/lwAIUmsmdAaLmlWsSmnSRt4aUqDQKTD8zSn5Yh2w08Ym549FcUJBd55AW
         uPAoYIjzWY2GggxEfsUCSx1Yx17GIQ++lII8old1+N8PnsL2EfmL4mfFZcLNN06rrsCD
         QqEg==
X-Gm-Message-State: APjAAAXCKV2bjfs7qcm6UpzS98fmUv/8Tha8H0iB2nuKP8kh60FtPiMW
        nqAyPoJaA08PQK7W3EqpDd0RasrXohI=
X-Google-Smtp-Source: APXvYqxmRODZoHNskq9e37gNwDOXmZ/5M90/bKlSuXLc7Uo/VCo1z94Sq7sPIvnRFTHDM0WqdgB9MA==
X-Received: by 2002:a17:902:1e2:: with SMTP id b89mr34670282plb.7.1562054370841;
        Tue, 02 Jul 2019 00:59:30 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id r188sm17294237pfr.16.2019.07.02.00.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 00:59:30 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 21/27] tty: remove unneeded memset
Date:   Tue,  2 Jul 2019 15:59:24 +0800
Message-Id: <20190702075924.24493-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_alloc_consistent calls dma_alloc_coherent directly.
In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

 drivers/tty/serial/icom.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index ad374f7c476d..624f3d541c68 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -207,8 +207,6 @@ static int get_port_memory(struct icom_port *icom_port)
 		return -ENOMEM;
 	}
 
-	memset(icom_port->statStg, 0, 4096);
-
 	/* FODs: Frame Out Descriptor Queue, this is a FIFO queue that
            indicates that frames are to be transmitted
 	*/
-- 
2.11.0

