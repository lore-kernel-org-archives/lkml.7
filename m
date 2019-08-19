Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBC3C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E16214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfHSVHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 17:07:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49463 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbfHSVHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 17:07:09 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzoro-0004Nn-57; Mon, 19 Aug 2019 23:07:04 +0200
Date:   Mon, 19 Aug 2019 23:07:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bandan Das <bsd@redhat.com>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/apic: reset LDR in clear_local_APIC
In-Reply-To: <jpga7ccl7la.fsf@linux.bootlegged.copy>
Message-ID: <alpine.DEB.2.21.1908192259390.4008@nanos.tec.linutronix.de>
References: <jpga7ccl7la.fsf@linux.bootlegged.copy>
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

Bandan,

On Wed, 14 Aug 2019, Bandan Das wrote:
> On a 32 bit RHEL6 guest with greater than 8 cpus, the
> kdump kernel hangs when calibrating apic. This happens
> because when apic initializes bigsmp, it also initializes LDR
> even though it probably wouldn't be used.

'It probably wouldn't be used' is a not really a useful technical
statement.

Either it is used, then it needs to be handled. Or it is unused then why is
it written in the first place?

The bigsmp APIC uses physical destination mode because the logical flat
model only supports 8 APICs. So clearly bigsmp_init_apic_ldr() is bogus and
should be empty.
 
> When booting into kdump, KVM apic incorrectly reads the stale LDR
> values from the guest while building the logical destination map
> even for inactive vcpus. While KVM apic can be fixed to ignore apics
> that haven't been enabled, a simple guest only change can be to
> just clear out the LDR.

This does not make much sense either. What has KVM to do with logical
destination maps while booting the kdump kernel? The kdump kernel is not
going through the regular cold/warm boot process, so KVM does not even know
that the crashing kernel jumped into the kdump one.

What builds the logical destination maps and what has LDR and the KVM APIC
to do with that?

I'm not opposed to the change per se, but I'm not accepting change logs
which have the fairy tale smell.

Thanks,

	tglx
