Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D1BC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CA12089C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561185360;
	bh=2M2TctF/awe+GqGVE+YdGFDJ21jEiTiXI2cZXGmS1DY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nNogVujQBgEjZB1IMu6XbxYqu2hHAGbj/Bj96FsYhkcqrPHX56v7r4sArc+S7nWCk
	 zXJwqtxBScSGBwDqqMJFPF83BzDt4UpSqC/RrwzH4oVwYrAqyMsZMxZNwcAqsvKVq6
	 MSOE+zT5l37au6/f7FIaq7IrQqIBAwAKlwSk99uQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfFVGfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 02:35:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbfFVGfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:35:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F32E2089C;
        Sat, 22 Jun 2019 06:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561185354;
        bh=2M2TctF/awe+GqGVE+YdGFDJ21jEiTiXI2cZXGmS1DY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zLPfPOXKAjTpc3HJ5yCFQ9Uqg+sVXaWqlnkvxBLROXuOkMI83x8+tM9nsaUIJLcl8
         N4lyzC/odQhVY1h4RleWGau5TvRhbsOQCP/YyowAc3qQyQlcK5Xa0qEAKunf3rKVnC
         Mo9aDlDcSvwT3gQGuqZtX7IkHCG2+qJSLFHkkWm8=
Date:   Sat, 22 Jun 2019 08:35:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Eric Dumazet <edumazet@google.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Steam is broken on new kernels
Message-ID: <20190622063551.GA6457@kroah.com>
References: <a624ec85-ea21-c72e-f997-06273d9b9f9e@valvesoftware.com>
 <20190621214139.GA31034@kroah.com>
 <CAHk-=wgXoBMWdBahuQR9e75ri6oeVBBjoVEnk0rN1QXfSKK2Eg@mail.gmail.com>
 <CANn89iL5+x3n9H9v4O6y39W=jvQs=uuXbzOvN5mBbcj0t+wdeg@mail.gmail.com>
 <CAHk-=wjZ=8VSjWuqeG6JJv4dQfK6M0Jgckq5-6=SJa25aku-vQ@mail.gmail.com>
 <CANn89iLU+NNy7QDPNLYPxNWMx5cXuhziOT7TX2uYt42uUJcNVg@mail.gmail.com>
 <b72599d1-b5d5-1c23-15fc-8e2f9454af05@valvesoftware.com>
 <CAHk-=wjZ1grLwJsGD+Fjz1_U_W47AFodBiwBX84HECUHt-guuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjZ1grLwJsGD+Fjz1_U_W47AFodBiwBX84HECUHt-guuw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 10:28:21PM -0700, Linus Torvalds wrote:
> On Fri, Jun 21, 2019 at 6:03 PM Pierre-Loup A. Griffais
> <pgriffais@valvesoftware.com> wrote:
> >
> > I applied Eric's path to the tip of the branch and ran that kernel and
> > the bug didn't occur through several logout / login cycles, so things
> > look good at first glance. I'll keep running that kernel and report back
> > if anything crops up in the future, but I believe we're good, beyond
> > getting distros to ship this additional fix.
> 
> Good. It's now in my tree, so we can get it quickly into stable and
> then quickly to distributions.
> 
> Greg, it's commit b6653b3629e5 ("tcp: refine memory limit test in
> tcp_fragment()"), and I'm building it right now and I'll push it out
> in a couple of minutes assuming nothing odd is going on.

Thanks, I will pick it up now.

greg k-h
