Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817EBC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D548218FF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354953;
	bh=Uza+4gkc6epCCNAYUzUpLMm6Qpun5ToiNP9CMsCV4Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W5quxJwB5YKAFfDSY/b4MLXZKC5vp9PS2fakTtXeLLSTiXbeHD81qdy5EL1pDPKo2
	 6D53rghRWDEFtk0kpEBOktU2FdR34fZSN1kcUlqbOUqBK/jy097zZtQQlm6YQwdiWH
	 SkZeqCECPD8t7c2SjdF4JQ9yy/DVS+AqY2Ajv42c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbfDOTCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:02:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728767AbfDOTC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:02:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7D3F218A1;
        Mon, 15 Apr 2019 19:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354948;
        bh=Uza+4gkc6epCCNAYUzUpLMm6Qpun5ToiNP9CMsCV4Ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bjxm8cf5F4A/vXiEQtdCHESmelQMUFGz4aZP/vMQVderETjwi/NwAcpdQhgP/UZ9a
         kEzcBdLDW004tp+qT51WEl8bAcaKynJ88ivs6H0FT8rmuMFw1MN/pkXoxFKHTmFHrw
         6WwdScGoYLNGWGuyqVO1dJbcDfQOkh+uAO7dPqMw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Golovin <dima@golovin.in>,
        Bill Wendling <morbo@google.com>, Rui Ueyama <ruiu@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Fangrui Song <maskray@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 10/69] x86/vdso: Drop implicit common-page-size linker flag
Date:   Mon, 15 Apr 2019 20:58:28 +0200
Message-Id: <20190415183728.891826319@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit ac3e233d29f7f77f28243af0132057d378d3ea58 upstream.

GNU linker's -z common-page-size's default value is based on the target
architecture. arch/x86/entry/vdso/Makefile sets it to the architecture
default, which is implicit and redundant. Drop it.

Fixes: 2aae950b21e4 ("x86_64: Add vDSO for x86-64 with gettimeofday/clock_gettime/getcpu")
Reported-by: Dmitry Golovin <dima@golovin.in>
Reported-by: Bill Wendling <morbo@google.com>
Suggested-by: Dmitry Golovin <dima@golovin.in>
Suggested-by: Rui Ueyama <ruiu@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Fangrui Song <maskray@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20181206191231.192355-1-ndesaulniers@google.com
Link: https://bugs.llvm.org/show_bug.cgi?id=38774
Link: https://github.com/ClangBuiltLinux/linux/issues/31
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/entry/vdso/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 0defcc939ab4..839015f1b0de 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -49,7 +49,7 @@ targets += $(vdso_img_sodbg)
 export CPPFLAGS_vdso.lds += -P -C
 
 VDSO_LDFLAGS_vdso.lds = -m elf_x86_64 -soname linux-vdso.so.1 --no-undefined \
-			-z max-page-size=4096 -z common-page-size=4096
+			-z max-page-size=4096
 
 $(obj)/vdso64.so.dbg: $(src)/vdso.lds $(vobjs) FORCE
 	$(call if_changed,vdso)
@@ -102,7 +102,7 @@ CFLAGS_REMOVE_vvar.o = -pg
 
 CPPFLAGS_vdsox32.lds = $(CPPFLAGS_vdso.lds)
 VDSO_LDFLAGS_vdsox32.lds = -m elf32_x86_64 -soname linux-vdso.so.1 \
-			   -z max-page-size=4096 -z common-page-size=4096
+			   -z max-page-size=4096
 
 # 64-bit objects to re-brand as x32
 vobjs64-for-x32 := $(filter-out $(vobjs-nox32),$(vobjs-y))
-- 
2.19.1



