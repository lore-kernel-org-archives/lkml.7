Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB112C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 03:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D5720644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 03:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrK9lUHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbfGODUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 23:20:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36192 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfGODUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 23:20:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id l21so7005477pgm.3;
        Sun, 14 Jul 2019 20:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=x9cx5daqiIQ1tM3rWp5IoFUTEpi0lqApKNh4MFAdUvE=;
        b=YrK9lUHAxSclec2PcYrOeb8GCIzvTz83nYqWGUZVOEURLw26zIPDvWcqMaeCNLIcNX
         ERI9NjxPCZqB1wDWWOY2dImu60zpk3CSXHLwccOoGN+45M5uI321JfDrG1llWg6K3FtF
         HLsv/+vg8ECHgCLk8uxkYuMv4mm5c8LBz8W1nxTzkJ0M/orfsEXOd/EXIYEVLjhDKdC6
         0Wx4CjW2UzUSlBSxeJI0hTP1zZCc9ABYSTzfZ6FoyQrnuZIlroaIEPvCUZjZkAGfCMym
         ZA5rSHiausMHGmfdYkpnDHxUMCD7uVcC4LPGCQljs/+xDwD/65bou0ptIIj5wW1THX78
         9eEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x9cx5daqiIQ1tM3rWp5IoFUTEpi0lqApKNh4MFAdUvE=;
        b=cCDJ0uQnE1Nswlob6w9XNXsALEFdl4g3fCKOv7y/Jbjf66henym+9HQvRNSpkgxh1d
         16Jt7a7QgZOFbiB/ZAa+8rkVNwtwBe9EfYYCgIge9xtOn+tf3tevKyup441xA2fBKzCN
         9lGzzNxS1KFKDN58qB3sKij9HvWNOn1T/Z+YbL8S1gctwShy377JqgcYNTWKl3zrjAkb
         9IIwpO/UzqxfWzg1/m9qfZObAXd3RRcijoTUALD+6iJXaMC70hCcXRGDYTrw3erMwpIE
         TBOVqud2k7EgD8/fQCg+SlHOxGb10hlMCmyoFmvZadib2aX10rzdjPrpakQ0Oga4ppyw
         XKPg==
X-Gm-Message-State: APjAAAWYgdNYUFVfeixsoIl9mZMPF9RWBYJSugieAyPAUrpRf7M40An/
        roG5dXVjhOQP3nIfXPegTRM=
X-Google-Smtp-Source: APXvYqz6WrWgHnKpYLCmjEBLzkrrWzLjGpYPQh8xh1axD3NA0KGrnPQwifOd3DkIlcnPSToCzvo/bw==
X-Received: by 2002:a65:56c1:: with SMTP id w1mr24171680pgs.395.1563160807339;
        Sun, 14 Jul 2019 20:20:07 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id j13sm14841634pgh.44.2019.07.14.20.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 20:20:06 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 22/24] tty: serial: Remove call to memset after pci_alloc_consistent
Date:   Mon, 15 Jul 2019 11:20:01 +0800
Message-Id: <20190715032001.7212-1-huangfq.daxian@gmail.com>
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

