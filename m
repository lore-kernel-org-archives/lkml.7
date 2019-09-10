Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C847FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97ED9216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568116507;
	bh=iQP6fsprLGcrFxmrVEu4EOZ1enga5prOit1bUnAqVfY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vL+9opPEQpg2wx64PRVbD5qyJbUZ/l7/apNNwcpYIfV1Psb81vjJm0UJREUVS8ouk
	 kI6I169Mo9VqkfCTud1tEaCR9aKbfaAB+xOIRcZo3Kn+P8X0XUMTun4DPFo6ZPU34M
	 qMwzWy2sXNEJ4XVs0k9nGRzJE2rDnRXeP1L6HGzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbfIJLzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 07:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbfIJLzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:55:06 -0400
Subject: Re: [GIT PULL] ipc: fix regressions from y2038 patches
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568116506;
        bh=iQP6fsprLGcrFxmrVEu4EOZ1enga5prOit1bUnAqVfY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JCfJwv6Vl91ADLeVjaf+OgDr6DzOrxBB3+to8TARj4srYw5zVFGgP7KiO0X+DZ0PH
         b1YI+Xsau3HNbwgWXm4vONGfEjWoo2d6tBhEBfqaNI1UmWcWhexfo4b5CSoflI4rZv
         dFdvSqjTCXbzsfqSWeMkRIm/jtIY9NUvnnTtpfvA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a1Q0ec50n2ueWDKHirpem+SQvsv3sYXzw9EFRqXiUqxUg@mail.gmail.com>
References: <CAK8P3a1Q0ec50n2ueWDKHirpem+SQvsv3sYXzw9EFRqXiUqxUg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a1Q0ec50n2ueWDKHirpem+SQvsv3sYXzw9EFRqXiUqxUg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
 tags/ipc-fixes
X-PR-Tracked-Commit-Id: fb377eb80c80339b580831a3c0fcce34a4c9d1ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3120b9a6a3f7487f96af7bd634ec49c87ef712ab
Message-Id: <156811650600.2184.136295943395140110.pr-tracker-bot@kernel.org>
Date:   Tue, 10 Sep 2019 11:55:06 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Anatoly Pugachev <matorola@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guo Ren <guoren@kernel.org>, Stafford Horne <shorne@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Manfred Spraul <manfred@colorfullife.com>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 10 Sep 2019 11:49:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/ipc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3120b9a6a3f7487f96af7bd634ec49c87ef712ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
