Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B337FC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864482196F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931752;
	bh=txizpSKWNllJpJ8T6Vas/37oGmdhWUzm8YhP+TFhjJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zXEeAHkbXhYqpsNIr7n6rpN43agtwT8YqGy4J8lc5PKVua7rIHWfv5rOrvik+yp7t
	 dobiYtsRcFa6Q2g5FJv/KpZ4s77oqekTeka9fXx+S7eZf+p/B4K7rt5lwS+5qDpvma
	 daunXyzrbIU4lpkAMbzL7oGGCf0VtZ6rf7wlGA6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404822AbfISWWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:22:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406847AbfISWW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:22:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9492F20678;
        Thu, 19 Sep 2019 22:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931746;
        bh=txizpSKWNllJpJ8T6Vas/37oGmdhWUzm8YhP+TFhjJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r01GTohX7ctfgL48vFJmIxwn8cgn5eKl7NBZa48NykWZa5OTXT7Y576v3Fd3Zbspb
         jMWXI+KLX/nzuNOBwFZfBYTQKYaTeFPYe7IsuIP2Csx8hdT4Byk6JWdJBeXZJK0K2t
         qrY1+ixsrTuB7e65zhHC1veGI/DV6JQCFdEcU5E0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.4 24/56] x86/build: Add -Wnoaddress-of-packed-member to REALMODE_CFLAGS, to silence GCC9 build warning
Date:   Fri, 20 Sep 2019 00:04:05 +0200
Message-Id: <20190919214755.167385430@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214742.483643642@linuxfoundation.org>
References: <20190919214742.483643642@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 42e0e95474fc6076b5cd68cab8fa0340a1797a72 upstream.

One of the very few warnings I have in the current build comes from
arch/x86/boot/edd.c, where I get the following with a gcc9 build:

   arch/x86/boot/edd.c: In function ‘query_edd’:
   arch/x86/boot/edd.c:148:11: warning: taking address of packed member of ‘struct boot_params’ may result in an unaligned pointer value [-Waddress-of-packed-member]
     148 |  mbrptr = boot_params.edd_mbr_sig_buffer;
         |           ^~~~~~~~~~~

This warning triggers because we throw away all the CFLAGS and then make
a new set for REALMODE_CFLAGS, so the -Wno-address-of-packed-member we
added in the following commit is not present:

  6f303d60534c ("gcc-9: silence 'address-of-packed-member' warning")

The simplest solution for now is to adjust the warning for this version
of CFLAGS as well, but it would definitely make sense to examine whether
REALMODE_CFLAGS could be derived from CFLAGS, so that it picks up changes
in the compiler flags environment automatically.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -38,6 +38,7 @@ REALMODE_CFLAGS	:= $(M16_CFLAGS) -g -Os
 
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -ffreestanding)
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -fno-stack-protector)
+REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -Wno-address-of-packed-member)
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), $(cc_stack_align4))
 export REALMODE_CFLAGS
 


