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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C494DC48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F07205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NM7Tf3kx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfF0Rlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:41:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34959 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfF0Rln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:41:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so1591846pfd.2;
        Thu, 27 Jun 2019 10:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5CHqL3EBEcLGFr61w8Fbiglt4+Qtw+juW+E0F79bUSs=;
        b=NM7Tf3kxJBT2upUU+pbABqaJLAjxI6Ms9o0eJv2QrYuvklzHK11o6kGy7Q8McL1vPq
         MgYWuWCBZqZNoAnexFzEFBBdgbibCPCGf6+Lgy86Y68MK/6R5s9ZK7mc8XplYTbK2Oji
         Hb0tMLHj9fwHiddVNbUaJZ1trObejkwRJi1L/IPyWUB+6lwIUoOzAXZwU67PtgsrxeXh
         xSkB/ra4fQX7u8pW22kcqNB/NRbN3awoAmuG1h/z6Fc3JpF77hbRBVZZmeRPjdmgAO/S
         lySUUWBD5b8nJHHTVmnDRIx1wYoatsNI5MtLg5ikI5GXBuafKODtPDu5Z/Ts5B0iLlyn
         9pQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5CHqL3EBEcLGFr61w8Fbiglt4+Qtw+juW+E0F79bUSs=;
        b=k/Khw6lEou8vaZ9WgRAujpGsrun4qlNhYkk9U+OQSZz77q0Ky/68Q5ucVQtlhwSv/6
         k/yvz80rc7/xpB9VIxQWcpRDV/fv5vU2gDM97BMYp0KTy9kE+cSJ57SUVbVREjbWP6e9
         +cjnOen08tj8HRlDy5fU1Cjun9Y8voCvWZNb9tbvx+tH07DotWnfM7k6n0J2GJA0N/UO
         lgzoYIORmnq7hkehW7g0byj1zZqMqNH13XR5/tFPForqtjtM152n/ba6IvBmalPU4Uum
         W0a50bD1T1Kz9czi8myqcSkAJmgFoI72csIXuWuNKsQmDd7uF7FgseclMdctp8/qar/q
         Z15Q==
X-Gm-Message-State: APjAAAXDRXV3mhB5pZ+7MaSuVFxbt9R9ATecvYXCkVbQ+0S3klaP+j8C
        XrjIBO+mO+ZdF4OYjN+Q+Io=
X-Google-Smtp-Source: APXvYqygHbISHDdrpLXVbPOdsy6jcU8n8uSLL//hpP7O9so9tZGLN1fZ3SYPqRuoFVHEXuoxUnueYw==
X-Received: by 2002:a17:90a:2506:: with SMTP id j6mr7654829pje.129.1561657302927;
        Thu, 27 Jun 2019 10:41:42 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id e26sm3392164pfn.94.2019.06.27.10.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:41:42 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 47/87] tty: serial: remove memset after pci_alloc_consistent in icom.c
Date:   Fri, 28 Jun 2019 01:41:35 +0800
Message-Id: <20190627174136.4451-1-huangfq.daxian@gmail.com>
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

