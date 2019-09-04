Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB51C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC2522CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfIDLTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 07:19:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51371 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfIDLTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:19:38 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1i5TK3-0005LA-Qr; Wed, 04 Sep 2019 11:19:35 +0000
Date:   Wed, 4 Sep 2019 13:19:35 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Hridya Valsaraju <hridya@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 0/4] Add binder state and statistics to binderfs
Message-ID: <20190904111934.ya37tlzqjqvt7h6a@wittgenstein>
References: <20190903161655.107408-1-hridya@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190903161655.107408-1-hridya@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 09:16:51AM -0700, Hridya Valsaraju wrote:
> Currently, the only way to access binder state and
> statistics is through debugfs. We need a way to
> access the same even when debugfs is not mounted.
> These patches add a mount option to make this
> information available in binderfs without affecting
> its presence in debugfs. The following debugfs nodes
> will be made available in a binderfs instance when
> mounted with the mount option 'stats=global' or 'stats=local'.
> 
>  /sys/kernel/debug/binder/failed_transaction_log
>  /sys/kernel/debug/binder/proc
>  /sys/kernel/debug/binder/state
>  /sys/kernel/debug/binder/stats
>  /sys/kernel/debug/binder/transaction_log
>  /sys/kernel/debug/binder/transactions

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Btw, I think your counting is off-by-one. :) We usually count the
initial send of a series as 0 and the first rework of that series as v1.
I think you counted your initial send as v1 and the first rework as v2. :)

Christian

> 
> Hridya Valsaraju (4):
>   binder: add a mount option to show global stats
>   binder: Add stats, state and transactions files
>   binder: Make transaction_log available in binderfs
>   binder: Add binder_proc logging to binderfs
> 
>  drivers/android/binder.c          |  95 ++++++-----
>  drivers/android/binder_internal.h |  84 ++++++++++
>  drivers/android/binderfs.c        | 255 ++++++++++++++++++++++++++----
>  3 files changed, 362 insertions(+), 72 deletions(-)
> 
> -- 
> 2.23.0.187.g17f5b7556c-goog
> 
