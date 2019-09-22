Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E0BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 11:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8958F2070C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 11:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="UVLCQzls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfIVLgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 07:36:16 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:40364 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfIVLgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 07:36:16 -0400
Received: from grover.flets-west.jp (softbank126021098169.bbtec.net [126.21.98.169]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x8MBYmv4009695;
        Sun, 22 Sep 2019 20:34:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x8MBYmv4009695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569152089;
        bh=7yyatVofTFDMDzxmIITg/C1SE4md6ZFoYRRjarWk/pU=;
        h=From:To:Cc:Subject:Date:From;
        b=UVLCQzlsytsAVkuzRjRvgdZy8VwXuJsnxUgniU6waW3rzE1LwmfcJis9xDlAnfqB9
         +8lBL3JydRMl+bdqumSrAJdvMTTVEMzSbJ8LIEd0ciW46b5ScyzuRLr27wUV/VaDGd
         VUybrtFFli3zoEe1VZjZJ1xqhcmroelBg7LfaoVzzVAeECgj3mtqQKBG0pQTF2cpNm
         4esWw92zbCqMfXW6DbizjVp5+v+JFOlag1Ya2n/BFhJTws7Bw27kYJjQb0JQF8vgo/
         zPzW700rhV2sF8+11AVjArlJ4Zqyfx0i9G+MEzT9c2cYd8d6ns0JyFQT61KdPQ7X3W
         2tK5UHJWFvueQ==
X-Nifty-SrcIP: [126.21.98.169]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
Cc:     Anatoly Pugachev <matorola@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: [PATCH] sparc: vdso: fix build error of vdso32
Date:   Sun, 22 Sep 2019 20:34:36 +0900
Message-Id: <20190922113436.10396-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 54b8ae66ae1a ("kbuild: change *FLAGS_<basetarget>.o to
take the path relative to $(obj)"), sparc allmodconfig fails to build
as follows:

  CC      arch/sparc/vdso/vdso32/vclock_gettime.o
unrecognized e_machine 18 arch/sparc/vdso/vdso32/vclock_gettime.o
arch/sparc/vdso/vdso32/vclock_gettime.o: failed

The cause of the breakage is that -pg flag not being dropped.

The vdso32 files are located in the vdso32/ subdirectory, but I missed
to update the Makefile.

Fixes: 54b8ae66ae1a ("kbuild: change *FLAGS_<basetarget>.o to take the path relative to $(obj)")
Reported-by: Anatoly Pugachev <matorola@gmail.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/sparc/vdso/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index 324a23947585..399bc22b1cf8 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -67,12 +67,14 @@ $(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(SPARC_REG_CFLAGS
 #
 CFLAGS_REMOVE_vdso-note.o = -pg
 CFLAGS_REMOVE_vclock_gettime.o = -pg
+CFLAGS_REMOVE_vdso32/vdso-note.o = -pg
+CFLAGS_REMOVE_vdso32/vclock_gettime.o = -pg
 
 $(obj)/%.so: OBJCOPYFLAGS := -S
 $(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
-CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
+CPPFLAGS_vdso32/vdso32.lds = $(CPPFLAGS_vdso.lds)
 VDSO_LDFLAGS_vdso32.lds = -m elf32_sparc -soname linux-gate.so.1
 
 #This makes sure the $(obj) subdirectory exists even though vdso32/
-- 
2.17.1

