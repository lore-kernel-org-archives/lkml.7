Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD2CC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FA020833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="q6XInizr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfDOJro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:47:44 -0400
Received: from 50-203-203-244-static.hfc.comcastbusiness.net ([50.203.203.244]:59106
        "EHLO mail.codeweavers.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725798AbfDOJro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:47:44 -0400
X-Greylist: delayed 1013 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Apr 2019 05:47:43 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hNO72mY6owZc9BbDkbkB6z1MumKqdRQ98mR/U6MEzko=; b=q6XInizrZMsjXaI5QsIP0B2zq
        bNLE+82bw2qRak7Auo29DUAx+nKMkn9AdFa0uJz77YL2JUCo1MDH/GvA6RIb0VAc69uyEnV/OrdOl
        AIFqaL1Z2X87ZTiV8bRcmH/aTS4pocqTAltHifuoGYBiOU4ZettOdUT88/rJPZOmQCQ2M=;
Received: from merlot.physics.ox.ac.uk ([163.1.241.98] helo=merlot)
        by mail.codeweavers.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <huw@codeweavers.com>)
        id 1hFxx3-0008JV-VR; Mon, 15 Apr 2019 04:30:59 -0500
Received: from daviesh by merlot with local (Exim 4.90_1)
        (envelope-from <huw@codeweavers.com>)
        id 1hFxwp-0005h8-KS; Mon, 15 Apr 2019 10:30:43 +0100
Date:   Mon, 15 Apr 2019 10:30:43 +0100
From:   Huw Davies <huw@codeweavers.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux kernel <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH 2/3] x86/vdso: Allow clock specific mult and shift values
Message-ID: <20190415093042.GA21726@merlot.physics.ox.ac.uk>
References: <20190411101205.10006-1-huw@codeweavers.com>
 <20190411101205.10006-3-huw@codeweavers.com>
 <alpine.DEB.2.21.1904141229380.4917@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904141229380.4917@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 12:53:32PM +0200, Thomas Gleixner wrote:
> So it stays in the same cache line, but as we move the VDSO to generic
> code, the mask field needs to stay and this will make basetime[CLOCK_MONOTONIC] 
> overlap into the next cache line.

Thanks for the great review; this is a good point.

> See https://lkml.kernel.org/r/alpine.DEB.2.21.1902231727060.1666@nanos.tec.linutronix.de
> for an alternate solution to this problem, which avoids this and just gives
> CLOCK_MONOTONIC_RAW a separate storage space alltogether.

I can certainly do this for the x86 vdso.  Would that be useful or
should I wait for Vincenzo's work on the generic vdso first?

Many thanks,
Huw.
