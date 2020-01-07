Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A2FC32771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 00:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F13D2072E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 00:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgAGAwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 19:52:34 -0500
Received: from kernel.crashing.org ([76.164.61.194]:33842 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbgAGAwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 19:52:34 -0500
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 0070ohut032384
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 6 Jan 2020 18:50:47 -0600
Message-ID: <6add0295e8790aef8df50d14b1bb607f5581687b.camel@kernel.crashing.org>
Subject: Re: [PATCH v2] printk: Fix preferred console selection with
 multiple matches
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 07 Jan 2020 11:50:42 +1100
In-Reply-To: <20200106102537.nirnfcauqdh4olgv@pathway.suse.cz>
References: <2712d7e2fb68bca06a33e2e062fc8e65a2652410.camel@kernel.crashing.org>
         <20191219135053.xr67lybhycepcxkp@pathway.suse.cz>
         <32fde8cd451ea0eaff38108d9f2f2d4a97a43097.camel@kernel.crashing.org>
         <20191220091131.4uifcbudwppjspf4@pathway.suse.cz>
         <20200106051508.GA17351@google.com>
         <20200106102537.nirnfcauqdh4olgv@pathway.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-01-06 at 11:25 +0100, Petr Mladek wrote:
> 
> I agree that the enums are more self-descriptive. My problem with it is
> that there are 5 values. I wanted to check how they were handled
> and neither 'con_matched' nor 'con_failed' were later used.
> 
> I though how to improve it. And I ended with feeling that the enum
> did more harm then good. -E??? codes are a bit less descriptive
> but there are only two. The meaning can be explained easily by
> a comment above the function.
> 
> If you want to keep the enum then please handle the return values
> by switch(). Or make it clear that all possible return values
> are handled properly.

Agreed. The enum was originally due to me trying to figure out all the
different cases happening separately from how we react to them. In fact
I'm not even convinced we don't have bugs in the latter (the failure
path of Braille consoles is dubious).

In any case, I'm back now, I'll try to respin this week.

Cheers,
Ben.

