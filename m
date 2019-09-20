Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B786C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580862086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408658AbfITKXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 06:23:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51967 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405917AbfITKXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 06:23:24 -0400
Received: from [5.158.153.55] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iBG4M-0006uo-Ru; Fri, 20 Sep 2019 12:23:19 +0200
Date:   Fri, 20 Sep 2019 12:23:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
cc:     Suleiman Souhlal <suleiman@google.com>, rkrcmar@redhat.com,
        john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [RFC 0/2] kvm: Use host timekeeping in guest.
In-Reply-To: <1ec0b238-61a7-8353-026e-3a2ee23e6240@redhat.com>
Message-ID: <alpine.DEB.2.21.1909201221070.1858@nanos.tec.linutronix.de>
References: <20190920062713.78503-1-suleiman@google.com> <1ec0b238-61a7-8353-026e-3a2ee23e6240@redhat.com>
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

On Fri, 20 Sep 2019, Paolo Bonzini wrote:

> On 20/09/19 08:27, Suleiman Souhlal wrote:
> > To do that, I am changing kvmclock to request to the host to copy
> > its timekeeping parameters (mult, base, cycle_last, etc), so that
> > the guest timekeeper can use the same values, so that time can
> > be synchronized between the guest and the host.
> > 
> > Any suggestions or feedback would be highly appreciated.
> 
> I'm not a timekeeping maintainer, but I don't think the
> kernel/time/timekeeping.c changes are acceptable.

Indeed. #ifdef WHATEVERTHEHECK does not go anywhere. If at all this needs
to be a runtime switch, but I have yet to understand the whole picture of
this.

Thanks,

	tglx
