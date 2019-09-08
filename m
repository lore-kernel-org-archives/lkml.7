Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951CBC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62478206BB
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GynCgb4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfIHK6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 06:58:18 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:43303 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfIHK6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 06:58:17 -0400
Received: by mail-ed1-f46.google.com with SMTP id c19so10423091edy.10;
        Sun, 08 Sep 2019 03:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lnxSRRi7ihBfaL8hYYdSikodKNd1ngPSvDfR2tbzNbw=;
        b=GynCgb4CidXL14RYKSChHe0YOMgrjWOSeVelayQIe6u9D5yl9LGsQ2HjEUc1P61F9E
         E/Y4/Cb0pyfEDTqAVIWizaFHUtaJm22jaTK3j21Y2P6c+35hLoGFjEebVoPGqHW6fJ+M
         Ygb1lKQwqC4/UoPgmjaVYyjAXSjEIl3h5gkyxo9Q0ZdzBr8f32wMntc83C/eGXpkLy7M
         xxiy93VXUjn4wiv3MAL36GaGQJT9iixLyBXHx8Hj8ZvqryVGJ6+n3rBLqUzpMhef/YDR
         ijqTLBOVmZJ+FaA9qWfAeVBzd6WVuzkhooBbmCxXBJ/Wbzym5KYubMwPsScbvWtPGdiF
         jCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lnxSRRi7ihBfaL8hYYdSikodKNd1ngPSvDfR2tbzNbw=;
        b=lk8aqUApBYKQj0R+z3l0pqI/mi6GjL5hVP3I9yEDR+t6TxCTF/UX4RLAD6w9u4Of7T
         gsQVrszhT2g5OfxG0nWyUBqgAuJb1K4p61zQ2HpIQedbQ9rEEyesdmg0JZ/KGxgJjy/y
         /q+OkLye6GDL2T+p6VaXYwV7YeYwbeDmz7SUBZ35YmOOms4yFm8jYQ86CaW00jWrczBh
         7fweBdh6c2gUx47ZLwedq/nglSEnoW/s6r5NN/yWQ3O2VSbV3wyIje5y0xHIyHdcIon3
         LDCJd1j/HeK4HLSdHgY5CnLy1BipO7VRYkao41PrL9Tkh6CKLeqMCYyQ9vhtUHy7FB8t
         OFUw==
X-Gm-Message-State: APjAAAVmmRo00DamBBfaRG9TQMUCZWF6nJ6E+LyfFbhTKrAJ2LuW9Uos
        bpgQPyWLGwLf3l+2cUqBUk0Cs59ytKgicz5pdbC0zhkF
X-Google-Smtp-Source: APXvYqzDQdpgAr7aUjs4Th1K+AlF1rZ/Pj++/IoGxk0U5Zi0Uc75LDHXn6VJB0/75JVYVvIiwxprGfBQRL3xNcTL1dA=
X-Received: by 2002:a17:906:c304:: with SMTP id s4mr14906836ejz.71.1567940295596;
 Sun, 08 Sep 2019 03:58:15 -0700 (PDT)
MIME-Version: 1.0
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Sun, 8 Sep 2019 13:58:08 +0300
Message-ID: <CADxRZqxmvfE9gYoT+1oLV6-o_BbUsay_U45qmMEYL3vErTCCLA@mail.gmail.com>
Subject: [sparc64] Kernel unaligned access at TPC lzo1x_1_do_compress
To:     Sparc kernel list <sparclinux@vger.kernel.org>
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

trying to use zram block device, shows the following:

# zramctl -f -s 16g
# cat /sys/block/zram0/comp_algorithm
lzo [lzo-rle] lz4 lz4hc 842 zstd
# zramctl
NAME       ALGORITHM DISKSIZE  DATA COMPR TOTAL STREAMS MOUNTPOINT
/dev/zram0 lzo-rle        16G 10.4M    4K  112K      32

# mkfs.xfs /dev/zram0
...

[   71.095998] zram: Added device: zram0
[   71.765591] zram0: detected capacity change from 0 to 17179869184
[   80.058772] Kernel unaligned access at TPC[8f2534]
lzo1x_1_do_compress+0x1b4/0x820
[   80.073832] Kernel unaligned access at TPC[8f2534]
lzo1x_1_do_compress+0x1b4/0x820
[   80.073866] Kernel unaligned access at TPC[8f2534]
lzo1x_1_do_compress+0x1b4/0x820
[   80.074709] Kernel unaligned access at TPC[8f2534]
lzo1x_1_do_compress+0x1b4/0x820
[   80.074923] Kernel unaligned access at TPC[8f2534]
lzo1x_1_do_compress+0x1b4/0x820


all other tested compression algorithms (lzo, lz4, lz4hc, deflate,
842) work without producing kernel TPC.
