Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FFFC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51E4208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556051003;
	bh=3DCq5Zb34EW+i8Yo2tYYjrRyG/OsGSpKDjB2lXOW8iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t4plAWqQsFfcT4BO1dlH2o9KA4VW6TQVy51RK7KdYqfiy749WlmPMxtMtlFF9+84V
	 L8KcI3gWm2USwHvSnhrjgvP1IpqRuzO1OER2pxhFjWgZUWCWRvcF6ZskKt0nR7lyKI
	 QcNe0LrxAWH00hXK093PfRkBXDyoJCp1nB7MVuM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfDWUXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:23:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfDWUXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:23:21 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC672208E4;
        Tue, 23 Apr 2019 20:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556051000;
        bh=3DCq5Zb34EW+i8Yo2tYYjrRyG/OsGSpKDjB2lXOW8iw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lautUO6dIfcSwgCJla2xfSHVh/5KMIURRnVoRcGgDcVtW6jaS11XVTjQ1FoyJSQ0U
         Xo/18cKA7iwaU7e2qedm6dlyp0iupplUIHzqBjNTvg4Y2ZHlQ4v856qApaCXCNKnh4
         pakwkUa4Qkpc+EJorQFN64fYJ9Z3PJ/4waZr0XhY=
Date:   Tue, 23 Apr 2019 22:23:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION 5.0.x] Windows XP broken on KVM
Message-ID: <20190423202317.GA15182@kroah.com>
References: <s5hy347pxtf.wl-tiwai@suse.de>
 <f1b93e90-edf2-f3ba-4d94-652929e6cca6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1b93e90-edf2-f3ba-4d94-652929e6cca6@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 09:56:02AM +0200, Paolo Bonzini wrote:
> On 18/04/19 09:38, Takashi Iwai wrote:
> > Hi,
> > 
> > we've got a regression report on the recent 5.0.x kernel, starting
> > from 5.0.6, where Windows XP can't boot on KVM any longer.
> > 
> > The culprit seems to be the patch
> >    KVM: x86: update %rip after emulating IO
> > with the upstream commit 45def77ebf79e2e8942b89ed79294d97ce914fa0.
> > Reverting this alone fixed the problem.
> > 
> > The report is found at openSUSE bugzilla:
> >   https://bugzilla.suse.com/show_bug.cgi?id=1132694
> > 
> > Is there already a followup fix?  If not, we need to revert it from
> > stable, at least.
> 
> No, it's the first time I hear this and I actually test Windows XP
> before every pull request I send to Linus...  I'll download 5.0.x and
> test it there.

Any further ideas about this?

thanks,

greg k-h
