Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D80C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4593207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfI0NTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 09:19:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40935 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfI0NTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 09:19:16 -0400
Received: from [65.39.69.237] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iDq9R-0000R4-Fn; Fri, 27 Sep 2019 13:19:13 +0000
Date:   Fri, 27 Sep 2019 15:19:12 +0200
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
Message-ID: <20190927131912.pg7xtyfforiettgx@wittgenstein>
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

I'm sitting in a talk from Jonathan about kernel documentation and what
I realized is that we forgot to update the documentation I wrote for
binderfs in Documentation/admin-guide/binderfs.rst to reflect the new
stats=global mount option. Would be great if we could add that after rc1
is out. Would you have time to do that, Hridya?

Should just be a new entry under:

Options
-------
max
  binderfs instances can be mounted with a limit on the number of binder
  devices that can be allocated. The ``max=<count>`` mount option serves as
  a per-instance limit. If ``max=<count>`` is set then only ``<count>`` number
  of binder devices can be allocated in this binderfs instance.
stats
  <description>

Thanks!
Christian
