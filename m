Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E94BC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 05:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8FF206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 05:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfLaF6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 00:58:42 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:57428 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfLaF6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 00:58:41 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1imAYB-0005Tn-RW; Tue, 31 Dec 2019 05:58:40 +0000
Date:   Tue, 31 Dec 2019 05:58:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Rob Landley <rob@landley.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Why is CONFIG_VT forced on?
Message-ID: <20191231055839.GG4203@ZenIV.linux.org.uk>
References: <b3cf8faf-ef04-2f55-3ccb-772e18a57d7b@infradead.org>
 <ac0e5b3b-6e70-6ab0-0c7f-43175b73058f@landley.net>
 <e55624fa-7112-1733-8ddd-032b134da737@infradead.org>
 <018540ef-0327-78dc-ea5c-a43318f1f640@landley.net>
 <774dfe49-61a0-0144-42b7-c2cbac150687@landley.net>
 <20191231024054.GC4203@ZenIV.linux.org.uk>
 <20191231025255.GD4203@ZenIV.linux.org.uk>
 <ffa8ec1d-71d7-a153-eed9-8e2daee40949@landley.net>
 <20191231035319.GE4203@ZenIV.linux.org.uk>
 <20191231041815.GF4203@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191231041815.GF4203@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 04:18:15AM +0000, Al Viro wrote:

> > > The thread _started_ because menuconfig help has a blind spot (which seemed like
> > > a bug to me, it _used_ to say why), and then I found the syntax you changed a
> > > year or two back non-obvious when I tried to RTFM but that part got answered.

FWIW, the change of help message (from reporting
Depends on: TTY [=y] && !S390 && !UML && EXPERT [=n]
to
Depends on: TTY [=y] && !S390 && !UML)
seems to have come about in
commit bcdedcc1afd6ac91e15cb90aedaf8432f62fed13
Author: Wengmeiling <wengmeiling.weng@huawei.com>
Date:   Tue Apr 30 15:28:46 2013 -0700

    menuconfig: print more info for symbol without prompts

Doesn't seem to be intentional, going by the commit message,
and I'm not familiar enough with menuconfig guts to tell
more than that without serious RTFS.

So if you are refering to the help message contents (its syntax
doesn't seem to have changed), that would appear to be the
point when it has happened (3.10, six and half years ago).

If you are refering to the syntax of Kconfig itself, AFAICS
that has remained since the introduction of Kconfig back in
2002 - at least the earliest version of the parser seems
to have it that way.  Hadn't checked how soon the first
users have appeared, but no later than in 2003.  No idea
about the earlier history - it went into the tree in that
form.

No opinion about the merits of Kconfig syntax, BTW.
The older form of reported dependencies looks strange,
now that I look at it (never noticed that quirk back
then) - usually <something> && <option> [=n] would've
meant that the entire expression is false; if anything,
it might've been better to report the predicates on
prompt separately.  No idea how hard would that be -
I hadn't looked into menuconfig guts for years, and
even then only casually.

FWIW, my only contact with KCONFIG_ALLCONFIG mechanism
had been on the build coverage side of things - i.e.
allmodconfig with fixed subset.  Never played with
allnoconfig applications, but AFAICS the only (relatively)
recent change I'd done there hadn't changed allnoconfig
behaviour at all.
