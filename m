Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A657AC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754AB21530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557308974;
	bh=hAVDdhZwhoNpDubsbyOj020hxpnxyk2xV6qoztKdil8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rxQwoTDL5BK6qqzYuK/1h26w7mmrWP/m42RUqr7b7pounbWnhvhtSZ8XKEtt/Mb0f
	 H2Jm7J99pXTQ98oyPoXN1hNSQGuwXAjYC/RrQ1BBywPjV1vvLkK1e8EGJxNDPmLvhY
	 lXcUmlVUiZCDuOX2rrCUeN6carl0lxC4IwxKMUeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfEHJtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 05:49:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfEHJtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 05:49:32 -0400
Received: from localhost (unknown [84.241.196.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9860321479;
        Wed,  8 May 2019 09:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557308972;
        bh=hAVDdhZwhoNpDubsbyOj020hxpnxyk2xV6qoztKdil8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q67L2B9atMkJuw9xV/NNYRQPWvvKePPssrGv/AI+w9N7q8vf3AV+ZzYT1bSRg3HL6
         JzMbfU0ANSSfwmPN7lAS3qk6PBKRvMHmaDQSKbiB1Ykncuq0EeA5RqQO2RF/LIKJKp
         okUr8CbZH3wLaVzC4H6L3K8u3EqMx8uNs3DT6Eew=
Date:   Wed, 8 May 2019 11:49:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        devel@linuxdriverproject.org
Subject: Re: [GIT PULL] Staging/IIO driver patches for 5.2-rc1
Message-ID: <20190508094929.GC6996@kroah.com>
References: <20190507175853.GA11568@kroah.com>
 <CAHk-=wg+w5+vAo1DQrprSG8APptZ5-Kek4NL_mnr9p08vFyQrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg+w5+vAo1DQrprSG8APptZ5-Kek4NL_mnr9p08vFyQrg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 01:33:06PM -0700, Linus Torvalds wrote:
> On Tue, May 7, 2019 at 10:59 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > All of these have been in linux-next for a while with no reported
> > issues, other than an odd gcc warning for one of the new drivers that
> > should be fixed up soon.
> 
> Ok, that's truly a funky warning.
> 
> But since I don't deal well with warnings, particularly during the
> merge window, I just fixed it up in the merge.
> 
> The fix is to simply not have a bitfield base type of "unsigned char",
> and have it cross a char boundary. Instead the base type should just
> be "unsigned int".

Ah, that's how to resolve that, thanks, it wasn't obvious at all from
the odd gcc warning.

> Of course, I couldn't test my change, but it shuts the compiler up,
> and it very much looks like the right thing.

The driver author can test it out, given that it needs loads of work
anyway, whatever you did to it is fine :)

thanks,

greg k-h
