Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602C4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEB5218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jMxOh0ci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732678AbfB1PFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:05:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44068 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731506AbfB1PFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W+T46heJCCHswyRGqlx+569SnMiQ3LjEEjOQeanPgKE=; b=jMxOh0citzdnR+vPQT3QQ/wt5
        Wg4QQhT5Nr/thJ5M1u/eQZeP6RrzkxfY+cUzXU4A0Q7smYfZbTCMRbSFT+S89NFfvB7utlR/SeU1h
        1Yq1JoIJ6ZOHuKVxTdCPjh/Vy9GZiM+qbs/l4mnJfk3H0lCvsSu7+siWkImRzrrCG7Uh6lQf6L9bu
        K3CmrT93AkI5uNZN1NBqoTMKhyS3XD/r0puawB+YovPc0RzxICNllOuI8kdNHUpwGYEkkEP54VPwP
        rIx0SO7ICyIhLUvd2DU1W4KjTU/Tg5ktoHdRH7CJOE2EhRLGLBEAV06N/Xi8OXW6rNpi/0M8B3IuN
        XMgAJeJkQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzNFH-0002NI-BW; Thu, 28 Feb 2019 15:05:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C2750202C2DA6; Thu, 28 Feb 2019 16:05:08 +0100 (CET)
Message-Id: <20190228145450.289603901@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 28 Feb 2019 15:54:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 0/8] objtool: UACCESS validation v2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Teach objtool to validate the UACCESS (SMAP, PAN) rules with are currently
unenforced and (therefore obviously) violated.

UACCESS sections should be small; we want to limit the amount of code that can
touch userspace. Furthermore, UACCESS state isn't scheduled, this means that
anything that directly calls into the scheduler will result in random code
running with UACCESS enabled and possibly getting back into the UACCESS region
with UACCESS disabled and causing faults.

Forbid any CALL/RET while UACCESS is enabled; but provide an annotation to mark
(a very limited) set of functions as UACCESS-safe (eg. the planned:
unsafe_copy_{to,from}_user()).

This set now compiles x86_64-allmodconfig _almost_ clean:

  arch/x86/lib/usercopy_64.o: warning: objtool: .altinstr_replacement+0x30: redundant UACCESS disable
  drivers/xen/privcmd.o: warning: objtool: privcmd_ioctl()+0x1c0: call to {dynamic}() with UACCESS enabled
  drivers/xen/privcmd.o: warning: objtool: privcmd_ioctl()+0x8f8: call to hypercall_page() with UACCESS enabled

Also; I found the UACCESS_SAFE() annotation as presented in these patches to be
inadequate; so I might go back to the STH_STRTAB variant for this.
Alternatively, we can simply keep the hard-coded list we have now. There really
should not be many more function on there.

*compile tested only*, esp. the KASAN changes have not been verified to
actually *work*.

---
 arch/x86/ia32/ia32_signal.c                |  29 +++--
 arch/x86/include/asm/bug.h                 |  28 ++--
 arch/x86/include/asm/kasan.h               |  15 +++
 drivers/gpu/drm/i915/i915_gem_execbuffer.c |   3 +-
 include/asm-generic/bug.h                  |   1 +
 include/linux/frame.h                      |  23 ++++
 include/linux/kasan.h                      |  12 +-
 lib/bug.c                                  |   9 +-
 mm/kasan/generic.c                         |   4 +-
 mm/kasan/kasan.h                           |   2 +-
 mm/kasan/report.c                          |   2 +-
 tools/objtool/arch.h                       |   6 +-
 tools/objtool/arch/x86/decode.c            |  22 +++-
 tools/objtool/check.c                      | 197 +++++++++++++++++++++++------
 tools/objtool/check.h                      |   3 +-
 tools/objtool/elf.c                        |  15 ++-
 tools/objtool/elf.h                        |   3 +-
 17 files changed, 290 insertions(+), 84 deletions(-)

