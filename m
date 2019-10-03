Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE51C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF6E20673
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121787;
	bh=M4zVaIblWaCwND8wPrykh0Kpifb/FzqvFc2ZQKcVEXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZsTox7jOtgbuQmDNawNsVduWnO04OD+nnD59NWEIx6lpXw2syS3OOf693O6D0Ipvr
	 NkHU552Dt2BgpewkMW9qfgrXDGPrjyxBlXI/k2CdLG1CDWf8JbvaKRh5ee0WY5CpJM
	 zYk3PBy+O8bP4ELG3qRXfmBA+08rNG7rfId7eA7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406013AbfJCQvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393112AbfJCQvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:51:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CCE720867;
        Thu,  3 Oct 2019 16:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121464;
        bh=M4zVaIblWaCwND8wPrykh0Kpifb/FzqvFc2ZQKcVEXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2iuEUhUq2JVKL4Z9NJt+I/Cu98N4BBK1MjZpu03hJL2vliSlihgVhc3KEclT4DUgo
         7JAcs4po6PpW4BtJSnb1cd3Qe15XwoRas4FSjSaYzc04SWsfaGSCuUzwaQVZDO0XKK
         7/mkKyjbwOYP5VmcEHZTkfepuFZZ1u7GJ1r7RC6k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5.3 261/344] platform/x86: intel_int0002_vgpio: Fix wakeups not working on Cherry Trail
Date:   Thu,  3 Oct 2019 17:53:46 +0200
Message-Id: <20191003154606.232415462@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 1bd43d0077b9a32a8b8059036471f3fc82dae342 upstream.

Commit 871f1f2bcb01 ("platform/x86: intel_int0002_vgpio: Only implement
irq_set_wake on Bay Trail") removed the irq_set_wake method from the
struct irq_chip used on Cherry Trail, but it did not set
IRQCHIP_SKIP_SET_WAKE causing  kernel/irq/manage.c: set_irq_wake_real()
to return -ENXIO.

This causes the kernel to no longer see PME events reported through the
INT0002 device as wakeup events. Which e.g. breaks wakeup by the (USB)
keyboard on many Cherry Trail 2-in-1 devices.

Cc: stable@vger.kernel.org
Fixes: 871f1f2bcb01 ("platform/x86: intel_int0002_vgpio: Only implement irq_set_wake on Bay Trail")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/intel_int0002_vgpio.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/platform/x86/intel_int0002_vgpio.c
+++ b/drivers/platform/x86/intel_int0002_vgpio.c
@@ -144,6 +144,7 @@ static struct irq_chip int0002_cht_irqch
 	 * No set_wake, on CHT the IRQ is typically shared with the ACPI SCI
 	 * and we don't want to mess with the ACPI SCI irq settings.
 	 */
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
 static const struct x86_cpu_id int0002_cpu_ids[] = {


