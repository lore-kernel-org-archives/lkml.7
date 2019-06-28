Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1F3C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864DB208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVEavs6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfF1CuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 22:50:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38152 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF1CuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:50:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id y15so2197666pfn.5;
        Thu, 27 Jun 2019 19:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5CHqL3EBEcLGFr61w8Fbiglt4+Qtw+juW+E0F79bUSs=;
        b=tVEavs6z2wplscnprKKaSAmCEe/4JHEpv3WbfQMHdn/Jvc3PBrTg7ZoSMpBov+2n4N
         /1hrTfk55l/kskoKPOZnzn+fFkk8urwMsui0Ym4GM2EPsN6HkB8ghxz/yT0I4LJpoqO0
         yy0ENzX7qm4rCZUzNU833gUNVMtHTpfizn3mfXg3esfYEFFOy+eb4T30Xel3bGQ1cHj8
         TRd4mCEGxXIXiY2mGeScQPf5Vz0jUsUsntXDKSQFpY7VTcZz6R5Vo/9eq3jZQkGjuus9
         +Bh9DA4aOfEXyIc19L6OegK6Hmt5MR/j2cnXMMVsBnEHzWy0O9nGETbAHUcDtM7s5D4U
         +Fxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5CHqL3EBEcLGFr61w8Fbiglt4+Qtw+juW+E0F79bUSs=;
        b=X5BFN+EyeCagf5yiKPPSNsTvYBm3sNn7UIhPRIzJNV9jlKmFOmzP4dGD5vaIh4OK4V
         18OnscF/Do+MZh2cXCJNKdIGaPWPvUb5Y/7VzFv7srv0m1bEWfNOO0kH8cGfGDt9wTqc
         mp6FD2iPWKcvtvT+g1MdlE8C+mYFDmSrMTpgl7a35HnlQh2lR+oKAAjiBYnJlmw6N7n5
         p2AB23NBUI6S2xZQgolJo/sO4uKZwb0lJgCNNwmKTM8jahkgVVH0QvJsO5PwNNECGWzN
         ilU7dyM6BfwwxOsvDRIO4K4UbW73aGRuKf9vQkKRJUeulAlBWoj31ZZnwGTPxZdcX02T
         oXfA==
X-Gm-Message-State: APjAAAVd93eDg05A6W7A/xzREM9CV7OnGH28cp9DR/2IBF0nZHrcGi1h
        lTfYYhW2Qc3C+8ndonM8UKc=
X-Google-Smtp-Source: APXvYqzN0rpbKafbSvm5Mwr5gaE+z6gJ4inrKire9RmKAk+IJYMR0kqfrztirhlrbrAddYP9lBty5w==
X-Received: by 2002:a17:90a:360b:: with SMTP id s11mr9960385pjb.51.1561690207932;
        Thu, 27 Jun 2019 19:50:07 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id 137sm451516pfz.116.2019.06.27.19.50.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 19:50:07 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/27] tty: remove unneeded memset
Date:   Fri, 28 Jun 2019 10:50:00 +0800
Message-Id: <20190628025000.15922-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_alloc_consistent calls dma_alloc_coherent directly.
In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
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

