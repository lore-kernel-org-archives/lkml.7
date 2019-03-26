Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66878C10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B6FD20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732562AbfCZS5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:57:36 -0400
Received: from namei.org ([65.99.196.166]:58702 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfCZS5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:57:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x2QIv7YY007246;
        Tue, 26 Mar 2019 18:57:07 GMT
Date:   Wed, 27 Mar 2019 05:57:07 +1100 (AEDT)
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
In-Reply-To: <CALCETrU=EqqRwyQGBT0=_N9-E_pBM53=z+WJrd9OzV7g6xJa0A@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1903270523240.5235@namei.org>
References: <20190325220954.29054-1-matthewgarrett@google.com> <20190325220954.29054-24-matthewgarrett@google.com> <20190325164221.5d8687bd@shemminger-XPS-13-9360> <CALCETrU=EqqRwyQGBT0=_N9-E_pBM53=z+WJrd9OzV7g6xJa0A@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019, Andy Lutomirski wrote:

> A while back, I suggested an approach to actually make this stuff
> mergeable: submit a patch series that adds lockdown mode, enables it
> by command line option (and maybe sysctl) *only* and has either no
> effect or only a token effect.  Then we can add actual features to
> lockdown mode one at a time and review them separately.

This makes sense to me.

> 
> And I'm going to complain loudly unless two things change about this
> whole thing:
> 
> 1. Lockdown mode becomes three states, not a boolean.  The states are:
> no lockdown, best-effort-to-protect-kernel-integrity, and
> best-effort-to-protect-kernel-secrecy-and-integrity.  And this BPF
> mess illustrates why: most users will really strongly object to
> turning off BPF when they actually just want to protect kernel
> integrity.  And as far as I know, things like Secure Boot policy will
> mostly care about integrity, not secrecy, and tracing and such should
> work on a normal locked-down kernel.  So I think we need this knob.

Another approach would be to make this entirely policy based:

- Assign an ID to each lockdown point
- Implement a policy mechanism where each ID is mapped to 0 or 1
- Allow this policy to be specified statically or dynamically

So, 

	kernel_is_locked_down("ioperm")

becomes

	kernel_is_locked_down(LOCKDOWN_IOPERM)

and this function checks e.g.

	if (lockdown_polcy[id]) {
		fail or warn;
        }

Thoughts?


> 2. All the proponents of this series, and the documentation, needs to
> document that it's best effort.  There will always be security bugs,
> and there will always be things we miss.

Right.  Maintaining this feature will be an ongoing effort, and if its not 
actively maintained, it will bitrot and become useless.


-- 
James Morris
<jmorris@namei.org>

