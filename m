Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39B0C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 17:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7322063F
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 17:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dr3arrr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfGNR1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 13:27:15 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35312 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfGNR1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 13:27:15 -0400
Received: by mail-qt1-f194.google.com with SMTP id d23so13376982qto.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 10:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XZMU82wNnKmKEZ0XxgcXJZsoyOLcOo4xlcTKRS8FhBc=;
        b=Dr3arrr2Pf8i39snL2FYw0NKg65N4FJTIH5KT3NN75mEX4YXnkGXkCcbuIjDeLWrY7
         zuoOV0EEo8NSoJ0Taxfz1V73Cx+L+So7W45uXMBgnhRBEKx3AAkfSbFth7OavjQ6QKWT
         3cxOATI3H8gqfwZ0V6nyH1SN13v/6JCnpyCsuuMwdslkF/h6fmVZW30TAl8nWgpWDsob
         UA2houJ565w726xZqph76sIPRMrbf9ITfznB1rg/Nkj8aq52LPvOQopNpqg9FWY5WYUZ
         XDlEDmjOfE4t4KcGDByWAvnKvktgsDM4/scz7qA3KijtT3ikFZkaeETMHuqDJyFlnVn7
         2R3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XZMU82wNnKmKEZ0XxgcXJZsoyOLcOo4xlcTKRS8FhBc=;
        b=ay04lUssIuo9Pr7BHP+kvRz29DZaa5Mw2tSzYERbnDO9PN89zukhtkdjnKNXpmBOea
         kXFjdVbnJECcoQ8yxEptI8qLhbZK3MS252vfSVooeyhE/fYV/0SxWet80abWZsUD/jpA
         TQPAtjxPZ+w0ldGA02GHwFCITegN/FJoHWVMC4dMldSA/vT/6qpHNQREQHlvXSP95O03
         vQsvwJmd7Mdo8KGUfUOoHxsLSVjvBVAcIltCtK5+JWGhrOsjI/BxLjD8TiLfyjwvV5UW
         E9539wIoue4lKRkTIrWeGUkSBMFYxXBMhZ/iNRLkrVmrKQrZZPdVYj2Ntd8Sqo1Fz6Ud
         Lcqg==
X-Gm-Message-State: APjAAAVMT/ERVbhwy6k/QvhC20DSlnT3TSsri4Pc1u+nSkj5x+RVrl1E
        QEYzbnYfSLgxz1rBUwSgZw==
X-Google-Smtp-Source: APXvYqxWIYI5kvypURV1il95tMRAkixqH5KL20pUR/4A1XY/9aDFQeiVy4dPTEVaqXGp7NWBGAaKVQ==
X-Received: by 2002:ac8:341d:: with SMTP id u29mr14117813qtb.320.1563125234391;
        Sun, 14 Jul 2019 10:27:14 -0700 (PDT)
Received: from localhost.localdomain (modemcable148.230-83-70.mc.videotron.ca. [70.83.230.148])
        by smtp.googlemail.com with ESMTPSA id z19sm7266767qtu.43.2019.07.14.10.27.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 10:27:13 -0700 (PDT)
From:   Keyur Patel <iamkeyur96@gmail.com>
Cc:     markus.elfring@web.de, Keyur Patel <iamkeyur96@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        Suresh Udipi <sudipi@jp.adit-jv.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] staging: most: Delete an error message for a failed memory allocation
Date:   Sun, 14 Jul 2019 13:27:06 -0400
Message-Id: <20190714172708.5067-1-iamkeyur96@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190714164126.3159-1-iamkeyur96@gmail.com>
References: <20190714164126.3159-1-iamkeyur96@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kfifo_alloc() failure generates enough information and doesn't need 
to be accompanied by another error statement.

Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
---
Changes in v5:
- change subject line
- simplify commit description
- fix checkpatch warning
- removed braces around if

 drivers/staging/most/cdev/cdev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/most/cdev/cdev.c b/drivers/staging/most/cdev/cdev.c
index d0cc0b746107..724d098aeef0 100644
--- a/drivers/staging/most/cdev/cdev.c
+++ b/drivers/staging/most/cdev/cdev.c
@@ -463,10 +463,8 @@ static int comp_probe(struct most_interface *iface, int channel_id,
 	spin_lock_init(&c->unlink);
 	INIT_KFIFO(c->fifo);
 	retval = kfifo_alloc(&c->fifo, cfg->num_buffers, GFP_KERNEL);
-	if (retval) {
-		pr_info("failed to alloc channel kfifo");
+	if (retval)
 		goto err_del_cdev_and_free_channel;
-	}
 	init_waitqueue_head(&c->wq);
 	mutex_init(&c->io_mutex);
 	spin_lock_irqsave(&ch_list_lock, cl_flags);
-- 
2.22.0

