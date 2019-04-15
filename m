Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123EBC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE3620880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfDOPug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:50:36 -0400
Received: from mail.hallyn.com ([178.63.66.53]:40858 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfDOPug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:50:36 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 69909978; Mon, 15 Apr 2019 10:50:34 -0500 (CDT)
Date:   Mon, 15 Apr 2019 10:50:34 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Christian Brauner <christian@brauner.io>,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com, luto@kernel.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        tglx@linutronix.de, mtk.manpages@gmail.com,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        joel@joelfernandes.org, dancol@google.com
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add
 CLONE_PIDFD]
Message-ID: <20190415155034.GA25351@mail.hallyn.com>
References: <20190414201436.19502-1-christian@brauner.io>
 <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 12:08:09PM +0200, Enrico Weigelt, metux IT consult wrote:
> On 14.04.19 22:14, Christian Brauner wrote:
> 
> Hi folks,
> 
> > This patchset makes it possible to retrieve pid file descriptors at
> > process creation time by introducing the new flag CLONE_PIDFD to the
> > clone() system call as previously discussed.
> 
> Sorry, for highjacking this thread, but I'm curious on what things to
> consider when introducing new CLONE_* flags.
> 
> The reason I'm asking is:
> 
> I'm working on implementing plan9-like fs namespaces, where unprivileged
> processes can change their own namespace at will. For that, certain

Is there any place where we can see previous discussion about this?

> traditional unix'ish things have to be disabled, most notably suid.

If you have to disable suid anyway, then is there any reason why the
existing ability to do this in a private user namespace, with only
your own uid mapped (which you can do without any privilege) does
not suffice?  That was actually one of the main design goals of user
namespaces, to be able to clone(CLONE_NEWUSER), map your current uid,
then clone(CLONE_NEWNS) and bind mount at will.

> As forbidding suid can be helpful in other scenarios, too, I thought
> about making this its own feature. Doing that switch on clone() seems
> a nice place for that, IMHO.
> 
> As there might be potentially even more CLONE_* flags in the future,
> and the bitmask size is limited, this raises the question on how to
> proceed with those flag additions in the future.
> 
> What's your thoughts on that ?
> 
> 
> --mtx
> 
> -- 
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287
