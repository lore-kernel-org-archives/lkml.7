Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D442C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19DC21473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfFNNCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:02:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37884 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfFNNCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:02:49 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hblqt-00046r-I2; Fri, 14 Jun 2019 15:02:43 +0200
Date:   Fri, 14 Jun 2019 15:02:43 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Kirkendall, Garrett" <Garrett.Kirkendall@amd.com>
cc:     "nstange@suse.de" <nstange@suse.de>,
        "luto@kernel.org" <luto@kernel.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: arch/x86/kernel/apic/apic.c: calibrate_APIC_clock() soft hangs
 when PIC is not configured by BIOS before kernel is launched.
In-Reply-To: <SN6PR12MB2734370504CF4B89600C8FD885330@SN6PR12MB2734.namprd12.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.1906141454430.1722@nanos.tec.linutronix.de>
References: <SN6PR12MB2734813FB27C43E06F5B4E3D85330@SN6PR12MB2734.namprd12.prod.outlook.com> <SN6PR12MB2734B49FDFEAC6CE5D93687185330@SN6PR12MB2734.namprd12.prod.outlook.com> <alpine.DEB.2.21.1905091526440.3139@nanos.tec.linutronix.de>
 <SN6PR12MB2734370504CF4B89600C8FD885330@SN6PR12MB2734.namprd12.prod.outlook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Garrett,

On Thu, 9 May 2019, Kirkendall, Garrett wrote:

  A: Because it messes up the order in which people normally read text.
  Q: Why is top-posting such a bad thing?
  A: Top-posting.
  Q: What is the most annoying thing in e-mail?

  A: No.
  Q: Should I include quotations after my reply?

  http://daringfireball.net/2007/07/on_top

Also please break the lines around 78 chars.

> 1.  Is it correct to probe the 8259 before it is initialized by the
>     kernel?  The 8259 will not respond properly to the probe unless it is
>     properly initialized.

So far the kernel relied on the BIOS to initialize 8259

> 2.  Should IOAPIC interrupts 0-15 require the legacy PIC be available and
>     initialized by the BIOS?

Unless the platform explicitely states that there is no legacy PIC, which
is true for some MID and HV guest systems. 

> 2.  The kernel will not boot if there is no legacy 8259 PIC even if all
>     the other factors stated are provided.

Hmm? what other factors?

> I want to understand why a preinitialized 8259 is a requirement for a
> system configured to use the IOAPIC?

Mostly historical reasons and the whole PIC/IOAPIC thing has been a fragile
nightmare forever, so I'm reluctant to do any extra work there which might
break older machines.

Thanks,

	tglx
