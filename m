Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804C8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5267A2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzHJfH+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfDAEtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:49:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41068 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfDAEtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 00:49:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id 188so3905651pfd.8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 21:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PFXB52oKOKtWpAtHBWrZrl223idOSLqoOifI3aKzID0=;
        b=qzHJfH+gXoL+e3XbbyUDNtYpk4IUcqV6A7nMsP1VO9cEbancdc9BfuNgW0k7iGoUA8
         fwQV4lrerur+amO7XbG/y7pG8+afQnY3we2UlsYVfhvfPNFQUdalU1bDj7B5dcMOP1UV
         mVIsQV7kCWqzBG9i1IpzA3VkK4CiGeQiWb+xHuPDxJFR+qDQowEWWPEfO7nJ6nrwnMIi
         TeY6o96IkcOIs8ScaKXXuyRrdcqw0tMKH+52bRvfwg4cq7ScqE2gH97+/yeyqBd2Cmfv
         nCq/IFkgdChjfDZKVUypMdlRmyvxn5kRFO4Y66YuCpXNp/rA46UCbdwHBugqBivASu9W
         YJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PFXB52oKOKtWpAtHBWrZrl223idOSLqoOifI3aKzID0=;
        b=A9twNQRHt8TWhbzpoavpOWGhONb66zTRG+BZRGWYTzyq2FBQ2+KtWiRYoHwKJSYTrA
         KU+dt2mPuHGdk7XmIbEAtr4fvcmu3Eh1f29saojeHvDO24seIbcLjseDHxuZz8WO9qIT
         4ba7WRwFeKbL1fsw/ZuWaHeYlAT5JvWj6glqRz64b3XajjI+EOAOyGZ9MuekFwbQii3a
         nYsjyyygIcQubDJ7bEVHsE9YLsjQmN5yIndHUVlJdmCZrraqQV60VEXGnDchz4gAN8zu
         D1Idm1IDrAX4KtpDbJCWgbp4oac3+GUe+S8lk+MgEAYG41SBY5mwwb0npGHoEyQSHLOe
         cfvA==
X-Gm-Message-State: APjAAAUQb8UMpzv/djSJQYKuNzOUx0xXjfZ8xck9m6vdCXLA0+utuiTn
        MDR3iPzdwf6ooZXQIeXCnGc=
X-Google-Smtp-Source: APXvYqxA6JlUi0W041FN16C641ZvmSjGPW8+EAd+/bdmJ+gnOhuKIAxGTRBVkdIehKj9nBq90d2Ulg==
X-Received: by 2002:a63:550d:: with SMTP id j13mr13455225pgb.18.1554094190765;
        Sun, 31 Mar 2019 21:49:50 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i31sm16256097pgi.36.2019.03.31.21.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:49:49 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mtd: devices: m25p80: Drop extra length clamping in m25p80_write()
Date:   Sun, 31 Mar 2019 21:49:37 -0700
Message-Id: <20190401044938.31237-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401044938.31237-1-andrew.smirnov@gmail.com>
References: <20190401044938.31237-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the needed length clamping should already be taken care of by
spi_mem_adjust_op_size(). No check like this is done in read path, so
this extra check in write doesn't appear to be necessary. Drop it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/mtd/devices/m25p80.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 114f8ccea85b..a54cad9bb6e3 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -103,7 +103,6 @@ static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
 	ret = spi_mem_adjust_op_size(flash->spimem, &op);
 	if (ret)
 		return ret;
-	op.data.nbytes = len < op.data.nbytes ? len : op.data.nbytes;
 
 	ret = spi_mem_exec_op(flash->spimem, &op);
 	if (ret)
-- 
2.20.1

