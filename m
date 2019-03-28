Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC24EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B066206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfC1TYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:24:01 -0400
Received: from namei.org ([65.99.196.166]:59092 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfC1TYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:24:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x2SJNUR1002465;
        Thu, 28 Mar 2019 19:23:30 GMT
Date:   Fri, 29 Mar 2019 06:23:30 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Matthew Garrett <mjg59@google.com>
cc:     Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Linux API <linux-api@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH 23/27] bpf: Restrict kernel image access functions when
 the kernel is locked down
In-Reply-To: <CACdnJusbi1jB+G0wMcj43wNik9Fiv3QCc8v30ztrFWg5-P-0iQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1903290621350.1769@namei.org>
References: <20190325220954.29054-1-matthewgarrett@google.com> <20190325220954.29054-24-matthewgarrett@google.com> <20190325164221.5d8687bd@shemminger-XPS-13-9360> <CALCETrU=EqqRwyQGBT0=_N9-E_pBM53=z+WJrd9OzV7g6xJa0A@mail.gmail.com> <alpine.LRH.2.21.1903270523240.5235@namei.org>
 <CALCETrUZ+oP0xxNt4mwN=AZA+zvkkfPZiAsFmAuqUD48pOHbBg@mail.gmail.com> <alpine.LRH.2.21.1903281403540.27561@namei.org> <CACdnJusbi1jB+G0wMcj43wNik9Fiv3QCc8v30ztrFWg5-P-0iQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019, Matthew Garrett wrote:

> On Wed, Mar 27, 2019 at 8:15 PM James Morris <jmorris@namei.org> wrote:
> > OTOH, this seems like a combination of mechanism and policy. The 3 modes
> > are a help here, but I wonder if they may be too coarse grained still,
> > e.g. if someone wants to allow a specific mechanism according to their own
> > threat model and mitigations.
> 
> In general the interfaces blocked by these patches could also be
> blocked with an LSM, and I'd guess that people with more fine-grained
> requirements would probably take that approach.

So... I have to ask, why not use LSM for this in the first place?

Either with an existing module or perhaps a lockdown LSM?

> 
> > Secure boot gives you some assurance of the static state of the system at
> > boot time, and lockdown is certainly useful (with or without secure boot),
> > but it's not a complete solution to runtime kernel integrity protection by
> > any stretch of the imagination.  I'm concerned about it being perceived as
> > such.
> 
> What do you think the functionality gaps are in terms of ensuring
> kernel integrity (other than kernel flaws that allow the restrictions
> to be bypassed)?

I don't know of any non-flaw gaps.

-- 
James Morris
<jmorris@namei.org>

