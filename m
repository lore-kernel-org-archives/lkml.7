Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CC4C2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 04:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575D8205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 04:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLaESS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 23:18:18 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56552 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfLaESR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 23:18:17 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1im8z1-0003cH-N5; Tue, 31 Dec 2019 04:18:15 +0000
Date:   Tue, 31 Dec 2019 04:18:15 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Rob Landley <rob@landley.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Why is CONFIG_VT forced on?
Message-ID: <20191231041815.GF4203@ZenIV.linux.org.uk>
References: <9b79fb95-f20c-f299-f568-0ffb60305f04@landley.net>
 <b3cf8faf-ef04-2f55-3ccb-772e18a57d7b@infradead.org>
 <ac0e5b3b-6e70-6ab0-0c7f-43175b73058f@landley.net>
 <e55624fa-7112-1733-8ddd-032b134da737@infradead.org>
 <018540ef-0327-78dc-ea5c-a43318f1f640@landley.net>
 <774dfe49-61a0-0144-42b7-c2cbac150687@landley.net>
 <20191231024054.GC4203@ZenIV.linux.org.uk>
 <20191231025255.GD4203@ZenIV.linux.org.uk>
 <ffa8ec1d-71d7-a153-eed9-8e2daee40949@landley.net>
 <20191231035319.GE4203@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191231035319.GE4203@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 03:53:19AM +0000, Al Viro wrote:
> On Mon, Dec 30, 2019 at 09:27:50PM -0600, Rob Landley wrote:
> 
> > > Your complaint is basically that the same thing is forcing all of those on
> > > in default configs.
> > 
> > No, my complaint was that kconfig basically has the concept of symbols that turn
> > _off_ something that is otherwise on by default ("Disable X" instead of "Enable
> > X"), but it was implemented it in an awkward way then allowed to scale to silly
> > levels, and now the fact it exists is being used as evidence that it was a good
> > idea.
> 
> Where and by whom?
> 
> > I had to work out a way to work around this design breakage, which I did and had
> > moved on before this email, but I thought pointing out the awkwardness might
> > help a design discussion.
> 
> What design discussion?  Where?
> 
> > My mistake.
> 
> Generally a passive-aggressive flame (complete with comparisons to INTERCAL)
> and not a shred of reference to any design issues in it tends to
> be rather ineffecient way to start such discussion...
> 
> > The thread _started_ because menuconfig help has a blind spot (which seemed like
> > a bug to me, it _used_ to say why), and then I found the syntax you changed a
> > year or two back non-obvious when I tried to RTFM but that part got answered.
> 
> _I_ have changed???  What the hell?  I have never touched kconfig syntax in any
> way; what are you talking about?  Care to post commit IDs in question?

BTW, in 2.6.12 drivers/char/Kconfig has
config VT
	bool "Virtual terminal" if EMBEDDED

so the syntax appears to be identical all way back to 2005.  Going to the historical
tree, we have
commit eda30c2b338cdc099951f45eb45d1ce7055706e3
Author: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date:   Thu Jul 31 05:15:05 2003 -0700

    [PATCH] console on by default if not embedded (save mucho pain)
    
    (Andi Kleen)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index f0ce5d7473ad..d16c54b65102 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -5,8 +5,9 @@
 menu "Character devices"
 
 config VT
-       bool "Virtual terminal"
+       bool "Virtual terminal" if EMBEDDED
        requires INPUT=y
+       default y

So application of that particular syntax to VT goes back to 2003.  I've no idea
how far back the syntax itself goes.

One change that might be relevant appears to have happened circa 3.15, when
allnoconfig started playing odd games with EXPERT; bisect points to
commit 5d2acfc7b974bbd3858b4dd3f2cdc6362dd8843a
Author: Josh Triplett <josh@joshtriplett.org>
Date:   Mon Apr 7 15:39:09 2014 -0700

    kconfig: make allnoconfig disable options behind EMBEDDED and EXPERT

Mind explaining what exactly are you talking about and how exactly have
I been involved in it?  My only involvement with kconfig (thorough all
its history) had been
commit 6b87b70c5339f30e3c5b32085e69625906513dc2
Author: Al Viro <viro@ZenIV.linux.org.uk>
Date:   Thu Jan 14 18:13:49 2016 +0000

    unbreak allmodconfig KCONFIG_ALLCONFIG=...
and
commit ce97e13e52848c6388598696b7d44748598db759
Author: Al Viro <viro@ZenIV.linux.org.uk>
Date:   Sun Oct 26 05:12:34 2008 +0000

    fix allmodconfig breakage

Neither of those has happened within the last couple of years and if either
has caused any breakage relevant to whatever you are doing, I would rather
hear details.  Certainly no syntax changes had been intended by either
commit and rereading those I see no likely candidates.
