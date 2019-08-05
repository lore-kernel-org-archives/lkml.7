Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E6CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BC72075B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565011188;
	bh=kET/XI/yGE7hnw4dQZUVxgjobkG7KvceWR0d2hddSUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s0+ez6VgF+05mCc4Ybn1plywzdhgpSW0nTssnCQ+1MaT2ANtNMMjvyCjb8X7F15af
	 bJm+IcSoLKp/189ZJDnH9jt1VxYp1148Z0/iRlx/g/VAtkI9EqJArS4btF5MW/YkoY
	 6WSJfLHFqU0LfKt775uEfosPU/plunTSXh2CU08s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbfHENTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:19:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbfHENTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:19:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFF1F2147A;
        Mon,  5 Aug 2019 13:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565011176;
        bh=kET/XI/yGE7hnw4dQZUVxgjobkG7KvceWR0d2hddSUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qKBwO2C53RjFII28Zm3kPJUxw4eUzj+wwTzlCLxFJ8SdE15u8Gyr8uAEjZvCicmMu
         i0POSwb98YaGC5rFUilhSFBqaB+CeoVX+3qWJR/8aplhhXM30NvMEBzKEq301avBJD
         K7SZrHMksMBXnoS6zbTaBtnJIH+y4P+1FnocmB98=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 72/74] gcc-9: properly declare the {pv,hv}clock_page storage
Date:   Mon,  5 Aug 2019 15:03:25 +0200
Message-Id: <20190805124941.618238077@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124935.819068648@linuxfoundation.org>
References: <20190805124935.819068648@linuxfoundation.org>
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
 


