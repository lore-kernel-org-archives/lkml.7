Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC37C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26892206BB
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfFIRmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:42:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35119 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbfFIRmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:42:14 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1911A802A0; Sun,  9 Jun 2019 19:42:03 +0200 (CEST)
Date:   Sun, 9 Jun 2019 19:41:39 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Arseny Maslennikov <ar@cs.msu.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        "Vladimir D . Seleznev" <vseleznv@altlinux.org>
Subject: Re: [PATCH 0/7] TTY Keyboard Status Request
Message-ID: <20190609174139.GA11944@xo-6d-61-c0.localdomain>
References: <20190605081906.28938-1-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605081906.28938-1-ar@cs.msu.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch series introduces TTY keyboard status request, a feature of
> the n_tty line discipline that reserves a character in struct termios
> (^T by default) and reacts to it by printing a short informational line
> to the terminal and sending a Unix signal to the tty's foreground
> process group. The processes may, in response to the signal, output a
> textual description of what they're doing.
> 
> The feature has been present in a similar form at least in
> Free/Open/NetBSD; it would be nice to have something like this in Linux
> as well. There is an LKML thread[1] where users have previously
> expressed the rationale for this.
> 
> The current implementation does not break existing kernel API in any
> way, since, fortunately, all the architectures supported by the kernel
> happen to have at least 1 free byte in the termios control character
> array.

I like the idea... I was often wondering "how long will this dd take". (And in
case of dd, SIGUSR1 does the job).

I assume this will off by default, so that applications using ^T today will not
get surprise signals?
									Pavel
