Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCE4C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 17:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D82420C01
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 17:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="PMzG834B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfG2Rz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 13:55:26 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42916 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbfG2Rz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 13:55:26 -0400
Received: by mail-io1-f66.google.com with SMTP id e20so91581785iob.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 10:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MqysGs2wJQ27T3E0UkpU/38wEwSuPNyfGQLAm9TTFME=;
        b=PMzG834BkEwNbhE0Ni5x0gdP+WLIy668TPoJWGvzWjaFN8k89yH5TW5BZ3lxnQppkJ
         4PsiMsX26M0D1BNsafwNC8s4syT6ewSa/lWzz3nrYC+++tPvxgK1dX1UhW7MdZsUZF3A
         T2bidHaD7FeklP6YCBKBnG73hqFMAeOKdiB4scOIjigzuA+7Bz0YqP1HwF61onLwG4Sc
         B3w5SMJQPrprSKJhn09MmyIby5sReSrrSh9ViLLoejiPwYgc4izELYns61sh/WTt9+Lz
         yirNAFtGlo2RzXPaFMInyFeq7Y8zzau9m5bpMHeGMNq7EN15w5u8d1kFyhXwGXYLQBRm
         dR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MqysGs2wJQ27T3E0UkpU/38wEwSuPNyfGQLAm9TTFME=;
        b=mbZAv5vfhTfPF0rQXprEnBNBP3fK1YmAr/5Pj0/r9fz/MXkicMRDgrWamDtL+PsDXU
         /ZFutEQpDYrCLuP67Hb38UMx4wDiLFxPS2B88nibUX5JWlZs4lOQFL2Qowk3t1cJ4b0M
         2JLze8cldBR0C6NZR2XVgWl/QE36A0AbkCTrcZwfhEPza8y1zAeChIeim8uP2W5RK+yZ
         n0J7Y0ErW4Yif/pxILeiXIl1jM21F0g902AX5xP3OwOfonHDSLVk3CyBeWqbq5DlqV1M
         wbDUUfJ3RsMmTf7Boj5TLHhyCHJXHDqCGjhye03VsT8yHgUv0AeUyGq8nffY1u8hHUYs
         2NNA==
X-Gm-Message-State: APjAAAXnbIWfUv8IHa8AW9wiBlYLrxdjx94Ml3hPMnlQIa2T8M7tdDHf
        QJ9D3oyexeQYXX2/0kqAe3c=
X-Google-Smtp-Source: APXvYqygdeACRRKJXvbicjMbhZweRLw3Jgcb1SQ8k1GPtrYsH0GPLozHJROS6ublebOCArv4Zd4L2A==
X-Received: by 2002:a6b:ea0f:: with SMTP id m15mr9993385ioc.300.1564422925602;
        Mon, 29 Jul 2019 10:55:25 -0700 (PDT)
Received: from brauner.io ([162.223.5.124])
        by smtp.gmail.com with ESMTPSA id t4sm47335263iop.0.2019.07.29.10.55.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 10:55:25 -0700 (PDT)
Date:   Mon, 29 Jul 2019 19:55:23 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, oleg@redhat.com,
        torvalds@linux-foundation.org, arnd@arndb.de,
        ebiederm@xmission.com, joel@joelfernandes.org, tglx@linutronix.de,
        tj@kernel.org, dhowells@redhat.com, jannh@google.com,
        luto@kernel.org, akpm@linux-foundation.org, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, kernel-team@android.com
Subject: Re: [PATCH v3 2/2] pidfd: add pidfd_wait tests
Message-ID: <20190729175523.5mca4wnmoldu2olp@brauner.io>
References: <20190727222229.6516-1-christian@brauner.io>
 <20190727222229.6516-3-christian@brauner.io>
 <201907290929.09B5189@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201907290929.09B5189@keescook>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 09:31:23AM -0700, Kees Cook wrote:
> On Sun, Jul 28, 2019 at 12:22:30AM +0200, Christian Brauner wrote:
> > Add tests for pidfd_wait() and CLONE_WAIT_PID:
> > - test that waitid(P_PIDFD) can wait on a pidfd
> > - test that waitid(P_PIDFD) can wait on a pidfd and return siginfo_t
> > - test that waitid(P_PIDFD) works with WEXITED
> > - test that waitid(P_PIDFD) works with WSTOPPED
> > - test that waitid(P_PIDFD) works with WUNTRACED
> > - test that waitid(P_PIDFD) works with WCONTINUED
> > - test that waitid(P_PIDFD) works with WNOWAIT
> > - test that waitid(P_PIDFD)works with WNOHANG
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> This all looks good to me! :) One note that doesn't apply to this patch
> in particular, but might be nice to add (as I didn't see in the existing
> tests) was testing for pathological conditions: passing in /dev/zero for
> the pidfd, etc. (Maybe I missed those?)

Yeah, I can probably just add one for this scenario. :)

Thanks!
Christian
