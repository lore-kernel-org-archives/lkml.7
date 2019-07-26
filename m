Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BCDC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD20218B8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7C28+Ok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfGZSXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:23:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51741 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfGZSXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:23:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so48766838wma.1;
        Fri, 26 Jul 2019 11:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GQuDpBmkjnxayekWigvyZunlIAi2qc1Enc5yFxgmoPc=;
        b=a7C28+Ok3bPbCfOEHMWu+fKm50hAEQWFJvMcAgw1VCIsELdLfkhJdWTy+BfrjNW+Bk
         Z5tHHSXGSEBK9W3yqNey6p2etKvSEXz42hGivuSle5nbGQedFbTh32kwdwfzom45Pbcv
         4e5qvFljA4iqqbhdxZgNPzu9wMTpxwRwSrT6TuUYu4UmQ8T/3clQJDFZt8jTcO5CSQvq
         6rsHcmKBjutX0XX9LQecAWZwczjASOhHNX/hq67eYtSFlqD0QIRkdgg4fh0JmIPAfYrQ
         f5qEr10VUcKTUgJGBCJk5ntNBkxTeYywS4Jw0B9Pg73d5HNApl2uBeotyV2DTSdYgbL6
         JrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GQuDpBmkjnxayekWigvyZunlIAi2qc1Enc5yFxgmoPc=;
        b=q3H+9XbD1fFiCVvEpzDxR7E0CztbFoRB8qeOcOR1oKTVAeOPQSa0mNNF6JTaejHnyk
         xSLk/6WsOeEKrKyg8r0zppCQr2yrrGoHW8Xp0XnDGK5KtAMHgu/B1ZaSXL62MkOEsXJ0
         MUzDJUVEeZYTvqBJj79fdt2u9WRKS2Lf5l6HhKo9zYIfS6TAkvbV4JsetmPQhYMEvhU6
         T8VNZJkuDIjbRglK9lK0WaEEajVqSdXaR0bnxmmMUNEMmzPZF7+3Udz+j4KBFnfIXBYz
         QCqKl3eOBQGBeYdEdakWiQ0GrSiQo6XnL1fyMpD8LXadCnA6c6BD04l0Cyfsohl2mQ90
         rxQw==
X-Gm-Message-State: APjAAAVTdgBjLgRGUr2/hVor518RBhAvGjTQQGZObKFE+6IF9gWMs2OW
        fSfpVQy6I7HsYFIbJmU3DfGPXPXtzWc4NdGzX3kdi+vd
X-Google-Smtp-Source: APXvYqwgWTa964KKQ02ChzqJH0P+jGNgtjGggAAURVzwwIYPja904COgVB/hjKv4r8wLYOe34bEgKPOeXREfoewGd40=
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr81914381wmk.99.1564165420572;
 Fri, 26 Jul 2019 11:23:40 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Fri, 26 Jul 2019 14:23:28 -0400
Message-ID: <CAD56B7cF3QXQbMmZVehtBEm2Bhfda4GpsHFZyDJE8D82xkgyEA@mail.gmail.com>
Subject: mmc: sdhci-of-arasan small issue with clock with 5.2 kernel
To:     Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm using the arm64 Zynq Ultrascale+ parts, and I'm running into what
I think is a small issue in sdhci-of-arasan with the handling of the
'clk_xin' which becomes pltfm_host->clk.

If I just use the mainline zynqmp-clk.dtsi file then 'clk_xin' get's
blindly defined as a "fixed-clock" at 200 Mhz and everything seems to
work fine.

However, in this design the clock is actually 50 Mhz [1]. For other
reasons [2] I switched the device-tree clock definitions to actually
use the zynqmp firmware interface for getting the clocks [3] when I do
this the clock is then correctly detected as 50 MHz:
# cat /sys/kernel/debug/clk/clk_summary
...
sdio0_ref       1        1        1    50000000          0     0  50000
...

And this is the frequency that is given to the controller (I put
printk's in to verify that 200 and 50 were the respective values for
mhz):
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/mmc/host/sdhci-of-arasan.c?h=v5.2.3#n594

At this point the functionality becomes partially broken. Detecting
the chip and some reads seem to work, but then when I go to fdisk
write there are errors such as:
[   56.481985] 002: print_req_error: I/O error, dev mmcblk0, sector 0 flags 1
[   56.481999] 002: Buffer I/O error on dev mmcblk0, logical block 0,
lost async page write

It seems to me that giving the real 'clk_xin' frequency to the
controller should not break anything? For now I'm fine with just using
the incorrect 200 MHz fixed-clock, but I thought someone might be
interested in this.

This controller is connected to an eMMC part.

I did try reducing spi-max-frequency from 10M down to 1M, but that
does not seem to make a difference.

thanks,
Paul

[1] As defined in Vivado in the MPSoC block in Output Clocks -> Low
Power Domain Clocks -> Peripherals/IO Clocks -> SDIO0
[2] To enable the macb driver to properly set the frequency of the GEM
clock so that 100 Mb/s works
[3] The device-tree like this:
https://github.com/Xilinx/linux-xlnx/blob/master/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
and adding "xlnx,zynqmp-clk" clock-controller
