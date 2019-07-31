Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8472C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D29218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfGaHPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 03:15:12 -0400
Received: from olimex.com ([184.105.72.32]:56701 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfGaHPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 03:15:12 -0400
Received: from localhost.localdomain ([94.155.250.134])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 00:15:08 -0700
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Cc:     linux-sunxi@googlegroups.com, Stefan Mavrodiev <stefan@olimex.com>
Subject: [PATCH 0/1] nvmem: sunxi_sid: fix A64 SID controller support
Date:   Wed, 31 Jul 2019 10:14:46 +0300
Message-Id: <20190731071447.9019-1-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A64 SID controller has some issues when readind data, To exampine the
problem I've done the following steps.


When reading the whole nvmem memory in one chunk the returned bytes
are valid:

dd if=/sys/bus/nvmem/devices/sunxi-sid0/nvmem 2>/dev/null | hexdump -C
00000000  ba 00 c0 92 20 46 10 84  00 45 34 50 0e 04 26 48  |.... F...E4P..&H|
00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000030  00 00 00 00 87 07 8d 07  8e 07 00 00 00 00 00 00  |................|
00000040  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000100


When bs is set to 4 bytes the data is no longer valid:

dd if=/sys/bus/nvmem/devices/sunxi-sid0/nvmem bs=4 2>/dev/null | hexdump -C
00000000  ba 00 c0 92 20 46 10 84  00 45 34 50 0e 04 26 48  |.... F...E4P..&H|
00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000030  00 00 00 00 87 00 00 00  8e 00 00 00 00 00 00 00  |................|
00000040  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000100


You can see that only the data at 0x34 and 0x38 is corrupted. It appears
that A64 needs minimun 8 bytes block size;

dd if=/sys/bus/nvmem/devices/sunxi-sid0/nvmem bs=8 2>/dev/null | hexdump -C
00000000  ba 00 c0 92 20 46 10 84  00 45 34 50 0e 04 26 48  |.... F...E4P..&H|
00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000030  00 00 00 00 87 07 8d 07  8e 07 00 00 00 00 00 00  |................|
00000040  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000100


In the driver stride is set to 4 and word_size to 1. When you're using
nvmem as thermal calibration data in the dts you write something like this:

sid: eeprom@1c14000 {
	compatible = "allwinner,sun50i-a64-sid";
	.....

	thermal_calibration: calib@34 {
		reg = <0x34 0x08>;
	};
};

This will return incorrect data.
One way to fix this is to set stride/word_size to 8, but this will be
inconvenient for the dts.
Other is to enable reading data via register access. After the fix:

dd if=/sys/bus/nvmem/devices/sunxi-sid0/nvmem bs=4 2>/dev/null | hexdump -C
00000000  ba 00 c0 92 20 46 10 84  00 45 34 50 0e 04 26 48  |.... F...E4P..&H|
00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000030  00 00 00 00 87 07 8d 07  8e 07 00 00 00 00 00 00  |................|
00000040  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000100


Stefan Mavrodiev (1):
  nvmem: sunxi_sid: fix A64 SID controller support

 drivers/nvmem/sunxi_sid.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.17.1

