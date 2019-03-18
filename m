Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477E8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1024D2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfCRX5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:57:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfCRX5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 19:57:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EEF73308425C;
        Mon, 18 Mar 2019 23:57:12 +0000 (UTC)
Received: from treble (ovpn-120-200.rdu2.redhat.com [10.10.120.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2424A1B5AC;
        Mon, 18 Mar 2019 23:57:10 +0000 (UTC)
Date:   Mon, 18 Mar 2019 18:57:07 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: Re: [PATCH 00/25] objtool: UACCESS validation v4
Message-ID: <20190318235707.wdaldl2354fxmbab@treble>
References: <20190318153840.906404905@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190318153840.906404905@infradead.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 18 Mar 2019 23:57:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 04:38:40PM +0100, Peter Zijlstra wrote:
> Teach objtool to validate the UACCESS (SMAP, PAN) rules which are currently
> unenforced and (therefore obviously) violated.
> 
> UACCESS sections should be small; we want to limit the amount of code that can
> touch userspace. Furthermore, UACCESS state isn't scheduled, this means that
> anything that directly calls into the scheduler will result in random code
> running with UACCESS enabled and possibly getting back into the UACCESS region
> with UACCESS disabled and causing faults.
> 
> Forbid any CALL/RET while UACCESS is enabled; but provide a few exceptions.
> 
> This builds x86_64-allmodconfig and lots of x86_64-randconfig clean.
> 
> Changes since -v3:
> 
>  - removed a bunch of functions from the UACCESS-safe list
>    due to the removal of CONFIG_KASAN_EXTRA=y.
> 
>  - hopefully addressed all the feedback from Josh
> 
>  - realized objtool doesn't cover x86_32
> 
>  - some added additional annotations/fixes: kcov, signal
> 
>  - retains the DF check for now, Linus, do you (still) think it is worth doing
>    that DF check?

I'm still not crazy about the DF thing, but otherwise everything looks
great.

For the objtool bits:

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
