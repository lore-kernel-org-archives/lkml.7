Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE84C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31342070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387769AbfG2NgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:36:22 -0400
Received: from foss.arm.com ([217.140.110.172]:44430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387722AbfG2NgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:36:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2C5328;
        Mon, 29 Jul 2019 06:36:21 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFB1E3F71F;
        Mon, 29 Jul 2019 06:36:20 -0700 (PDT)
Date:   Mon, 29 Jul 2019 14:36:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Eric Biggers <ebiggers@google.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: syzbot bisection analysis
Message-ID: <20190729133618.GG2368@arrakis.emea.arm.com>
References: <CACT4Y+Y3nN=nLEkHXLFcX7vxp_vs1JrD=8auJ3cX9we6TQHO+w@mail.gmail.com>
 <CACT4Y+YXQBF1QQwEPEkR3b3-RoeZw_We5B-o_71xxc9HMSyTdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YXQBF1QQwEPEkR3b3-RoeZw_We5B-o_71xxc9HMSyTdw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Mon, Jul 29, 2019 at 01:08:16PM +0200, Dmitry Vyukov wrote:
> The remaining 10 were all diverged due to other unrelated memory leaks
> and other non-leak bugs. It seems the main 2 reasons for this:
> 1. Lots of leaks are old (kernel is under-tested with KMEMLEAK).
> 2. Lots of unrelated bugs.
> It's unclear how much KMEMLEAK potential for false positives is in
> play. For example, lots of bisections are diverged by "memory leak in
> batadv_tvlv_handler_register", but this is a true bug reported at:
> https://syzkaller.appspot.com/bug?id=0654529ad3cc1d67a6d9812d8b75489c03dfb983
> However, some are diverged by e.g. "memory leak in __neigh_create" and
> "memory leak in copy_process" and these were not reported as separate
> leaks, so either false positives or true leaks fixed in previous
> releases.

Out of curiosity, when the tool tries to bisect a memory leak, does it
check for precisely that leak (e.g. by function name, object size) or
any other unrelated leak can confuse the bisection?

-- 
Catalin
