Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9740CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6543B20850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389101AbfCAQ3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:29:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728449AbfCAQ3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:29:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 35C683018985;
        Fri,  1 Mar 2019 16:29:15 +0000 (UTC)
Received: from treble (ovpn-122-204.rdu2.redhat.com [10.10.122.204])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AC39960143;
        Fri,  1 Mar 2019 16:29:13 +0000 (UTC)
Date:   Fri, 1 Mar 2019 10:29:11 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+ca95b2b7aef9e7cbd6ab@syzkaller.appspotmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/unwind: add hardcoded ORC entry for NULL
Message-ID: <20190301162911.ucd6diddioqnthc2@treble>
References: <20190301031201.7416-1-jannh@google.com>
 <20190301031201.7416-2-jannh@google.com>
 <20190301162418.sbhth5tycd6znxin@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190301162418.sbhth5tycd6znxin@treble>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 01 Mar 2019 16:29:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 10:24:18AM -0600, Josh Poimboeuf wrote:
> > Is there a reason why the top-level Makefile only sets
> > -fno-optimize-sibling-calls if CONFIG_FRAME_POINTER is set?
> > I suspect that this is just a historical thing, because reliable
> > unwinding didn't work without frame pointers until ORC came along.
> > I'm not quite sure how best to express "don't do tail optimization if
> > either frame pointers are used or ORC is used" in a Makefile, and
> > whether we want an indirection through Kconfig for that, so I'm not
> > doing anything about it in this series.
> > Can someone send a patch to deal with it properly?
> 
> Why would sibling calls be a problem for ORC?  Once a function does a
> sibling call, it has effectively returned and shouldn't show up on the
> stack trace anyway.

Answering my own question, I guess some people might find it confusing
to have a caller skipped in the stack trace.  But nobody has ever
complained about it.

It's not a problem for livepatch since we only care about the return
path.

-- 
Josh
