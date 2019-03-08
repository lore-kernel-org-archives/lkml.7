Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8489DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCD620857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfCHTdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:33:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfCHTdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:33:12 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED587A4053;
        Fri,  8 Mar 2019 19:33:11 +0000 (UTC)
Received: from treble (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 43CD360856;
        Fri,  8 Mar 2019 19:33:08 +0000 (UTC)
Date:   Fri, 8 Mar 2019 13:33:05 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: Re: [PATCH 15/20] objtool: Add --backtrace support
Message-ID: <20190308193305.ccivol3axwvcuc5p@treble>
References: <20190307114511.870090179@infradead.org>
 <20190307115200.419834588@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190307115200.419834588@infradead.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 08 Mar 2019 19:33:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 12:45:26PM +0100, Peter Zijlstra wrote:
> For when you want to know the path that reached your fail state.
> 
> $ ./objtool check --no-fp --backtrace arch/x86/lib/usercopy_64.o
> arch/x86/lib/usercopy_64.o: warning: objtool: .altinstr_replacement+0x3: UACCESS disable without MEMOPs: __clear_user()
> arch/x86/lib/usercopy_64.o: warning: objtool:   __clear_user()+0x3a: (alt)
> arch/x86/lib/usercopy_64.o: warning: objtool:   __clear_user()+0x2e: (branch)
> arch/x86/lib/usercopy_64.o: warning: objtool:   __clear_user()+0x18: (branch)
> arch/x86/lib/usercopy_64.o: warning: objtool:   .altinstr_replacement+0xffffffffffffffff: (branch)
> arch/x86/lib/usercopy_64.o: warning: objtool:   __clear_user()+0x5: (alt)
> arch/x86/lib/usercopy_64.o: warning: objtool:   __clear_user()+0x0: <=== (func)

We should have done this a long time ago.  Thank you for this!

-- 
Josh
