Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7923AC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123F7206DE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567689004;
	bh=T6Hjysi8KQ3q7Hw/PPwFXQ6fg/TWt+MuBSvYozhEKcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mlzkqglChPgTYsdF3uKOH7r3J1BX4qtwdSYdlZmWgJuHBMT4vEQ54hM/+MSLcBGUc
	 TdgskLjWTQgsbEl9trvrWQbpW1eb4wgo3cButEBWKosRrvD/87c8yjN2DeVAz6wu2M
	 UpGQPsMd37J68mAfEESEy71zNs04a+u7qMdqRE00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733030AbfIENKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730839AbfIENKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:10:04 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02CC4206CD;
        Thu,  5 Sep 2019 13:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567689002;
        bh=T6Hjysi8KQ3q7Hw/PPwFXQ6fg/TWt+MuBSvYozhEKcY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oxqK7XnFmv/m8jH5QET6wGe5cWWTp/PCIVUr31qWbtDqzR5WkRSq906Qkr16jtNxb
         MrtxJ3jWmOz9xJxqJE1suTgLAftz/i7cyFOf4SwdT2BnVPq59d1yrk3l/tMXlDw+am
         hDDQyj9hAvxS6u5h+cOIMysaE70bTcIGivIJyF5E=
Date:   Thu, 5 Sep 2019 22:09:58 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH -tip 0/2] x86: Prohibit kprobes on
 XEN_EMULATE_PREFIX
Message-Id: <20190905220958.d0189e1e253f9e553b880675@kernel.org>
In-Reply-To: <20190905203224.e41d7f3dfbf918c5031f9766@kernel.org>
References: <156759754770.24473.11832897710080799131.stgit@devnote2>
        <ad6431be-c86e-5ed5-518a-d1e9d1959e80@citrix.com>
        <20190905104937.60aa03f699a9c0fbf1b651b9@kernel.org>
        <1372ce73-e2d8-6144-57df-a98429587826@citrix.com>
        <20190905203224.e41d7f3dfbf918c5031f9766@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2019 20:32:24 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Thu, 5 Sep 2019 08:54:17 +0100
> Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> 
> > On 05/09/2019 02:49, Masami Hiramatsu wrote:
> > > On Wed, 4 Sep 2019 12:54:55 +0100
> > > Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> > >
> > >> On 04/09/2019 12:45, Masami Hiramatsu wrote:
> > >>> Hi,
> > >>>
> > >>> These patches allow x86 instruction decoder to decode
> > >>> xen-cpuid which has XEN_EMULATE_PREFIX, and prohibit
> > >>> kprobes to probe on it.
> > >>>
> > >>> Josh reported that the objtool can not decode such special
> > >>> prefixed instructions, and I found that we also have to
> > >>> prohibit kprobes to probe on such instruction.
> > >>>
> > >>> This series can be applied on -tip master branch which
> > >>> has merged Josh's objtool/perf sharing common x86 insn
> > >>> decoder series.
> > >> The paravirtualised xen-cpuid is were you'll see it most in a regular
> > >> kernel, but be aware that it is also used for testing purposes in other
> > >> circumstances, and there is an equivalent KVM prefix which is used for
> > >> KVM testing.
> > > Good catch! I didn't notice that. Is that really same sequance or KVM uses
> > > another sequence of instructions for KVM prefix?
> > 
> > I don't know if you've spotted, but the prefix is a ud2a instruction
> > followed by 'xen' in ascii.
> > 
> > The KVM version was added in c/s 6c86eedc206dd1f9d37a2796faa8e6f2278215d2

Hmm, I think I might misunderstand what the "emulate prefix"... that is not
a prefix which replace actual prefix, but just works like an escape sequence.
Thus the next instruction can have any x86 prefix, correct?

If so, this patch doesn't work. I have to add a new field in struct insn
like "insn.emulate_prefix_size" so that we can keep a room for the prefixes
for real instruction.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
