Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6B6C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20109204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfEINcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 09:32:42 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50148 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfEINcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 09:32:42 -0400
Received: from [85.235.16.11] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hOjA3-0007a7-6H; Thu, 09 May 2019 15:32:35 +0200
Date:   Thu, 9 May 2019 15:32:19 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Kirkendall, Garrett" <Garrett.Kirkendall@amd.com>
cc:     "nstange@suse.de" <nstange@suse.de>,
        "luto@kernel.org" <luto@kernel.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: arch/x86/kernel/apic/apic.c: calibrate_APIC_clock() soft hangs
 when PIC is not configured by BIOS before kernel is launched.
In-Reply-To: <SN6PR12MB2734B49FDFEAC6CE5D93687185330@SN6PR12MB2734.namprd12.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.1905091526440.3139@nanos.tec.linutronix.de>
References: <SN6PR12MB2734813FB27C43E06F5B4E3D85330@SN6PR12MB2734.namprd12.prod.outlook.com> <SN6PR12MB2734B49FDFEAC6CE5D93687185330@SN6PR12MB2734.namprd12.prod.outlook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1735728731-1557408570=:3139"
Content-ID: <alpine.DEB.2.21.1905091529410.3139@nanos.tec.linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1735728731-1557408570=:3139
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.21.1905091529411.3139@nanos.tec.linutronix.de>

On Thu, 9 May 2019, Kirkendall, Garrett wrote:
> I am trying to boot a UEFI BIOS with minimal legacy hardware support. 
> The Linux kernel soft hangs when the PIC is not configured by the BIOS
> because it is using IOAPIC.  Hopefully, this provides enough information.
>
> Soft hang occurs in calibrate_APIC_clock():

...

> If 8259A PIC is not configured before kernel is launched, HPET IRQ 0
> registration fails because probe_8259A returns PIC as not available and
> therefore interrupt descriptors 0-15 are not allocated.  This happens
> when BIOS does not configure 8259A PIC because it uses IOAPIC.

Right. Works as designed.

There is not much we can do at that point, unless your platform has other
means to provide the TSC frequency (cpuid or MSR) along with the bus
frequency which is fed into the local apic timer.

Thanks,

	tglx
--8323329-1735728731-1557408570=:3139--
