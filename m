Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A1AC0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 15:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E1820856
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 15:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfGFPuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 11:50:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58976 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfGFPuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 11:50:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F32C3082201;
        Sat,  6 Jul 2019 15:50:05 +0000 (UTC)
Received: from treble (ovpn-122-197.rdu2.redhat.com [10.10.122.197])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 00C9C1714B;
        Sat,  6 Jul 2019 15:50:03 +0000 (UTC)
Date:   Sat, 6 Jul 2019 10:50:01 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Craig Topper <craig.topper@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Bill Wendling <morbo@google.com>,
        Stephen Hines <srhines@google.com>
Subject: Re: objtool warnings in prerelease clang-9
Message-ID: <20190706155001.yrfxqj7c2bmqtbid@treble>
References: <CAKwvOdnGL_9cJ+ETNce89+z7CTDctjACS8DFsLu=ev4+vkVkUw@mail.gmail.com>
 <alpine.DEB.2.21.1907022332000.1802@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907022332000.1802@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sat, 06 Jul 2019 15:50:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 11:58:27PM +0200, Thomas Gleixner wrote:
> platform-quirks.o:
> 
>         if (x86_platform.set_legacy_features)
>   74:   4c 8b 1d 00 00 00 00    mov    0x0(%rip),%r11        # 7b <x86_early_init_platform_quirks+0x7b>
>   7b:   4d 85 db                test   %r11,%r11
>   7e:   0f 85 00 00 00 00       jne    84 <x86_early_init_platform_quirks+0x84>
>                 x86_platform.set_legacy_features();
> }
>   84:   c3                      retq   
> 
> That jne jumps to __x86_indirect_thunk_r11, aka. ratpoutine.
> 
> No idea why objtool thinks that the instruction at 0x84 is not
> reachable. Josh?

That's a conditional tail call, which is something GCC never does.
Objtool doesn't understand that, so we'll need to fix it.

-- 
Josh
