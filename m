Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BD7C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAD421882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gandi.net header.i=@gandi.net header.b="STARqt7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390138AbfKEQF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 11:05:57 -0500
Received: from mail12.gandi.net ([217.70.182.73]:48463 "EHLO gandi.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390011AbfKEQF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 11:05:56 -0500
Received: from khany.gandi.net (unknown [10.231.1.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gandi.net (Postfix) with ESMTPSA id 076811604EC;
        Tue,  5 Nov 2019 16:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gandi.net; s=20190808;
        t=1572969955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t6saG2bge6fB4OT/ZiIwFe0H0AmxMfR+BkgEGdWxza0=;
        b=STARqt7TQsO1av9JWizmQTYs6hEt85jtJUkEqNAgf5ny3/mRiJl57kIDn+jW5KbXzCxbw9
        8BvB0BukpvKumfDECEglJAofntzKC0peKOFz3mWOQF3LtCu/w1iYWo6QUZtNoRbT96BYn9
        Hexe+Di4YhZ4062YOcFFY465ElzP7BO6t0nkSZYixGk6nOEADUvGPvy/b7yYkxjIDC7iL3
        paZ7p5kmSVXAoAZ3+S4WLVNvr8lwp1L1NttCd0iLDyzCGj14JqrUukSVSS/C23TullGbUY
        ZkbNj1BxldkUCSdrF/FaFNpi20da/vNijCfaAfhSL6F3zyc9HpjVfytj8N+ozQ==
Received: by khany.gandi.net (Postfix, from userid 1000)
        id 6A4D5DC009B; Tue,  5 Nov 2019 16:05:30 +0000 (GMT)
Date:   Tue, 5 Nov 2019 16:05:30 +0000
From:   Arthur Gautier <baloo@gandi.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: uaccess: fix regression in unsafe_get_user
Message-ID: <20191105160530.vdaii44gckfo45rw@khany>
References: <20190216234702.GP2217@ZenIV.linux.org.uk>
 <20190217034121.bs3q3sgevexmdt3d@khany>
 <20190217042201.GU2217@ZenIV.linux.org.uk>
 <alpine.DEB.2.21.1902181347500.1549@nanos.tec.linutronix.de>
 <CALCETrXyard2OXmOafiLks3YuyO=ObbjDXB6NJo_08rL4M6azw@mail.gmail.com>
 <20190218215150.xklqbfckwmbtdm3t@khany>
 <20190926095825.zkdpya55yjusvv4g@khany>
 <20190926140939.GD18383@zn.tnic>
 <20191010164951.kr2epy5lyywgngt6@khany>
 <20191105141112.GB28418@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105141112.GB28418@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 03:11:12PM +0100, Borislav Petkov wrote:
> On Thu, Oct 10, 2019 at 04:49:51PM +0000, Arthur Gautier wrote:
> > I did not receive neither the patch Andy provided, nor the comments made
> > on it. But I'd be happy to help and/or take over to fix those if someone could
> > send me both.
> 
> Yes, please do, it seems Andy's busy. You can find the whole thread here:
> 
> https://lore.kernel.org/lkml/20190215235901.23541-1-baloo@gandi.net/
> 
> and you can download it in mbox format.
> 
> Care to take Andy's patch, work in the comments I made to it, test it,
> write a commit message, i.e., productize it?
> 
> So that we get this thing moving...
> 
> Thx.
> 

Hello Boris,

Thank you! But I believe this is the patch I sent, I know Andy sent a
patchset with two patches, I believe privately (not copied to a public
ML) to some of the recepients here. I got a copy of the second patch
but not the first one.

I believe from discussions here, that comments have been made on those
patchset and because I was not Cc-ed on those patches, I do not have
neither the full patchset nor the comments.

I cannot take over the work, nor finish the patchset.

Would anyone have a copy of the thread and could send them my way?

Thank you so much!

-- 
\o/ Arthur
 G  Gandi.net
