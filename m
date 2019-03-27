Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1B7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4532087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="VwKUcHV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbfC0N2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:28:06 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36602 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729607AbfC0N2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:28:06 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EFAAA1EC014B;
        Wed, 27 Mar 2019 14:28:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553693284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7qTz0uTWMtK6x7ClRm+ljT0eSvDxnKav3O9ffZ/1+lM=;
        b=VwKUcHV08ODOvFctoZKnT4kCPmBRt/65Qz2etf6IQ0oLirWzl56H3KAm4xUZSFRaO7xUC0
        3Rn8iVMGPKmxE828o5d9Lq4Z9mw/7xNCDs8U4X7vfbV3oPqHBEIQ/dkjv5enIq30sBdhAU
        gMw6Grxu5jcoFkhVR8zV3h2h5CDuef0=
Date:   Wed, 27 Mar 2019 14:28:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     syzbot <syzbot+370a6b0f11867bf13515@syzkaller.appspotmail.com>
Cc:     frederic@kernel.org, gustavo@embeddedor.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: WARNING in arch_install_hw_breakpoint
Message-ID: <20190327132805.GG32571@zn.tnic>
References: <000000000000639f6a0584d11b82@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000639f6a0584d11b82@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 11:22:06PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    fd1f297b Merge tag 'drm-fixes-2019-03-22' of git://anongit..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1574f56d200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31fb246de2a622
> dashboard link: https://syzkaller.appspot.com/bug?extid=370a6b0f11867bf13515
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1157b7cf200000
> 
> Bisection is inconclusive: the bug happens on the oldest tested release.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10ca39b3200000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=12ca39b3200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=14ca39b3200000

So I've tried running your .config in both an AMD and an Intel guest
like this:

./syz-execprog -repeat=0 repro.syz

and killed it after 30K executed programs without success in
reproducing.

Either I'm missing something and my environment doesn't match yours -
because looking at your console output it happens almost immediately
after starting - or it has been fixed in the meantime...

Hmmm.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
