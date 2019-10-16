Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AB7ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA16207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263714;
	bh=Wr/xZxIqAJ6Qdy60YBuEq9FdlnUPXajz3zyOMIkcgK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0tF+XkDOHjWYbzDMXE7FN4N4fnYAc6veArdBX1kcHu9BmhMJkGQ4od/XtASciNCEy
	 oR2YKXVHuMlTqMOd7NvKYEqpKhh54lmTup7Dy3efcf/Mm/A5fAc2TaYbtIhRMFK+ED
	 /iwF8mg+1btqhBkmQCL0i01xtjPJwRISp1ud8L60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439097AbfJPWId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:08:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438044AbfJPV5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:57:46 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76AD421928;
        Wed, 16 Oct 2019 21:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263065;
        bh=Wr/xZxIqAJ6Qdy60YBuEq9FdlnUPXajz3zyOMIkcgK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w5Yq27LJGcNelmH8U2Gq5iD9ZbtvBAhvBLZy7j4BFiw1CiQuRK1ISQnqboLfzAFI1
         eca6zvzbYUCOx6dyyXJ77awKXoIgKs6JMtcYio+wVfku2t+EbMKnMt3smEhEBFIwJh
         kRbIFfCGMx0q/32Ma0ceBdtHGq0+IDhXaskDciIc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org
Subject: [PATCH 4.19 66/81] MIPS: Disable Loongson MMI instructions for kernel build
Date:   Wed, 16 Oct 2019 14:51:17 -0700
Message-Id: <20191016214845.344235056@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214805.727399379@linuxfoundation.org>
References: <20191016214805.727399379@linuxfoundation.org>
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
 
 ifeq ($(cc-name),clang)


