Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31F4C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70EC720811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553654127;
	bh=1r3fdl+UtL2+YxlwOVs9Pnn+Om8fHtKWrWnR5n6i8Ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cCNMdsT8Cn+S7jfVF/j3NUxZECc35bs9VV2Qkp1A/4hg6XY0yDT5wyEUFckA86I+/
	 qxevZTD3E9w70RM7yjx0NI/+elnKAIejpsk0otjuW4qrhJwIf85PCPnOIaGROVuUzr
	 93BzvBrozeT3ewX6ky8nKopE9GumCRD6yHeY147c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732843AbfC0Cf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 22:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732018AbfC0Cf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 22:35:26 -0400
Received: from localhost (mobile-166-137-177-030.mycingular.net [166.137.177.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 869A020811;
        Wed, 27 Mar 2019 02:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553654125;
        bh=1r3fdl+UtL2+YxlwOVs9Pnn+Om8fHtKWrWnR5n6i8Ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A8rKYcu8z5ztGRzeH31XPPvIXlUtRYHdYRcG4JhblIKYOWQmD5z9p+5SUhky3CCcg
         ZuQRrySzsDDTPKgzEyItqwRL05RYP271xgxnDUxB9Pmh+uqFTYcQjf8BcCPMPOMzaz
         kemnsoImSqzSidRr9Bb5WOUIRLaokobu69gnHiPs=
Date:   Wed, 27 Mar 2019 11:35:20 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Garrett <mjg59@google.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH V31 25/25] debugfs: Disable open() when kernel is locked
 down
Message-ID: <20190327023520.GA20766@kroah.com>
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-26-matthewgarrett@google.com>
 <20190327003130.GB27311@kroah.com>
 <CACdnJuvBJmCRnzT=4qh9cmNkRNHi3Xfha5xqUqYu8cgCRrtsqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdnJuvBJmCRnzT=4qh9cmNkRNHi3Xfha5xqUqYu8cgCRrtsqQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 07:06:36PM -0700, Matthew Garrett wrote:
> On Tue, Mar 26, 2019 at 5:31 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Tue, Mar 26, 2019 at 11:27:41AM -0700, Matthew Garrett wrote:
> > > From: Matthew Garrett <mjg59@google.com>
> > >
> > > debugfs has not been meaningfully audited in terms of ensuring that
> > > userland cannot trample over the kernel. At Greg's request, disable
> > > access to it entirely when the kernel is locked down. This is done at
> > > open() time rather than init time as the kernel lockdown status may be
> > > made stricter at runtime.
> 
> (snip)
> 
> > Why allow all this, why not just abort the registering of the filesystem
> > with the vfs core so it can't even be mounted?
> 
> As mentioned in the commit message, because the lockdown state can be
> made stricter at runtime - blocking at mount time would be
> inconsistent if the machine is locked down afterwards. We could
> potentially assert that it's the admin's responsibility to ensure that
> debugfs isn't mounted at the point of policy being made stricter?

Ugh, I can not read, sorry, neverind.

The patch is fine as-is.

greg k-h
