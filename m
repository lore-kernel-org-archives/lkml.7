Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A1CC48BD7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E01D2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfFYVdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 17:33:51 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54416 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726331AbfFYVdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 17:33:49 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5PLWF3v023800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 17:32:16 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 59DBA42002B; Tue, 25 Jun 2019 17:32:15 -0400 (EDT)
Date:   Tue, 25 Jun 2019 17:32:15 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Arseny Maslennikov <ar@cs.msu.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Vladimir D. Seleznev" <vseleznv@altlinux.org>,
        Rob Landley <rob@landley.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 4/7] linux/signal.h: Ignore SIGINFO by default in new
 tasks
Message-ID: <20190625213215.GB3116@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Arseny Maslennikov <ar@cs.msu.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Vladimir D. Seleznev" <vseleznv@altlinux.org>,
        Rob Landley <rob@landley.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Machek <pavel@ucw.cz>
References: <20190625161153.29811-1-ar@cs.msu.ru>
 <20190625161153.29811-5-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190625161153.29811-5-ar@cs.msu.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 07:11:50PM +0300, Arseny Maslennikov wrote:
> This matches the behaviour of other Unix-like systems that have SIGINFO
> and causes less harm to processes that do not install handlers for this
> signal, making the keyboard status character non-fatal for them.
> 
> This is implemented with the assumption that SIGINFO is defined
> to be equivalent to SIGPWR; still, there is no reason for PWR to
> result in termination of the signal recipient anyway — it does not
> indicate there is a fatal problem with the recipient's execution
> context (like e.g. FPE/ILL do), and we have TERM/KILL for explicit
> termination requests.

So this is a consequence of trying to overload SIGINFO with SIGPWR.
At least on some legacy Unix systems, the way SIGPWR worked was that
init would broadcast SIGPWR to all userspace process (with system
daemons on an exception list so they could get shutdown last).
Applications which didn't have a SIGPWR handler registered, would just
exit.  Those that did, were expected to clean up in preparation with
the impending shutdown.  After some period of time, then processes
would get hard killed and then system daemons would get shut down and
the system would cleanly shut itself down.

So SIGPWR acted much like SIGHUP, and that's why the default behavior
was "terminate".  Now, as far as I know, we've not actually used in
that way, at least for most common distributions, but there is a sane
reason why things are they way there are, and in there are people who
have been using SIGPWR the way it had originally been intended, there
is risk in overloading SIGINFO with SIGPWR --- in particular, typing
^T might cause some enterprise database to start shutting itself down.  :-)

(In particular it might be worth checking Linux ports of Oracle and
DB2.)

					- Ted
