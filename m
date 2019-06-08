Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B49CC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 13:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E430E21530
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 13:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="degT9g5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfFHNxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 09:53:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41099 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfFHNxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 09:53:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so4815278wrm.8
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 06:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=H30MmEEpsggHLTru0xvrLHxIqR8iOyCZJcNBqqWDdmU=;
        b=degT9g5y/7neS+Luhz7XUDQAnT2K6hd1tuBV25h7IXMpkRJi9/R9IDAg6wLkaSg+6s
         +heei7lwiuwaJRUpcS5Cq2nIlZk9N2hJH5Mi2HagULv0gH5+X3NBCpsf/PnLT5byfY0r
         DTV+kqfPYES1z4zs+ZTqDomQ/nauF+rxdh6su0gitzpcWIYLIv09Mk01iRF90T9JI9o0
         1SSM/PcVQ3Q4tLaWa3AYn7XwWiB3bDtrKAy6O0dudTpjAXRgzi8/9pMDEYvFl+Wids6M
         zf8ZMjp0APSsEImDca3SuAyUYh8TqZkui02baaQ/ZT8rociM+eZzEcGCdI3NSsPAxVNm
         CIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H30MmEEpsggHLTru0xvrLHxIqR8iOyCZJcNBqqWDdmU=;
        b=mssnYYgAd7eYPCEAOtGkqsET0WmTdh/FtWtTe1yjx62NB/ak0mYfarVFjD3aPxzE+J
         zpaDbi5M2jE9b5dNOuF6u6RlMPS3Jns3e4vlvwGQxLSfhs/UnuthVH7++aKT9R/tA5Si
         06i5c/QNMkI6WiblPo3M0CDWVjRUwU7SoqOCnEIoRbni4EeekZGESR3s5MFrJHvBZORT
         tl6Y6Q3sSKpG+YQVVHcEEJOvpzzxbu8+bfIH+MBxoYFsnzp6ikcBje3nNyQm2lBcr2i5
         BAGsYPaKxk74EJogNqM8Cz7wqwVooXWUHDV0fGorOdYYan5CX1eW1CgoPUZqXNqYRGAx
         hSHA==
X-Gm-Message-State: APjAAAXeDO9vJIoofVRkAsN2ft59IRgksfVLH59ziGFtFXPlS+dz0WgZ
        efMU+/rVYMNpjc4CktE8k47Dec6kg3o=
X-Google-Smtp-Source: APXvYqzG9/H/KwkoLM2OLhX84LY+EmAyrLb95moEe2j04/SG3GGQBZUtgjivI8QUoa7KLgOP5Rdxkw==
X-Received: by 2002:adf:ef0a:: with SMTP id e10mr22144866wro.303.1560002017063;
        Sat, 08 Jun 2019 06:53:37 -0700 (PDT)
Received: from xe-vm.localdomain (2.red-83-34-179.dynamicip.rima-tde.net. [83.34.179.2])
        by smtp.gmail.com with ESMTPSA id v15sm5085608wrt.25.2019.06.08.06.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 06:53:36 -0700 (PDT)
From:   xabi1500@gmail.com
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Xabier Etxezarreta <xabi1500@gmail.com>
Subject: [PATCH] Staging: rts5208: fixed brace coding style issue
Date:   Sat,  8 Jun 2019 15:53:35 +0200
Message-Id: <20190608135335.6383-1-xabi1500@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xabier Etxezarreta <xabi1500@gmail.com>

Fixed a coding style issue checked with checkpatch.pl

Signed-off-by: Xabier Etxezarreta <xabi1500@gmail.com>
---
 drivers/staging/rts5208/rtsx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index fa597953e9a0..d16e92b09a1f 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -419,10 +419,7 @@ static int rtsx_control_thread(void *__dev)
 				chip->srb->device->id,
 				(u8)chip->srb->device->lun);
 			chip->srb->result = DID_BAD_TARGET << 16;
-		}
-
-		/* we've got a command, let's do it! */
-		else {
+		} else { /* we've got a command, let's do it! */
 			scsi_show_command(chip);
 			rtsx_invoke_transport(chip->srb, chip);
 		}
-- 
2.17.1

