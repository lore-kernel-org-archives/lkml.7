Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2004C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDFD2133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfCRVyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:54:05 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54872 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbfCRVyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 17:54:05 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h60Cj-0005n4-B9; Mon, 18 Mar 2019 21:53:57 +0000
Date:   Mon, 18 Mar 2019 21:53:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2/resend] tracing: eliminate const char[] auto variables
Message-ID: <20190318215356.GJ2217@ZenIV.linux.org.uk>
References: <20181102205442.7758-1-linux@rasmusvillemoes.dk>
 <20190318213427.22108-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318213427.22108-1-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 10:34:27PM +0100, Rasmus Villemoes wrote:

> I didn't get any response to this; just let me know if you don't want
> this kind of microoptimization patches.

Umm...  What's wrong with "%*s", width, "" instead of those games?
As in
{
        bool tgid = flags & TRACE_ITER_RECORD_TGID;
	int width = tgid ? 10 : 2;

        print_event_info(buf, m);

        seq_printf(m, "#                          %*s  _-----=> irqs-off\n",
		   width, "");
        seq_printf(m, "#                          %*s / _----=> need-resched\n",
		   width, "");
        seq_printf(m, "#                          %*s| / _---=> hardirq/softirq\n",
		   width, "");
        seq_printf(m, "#                          %*s|| / _--=> preempt-depth\n",
		   width, "");
        seq_printf(m, "#                          %*s||| /     delay\n",
		   width, "");
        seq_printf(m, "#           TASK-PID %*sCPU#  ||||    TIMESTAMP  FUNCTION\n",
		   width, tgid ? "TGID   " : "");
        seq_printf(m, "#              | |   %*s  |   ||||       |         |\n",
		   width, "");
}
and bugger those constants...

PS: it's very tempting to add some warlording to that piece of... ASCII art
