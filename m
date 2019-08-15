Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E46AC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBED92089E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733245AbfHOUEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 16:04:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40754 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731196AbfHOUEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 16:04:23 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyLyt-0005AL-Cb; Thu, 15 Aug 2019 22:04:19 +0200
Date:   Thu, 15 Aug 2019 22:04:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kernel User <linux-kernel@riseup.net>
cc:     LKML <linux-kernel@vger.kernel.org>, mhocko@suse.com,
        x86@kernel.org
Subject: Re: /sys/devices/system/cpu/vulnerabilities/ doesn't show all known
 CPU vulnerabilities
In-Reply-To: <20190815223730.0b5c6c13@localhost>
Message-ID: <alpine.DEB.2.21.1908152140460.1908@nanos.tec.linutronix.de>
References: <20190813232829.3a1962cc@localhost> <20190813212115.GO16770@zn.tnic> <20190814010041.098fe4be@localhost> <20190814070457.GA26456@zn.tnic> <20190814121154.12f488f7@localhost> <alpine.DEB.2.21.1908151054090.2241@nanos.tec.linutronix.de>
 <20190815223730.0b5c6c13@localhost>
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

On Thu, 15 Aug 2019, Kernel User wrote:
> On Thu, 15 Aug 2019 11:03:35 +0200 (CEST) Thomas Gleixner wrote:
> 
> > It's used to denote vulnerability classes and their mitigations:
> > 
> >   - Spectre v1
> >   - Spectre v2
> >   - Meltdown
> >   - SSB
> >   - L1TF
> >   - MDS
> 
> In the Wikipedia article there are:
> 
> + Bounds Check Bypass (Spectre, Variant 1)
> + Branch Target Injection (Spectre, Variant 2)
> + Rogue Data Cache Load (Meltdown, Variant 3)
> - Rogue System Register Read (Spectre-NG, Variant 3a)

Is a subclass of Meltdown, but cannot be mitigated in software and we don't
know whether the micro-code contains a fix or not unless the CPU/microcode
tells us that Meltdown is fixed, which includes 3a. We report that
correctly.

It's also not a really spectacular issue. The only valuable data you might
get out of it is info to break KASLR, but there are a gazillion other ways
to do so.

> + Speculative Store Bypass (Spectre-NG, Variant 4)
> - Lazy FP state restore (Spectre-NG)

The kernel is not using lazy restore. Dead kernels did, but they got
patched and no longer allow the lazy mode. So, nothing to see here.

> - Bounds Check Bypass Store (Spectre-NG)

Is a subclass of Spectre V1 similar to the recently published SWAPGS issue.

> + Foreshadow
> - Spoiler

Spoiler cannot be mitigated by any means. It's like Rowhammer. Nothing we
can do about and nothing to show.

> + Microarchitectural Data Sampling
> 
> I have marked with '+' those which I recognize in the list you provided
> and with '-' those which are not.
> 
> > We are not tracking subclasses and their individual CVEs.
> 
> Why do you say that? In your list only L1TF and MDS are not subclasses,
> i.e. subclasses are in the list. So why not have the others? Also
> Spoiler seems to be a separate class.

What? Spectre V1, V2 and Meltdown and SSB are different classes despite the
variant 1,2,3,4 enumeration. They are different classes because they
utilize different parts of the whole speculative execution machinery and
need very different mitigation mechanisms.

Just because Wikipedia has a list of some sort does not mean that we have
to blindly follow it.

Thanks,

	tglx
