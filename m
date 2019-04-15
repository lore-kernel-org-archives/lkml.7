Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC920C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBA720883
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="tkPfiY0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfDOMOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:14:38 -0400
Received: from 50-203-203-244-static.hfc.comcastbusiness.net ([50.203.203.244]:37468
        "EHLO mail.codeweavers.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727025AbfDOMOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QDmYhfMbphwvW3eq2t0rwZlHLxkIdoAbNcDRaFqRguE=; b=tkPfiY0cPEdkiH5mBe8PwIQ54
        GuD+NkMsAv1fVrWR6cPXCI/EZvOGm5nqZcsmZjTewbbHc6SsQqVKhfJ/Gf1f9jiz4LrScy3DeLQ1j
        lS5mP9nNOeg+O//DOCMTSYLkzPQkmuVVroQ1wfsWBdLbWV0o21vJP6gJwldZceaLZ8Cd8=;
Received: from merlot.physics.ox.ac.uk ([163.1.241.98] helo=merlot)
        by mail.codeweavers.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <huw@codeweavers.com>)
        id 1hG0Vb-00021R-GO; Mon, 15 Apr 2019 07:14:48 -0500
Received: from daviesh by merlot with local (Exim 4.90_1)
        (envelope-from <huw@codeweavers.com>)
        id 1hG0VM-0005kX-DG; Mon, 15 Apr 2019 13:14:32 +0100
Date:   Mon, 15 Apr 2019 13:14:32 +0100
From:   Huw Davies <huw@codeweavers.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux kernel <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 2/3] x86/vdso: Allow clock specific mult and shift values
Message-ID: <20190415121431.GA22003@merlot.physics.ox.ac.uk>
References: <20190411101205.10006-1-huw@codeweavers.com>
 <20190411101205.10006-3-huw@codeweavers.com>
 <alpine.DEB.2.21.1904141229380.4917@nanos.tec.linutronix.de>
 <20190415093042.GA21726@merlot.physics.ox.ac.uk>
 <alpine.DEB.2.21.1904151148160.17231@nanos.tec.linutronix.de>
 <82a61daf-f6f9-8be0-2157-e9f9d7ba1cdf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82a61daf-f6f9-8be0-2157-e9f9d7ba1cdf@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 11:15:56AM +0100, Vincenzo Frascino wrote:
> On 15/04/2019 10:51, Thomas Gleixner wrote:
> > On Mon, 15 Apr 2019, Huw Davies wrote:
> >> On Sun, Apr 14, 2019 at 12:53:32PM +0200, Thomas Gleixner wrote:
> >>> See https://lkml.kernel.org/r/alpine.DEB.2.21.1902231727060.1666@nanos.tec.linutronix.de
> >>> for an alternate solution to this problem, which avoids this and just gives
> >>> CLOCK_MONOTONIC_RAW a separate storage space alltogether.
> >>
> >> I can certainly do this for the x86 vdso.  Would that be useful or
> >> should I wait for Vincenzo's work on the generic vdso first?
> > 
> > Depends. If Vincenzo comes along with his new version soon, then you might
> > get this for free :)
> > 
> > Vincenzo, what's the state of your work?
> >
> 
> I am mostly done with the development, the only thing missing is the integration
> of the generic update_vsyscall. After this is complete, I will need to do some
> testing and extract the performance numbers.
> 
> Considering that I will be on Easter holiday from this Wednesday till the end of
> April, I think v6 will be ready around second week of May.

Hi Vincenzo,

Great!  In which case there's not much point in me changing the x86
vdso---it'll just end up making more work for you.

Let me know if there's anything I can help with.

Huw.
