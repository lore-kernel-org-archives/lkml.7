Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1915FC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E7A206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731075AbfG3Ioo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 04:44:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56111 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbfG3Ioo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:44:44 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hsNkN-0002Vf-SA; Tue, 30 Jul 2019 10:44:39 +0200
Date:   Tue, 30 Jul 2019 10:44:34 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Santosh Sivaraj <santosh@fossix.org>
cc:     x86@kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] x86/mce: Remove redundant irq work
In-Reply-To: <20190730061520.19953-1-santosh@fossix.org>
Message-ID: <alpine.DEB.2.21.1907301042190.1738@nanos.tec.linutronix.de>
References: <20190730061520.19953-1-santosh@fossix.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2019, Santosh Sivaraj wrote:

> IRQ work currently only does a schedule work to process the mce
> events. Since irq work does no other function, remove it.

No. You _cannot call schedule_work() from MCE exception context as MCE can
interrupt even interrupt disabled context similar to NMI. irq work is
designed to work in those contexts.

Thanks,

	tglx
