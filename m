Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9615DC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621CA2168B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567608548;
	bh=RPE8b67fmubiSZrCTV7LHouX1oUclLHCZWI7Yt8Bx6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kjt7iBh/s4ao1ZiLT78M6CusY8W+mWCuVZaKbb7frfEvmiZXfkgoiwa+0fpWPj1mH
	 7PNFXkTynPeYai15WEPRJTAz4pm26i3/m+aP30ncDEJnGpWJj/vA2FjWiYmp8sARs1
	 LqelN3hUzjxWGFzltyer6vEhEjNPslBqVFbNRAS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbfIDOtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 10:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbfIDOtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:49:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA5DE208E4;
        Wed,  4 Sep 2019 14:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567608546;
        bh=RPE8b67fmubiSZrCTV7LHouX1oUclLHCZWI7Yt8Bx6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zzUV5wdJcf55ru/t69XtJzcn8Z/+XSbF6iZR7S54V7oL4gSfkcoVrRSfRE4JduwXE
         TCci2o+DOh0CCKrDDl3bXZcyiR4VFEm+y//A7k2j3GSvvAugEiUoMLoZRUEf3RYkXK
         vJgR1S9BEPYMOEKn875B6HrQtv2oinTx8EDGkSs0=
Date:   Wed, 4 Sep 2019 16:49:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Hridya Valsaraju <hridya@google.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        kernel-team <kernel-team@android.com>,
        Todd Kjos <tkjos@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v3 0/4] Add binder state and statistics to binderfs
Message-ID: <20190904144903.GA30432@kroah.com>
References: <20190903161655.107408-1-hridya@google.com>
 <20190904111934.ya37tlzqjqvt7h6a@wittgenstein>
 <CAEXW_YSj5tdykM8txae66zd0jX_aJujrnS4jG=fHWRvCH7aR7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YSj5tdykM8txae66zd0jX_aJujrnS4jG=fHWRvCH7aR7w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 10:20:32AM -0400, Joel Fernandes wrote:
> On September 4, 2019 7:19:35 AM EDT, Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >On Tue, Sep 03, 2019 at 09:16:51AM -0700, Hridya Valsaraju wrote:
> >> Currently, the only way to access binder state and
> >> statistics is through debugfs. We need a way to
> >> access the same even when debugfs is not mounted.
> >> These patches add a mount option to make this
> >> information available in binderfs without affecting
> >> its presence in debugfs. The following debugfs nodes
> >> will be made available in a binderfs instance when
> >> mounted with the mount option 'stats=global' or 'stats=local'.
> >>
> >>  /sys/kernel/debug/binder/failed_transaction_log
> >>  /sys/kernel/debug/binder/proc
> >>  /sys/kernel/debug/binder/state
> >>  /sys/kernel/debug/binder/stats
> >>  /sys/kernel/debug/binder/transaction_log
> >>  /sys/kernel/debug/binder/transactions
> >
> >Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> >
> >Btw, I think your counting is off-by-one. :) We usually count the
> >initial send of a series as 0 and the first rework of that series as
> >v1.
> >I think you counted your initial send as v1 and the first rework as v2.
> 
> Which is fine. I have done it both ways. Is this a rule written somewhere?

No where, I can count both ways, it's not a big deal :)

greg k-h
