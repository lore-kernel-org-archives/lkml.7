Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDE8C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8422184E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391363AbfEXLww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391235AbfEXLwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:52:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B39EE20673;
        Fri, 24 May 2019 11:52:50 +0000 (UTC)
Date:   Fri, 24 May 2019 07:52:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: silence GCC 9 array bounds warning
Message-ID: <20190524075249.48aac0e7@gandalf.local.home>
In-Reply-To: <CANiq72=J_RkEByD1ToX1Y2MwkwrCdg0SFZKK02jwu_PpyADPoQ@mail.gmail.com>
References: <20190523124535.GA12931@gmail.com>
        <20190523221210.4a2bb326@oasis.local.home>
        <CANiq72=J_RkEByD1ToX1Y2MwkwrCdg0SFZKK02jwu_PpyADPoQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2019 06:05:36 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Fri, May 24, 2019 at 4:12 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Thu, 23 May 2019 14:45:35 +0200
> > Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > I still prefer the typecast of void *, as that's used a bit more in the
> > kernel, but since char * is also used (not as much), I'll leave it. But
> > the parenthesis around iter are unnecessary. I'll remove them.  
> 
> If the preferred style in the kernel is void *, change it on your
> side, please! :-) Maybe we should mention it in the coding guidelines.
>

Well, it's not officially the preferred style. There's 240 uses of
(void *) in memset, compared to 98 uses of (char *)

$ git grep memset | grep '(void \*)' | wc -l
240

$ git grep memset | grep '(char \*)' | wc -l
98

I was about to make the conversion, but when I added addition to the
equation, the (char *) went ahead slightly:

$ git grep memset | grep '(void \*)' | grep '+' | wc -l
32

$ git grep memset | grep '(char \*)' | grep '+' | wc -l
35

Both are fine and legit, but as the weight is slightly higher doing
byte arithmetic with char *, I'll keep it as is.

-- STeve
