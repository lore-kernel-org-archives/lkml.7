Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337E6CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045F620862
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572690920;
	bh=mbxbLsNycQLuE8Rszlxz5umA/C2he7utVAFoZom6eio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dQsjK/rWcjL51mI6rGjAfPZXmgQvD2Z/eec9fc9+9DwpEQvGXPmCkmBd0BNIY95JZ
	 BSqeE9r7jaQokgS4VI7AiP8Jq03xYOK+3ZWS9U+zHfcBvWT9wTJ5/pX4EAeHDnWJuK
	 7iZFGwoJKdGGk9Tcm1iGGzcDvfaFqt1r1ntX3nhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfKBKfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 06:35:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfKBKfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 06:35:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 577EA20679;
        Sat,  2 Nov 2019 10:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572690917;
        bh=mbxbLsNycQLuE8Rszlxz5umA/C2he7utVAFoZom6eio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mnnZp8cgHwOL3Bklw15NKTAPy0z0ECSizzfhfDLGYPmHX8YE6yC4hExGqCyYunR2/
         wfcqjzLuC8+/U1jXFDDHTPo996opRuMc04Iw41Ox8Xot2gY+Ef+llKYx45ZvyzYnd5
         OetJZrUISpIrSB6ZYWKL8fkhh8dBRKx9lX1XU7xE=
Date:   Sat, 2 Nov 2019 11:35:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     eric@anholt.net, wahrenst@gmx.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] staging: vc04_services: replace
 g_free_fragments_mutex with spinlock
Message-ID: <20191102103515.GA135926@kroah.com>
References: <20191028165909.GA469472@kroah.com>
 <20191101182949.21225-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101182949.21225-1-dave@stgolabs.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 11:29:49AM -0700, Davidlohr Bueso wrote:
> There is no need to be using a semaphore, or a sleeping lock
> in the first place: critical region is extremely short, does not
> call into any blocking calls and furthermore lock and unlocking
> operations occur in the same context.
> 
> Get rid of another semaphore user by replacing it with a spinlock.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> This is in an effort to further reduce semaphore users in the kernel.
> 
> This is a resend, which just seems simpler given the confusions.
> 
>  .../staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

This patch does not apply to my tree at all, what did you make it
against?

Please fix up and resend.

thanks,

greg k-h
