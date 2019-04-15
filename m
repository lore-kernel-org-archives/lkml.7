Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8067C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6C82087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555359551;
	bh=wvktTMWEEtjKHS6GEsVhpKDC8rfR3zBfhNlN4gzQv6o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0BiHwr9m+JnlvLjDQKlS6iq8KFh1miSEJEn5tPhNkk2Ly3FI8M3ry/xOizMU9PILJ
	 bg9UjZohMxzx3/yHYe+BRV51ZxsZjkRPmpV+DtXErT3yPsdblXgDQ6n+QtXFwUIklD
	 YOX2iIoMzHWceuzCgOnRSti0IiYACGmX/6Xnygho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbfDOUTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:19:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728292AbfDOUTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:19:10 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5817C218FF
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 20:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555359549;
        bh=wvktTMWEEtjKHS6GEsVhpKDC8rfR3zBfhNlN4gzQv6o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G+M4PDu4En58IAUFetL/yyP1RRPkr9v8vyYZzcfMiKRobRYDHKUsMONecmGTCpgG7
         7HkfJGSKtLwyhnGDylyeB43Pqcqd4DPWOd0Iy122R96VXe9hBn2YjyBZ0M8p+Jf7uQ
         +u82mlfdHk2MXceJ/WCYGc+eIzp2z8BERO2sjYEA=
Received: by mail-wr1-f50.google.com with SMTP id p10so23650273wrq.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 13:19:09 -0700 (PDT)
X-Gm-Message-State: APjAAAU4FErFrzadU0VEJH13fszMjY/loFVOH15w+mVfEYq1aDG9/Iu7
        Tt6epfBWlNiXSAn928Yr4OTg70g1qEUu42oRZdZSgg==
X-Google-Smtp-Source: APXvYqxEoZHQkSkCkSz4q33m1Xs3bk6vOmhORe7/J6/MaDt8wfgbxl9NWJyOrOLiNe0b/GcLyGEIrZF01y31ltt6ft4=
X-Received: by 2002:adf:fd46:: with SMTP id h6mr50713558wrs.139.1555359547852;
 Mon, 15 Apr 2019 13:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190415183726.036654568@linuxfoundation.org> <20190415183727.581656002@linuxfoundation.org>
 <20190415200452.GA25908@amd>
In-Reply-To: <20190415200452.GA25908@amd>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 15 Apr 2019 13:18:56 -0700
X-Gmail-Original-Message-ID: <CALCETrW9E8Y1vxn377jU_P2cQBw0oR2VDJGUkUKKH3RJEByiPQ@mail.gmail.com>
Message-ID: <CALCETrW9E8Y1vxn377jU_P2cQBw0oR2VDJGUkUKKH3RJEByiPQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 05/69] x86/power: Make restore_processor_context() sane
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bpetkov@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 1:04 PM Pavel Machek <pavel@denx.de> wrote:
>
> On Mon 2019-04-15 20:58:23, Greg Kroah-Hartman wrote:
> > [ Upstream commit 7ee18d677989e99635027cee04c878950e0752b9 ]
> >
> > My previous attempt to fix a couple of bugs in __restore_processor_context():
> >
> >   5b06bbcfc2c6 ("x86/power: Fix some ordering bugs in __restore_processor_context()")
> >
> > ... introduced yet another bug, breaking suspend-resume.
> >
> > Rather than trying to come up with a minimal fix, let's try to clean it up
> > for real.  This patch fixes quite a few things:
>
> 5b06bbcfc2c6 fixed theoretical bug; rather than porting it to stable
> than fixing it up, it would be better not to port it to stable in the
> first place or simply revert it there.

Are you sure about that?  The bug was reported by real users who had
their systems really crash:

https://lore.kernel.org/lkml/?q=0fede9f9-88b0-a6e7-1027-dfb2019b8ef2%40linux.intel.com

https://lore.kernel.org/lkml/CA+55aFwsMuHUBQz5kDNwRf17JnasXMWjvmLq5qXGH-694yeq1w@mail.gmail.com/

And we had a report that the bug got backported:

https://lore.kernel.org/stable/20190407160005.djiw4reapwvbxmgo@debian/

And if we're going to backport some of the fix, we should definitely
backport the whole set to avoid having the -stable kernels be in a
state that was never in any released kernel.


--Andy
https://lore.kernel.org/stable/20190407160005.djiw4reapwvbxmgo@debian/
