Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4397C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE2B2084B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561018365;
	bh=684dG/Qb4pd0Qep2VF5lKmVvY49DtL5QS1MEmJHfn+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WFIsMCTzQqLwI3iUwqTNUro1FnGxnhz0Uo532rt7VQVp1d8/S204JE6eU817U/L96
	 ZyrtrlDHpYtWPYS874siErGoVcTP/gPYwUU7PleZD7hAjLDLlHf7wEMlpESy2JH8Nj
	 EpFV9RHXbR5ma8jXgPENu40Ea3ShM0T4YnWlSAwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbfFTIMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 04:12:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfFTIMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:12:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41C992084B;
        Thu, 20 Jun 2019 08:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561018362;
        bh=684dG/Qb4pd0Qep2VF5lKmVvY49DtL5QS1MEmJHfn+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zl7+0jzHJdyogSAnJRJllBM5NEq6L1SctwnZFHaOSff6w8JYoyn93btn+AIGldECL
         0iHyYGK74xJn1am6iLM9fZezE/T74z70J1oVqvLC3dILX9UnxGQdRtAP7C4z5lbdcF
         NTRqeAU2ksziT8IhUOgd704RM7XJUWmlAwu+vPjs=
Date:   Thu, 20 Jun 2019 10:12:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] Automatically choose a bigger font for high
 resolution screens
Message-ID: <20190620081240.GA17630@kroah.com>
References: <20190618203425.10723-1-tiwai@suse.de>
 <20190620062821.GA20578@kroah.com>
 <s5hzhmcem7a.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hzhmcem7a.wl-tiwai@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 09:43:21AM +0200, Takashi Iwai wrote:
> On Thu, 20 Jun 2019 08:28:21 +0200,
> Greg Kroah-Hartman wrote:
> > 
> > On Tue, Jun 18, 2019 at 10:34:22PM +0200, Takashi Iwai wrote:
> > > Hi,
> > > 
> > > this is an RFC patch for automatically selecting a bigger font for
> > > high resolution monitors if available.  Although we recently got a
> > > 16x32 sized font support in the kernel, using it still requires some
> > > extra kernel option.  This patch reduces this and the kernel will pick
> > > up a bigger font.
> > > 
> > > The logic is simply checking the text screen size.  If it's over a
> > > threshold, the penalty is given to the function that chooses the
> > > default font.
> > > 
> > > The threshold was chosen so that the normal display up to Full HD
> > > won't be affected.
> > > 
> > > There are two preliminary patches and they are merely cleanups.  They
> > > can be applied no matter whether to take the last patch or not.
> > 
> > I applied the first two patches, as they seem sane.
> 
> Thanks!
> 
> > I like the idea of the last one, and have no objections to it.  I can
> > apply it too if you want and we can see what happens :)
> 
> OK, then let's go ahead.  We can see what people react if they can
> read a kernel crash message without glasses :)

Now applied, thanks.

greg k-h
