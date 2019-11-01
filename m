Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E970CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC46217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfKAWPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 18:15:10 -0400
Received: from smtprelay0147.hostedemail.com ([216.40.44.147]:55173 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725989AbfKAWPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 18:15:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 4774E182CED34;
        Fri,  1 Nov 2019 22:15:08 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-HE-Tag: shade52_49a12faf12c2a
X-Filterd-Recvd-Size: 2421
Received: from grimm.local.home (unknown [94.155.134.143])
        (Authenticated sender: rostedt@goodmis.org)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Fri,  1 Nov 2019 22:15:05 +0000 (UTC)
Date:   Fri, 1 Nov 2019 18:15:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     dann frazier <dann.frazier@canonical.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris <jmorris@namei.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: tracefs splats in lockdown=confidentiality mode
Message-ID: <20191101181501.4beff81b@grimm.local.home>
In-Reply-To: <20191101210803.GA9841@xps13.dannf>
References: <20191101210803.GA9841@xps13.dannf>
X-Mailer: Claws Mail 3.17.4git49 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2019 15:08:03 -0600
dann frazier <dann.frazier@canonical.com> wrote:

> hey,
>   fyi, I'm seeing a bunch of errors from tracefs when booting 5.4-rc5 in
> lockdown=confidentiality mode:
> 
> [    1.763630] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
> [    1.772332] Could not create tracefs 'available_events' entry
> [    1.778633] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
> [    1.787095] Could not create tracefs 'set_event' entry
> [    1.792412] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
> (...)
> [    2.899481] Could not create tracefs 'set_graph_notrace' entry
> [    2.905671] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
> [    2.913934] ------------[ cut here ]------------
> [    2.918435] Could not register function stat for cpu 0
> [    2.923717] WARNING: CPU: 1 PID: 1 at kernel/trace/ftrace.c:987 ftrace_init_tracefs_toplevel+0x168/0x1bc
> [    2.933939] Modules linked in:
> [    2.937290] CPU: 1 PID: 1 Comm: 

Looks to me that it's working as designed ;-)

I'm guessing we could quiet these warnings for boot up though. :-/

But there should be at least one message that states that the tracefs
files are not being created due to lockdown.

-- Steve
