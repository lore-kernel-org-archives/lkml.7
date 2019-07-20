Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78C3C76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 03:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936922082F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 03:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WXN6CNeA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfGTDln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 23:41:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34606 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfGTDln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 23:41:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so9043090pgc.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 20:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=rt8ZjqZYhwETF4H/AUDaR/BRfMKu6KoKEf3DEfigTjw=;
        b=WXN6CNeAumV5siU+FiCqKs9RTZyz/iq0ZqZbhfYdPTremzbXLguWeMwNJJ2dQrFC35
         Hd07gODeRW9XY/pzRaxSj+TaKHdGoLE2hn+/vlZ6rJ2okpp9qjDCdMX416bOE+/S8fhn
         4cC9GkkJgBAbdPxxyxhiJ6h1WwewJs5Rn12D8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=rt8ZjqZYhwETF4H/AUDaR/BRfMKu6KoKEf3DEfigTjw=;
        b=mJhWiGz2h9PYcP97wL8vJukJMqbskwVTVQalzQPvO0RVo7xhz9GFVBWoTr56KLUbwM
         ooPeR3JpkIpsM5feSC3VQ88+63QO8F2I+0yWTpmJ1CnVGjXeaL/QXhnTSeLOWiHmAl1I
         a9PSAjG57nnJ3t9SUty8wAaJYeq74NVm75kYUbpjUDL2sjD3GXklyBnD2qrg1pNus6IB
         KhsDnVeNF2svemrAlcDjRbsic6/UZ9e5ZQljYZ7vJ5Tg1LtyKcK+bhO/4cBNuD+eYdac
         iXtCd4AgeFK+nZgvYR+VVia3aDhDErfD+1Pxvd58ZLsbJKLMoChJPcLa44Rql9i3NUMZ
         xSSg==
X-Gm-Message-State: APjAAAWH/nJMuAjwS1jx8x7yTwUYvnSd1bdf8tIGPRhzyNe/32GERXmy
        jHinzWJNzgV7JKJwDvLZaYtkQg==
X-Google-Smtp-Source: APXvYqyzeNksJYd4KoZvasturz4jFM5RNvls/ibesYWVHziTJKh1bq/WGSkBQ810dE4HWKKd8SPFcQ==
X-Received: by 2002:a17:90b:d8b:: with SMTP id bg11mr61859798pjb.30.1563594102329;
        Fri, 19 Jul 2019 20:41:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s66sm33681296pfs.8.2019.07.19.20.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jul 2019 20:41:41 -0700 (PDT)
Date:   Fri, 19 Jul 2019 20:41:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        tobin@kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
Subject: [PATCH] libata: zpodd: Fix small read overflow in
 zpodd_get_mech_type()
Message-ID: <201907192038.AEF9B52@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Much like commit 18c9a99bce2a ("libata: zpodd: small read overflow in
eject_tray()"), this fixes a cdb[] buffer length, this time in
zpodd_get_mech_type():

We read from the cdb[] buffer in ata_exec_internal_sg(). It has to be
ATAPI_CDB_LEN (16) bytes long, but this buffer is only 12 bytes.

The KASAN report was:

BUG: KASAN: global-out-of-bounds in ata_exec_internal_sg+0x50f/0xc70
Read of size 16 at addr ffffffff91f41f80 by task scsi_eh_1/149
...
The buggy address belongs to the variable:
 cdb.48319+0x0/0x40

Reported-by: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Fixes: afe759511808c ("libata: identify and init ZPODD devices")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/ata/libata-zpodd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
index 173e6f2dd9af..eefda51f97d3 100644
--- a/drivers/ata/libata-zpodd.c
+++ b/drivers/ata/libata-zpodd.c
@@ -56,7 +56,7 @@ static enum odd_mech_type zpodd_get_mech_type(struct ata_device *dev)
 	unsigned int ret;
 	struct rm_feature_desc *desc;
 	struct ata_taskfile tf;
-	static const char cdb[] = {  GPCMD_GET_CONFIGURATION,
+	static const char cdb[ATAPI_CDB_LEN] = {  GPCMD_GET_CONFIGURATION,
 			2,      /* only 1 feature descriptor requested */
 			0, 3,   /* 3, removable medium feature */
 			0, 0, 0,/* reserved */
-- 
2.17.1


-- 
Kees Cook
