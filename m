Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A37FC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E1521721
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfGCDFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 23:05:11 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:33536 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfGCDFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 23:05:10 -0400
Received: from twhfmlp1.macronix.com (twhfm1p1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id x6333J7g046150;
        Wed, 3 Jul 2019 11:03:19 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id 1CBFD7CFFB98E88ECBE7;
        Wed,  3 Jul 2019 11:03:19 +0800 (CST)
In-Reply-To: <20190627193635.29abff43@xps13>
References: <1561443056-13766-1-git-send-email-masonccyang@mxic.com.tw> <1561443056-13766-2-git-send-email-masonccyang@mxic.com.tw> <20190627193635.29abff43@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     anders.roxell@linaro.org, bbrezillon@kernel.org,
        broonie@kernel.org, christophe.kerello@st.com,
        computersforpeace@gmail.com, devicetree@vger.kernel.org,
        dwmw2@infradead.org, jianxin.pan@amlogic.com, juliensu@mxic.com.tw,
        lee.jones@linaro.org, liang.yang@amlogic.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, paul@crapouillou.net, paul.burton@mips.com,
        richard@nod.at, stefan@agner.ch, vigneshr@ti.com
Subject: Re: [PATCH v4 1/2] mtd: rawnand: Add Macronix Raw NAND controller
MIME-Version: 1.0
X-KeepSent: 041E283A:13DCC1D9-4825842C:000C9C7C;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF041E283A.13DCC1D9-ON4825842C.000C9C7C-4825842C.0010C960@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Wed, 3 Jul 2019 11:03:21 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/07/03 AM 11:03:19,
        Serialize complete at 2019/07/03 AM 11:03:19
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com x6333J7g046150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquel,

> > Add a driver for Macronix raw NAND controller.
> 
> Could you pass userspace major MTD tests and can you attach/mount/edit
> a UBI/UBIFS storage?

The other userspace MTD tests are passed.

nandwrite, nanddump and nandtest.
i.e.,
zynq> ./nandtest -k /dev/mtd1
ECC corrections: 0
ECC failures   : 0
Bad blocks     : 0
BBT blocks     : 0
00100000: writing...random: crng init done
005c0000: checking...
Finished pass 1 successfully
zynq>


UBI/UBI-FS test is also passed.
i.e.,
UBI/UBIFS storage test on mtd2 as example
1. ubiformat /dev/mtd2
2. ubiattach /dev/ubi_ctrl -m 2
3. ubimkvol /dev/ubi0 -N ubifs -m
4. mknod -m 777 /dev/ubi0 c 244 0
5. mount -t ubifs ubi0_0 /mnt/ubifs
6. copy a file to /mnt/ubifs
7. sync and power off - on cycle
8. ubiattach & mount /mnt/ubifs
9. read file and compare it with md5sum

thanks & best regards,
Mason

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information 
and/or personal data, which is protected by applicable laws. Please be 
reminded that duplication, disclosure, distribution, or use of this e-mail 
(and/or its attachments) or any part thereof is prohibited. If you receive 
this e-mail in error, please notify us immediately and delete this mail as 
well as its attachment(s) from your system. In addition, please be 
informed that collection, processing, and/or use of personal data is 
prohibited unless expressly permitted by personal data protection laws. 
Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================



============================================================================

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information and/or personal data, which is protected by applicable laws. Please be reminded that duplication, disclosure, distribution, or use of this e-mail (and/or its attachments) or any part thereof is prohibited. If you receive this e-mail in error, please notify us immediately and delete this mail as well as its attachment(s) from your system. In addition, please be informed that collection, processing, and/or use of personal data is prohibited unless expressly permitted by personal data protection laws. Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================

