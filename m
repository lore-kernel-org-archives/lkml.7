Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534D3C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B00721479
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1u8NEHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfIKREb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 13:04:31 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41146 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbfIKREb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 13:04:31 -0400
Received: by mail-qk1-f193.google.com with SMTP id p10so3516996qkg.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 10:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WOq5+7XVoPxuMvtL+l86brUuffl5eEcrVPzxLYxuj10=;
        b=h1u8NEHmO9x8w9CMEXV1ytXnb22fSDNFPlOisyUFURX+akP1Q7bElm0ZnyKj6sIHjz
         VWeL6pZnjessX1+HQU32egYArrREXvHLKfD2P5y4YP+ZgL35LoS91ZS+1uTnB98TRXYp
         fDtHWI+NCt9z+42BbM3n1vzvfINWhXruSkrc/3pZAuuTwyZVgk9CE7GPQJlJGhmnLewV
         tAr5lTtqsXNl2FFBKULTzeCwW7LJKanqunMB6lEPvoghzeanD1yy3T7ugzMbtfvRDk4X
         MhPoBY6YGJODVbDjtv2FJL1YOohHCAXTJGt8MpOLiqzwUT27nupvBST01M7s0Cq85WYk
         30Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WOq5+7XVoPxuMvtL+l86brUuffl5eEcrVPzxLYxuj10=;
        b=Tvd6iSzU4imaHFjDMQCOdZegKCZjTolmRgPxCpobURrPAorCcG0trNdY4/2hVOFh5I
         wEwRz5KQpELU1WgR0DotvZVghafV2nhqocYB+qPGWhGqDevD+URDke27redKtYvwCQK3
         HBWlyS5HpmwyPQpcuS5BhQ0Umqw9ximzYgIpAIPkR15un11ibL37Lqn8WXz0/KLdr2IX
         0t2IKo33rbwlDd3u/kaku7QYP+f0i+QFGqhLrCLeVZ+8I7jzEcMepzVyK2X7dVVUWadC
         ujFcaUDmd9nngJ/8f9Ln+5MDQkUpsCv3mgY5KAZ6/b87raJI8eLp33Eek6VdPrL7pxwF
         7r7Q==
X-Gm-Message-State: APjAAAUN2ad6dWp84d5GShSS5XOzloRagIRtb6PIIxE9kH+tJOl0jn//
        CTcM64PMjv+kOmJWYPHY07mAW4YJeiWbh4lHJ4s=
X-Google-Smtp-Source: APXvYqy3nXBslicHvc23I6vrB+VSCoRDgrIQKxPMpjScXgyiZarIWO/6ZinNfy+IPnDiAErY37f1cCydtDKcsTdSM5g=
X-Received: by 2002:a37:92c6:: with SMTP id u189mr34619324qkd.69.1568221469858;
 Wed, 11 Sep 2019 10:04:29 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Wed, 11 Sep 2019 13:04:19 -0400
Message-ID: <CAD56B7euf1kQpwOYiq-he8HveKKzkGdf8_-izEVfwa=QH24a3g@mail.gmail.com>
Subject: Regression: commit c9712e333809 breaks xilinx_uartps
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

As I was working with a recent 5.2 kernel with a Zynq Ultrascale+
board I found that the serial console wasn't working with a message
like:
 xuartps: probe of ff000000.serial failed with error -16

I did a git bisect and found that this came from:
 commit: c9712e3338098359a82c3f5d198c92688fa6cd26
 serial: uartps: Use the same dynamic major number for all ports

One difference I might have is in the device-tree, I'm using a proper
clock config (zynqmp-clk-ccf.dtsi) using the firmware clock interface.
This is absolutely necessary, for instance, with the Ethernet
negotiation where the macb driver needs to change the clock rate. In
any case I believe this pushes my case to the -EPROBE_DEFER when
devm_clk_get() fails the first time, this might not have been tested
in with the original submission. I'm not sure this makes everything
completely correct, but the patch below does fix the issue for me.

thanks,
Paul

---
 drivers/tty/serial/xilinx_uartps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c
b/drivers/tty/serial/xilinx_uartps.c
index 9dcc4d855ddd..ece7f6caa994 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1565,6 +1565,8 @@ static int cdns_uart_probe(struct platform_device *pdev)

        cdns_uart_data->pclk = devm_clk_get(&pdev->dev, "pclk");
        if (PTR_ERR(cdns_uart_data->pclk) == -EPROBE_DEFER) {
+               /* If we end up defering then set uartps_major back to 0 */
+               uartps_major = 0;
                rc = PTR_ERR(cdns_uart_data->pclk);
                goto err_out_unregister_driver;
        }
-- 
2.17.1
