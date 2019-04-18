Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94750C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8072183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555574013;
	bh=5N4XnBnp+soefsrzhGXOMdydGFtjZWDwX3Nps2n7GqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cs8fMS2OQ/7nq8x7M2xepxNN2AUb/K6zv2w7PTOmrmEwqWvgvB9AvzDkeoPi7umFD
	 hdOFjM0xNZD+peahYyBFVEwh9Qb1JdwOXrJ3/N4Ka4v+EahOgUgp7WrHzfykRvOhYX
	 gKkLDU0hTt3RP94rZbe62k9ME6gh4q/9MFCrvSZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388211AbfDRHxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 03:53:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfDRHxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 03:53:31 -0400
Received: from localhost (unknown [178.227.254.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09D7C2183E;
        Thu, 18 Apr 2019 07:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555574011;
        bh=5N4XnBnp+soefsrzhGXOMdydGFtjZWDwX3Nps2n7GqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=prIwfjA8WQ5KkCyrDrS9eMVv0436CiF9Dli+rmnLdcWLjx7wzAnoe6jTg9UJZEkYy
         F9RJJLwgEDFSOMExVJSxwbI9og6TMirQGjeCWZ2in2YiCazZ8Y0SXHf+01OM/WX1HE
         4F8oBEpo39KVJ0w7vanKhLx0qwCoI8fS2PmVZW5s=
Date:   Thu, 18 Apr 2019 09:53:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION 5.0.x] Windows XP broken on KVM
Message-ID: <20190418075328.GA19532@kroah.com>
References: <s5hy347pxtf.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hy347pxtf.wl-tiwai@suse.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 09:38:52AM +0200, Takashi Iwai wrote:
> Hi,
> 
> we've got a regression report on the recent 5.0.x kernel, starting
> from 5.0.6, where Windows XP can't boot on KVM any longer.
> 
> The culprit seems to be the patch
>    KVM: x86: update %rip after emulating IO
> with the upstream commit 45def77ebf79e2e8942b89ed79294d97ce914fa0.
> Reverting this alone fixed the problem.
> 
> The report is found at openSUSE bugzilla:
>   https://bugzilla.suse.com/show_bug.cgi?id=1132694
> 
> Is there already a followup fix?  If not, we need to revert it from
> stable, at least.

Is this also a problem in 5.1-rc5?

Those KVM tests being integrated by Linaro into the stable testing
process can't come fast enough, I was told yesterday that they would be
in there "soon"...

thanks,

greg k-h
