Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2276FC73C63
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 23:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF39E20693
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 23:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b="GsBDdcNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfGIXlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 19:41:04 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:36485 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfGIXlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 19:41:04 -0400
Received: by mail-qt1-f171.google.com with SMTP id z4so512262qtc.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 16:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=E1NUveCyEvwE6X2Y9u/qmaL5MyrTcuFS6X+2DDDjXqE=;
        b=GsBDdcNheY/SRfTwmU78m+HpC/CMxNc12rWmPnkmr8gOshOYFihE9GVhAZJ3bRiFvf
         d0jpdzsPYHQI3+n77xke0MdDXhUYZB9LhO0qlWSOriKwbetFRNqaF89KZlJxxND+icud
         R3ji6r6Fl9BpJLC87/5YsxT+FF2j5eBUuAShQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=E1NUveCyEvwE6X2Y9u/qmaL5MyrTcuFS6X+2DDDjXqE=;
        b=CnmTT6RQJURThkSjayzGAE1cpGsKTn/MVQ8GVnexlHHURe1q9/0GyY2544mmMOzhxg
         YkrqQiOwKtukZPrJkWINW7UwmhbznWD2f2pR0EMo9nSJxBpvA3EsSegv1IbSOO/9wc54
         D8ZlEyR7ybLAjElf/vNNBo57WWkHKMWpZkKcA3aHFv24ii59kafHSpZrqbd5Vm6UIc1O
         GEImCcCc6Zs0GqSjV7lBcywEpOlBtxMXQ5lZGZl/Fx7SV5pmq31I4nymImw2KZw/wVHg
         6vMdKD3KPhsKl3qocBLBo9nSb2PKdhKTpsIoB7c8wcqNpnG+CD5e+HILIQ5BJjoB5IGm
         EVxw==
X-Gm-Message-State: APjAAAWY9QOWhulT0uSmctYpjGTm5jON7gkGD3QPk+oDkXLaFi5avxHE
        7JfvoSplGBuL22Yo3xEVWkJbKuxulwewFg==
X-Google-Smtp-Source: APXvYqwkyhtpFKS3FLWcwG7MRgW2zdPWr++zAZDxmYx+1ndynWHX5PjMxrZjV7u5MVZGT7oSvVQ+9A==
X-Received: by 2002:ac8:48cd:: with SMTP id l13mr21083219qtr.250.1562715662393;
        Tue, 09 Jul 2019 16:41:02 -0700 (PDT)
Received: from WARPC (pool-173-72-201-135.clppva.fios.verizon.net. [173.72.201.135])
        by smtp.gmail.com with ESMTPSA id y194sm261639qkb.111.2019.07.09.16.41.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 16:41:01 -0700 (PDT)
From:   "Justin Piszcz" <jpiszcz@lucidpixels.com>
To:     <linux-kernel@vger.kernel.org>
Subject: kernel 5.2: crash with zswap+zram (x86_64)
Date:   Tue, 9 Jul 2019 19:41:00 -0400
Message-ID: <020901d536af$c39e0ef0$4ada2cd0$@lucidpixels.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdU2rkxqpxwPH8PwRBi/8Mo/kI+Wrg==
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Going to be turning these options off for now (zswap+zram) under 5.2 and
hopefully this makes the machine stable again-but just wanted to point out
under 5.1.xx never had any issues but with 5.2 the kernel crashes fairly
quickly when performing heavy I/O with these options enabled: (note:
compressed ram is still marked as experimental in the kernel as of 5.2)

Append line used:
append="3w-sas.use_msi=1 nohugeiomap page_poison=1 pcie_aspm=off pti=on
rootfstype=ext4 slub_debug=P zram.enabled=1 zram.num_devices=12
zswap.enabled=1 zswap.compressor=lz4 zswap.zpool=z3fold"

$ diff -u .config .config-5.2.0-2
--- .config     2019-07-09 19:23:57.355550063 -0400
+++ .config-5.2.0-2     2019-07-09 12:44:31.803653032 -0400
@@ -790,10 +790,13 @@
 CONFIG_CLEANCACHE=y
 CONFIG_FRONTSWAP=y
 # CONFIG_CMA is not set

-# CONFIG_ZSWAP is not set
-# CONFIG_ZPOOL is not set
-# CONFIG_ZBUD is not set
-# CONFIG_ZSMALLOC is not set
+CONFIG_ZSWAP=y
+CONFIG_ZPOOL=y
+CONFIG_ZBUD=y
+CONFIG_Z3FOLD=y
+CONFIG_ZSMALLOC=y
+CONFIG_PGTABLE_MAPPING=y
+CONFIG_ZSMALLOC_STAT=y
 CONFIG_GENERIC_EARLY_IOREMAP=y
 # CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
 # CONFIG_IDLE_PAGE_TRACKING is not set
@@ -1309,6 +1312,9 @@
 # CONFIG_BLK_DEV_FD is not set
 CONFIG_CDROM=y
 # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
+CONFIG_ZRAM=y
+CONFIG_ZRAM_WRITEBACK=y
+CONFIG_ZRAM_MEMORY_TRACKING=y
 # CONFIG_BLK_DEV_UMEM is not set
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_LOOP_MIN_COUNT=8

As it kills the machine, I could only take screenshots of the crashes:
http://installkernel.tripod.com/IMG_2068.jpg
http://installkernel.tripod.com/IMG_2069.jpg
http://installkernel.tripod.com/IMG_2070.jpg
http://installkernel.tripod.com/IMG_2071.jpg

Regards,

Justin.

