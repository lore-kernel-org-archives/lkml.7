Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5670AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306BF21900
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387878AbfB1PLE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:11:04 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:54377 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387854AbfB1PLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:11:02 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 15732212-1500050 
        for multiple; Thu, 28 Feb 2019 15:10:45 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Peter Zijlstra <peterz@infradead.org>, bp@alien8.de,
        brgerst@gmail.com, catalin.marinas@arm.com, dvlasenk@redhat.com,
        hpa@zytor.com, james.morse@arm.com, jpoimboe@redhat.com,
        julien.thierry@arm.com, luto@amacapital.net, luto@kernel.org,
        mingo@kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, valentin.schneider@arm.com,
        will.deacon@arm.com
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190228150152.540038736@infradead.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
References: <20190228145450.289603901@infradead.org>
 <20190228150152.540038736@infradead.org>
Message-ID: <155136664389.5847.6200085578174808757@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH 6/8] i915,uaccess: Fix redundant CLAC
Date:   Thu, 28 Feb 2019 15:10:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peter Zijlstra (2019-02-28 14:54:56)
> drivers/gpu/drm/i915/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x3c: redundant UACCESS disable
> drivers/gpu/drm/i915/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x66: redundant UACCESS disable
> 
> AKA. you don't need user_access_end() if user_access_begin() fails.

Cool, I had no idea if it was required or not. The closest to
instructions on how to use user_access_begin() is in
arch/x86/include/asm/uaccess.h ... which I guess is earlier in this
series!

> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
