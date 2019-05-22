Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ED3C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602E320881
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbfEVSGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 14:06:01 -0400
Received: from namei.org ([65.99.196.166]:33826 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729506AbfEVSGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 14:06:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x4MI5u4R019801;
        Wed, 22 May 2019 18:05:56 GMT
Date:   Thu, 23 May 2019 04:05:56 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Matthew Garrett <mjg59@google.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Turn lockdown into an LSM
In-Reply-To: <CALCETrVow8U=xhQdJt8kSMX16Lf0Mstf3+QxY4iz4DHVp=PYWA@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1905230343390.18826@namei.org>
References: <20190521224013.3782-1-matthewgarrett@google.com> <alpine.LRH.2.21.1905221203070.3967@namei.org> <CACdnJuuTR=Ut4giPKC=kdxgY9yPv8+3PZyEzuxvON3Jr_92XnQ@mail.gmail.com> <CALCETrVow8U=xhQdJt8kSMX16Lf0Mstf3+QxY4iz4DHVp=PYWA@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019, Andy Lutomirski wrote:

> And I still think it would be nice to have some credible use case for
> a more fine grained policy than just the tri-state.  Having a lockdown
> policy of "may not violate kernel confidentiality except using
> kprobes" may be convenient, but it's also basically worthless, since
> kernel confidentiality is gone.

This is an important point, but there's also "can't use any lockdown 
features because the admin might need to use kprobes".  I mention a 
use-case below.

I think it's fine (and probably preferred) to keep the default behavior 
tri-state and allow LSMs to implement finer-grained policies.

> All this being said, I do see one big benefit for LSM integration:
> SELinux or another LSM could allow certain privileged tasks to bypass
> lockdown.  

Some environments _need_ a "break glass" option, and a well-defined policy
(e.g. an SELinux domain which can only be entered via serial console, with
2FA or JIT credentials) to selectively un-lock the kernel lockdown in  
production would mean the difference between having a fleet of millions of
nodes 99.999% locked down vs 0%.

> This seems fine, except that there's potential nastiness
> where current->cred isn't actually a valid thing to look at in the
> current context.

Right.

Can we identify any such cases in the current patchset?

One option would be for the LSM to assign a default (untrusted/unknown) 
value for the subject and then apply policy as needed (e.g. allow or deny 
these).

> So I guess my proposal is: use LSM, but make the hook very coarse
> grained: int security_violate_confidentiality(const struct cred *) and
> int security_violate_integrity(const struct cred *).

Perhaps security_kernel_unlock_*



-- 
James Morris
<jmorris@namei.org>

