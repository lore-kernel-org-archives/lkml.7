Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A20C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5640F2082A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfHSOpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:45:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47462 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfHSOpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:45:13 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzitr-0005pc-MS; Mon, 19 Aug 2019 16:44:47 +0200
Date:   Mon, 19 Aug 2019 16:44:46 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dmitry Safonov <0x7f454c46@gmail.com>
cc:     Andy Lutomirski <luto@kernel.org>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCHv6 23/36] x86/vdso: Allocate timens vdso
In-Reply-To: <37f08bfa-0ef8-6df9-e119-e010cdeb9a5a@gmail.com>
Message-ID: <alpine.DEB.2.21.1908191639320.2147@nanos.tec.linutronix.de>
References: <20190815163836.2927-1-dima@arista.com> <20190815163836.2927-24-dima@arista.com> <b719199a-ed91-610b-38bc-015a0749f600@kernel.org> <alpine.DEB.2.21.1908162208190.1923@nanos.tec.linutronix.de> <483678c7-7687-5445-f09e-e45e9460d559@gmail.com>
 <alpine.DEB.2.21.1908171709360.1923@nanos.tec.linutronix.de> <37f08bfa-0ef8-6df9-e119-e010cdeb9a5a@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry,

On Mon, 19 Aug 2019, Dmitry Safonov wrote:
> On 8/18/19 5:21 PM, Thomas Gleixner wrote:
> > That means your timens_to_host() and host_to_timens() conversion functions
> > should just use that special VDSO page and do the same array based
> > unconditional add/sub of the clock specific offset.
> 
> I was a bit scarred that clock_mode change would result in some complex
> logic, but your patch showed me that it's definitely not so black as I
> was painting it.

Right. It took me a while to find the right spot which does not affect the
non-timens path and at the same time gives a reasonable result for the
timens case.

One thing occured to me while doing that vvar_fault() hack for testing. For
the timens case it will hit

     if (sym_offset == image->sym_vvar_page) {

first, which is then installing the special vvar page.

It's clear that the code will hit the next fault immediately when trying to
access the real vvar page at the timens offset. So it might be sensible to
map that one in one go to avoid the immediate second page fault. But that
should be a separate patch after the initial 'functional' one.

Thanks,

	tglx
