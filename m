Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B544C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE9E217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="ylrk66FE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbfHAGY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 02:24:59 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46565 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729196AbfHAGY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:24:59 -0400
Received: by mail-qk1-f196.google.com with SMTP id r4so51047860qkm.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 23:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gx9i9pIcSx9u0H8yeTzotYg78gs3eILVwcDRbpCCDJE=;
        b=ylrk66FE2m0/ujXQt/hK/AwAle8S1D/zKWc4neCPtJMtfPDZegxr748czetFBxPEV3
         P7Cf0u5mPMn04KZRmNjKwxL4j2XFgvueFYYsbi+oSrr5p3HDN5PZV8rsdhW4ok0x4KJ+
         2y00SpVqxEYkAAekqlyWAQgBcU6o2/C3InY4VaRmF4vea/GHUf1XCpsGaBZw1B+DlRLK
         1f6oxP5WRKIGQvkNTpMTGuggEXn5/cuEML3Tr7qF2uebB554+wMvIAjl8JKDkffyXlqA
         DqFncVshNbereBZa2+Ri9ahLQxJVfdPyn0TxDDyjFi5APxL+oidyJiRYmasl7SZb8W19
         bTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gx9i9pIcSx9u0H8yeTzotYg78gs3eILVwcDRbpCCDJE=;
        b=LDo49M/2Axfajg9oy/kwPWqrrkhxmLP697PpyaTVMJx4yn0xStI7I2fkN8ik6HKErQ
         7q6z5HXdfRxByLedWdMY3SyOBnrgU5WjuwKsaeFYqbFm2gZo4I+vkZzWw94uQMfSfk1d
         Eao79ldYbMPGCW2R37iFYNdV9kJxoJTp/5HcmkBUE0WpKyO8XR6p1f8K8NdQXnFHqLoI
         qhQo2CJuR1Uup47EfLHrAw7zpTXzq0W1Q8kDQfEgsqsM4mVHTcbi+RcprQod7tGivV6R
         u9UlG401tt2Kj1jzKyk+BYx+TVqY5K9DFsip4l3rUpPLfUSIqajPUI4c/um+giVZ3Qxl
         mWcw==
X-Gm-Message-State: APjAAAW8/KX+ABqlpPofgbBewc/NMfq/Qe+dRE/EADeiWRUZAJJp9Ivk
        o6DxhEyUPk9FRg8pehnVivmrRw1YC6K6Y05Q5F0F1Q==
X-Google-Smtp-Source: APXvYqwUxCwssu0Vj2FVrVcIXNUPoeuxP6PaUWc9lasxMXPfUdEHVftGxrJY7DUuaUf3iRbZ/vgtf34YuDkv0V7TF2Q=
X-Received: by 2002:ae9:eb4e:: with SMTP id b75mr82162774qkg.478.1564640698159;
 Wed, 31 Jul 2019 23:24:58 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Drake <drake@endlessm.com>
Date:   Thu, 1 Aug 2019 14:24:46 +0800
Message-ID: <CAD8Lp448i7jOk9C5NJtC2wHMaGuRLD4pxVqK17YqRCuMVXhsOA@mail.gmail.com>
Subject: setup_boot_APIC_clock() NULL dereference during early boot on reduced
 hardware platforms
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        aubrey.li@linux.intel.com, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Working with a new consumer laptop based on AMD R7-3700U, we are
seeing a kernel panic during early boot (before the display
initializes). It's a new product and there is no previous known
working kernel version (tested 5.0, 5.2 and current linus master).

We may have also seen this problem on a MiniPC based on AMD APU 7010
from another vendor, but we don't have it in hands right now to
confirm that it's the exact same crash.

earlycon shows the details: a NULL dereference under
setup_boot_APIC_clock(), which actually happens in
calibrate_APIC_clock():

    /* Replace the global interrupt handler */
    real_handler = global_clock_event->event_handler;
    global_clock_event->event_handler = lapic_cal_handler;

global_clock_event is NULL here. This is a "reduced hardware" ACPI
platform so acpi_generic_reduced_hw_init() has set timer_init to NULL,
avoiding the usual codepaths that would set up global_clock_event.

I tried the obvious:
 if (!global_clock_event)
    return -1;

However I'm probably missing part of the big picture here, as this
only makes boot fail later on. It continues til the next point that
something leads to schedule(), such as a driver calling msleep() or
mark_readonly() calling rcu_barrier(), etc. Then it hangs.

Is something missing in terms of timer setup here? Suggestions appreciated...

Thanks
Daniel
