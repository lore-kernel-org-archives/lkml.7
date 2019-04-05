Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0129CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF273204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbfDEQFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:05:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbfDEQFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:05:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D639544FA7;
        Fri,  5 Apr 2019 16:05:43 +0000 (UTC)
Received: from treble (ovpn-123-87.rdu2.redhat.com [10.10.123.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C756660C8D;
        Fri,  5 Apr 2019 16:05:38 +0000 (UTC)
Date:   Fri, 5 Apr 2019 11:05:36 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jon Masters <jcm@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC 2/5] x86/speculation: Add support for
 'cpu_spec_mitigations=' cmdline options
Message-ID: <20190405160536.sks2hmo6sxnxg3tl@treble>
References: <cover.1554396090.git.jpoimboe@redhat.com>
 <78c63cb08f36f55407f534d49cc2543079e44dbb.1554396090.git.jpoimboe@redhat.com>
 <20190405135712.GF23348@zn.tnic>
 <20190405143101.ksj7ayjis4p52dgt@treble>
 <20190405152650.GH23348@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190405152650.GH23348@zn.tnic>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 05 Apr 2019 16:05:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 05:26:50PM +0200, Borislav Petkov wrote:
> On Fri, Apr 05, 2019 at 09:31:01AM -0500, Josh Poimboeuf wrote:
> > My thinking was that the individual options could be used to override
> > the global option.  But maybe that's overkill?  I dunno.
> 
> You mean if the user deliberately types:
> 
> "cpu_spec_mitigations=off spectre_v2=auto"
> 
> on the cmdline to turn off all and then enable only one?
> 
> Hmm, yap, sounds like an overkill to me. Then I'd probably do:
> 
> 	pr_err("Make up your mind already!\n");
> 	return;
> 
> :-))
> 
> I'd say let's do the simpler and cleaner thing now and think about
> supporting this overkill when it really turns out that it is needed.

Fair enough.

> > I assume you mean just the part where L1TF_MITIGATION_DEFAULT is added?
> 
> Yap.

Ok.

-- 
Josh
