Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B22FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7063E21928
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263023;
	bh=L95EMHtNAx1++/FTWvOD8AFJ7l+KXtUK06uQ1uo1HIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0iqF4FxCWgWVEF73XEuJEIH06rXzsf4r4+gzKWZgLeZHeA+AbRXO2lrrXI0xpf/sd
	 F5mEvzWW7SBapvW2vT2ccREhnV+Ci0CoKRkIbhXblbwKaDyme4tqkuDw4WH1LVjTMP
	 NIEKa7fKy9OdE8np8h7E/3cTLUp80V7Z1CNj5MJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391484AbfJPV5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:57:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406657AbfJPV4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:56:30 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE24021A49;
        Wed, 16 Oct 2019 21:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262990;
        bh=L95EMHtNAx1++/FTWvOD8AFJ7l+KXtUK06uQ1uo1HIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ynwlWHHJyJqer7kYxICV018N7sUxdSVFSAuZdHoF3QUgVrRzXWkTc7Lock0v/I+AF
         qM40yFlBh//j8lXBE7ax0HMHhZKOhnRAP2eUaB56kV2ovb6RpT5t0DBsSFG0Pqw7EA
         3hNBZa5dbZ8zad7PE7ZwMpe7uAV38MFW8WA+6Bjg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org
Subject: [PATCH 4.14 57/65] MIPS: Disable Loongson MMI instructions for kernel build
Date:   Wed, 16 Oct 2019 14:51:11 -0700
Message-Id: <20191016214838.518286192@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214756.457746573@linuxfoundation.org>
References: <20191016214756.457746573@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paul.burton@mips.com>

commit 2f2b4fd674cadd8c6b40eb629e140a14db4068fd upstream.

GCC 9.x automatically enables support for Loongson MMI instructions when
using some -march= flags, and then errors out when -msoft-float is
specified with:

  cc1: error: ‘-mloongson-mmi’ must be used with ‘-mhard-float’

The kernel shouldn't be using these MMI instructions anyway, just as it
doesn't use floating point instructions. Explicitly disable them in
order to fix the build with GCC 9.x.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: 3702bba5eb4f ("MIPS: Loongson: Add GCC 4.4 support for Loongson2E")
Fixes: 6f7a251a259e ("MIPS: Loongson: Add basic Loongson 2F support")
Fixes: 5188129b8c9f ("MIPS: Loongson-3: Improve -march option and move it to Platform")
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: stable@vger.kernel.org # v2.6.32+
Cc: linux-mips@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/loongson64/Platform |    4 ++++
 arch/mips/vdso/Makefile       |    1 +
 2 files changed, 5 insertions(+)

--- a/arch/mips/loongson64/Platform
+++ b/arch/mips/loongson64/Platform
@@ -43,6 +43,10 @@ else
       $(call cc-option,-march=mips64r2,-mips64r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64)
 endif
 
+# Some -march= flags enable MMI instructions, and GCC complains about that
+# support being enabled alongside -msoft-float. Thus explicitly disable MMI.
+cflags-y += $(call cc-option,-mno-loongson-mmi)
+
 #
 # Loongson Machines' Support
 #
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -9,6 +9,7 @@ ccflags-vdso := \
 	$(filter -mmicromips,$(KBUILD_CFLAGS)) \
 	$(filter -march=%,$(KBUILD_CFLAGS)) \
 	$(filter -m%-float,$(KBUILD_CFLAGS)) \
+	$(filter -mno-loongson-%,$(KBUILD_CFLAGS)) \
 	-D__VDSO__
 cflags-vdso := $(ccflags-vdso) \
 	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \


