Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C79FC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DB02178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbfKFRmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:42:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44903 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728983AbfKFRmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:42:20 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSPJu-0000c5-FI; Wed, 06 Nov 2019 18:42:14 +0100
Date:   Wed, 6 Nov 2019 18:42:13 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Oleg Nesterov <oleg@redhat.com>
cc:     Florian Weimer <fweimer@redhat.com>, Shawn Landden <shawn@git.icu>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Keith Packard <keithp@keithp.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: handle_exit_race && PF_EXITING
In-Reply-To: <20191106121111.GC12575@redhat.com>
Message-ID: <alpine.DEB.2.21.1911061808030.1869@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1911051053470.17054@nanos.tec.linutronix.de> <20191105152728.GA5666@redhat.com> <alpine.DEB.2.21.1911051800070.1869@nanos.tec.linutronix.de> <alpine.DEB.2.21.1911051851380.1869@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1911051920420.1869@nanos.tec.linutronix.de> <alpine.DEB.2.21.1911051959260.1869@nanos.tec.linutronix.de> <20191106085529.GA12575@redhat.com> <alpine.DEB.2.21.1911061028020.1869@nanos.tec.linutronix.de> <20191106103509.GB12575@redhat.com>
 <alpine.DEB.2.21.1911061154520.1869@nanos.tec.linutronix.de> <20191106121111.GC12575@redhat.com>
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

On Wed, 6 Nov 2019, Oleg Nesterov wrote:
> 
> I think that (with or without this fix) handle_exit_race() logic needs
> cleanups, there is no reason for get_futex_value_locked(), we can drop
> ->pi_lock right after we see PF_EXITPIDONE. Lets discuss this later.

Which still is in atomic because the hash bucket lock is held, ergo
get_futex_value_locked() needs to stay for now.

So the only thing we could do is to reduce the pi_lock held section a bit.

Thanks,

	tglx

