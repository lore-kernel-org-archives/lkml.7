Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44AAC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F132133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="HN68Q3EV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbfEWMvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:51:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36452 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730492AbfEWMvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:51:49 -0400
Received: by mail-lj1-f195.google.com with SMTP id z1so5357422ljb.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 05:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WaaInSZ/8FR2reHnDUn1kcD6WX/fXP/+clwh+fO1tAQ=;
        b=HN68Q3EVQZhJbkZThtdPhltW9YfxgYN5sV+4a7aKumDdVvFz1CzCwxgRl0JHnCfp5B
         ht7YabU+8ofwfTU3i5NCuaeAurTHZoHtE5M66Jqz66MWlInRIhDlpajOQVZZYEYagSaX
         9gj0gERXnkjrrUV6qeULqu2GYW3ZHLOzQOtUMEqwvqF3Kgs3V+sZ8dWPTvrcJgdyknky
         a4vIUH6jjj3372GsoCQh4BKqDaBnux5iTI+1N2P4/kAPzdEtyHX2nFLaU12147ebdDfw
         l0WZiF+cLO1VJkoCB0NElBLL1mGjRux4amiJbec+ajjHsFpGUtzTaxmyQSt8LSfyAqUQ
         TwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WaaInSZ/8FR2reHnDUn1kcD6WX/fXP/+clwh+fO1tAQ=;
        b=WW0thPCeNJLVZJc+Wuv4z1YsxQgb7G7GYn6eJ1hPHIf3I53YSCASct0a+/dnUYk3x3
         YVg2KpLIac7rDFpLataHTTGtcStLZblN38fpSQblEyvY4D0J0BFcYpkWWa3cTHNBDbPO
         ENIxBK0WdW1aP4eV3xRjKa4rIjduDZi7nbtWjP3I53TIBRb3GKtKW1GTBvMiIPgSaacx
         LacHAV7D6Kdziwq8u2PqKgkr6LYXrSNorrSd19F/efRPXSs3vmhShMeiyX/flDieDOeP
         6+Gg1m4f+Jg5aLU7wYR7swurCBEE8Ns+185xt4TEj0HS0ISgw1WLYCYvAC613NL0Zqnq
         NzQg==
X-Gm-Message-State: APjAAAX477m3nS87CCg9TG1HX+FWSxYC+ALzMSvT6BDUStBc/rF6NWfS
        s/DwGtV0IV0hwdlvhO0RsxULhQ==
X-Google-Smtp-Source: APXvYqwwDdOf6xI+YV3fdp0081pb426NkWEs8zvOFG/hz0kcmI7ogEtPNQtz4h6uyHQTaFpBYVdOIg==
X-Received: by 2002:a2e:5d49:: with SMTP id r70mr51228511ljb.102.1558615907367;
        Thu, 23 May 2019 05:51:47 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id c19sm5947154lfi.69.2019.05.23.05.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 05:51:46 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] staging: kpc2000: add blank line after declarations
Date:   Thu, 23 May 2019 14:51:35 +0200
Message-Id: <20190523125143.32511-2-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523125143.32511-1-simon@nikanor.nu>
References: <20190523125143.32511-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl warning "Missing a blank line after declarations".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index e5cddf0eeed3..95bfbe4aae4d 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -245,6 +245,7 @@ int  kp2000_check_uio_irq(struct kp2000_device *pcard, u32 irq_num)
 	u64 interrupt_active   =  readq(pcard->sysinfo_regs_base + REG_INTERRUPT_ACTIVE);
 	u64 interrupt_mask_inv = ~readq(pcard->sysinfo_regs_base + REG_INTERRUPT_MASK);
 	u64 irq_check_mask = (1 << irq_num);
+
 	if (interrupt_active & irq_check_mask) { // if it's active (interrupt pending)
 		if (interrupt_mask_inv & irq_check_mask) {    // and if it's not masked off
 			return 1;
@@ -257,6 +258,7 @@ static
 irqreturn_t  kuio_handler(int irq, struct uio_info *uioinfo)
 {
 	struct kpc_uio_device *kudev = uioinfo->priv;
+
 	if (irq != kudev->pcard->pdev->irq)
 		return IRQ_NONE;
 
@@ -506,8 +508,10 @@ void  kp2000_remove_cores(struct kp2000_device *pcard)
 {
 	struct list_head *ptr;
 	struct list_head *next;
+
 	list_for_each_safe(ptr, next, &pcard->uio_devices_list) {
 		struct kpc_uio_device *kudev = list_entry(ptr, struct kpc_uio_device, list);
+
 		uio_unregister_device(&kudev->uioinfo);
 		device_unregister(kudev->dev);
 		list_del(&kudev->list);
-- 
2.20.1

