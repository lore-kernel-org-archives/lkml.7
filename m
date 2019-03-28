Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044A3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84B9206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfC1DQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 23:16:15 -0400
Received: from namei.org ([65.99.196.166]:59014 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbfC1DQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 23:16:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x2S3Fkde027824;
        Thu, 28 Mar 2019 03:15:46 GMT
Date:   Thu, 28 Mar 2019 14:15:46 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
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
In-Reply-To: <CALCETrUZ+oP0xxNt4mwN=AZA+zvkkfPZiAsFmAuqUD48pOHbBg@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1903281403540.27561@namei.org>
References: <20190325220954.29054-1-matthewgarrett@google.com> <20190325220954.29054-24-matthewgarrett@google.com> <20190325164221.5d8687bd@shemminger-XPS-13-9360> <CALCETrU=EqqRwyQGBT0=_N9-E_pBM53=z+WJrd9OzV7g6xJa0A@mail.gmail.com> <alpine.LRH.2.21.1903270523240.5235@namei.org>
 <CALCETrUZ+oP0xxNt4mwN=AZA+zvkkfPZiAsFmAuqUD48pOHbBg@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019, Andy Lutomirski wrote:

> >
> >         kernel_is_locked_down("ioperm")
> >
> > becomes
> >
> >         kernel_is_locked_down(LOCKDOWN_IOPERM)
> >
> > and this function checks e.g.
> >
> >         if (lockdown_polcy[id]) {
> >                 fail or warn;
> >         }
> >
> > Thoughts?
> 
> I'm concerned that this gives too much useless flexibility to
> administrators and user code in general.  If you can break kernel
> integrity, you can break kernel integrity -- it shouldn't really
> matter *how* you break it.

OTOH, this seems like a combination of mechanism and policy. The 3 modes 
are a help here, but I wonder if they may be too coarse grained still, 
e.g. if someone wants to allow a specific mechanism according to their own 
threat model and mitigations.

Secure boot gives you some assurance of the static state of the system at 
boot time, and lockdown is certainly useful (with or without secure boot), 
but it's not a complete solution to runtime kernel integrity protection by 
any stretch of the imagination.  I'm concerned about it being perceived as 
such.

I'm not sure how to think about it architecturally and how it fits as such 
in the mainline kernel.


-- 
James Morris
<jmorris@namei.org>

