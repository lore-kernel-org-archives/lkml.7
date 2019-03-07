Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FF4C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F002081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfCGRVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:21:00 -0500
Received: from smtprelay0236.hostedemail.com ([216.40.44.236]:37205 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726161AbfCGRVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:21:00 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 91721100E86C5;
        Thu,  7 Mar 2019 17:20:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cord55_229b6f3b7ec33
X-Filterd-Recvd-Size: 2830
Received: from XPS-9350 (unknown [172.56.44.251])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 Mar 2019 17:20:35 +0000 (UTC)
Message-ID: <b83ed0ab05b12484a70d5f3db742a7a141718a00.camel@perches.com>
Subject: Re: [PATCH 1/2] futex: mark futex_detect_cmpxchg() as 'noinline'
From:   Joe Perches <joe@perches.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190307091514.2489338-1-arnd@arndb.de>
References: <20190307091514.2489338-1-arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Date:   Thu, 07 Mar 2019 09:19:04 -0800
User-Agent: Evolution 3.30.1-1build1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-07 at 10:14 +0100, Arnd Bergmann wrote:
> On 32-bit ARM, I got a link failure in futex_init() when building
> with clang in some random configurations:
> 
> kernel/futex.o:(.text.fixup+0x5c): relocation truncated to fit: R_ARM_JUMP24 against `.init.text'
> 
> As far as I can tell, the problem is that a branch is over 16MB
> apart in those configurations, but only if it branches back to
> the init text.
> 
> Marking the futex_detect_cmpxchg() function as noinline and
> not __init avoids the problem for me.

Perhaps the __init and __exit #defines should be noinline
to allow discarding of the code.

These defines are already marked with __section so I'd've
expected these to be noinline anyway.

---
 include/linux/init.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 5255069f5a9f..806215a74064 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -47,7 +47,7 @@
 
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
-#define __init		__section(.init.text) __cold  __latent_entropy __noinitretpoline
+#define __init		__section(.init.text) __cold  __latent_entropy __noinitretpoline noinline
 #define __initdata	__section(.init.data)
 #define __initconst	__section(.init.rodata)
 #define __exitdata	__section(.exit.data)
@@ -80,7 +80,7 @@
 #define __exitused  __used
 #endif
 
-#define __exit          __section(.exit.text) __exitused __cold notrace
+#define __exit          __section(.exit.text) __exitused __cold notrace noinline
 
 /* Used for MEMORY_HOTPLUG */
 #define __meminit        __section(.meminit.text) __cold notrace \



