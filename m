Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9F4C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8D82080C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561032507;
	bh=Hu4fjtFx9KYIeiMqIRLLcDpAkiZGrzLLCm4nvrd1BlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=abyB1+raUCku1WA/apCBv4nWk6pcOZclRpitGodAT94OQjZzVgjdktxZv6mzAPvR0
	 d1pyIpY6LWq9n91164FG/hebbob0UToqKFrewlFtaBT20pCndM1eC7GOsgU3FxJWdL
	 faAHHr/YGgCucKaFDknuXNWuYncU7Uljt9mmnjW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbfFTMIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 08:08:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730596AbfFTMIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 08:08:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E93232080C;
        Thu, 20 Jun 2019 12:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561032504;
        bh=Hu4fjtFx9KYIeiMqIRLLcDpAkiZGrzLLCm4nvrd1BlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rjWHoVLcgcLJJhpkJqHXWS2v8WcGC+lV6YhSOop3h+Nk7YF56eMv0f5noITVKDEA+
         14PRPi37MfxDDUB0wuAiwZ9BIG3tfTVcTFjwhO3JqOjSHOX8Pnz+49ZiQQTGWGYy39
         OYuXXRvq0dEsC5uqoyZKUOglPkYgSZOdYjBnq5Xg=
Date:   Thu, 20 Jun 2019 14:08:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: remove redundant 'default n' from Kconfig-s
Message-ID: <20190620120821.GA19295@kroah.com>
References: <CGME20190520141434eucas1p266520a2ef8db42b3deee004e1cba3a1f@eucas1p2.samsung.com>
 <79726177-d524-4f83-eeb2-18ae9b2e50cf@samsung.com>
 <874l4ngxl5.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874l4ngxl5.fsf@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 10:29:58AM +0300, Felipe Balbi wrote:
> Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> writes:
> 
> > 'default n' is the default value for any bool or tristate Kconfig
> > setting so there is no need to write it explicitly.
> >
> > Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
> > is not set' for visible symbols") the Kconfig behavior is the same
> > regardless of 'default n' being present or not:
> >
> >     ...
> >     One side effect of (and the main motivation for) this change is making
> >     the following two definitions behave exactly the same:
> >     
> >         config FOO
> >                 bool
> >     
> >         config FOO
> >                 bool
> >                 default n
> >     
> >     With this change, neither of these will generate a
> >     '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
> >     That might make it clearer to people that a bare 'default n' is
> >     redundant.
> >     ...
> >
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> Fine by me. Greg if you want to take this directly (since it touches
> things all over the place):
> 
> Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> 
> If you prefer that I put this in my pull request to you, just let me know.

I think I already took this :)
