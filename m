Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4D1C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEB722CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbfIDPMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:12:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58119 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730065AbfIDPMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:12:19 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1i5WxC-0006zY-EM; Wed, 04 Sep 2019 15:12:14 +0000
Date:   Wed, 4 Sep 2019 17:12:13 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        kernel-team <kernel-team@android.com>,
        Todd Kjos <tkjos@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v3 0/4] Add binder state and statistics to binderfs
Message-ID: <20190904151212.wolcug25ozytp4bw@wittgenstein>
References: <20190903161655.107408-1-hridya@google.com>
 <20190904111934.ya37tlzqjqvt7h6a@wittgenstein>
 <CAEXW_YSj5tdykM8txae66zd0jX_aJujrnS4jG=fHWRvCH7aR7w@mail.gmail.com>
 <20190904144903.GA30432@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190904144903.GA30432@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 04:49:03PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 04, 2019 at 10:20:32AM -0400, Joel Fernandes wrote:
> > On September 4, 2019 7:19:35 AM EDT, Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > >On Tue, Sep 03, 2019 at 09:16:51AM -0700, Hridya Valsaraju wrote:
> > >> Currently, the only way to access binder state and
> > >> statistics is through debugfs. We need a way to
> > >> access the same even when debugfs is not mounted.
> > >> These patches add a mount option to make this
> > >> information available in binderfs without affecting
> > >> its presence in debugfs. The following debugfs nodes
> > >> will be made available in a binderfs instance when
> > >> mounted with the mount option 'stats=global' or 'stats=local'.
> > >>
> > >>  /sys/kernel/debug/binder/failed_transaction_log
> > >>  /sys/kernel/debug/binder/proc
> > >>  /sys/kernel/debug/binder/state
> > >>  /sys/kernel/debug/binder/stats
> > >>  /sys/kernel/debug/binder/transaction_log
> > >>  /sys/kernel/debug/binder/transactions
> > >
> > >Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> > >
> > >Btw, I think your counting is off-by-one. :) We usually count the
> > >initial send of a series as 0 and the first rework of that series as
> > >v1.
> > >I think you counted your initial send as v1 and the first rework as v2.
> > 
> > Which is fine. I have done it both ways. Is this a rule written somewhere?
> 
> No where, I can count both ways, it's not a big deal :)

It isn't documented (as many things we still do are) and it's not a big
deal. But most people seem to be counting revisions starting from 0 it
seems. I went looking for previous version to link to in the patch cover
letter and was confused because I was missing a v1. :)

Anyway, I'm happy that Hridya landed this! It was fun helping her the
last couple of weeks on- and off-list. Thanks for getting this done! I
hope we'll see even more patches in the future. :)

Christian
