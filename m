Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDF0C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D2520863
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568209738;
	bh=2ZAB+MxpAQ5hJTPfjiPVljlb21WGGQdhzccadL1cdPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=t6pCRsweYzfLdKTer0+dQxN2ZDS/jdynWQHB601NxZAac8Fd/X3IN756myW+RZmfp
	 sZTR+FSKtImHCq2njX4v3iBxjCteB+h+6dUjMuC5Qd9apyLE8/IqJv+rX2wyKJtvDX
	 7MVMhHalMMVY0+9dzlbroZ5objvYI1Q6Vtsu1By0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfIKNs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 09:48:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbfIKNs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:48:57 -0400
Received: from X1 (110.8.30.213.rev.vodafone.pt [213.30.8.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13A6A206CD;
        Wed, 11 Sep 2019 13:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568209737;
        bh=2ZAB+MxpAQ5hJTPfjiPVljlb21WGGQdhzccadL1cdPs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yLZdyRICT5fdlJII7PdUmXMGmuN7rE8UOq/X4b1M1Mpki/JS7/vsvXA8KvGSmfXRb
         jdUZ+fJGg7XWaumbFjMoLNPNSgI6vV8coA/RvRaB4MIVKWhLbSSnuJXg/hxy99xE1y
         9NYp9yLP20fZWnh+XuV1Bb7QYStdGeHy0gcvEPf4=
Date:   Wed, 11 Sep 2019 06:48:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v2] fork: check exit_signal passed in clone3() call
Message-Id: <20190911064852.9f236d4c201b50e14d717c14@linux-foundation.org>
In-Reply-To: <20190910175852.GA15572@asgard.redhat.com>
References: <20190910175852.GA15572@asgard.redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2019 18:58:52 +0100 Eugene Syromiatnikov <esyr@redhat.com> wrote:

> Previously, higher 32 bits of exit_signal fields were lost when
> copied to the kernel args structure (that uses int as a type for the
> respective field).  Moreover, as Oleg has noted[1], exit_signal is used
> unchecked, so it has to be checked for sanity before use; for the legacy
> syscalls, applying CSIGNAL mask guarantees that it is at least non-negative;
> however, there's no such thing is done in clone3() code path, and that can
> break at least thread_group_leader.
> 
> Checking user-passed exit_signal against ~CSIGNAL mask solves both
> of these problems.
> 
> [1] https://lkml.org/lkml/2019/9/10/467
> 
> * kernel/fork.c (copy_clone_args_from_user): Fail with -EINVAL if
> args.exit_signal has bits set outside CSIGNAL mask.
> (_do_fork): Note that exit_signal is expected to be checked for the
> sanity by the caller.
> 
> Fixes: 7f192e3cd316 ("fork: add clone3")

What are the user-visible runtime effects of this bug?

Relatedly, should this fix be backported into -stable kernels?  If so, why?

