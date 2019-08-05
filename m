Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9590C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8972067D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565010516;
	bh=kET/XI/yGE7hnw4dQZUVxgjobkG7KvceWR0d2hddSUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jnQX6QyY7vutWGXFnRdcy2IUA7fWUld1LIb4eqdlbTdfEfG3zKe2/Tv7YxQ9tFgBs
	 m+tdG1KACJTZ9y5t4BwtxbquGUv1X6bFaXMic2kyy8jjcg67t0GnZXHkg+El/pI/Hh
	 tSsM0XH523GZ21eKM/52TKgRYYAq6XsWGhC+dDSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfHENIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729457AbfHENIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:08:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 871452087B;
        Mon,  5 Aug 2019 13:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565010510;
        bh=kET/XI/yGE7hnw4dQZUVxgjobkG7KvceWR0d2hddSUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJWDyQUpuGpBkxTWz7fnPfJGH4e5L8xRghx9k1xHLB/egKg7NyWyPSMcdQIQIyfos
         9HbdEehDDl7wsw9qiVOLxckEj1XsjxBtYlIb4kWc1iRdtGp0GSNIYKdl1SPffFBMV4
         aJ5ApopB0kLnrnAEGhwHSfa3zKgbU1AxHI4Sv/jA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 52/53] gcc-9: properly declare the {pv,hv}clock_page storage
Date:   Mon,  5 Aug 2019 15:03:17 +0200
Message-Id: <20190805124933.610345569@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124927.973499541@linuxfoundation.org>
References: <20190805124927.973499541@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 459e3a21535ae3c7a9a123650e54f5c882b8fcbf upstream.

The pvlock_page and hvclock_page variables are (as the name implies)
addresses to pages, created by the linker script.

But we declared them as just "extern u8" variables, which _works_, but
now that gcc does some more bounds checking, it causes warnings like

    warning: array subscript 1 is outside array bounds of ‘u8[1]’

when we then access more than one byte from those variables.

Fix this by simply making the declaration of the variables match
reality, which makes the compiler happy too.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/vdso/vclock_gettime.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -29,12 +29,12 @@ extern int __vdso_gettimeofday(struct ti
 extern time_t __vdso_time(time_t *t);
 
 #ifdef CONFIG_PARAVIRT_CLOCK
-extern u8 pvclock_page
+extern u8 pvclock_page[PAGE_SIZE]
 	__attribute__((visibility("hidden")));
 #endif
 
 #ifdef CONFIG_HYPERV_TSCPAGE
-extern u8 hvclock_page
+extern u8 hvclock_page[PAGE_SIZE]
 	__attribute__((visibility("hidden")));
 #endif
 


