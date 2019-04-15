Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51E1C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9367F2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfDOJvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:51:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45168 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfDOJvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:51:47 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hFyHA-0004FB-7H; Mon, 15 Apr 2019 11:51:44 +0200
Date:   Mon, 15 Apr 2019 11:51:38 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Huw Davies <huw@codeweavers.com>
cc:     linux kernel <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH 2/3] x86/vdso: Allow clock specific mult and shift
 values
In-Reply-To: <20190415093042.GA21726@merlot.physics.ox.ac.uk>
Message-ID: <alpine.DEB.2.21.1904151148160.17231@nanos.tec.linutronix.de>
References: <20190411101205.10006-1-huw@codeweavers.com> <20190411101205.10006-3-huw@codeweavers.com> <alpine.DEB.2.21.1904141229380.4917@nanos.tec.linutronix.de> <20190415093042.GA21726@merlot.physics.ox.ac.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019, Huw Davies wrote:

> On Sun, Apr 14, 2019 at 12:53:32PM +0200, Thomas Gleixner wrote:
> > So it stays in the same cache line, but as we move the VDSO to generic
> > code, the mask field needs to stay and this will make basetime[CLOCK_MONOTONIC] 
> > overlap into the next cache line.
> 
> Thanks for the great review; this is a good point.
> 
> > See https://lkml.kernel.org/r/alpine.DEB.2.21.1902231727060.1666@nanos.tec.linutronix.de
> > for an alternate solution to this problem, which avoids this and just gives
> > CLOCK_MONOTONIC_RAW a separate storage space alltogether.
> 
> I can certainly do this for the x86 vdso.  Would that be useful or
> should I wait for Vincenzo's work on the generic vdso first?

Depends. If Vincenzo comes along with his new version soon, then you might
get this for free :)

Vincenzo, what's the state of your work?

Thanks,

	tglx

