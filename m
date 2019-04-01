Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAA7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B38B21473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="BOFwhvpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfDAQ0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:26:30 -0400
Received: from tomli.me ([153.92.126.73]:32896 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbfDAQ0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:26:30 -0400
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 7ee7b0bc;
        Mon, 1 Apr 2019 16:26:27 +0000 (UTC)
X-HELO: localhost.localdomain
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.localdomain) (2402:f000:1:1501:200:5efe:ddd9:ae88)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Mon, 01 Apr 2019 16:26:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=1490979754; bh=VpBaR4q4qXUfszW4SkbQv4Avziosqp7yv0qOz1zizUg=; b=BOFwhvpTtkfhnj0+T4AN3eMhmTzjTBB4XcqIi3jmcSCU/OdqVP6AhVL6yBX0feuML5Y8b5FzDyBEu0BNjoSxTlP5QoJCTX5NYHJO5zOKV6egWaQHFGmocGglL7UC4U/ma7xXH8f30F7HAOUPsRGNH50i8v6N4hG0xmj2NLoJF73/p82wX1Nw+etgj/D0nJCwSLKOa6UmuDcor5wiMJw5x7tJr9d2PawwwFsaz+o0vYPT46NUINv1Agd9aJYCJIFii4dsBsbSrzsfWwn9Fx07DeBS8j9HSqj7yLD5ScWD2tknDXSsvSPVI5pUgyf2Yz2cSzvr8uix80mvP7EpwrGuHg==
Date:   Tue, 2 Apr 2019 00:26:18 +0800
From:   Tom Li <tomli@tomli.me>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 3/7] fbdev: sm712fb: support 2D acceleration on SM712
 w/ Little-Endian CPU.
Message-ID: <20190401162618.GB15736@localhost.localdomain>
References: <20190322051759.15007-1-tomli@tomli.me>
 <20190322051759.15007-4-tomli@tomli.me>
 <20190331180947.s44eznujdeucnl7f@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190331180947.s44eznujdeucnl7f@debian>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 07:09:47PM +0100, Sudip Mukherjee wrote:
> On Fri, Mar 22, 2019 at 01:17:55PM +0800, Yifeng Li wrote:
> I didnot notice any performace improvement in my system. Infact, I have
> never seen the performance problem that you mentioned. But, it will be
> good to have the 2D feature back again.

Are you using sm712fb under the Linux tty console? If you are using X,
Qt or DirectFB or something similar, these 2D code won't have any effect
at all, because they are only used by the Linux VT console internally.
Please try testing it under a Linux tty.

Another possibility is that you are using a high-performance CPU with
high clock/bus frequencies, which writing to the framebuffer directly
can break-even/outperform the 2D acceleration. But I'm not sure about
it. Please let me know more about your setup.

> If it is a big endian, acceleration is disabled, but you are still
> calling smtcfb_reset_accel() which will "enable Zoom Video Port,
> 2D Drawing Engine and Video Processor". Will that not create any problem
> in a big endian system?

Personally, I don't think there's an issue, because smtc_seqw() only does
8-bit I/O, and is known to be safe under Big-Endian.

But I agree, calling this function should be avoided since it's not tested.

> > +	if (unlikely(info->state != FBINFO_STATE_RUNNING))
> > +		return;
> 
> Did you measure the performance difference with and without "unlikely"?
> Quoting GregKH from https://lkml.org/lkml/2018/11/7/36
> "don't do stuff like this unless you can actually measure the
> difference".

In the old days, these two macros are used liberally, everywhere. I learned
about them by reading drivers code in fbdev/. Thanks for informing me the
new policy regarding the use of them. I'll remove them.

> <snip>
> > +		 * & HIGH with 0xffffffff (all ones, and we have already set
> > +		 * that in smtcfb_init_accel). Since the color of this mono
> > +		 * pattern is controlled by DPR_FG_COLOR, BITBLTing it with
> > +		 * ROP_COPY is effectively a rectfill().
> > +		 */
> > +		smtc_dprw(DPR_FG_COLOR, color);
> > +		smtc_dprw(DPR_DST_COORDS, DPR_COORDS(dx, dy));
> 
> I will need some more time to verify all these and other registers with
> the datasheet and test again.

No problem. 

But again, the 2D code is only used by Linux VT code internally, if you are
not using VT console, the behavior cannot be tested properly. Are you testing
it under the Linux tty console? And does your dmesg log says, "2D acceleration
is enabled"?

Running the "fbtest" testsuit is also a good way to "smoke-test" the fbdev
code.

Thanks,
Tom Li
