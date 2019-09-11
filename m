Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9111DC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 14:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD0A21D79
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 14:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfIKOyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 10:54:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60067 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbfIKOyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 10:54:52 -0400
Received: from [148.69.85.38] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1i841A-0003CG-8l; Wed, 11 Sep 2019 14:54:48 +0000
Date:   Wed, 11 Sep 2019 16:54:47 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v2] fork: check exit_signal passed in clone3() call
Message-ID: <20190911145446.vkcqy2shldi5ibb5@wittgenstein>
References: <20190910175852.GA15572@asgard.redhat.com>
 <20190911064852.9f236d4c201b50e14d717c14@linux-foundation.org>
 <20190911135236.73l6icwxqff7fkw5@wittgenstein>
 <20190911141635.lafrcjwvbhjm3ezy@wittgenstein>
 <20190911143213.GB21600@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190911143213.GB21600@asgard.redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 03:32:13PM +0100, Eugene Syromiatnikov wrote:
> On Wed, Sep 11, 2019 at 04:16:36PM +0200, Christian Brauner wrote:
> > On Wed, Sep 11, 2019 at 03:52:36PM +0200, Christian Brauner wrote:
> > > On Wed, Sep 11, 2019 at 06:48:52AM -0700, Andrew Morton wrote:
> > > > What are the user-visible runtime effects of this bug?
> 
> The userspace can set -1 as an exit_signal, and that will break process
> signalling and reaping.
> 
> > > > Relatedly, should this fix be backported into -stable kernels?  If so, why?
> > > 
> > > No, as I said in my other mail clone3() is not in any released kernel
> > > yet. clone3() is going to be released in v5.3.
> > 
> > Sigh, I spoke to soon... Hm, this is placed in _do_fork(). There's a
> > chance that this might be visible in legacy clone if anyone passes in an
> > invalid signal greater than NSIG right now somehow, they'd now get
> > EINVAL if I'm seeing this right.
> > 
> > So an alternative might be to only fix this in clone3() only right now
> > and get this patch into 5.3 to not release clone3() with this bug from
> > legacy clone duplicated.
> > And we defer the actual legacy clone fix until after next merge window
> > having it stew in linux-next for a couple of rcs. Distros often pull in
> > rcs so if anyone notices a regression for legacy clone we'll know about
> > it... valid_signal() checks at process exit time when the parent is
> > supposed to be notifed will catch faulty signals anyway so it's not that
> > big of a deal.
> 
> As the patch is written, only copy_clone_args_from_user is touched (which
> is used only by clone3 and not legacy clone), and the check added

Great!

> replicates legacy clone behaviour: userspace can set 0..CSIGNAL
> as an exit_signal.   Having ability to set exit_signal in NSIG..CSIGNAL

Hm. The way I see it for clone3() it would make sense to only have <
NSIG right away. valid_signal() won't let through anything else
anyway... Since clone3() isn't out yet it doesn't make sense to
replicate the (buggy) behavior of legacy clone, right?

Christian
