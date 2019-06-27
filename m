Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A83C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE1420843
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="Xklg8qf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfF0Iy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 04:54:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32854 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfF0Iy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 04:54:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id x15so893231pfq.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 01:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uE7UhkaemzZrZY8DroeOZDa2kTMOR+lb/8mv5OZuH0o=;
        b=Xklg8qf/JLBEkmP48mtlbR9QUhuJP+MsQZ8PL3MnIbvLutj2UWnrwelO4wYfLhmsHs
         q+KrDx+BC6tyl+CHfS+6JKsM9Oo8SZdQWHdSpisbwst0BECYw/W6dfz+TXxc5Uj1JdQ0
         zd8ESi7N5PrMcTXwSHvePkH5yVrXjW3PMoj4+8kxL2RUAQ1jPDsGG3mI8T321U2YbCwx
         vi3k6Ppzp8GMvtCcBTgmPxCiA/XCzl5UY/Xq6riVcsosQCp4p4SRkqt7DRRnM7HRcEgM
         B4PJ/zVgEF9IYlVCQf+KPBhkTorX4qNuyB6U3WVlqapD3HBlIQ94oWxSbl4gDWqX9/az
         Mp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uE7UhkaemzZrZY8DroeOZDa2kTMOR+lb/8mv5OZuH0o=;
        b=k8OjrYTKEOHuAlqDk67ESg0wlDoLW5i0R3NVLvIjamYN9jXaxQYqcfeywc8uJNsbd2
         LCd9ysEXj6Dbzp9adXtiq3ZTRcKFhbTMF9BbYaneXNPlVCm2a8EPWn61QsvscGi9wMwK
         fo3INaT2U0V3yMvzVAm7O2IcaWNvp2BUSPyPdFdehbScr+H4qIU3fcdIPw1X1gKf3DNR
         Mk3zQHmg5BUTn285RjdWiqoks0lFPX5cwTquN+rvZcVlvAUWRwHJqNnoXgkrTYYXi7az
         fKVGsIdzuZx/HpOTj+zxQ9bzPMAqnpHSrh1W4E3yqE8fLeVqrdOIc8Jslg1cC7u4yMh9
         gwMQ==
X-Gm-Message-State: APjAAAVQ99syewVYQHdqoBiaYb1wUEo3tQgQ/foVHNVYJpdkH4Gm2xdo
        WgW7287YJyoe/dI5i03c5twLw4i07TkmyA==
X-Google-Smtp-Source: APXvYqwdQMOqKfGcEmEvEHKgSADdx37xsc4hPqaVIjTB+3A97knfEIdB5xFBGhuaRRMtaTtJlMg5dw==
X-Received: by 2002:a65:4085:: with SMTP id t5mr2736464pgp.109.1561625665874;
        Thu, 27 Jun 2019 01:54:25 -0700 (PDT)
Received: from limbo.local (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id d6sm3892185pjo.32.2019.06.27.01.54.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 01:54:25 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de,
        hdegoede@redhat.com, david.e.box@linux.intel.com,
        linux@endlessm.com, rafael.j.wysocki@intel.com, x86@kernel.org
Subject: Re: No 8254 PIT & no HPET on new Intel N3350 platforms causes kernel panic during early boot
Date:   Thu, 27 Jun 2019 16:54:19 +0800
Message-Id: <20190627085419.27854-1-drake@endlessm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <alpine.DEB.2.21.1904031206440.1967@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1904031206440.1967@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Picking up this issue again after a break!

We made some progress last time on reducing PIT usage in the TSC
calibration code, but we still have the bigger issue to resolve:
IO-APIC code panicing when the PIT isn't ticking.

On Wed, Apr 3, 2019 at 7:21 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> For newer CPUs we might assume that:
>
>  1) The TSC and APIC timer are actually usable
>
>  2) The frequencies can be retrieved from CPUID or MSRs
>
> If #1 and #2 are reliable we can avoid the whole calibration and interrupt
> delivery mess.
>
> That means we need the following decision logic:
>
>   1) If HPET is available in ACPI, boot normal.
>
>   2) If HPET is not available, verify that the PIT actually counts. If it
>      does, boot normal.
>
>      If it does not either:
>
>      2A) Verify that this is a PCH 300/C240 and fiddle with that ISST bit.
>
>          But that means that we need to chase PCH ids forever...
>
>      2B) Shrug and just avoid the whole PIT/HPET magic all over the place:
>
>          - Avoid the interrupt delivery check in the IOAPIC code as it's
>            uninteresting in that case. Trivial to do.

I tried to explore this idea here:
https://lore.kernel.org/patchwork/patch/1064972/
https://lore.kernel.org/patchwork/patch/1064971/

But I can't say I really knew what I was doing there, and you
pointed out some problems.

Any new ideas that I can experiment with?

Being more conservative, how about something like this?
---
 arch/x86/kernel/apic/io_apic.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 53aa234a6803..36b1e7d5b657 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2073,7 +2073,7 @@ static int mp_alloc_timer_irq(int ioapic, int pin)
  *
  * FIXME: really need to revamp this for all platforms.
  */
-static inline void __init check_timer(void)
+static inline void __init check_timer(int timer_was_working)
 {
 	struct irq_data *irq_data = irq_get_irq_data(0);
 	struct mp_chip_data *data = irq_data->chip_data;
@@ -2216,8 +2216,15 @@ static inline void __init check_timer(void)
 		apic_printk(APIC_QUIET, KERN_INFO
 			    "Perhaps problem with the pre-enabled x2apic mode\n"
 			    "Try booting with x2apic and interrupt-remapping disabled in the bios.\n");
-	panic("IO-APIC + timer doesn't work!  Boot with apic=debug and send a "
-		"report.  Then try booting with the 'noapic' option.\n");
+
+	if (timer_was_working)
+		panic("IO-APIC + timer doesn't work!  Boot with apic=debug and send a "
+			"report.  Then try booting with the 'noapic' option.\n");
+	else
+		apic_printk(APIC_QUIET, KERN_INFO
+			    "Continuing anyway with no 8254 timer, as it was not working even before IO-APIC setup was attempted.\n"
+			    "Boot will fail unless another working clocksource is found.\n");
+
 out:
 	local_irq_restore(flags);
 }
@@ -2304,12 +2311,20 @@ static void ioapic_destroy_irqdomain(int idx)
 void __init setup_IO_APIC(void)
 {
 	int ioapic;
+	int timer_was_working = 0;
 
 	if (skip_ioapic_setup || !nr_ioapics)
 		return;
 
 	io_apic_irqs = nr_legacy_irqs() ? ~PIC_IRQS : ~0UL;
 
+	/*
+	 * Record if the timer was in working state before we do any
+	 * IO-APIC setup.
+	 */
+	if (nr_legacy_irqs())
+		timer_was_working = timer_irq_works();
+
 	apic_printk(APIC_VERBOSE, "ENABLING IO-APIC IRQs\n");
 	for_each_ioapic(ioapic)
 		BUG_ON(mp_irqdomain_create(ioapic));
@@ -2323,7 +2338,7 @@ void __init setup_IO_APIC(void)
 	setup_IO_APIC_irqs();
 	init_IO_APIC_traps();
 	if (nr_legacy_irqs())
-		check_timer();
+		check_timer(timer_was_working);
 
 	ioapic_initialized = 1;
 }
-- 
2.20.1

