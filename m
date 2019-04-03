Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C9DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E5620830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HDNcz9n1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfDCMsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:48:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40306 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDCMsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QHj+WG3qtSJ9+7gKlWpGNTF0tHWwgHByHfv3r2ZoP3o=; b=HDNcz9n10w3+mMkZiVVaP7UtB
        z3SREYyU3MjBM4SUpY140NmCJWK3Jo6IZrhHnroa7EF3ZBb/GRWr2pAOf+G4hUkC3wCx3OlAD2ZM0
        qyu47YHPPvgbfMa/2l1fJDk4jGRYkqZuGrrkhg63BeVXPXpjFN4YU7qlO2uThRcDTTOo9YJ4Yp99x
        Os0Jsx6zuawqzR+2EkyOZA8ZRWzUeBlw3oqg9N7mmPxkX6AGNBlb7FTU4jWjwV3xgDMzsJjxIwGgy
        JkBPXUWH28LunJUJFP7tezcQrSGFMyZJFJ5B0qgWc6CKCbsx4zoubP8UZa59nSp48p+m3l1jREeVu
        9QkSkEwKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBfJ3-0002NM-P5; Wed, 03 Apr 2019 12:47:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 31BCE2038C23F; Wed,  3 Apr 2019 14:47:51 +0200 (CEST)
Date:   Wed, 3 Apr 2019 14:47:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, dave@stgolabs.net, arnd@arndb.de,
        tim.c.chen@linux.intel.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, hpa@zytor.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        will.deacon@arm.com, paulmck@linux.vnet.ibm.com, longman@redhat.com
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:locking/core] locking/rwsem: Remove arch specific rwsem
 files
Message-ID: <20190403124751.GF4038@hirez.programming.kicks-ass.net>
References: <20190322143008.21313-2-longman@redhat.com>
 <tip-701fd16f3b4e3e5f317a051b36962b8cc756c138@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-701fd16f3b4e3e5f317a051b36962b8cc756c138@git.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 03:44:11AM -0700, tip-bot for Waiman Long wrote:
> diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
> index 2d686ae54681..22554c585ced 100644
> --- a/arch/x86/um/Makefile
> +++ b/arch/x86/um/Makefile
> @@ -21,7 +21,6 @@ obj-y += checksum_32.o syscalls_32.o
>  obj-$(CONFIG_ELF_CORE) += elfcore.o
>  
>  subarch-y = ../lib/string_32.o ../lib/atomic64_32.o ../lib/atomic64_cx8_32.o
> -subarch-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += ../lib/rwsem.o
>  
>  else
>  

The x86_64 um build needs this on top:

diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 22554c585ced..33c51c064c77 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -26,8 +26,7 @@ else
 
 obj-y += syscalls_64.o vdso/
 
-subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o ../entry/thunk_64.o \
-		../lib/rwsem.o
+subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o ../entry/thunk_64.o
 
 endif
 
