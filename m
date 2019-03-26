Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C1EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6EF20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732749AbfCZVL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 17:11:27 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49395 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732118AbfCZVL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 17:11:26 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8tLp-0006S7-8T; Tue, 26 Mar 2019 22:11:17 +0100
Date:   Tue, 26 Mar 2019 22:11:16 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH v2 05/14] x86/hpet: Relocate flag definitions to a
 header file
In-Reply-To: <1551283518-18922-6-git-send-email-ricardo.neri-calderon@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1903262204080.1789@nanos.tec.linutronix.de>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com> <1551283518-18922-6-git-send-email-ricardo.neri-calderon@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019, Ricardo Neri wrote:

> Users of HPET timers (such as the hardlockup detector) need the definitions
> of these flags to interpret the configuration of a timer as passed by
> platform code.

Which platform code?

> +#define HPET_DEV_USED_BIT		2
> +#define HPET_DEV_USED			(1 << HPET_DEV_USED_BIT)
> +#define HPET_DEV_VALID			0x8
> +#define HPET_DEV_FSB_CAP		0x1000
> +#define HPET_DEV_PERI_CAP		0x2000

I'm not seing why you would need any of those in the watchdog code.

The only function related to the watchdog which needs these is
hpet_hardlockup_detector_assign_timer() and that is located in hpet.c
itself.

Thanks,

	tglx


