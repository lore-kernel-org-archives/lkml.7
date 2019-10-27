Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1102CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41FC205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211670;
	bh=haQrs3c9WFi14yzGlsrMHFdxnYCKCu3FeZbrAxy876Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M4O1kNALmU7upgY8LYOjFQslDf/7vIZ+PZNjbnDra2dqZcCsJE/WZPsMCXDgMh0Wp
	 NI4GJ6L6f73Hpk6fBOOJ9BiIVmy7dt4A0K2FZhiwIqV8i6GbEVRYC5/HC+M42E3DIM
	 2Y3yFalLjqfpfIgzbOUG5auuHvavDmLwPk5ukKe4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbfJ0V1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:27:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730777AbfJ0VYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:24:20 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB76921726;
        Sun, 27 Oct 2019 21:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211459;
        bh=haQrs3c9WFi14yzGlsrMHFdxnYCKCu3FeZbrAxy876Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HPaQt6UMM9v8UDLdDsuRAIaX7bshgDYOJkAWijrgTWRe6njG7rrKANik/tJGstWs/
         jc40jMRSU0jFSsCHob0+vDfYZoQy/qqIBYwYvc1fghaU73WuFq1UTsm0UAubczwaRc
         PeFEQAXoGINq1pgEt1/z1rmYILdZDS8/IE42s/Ow=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 5.3 159/197] s390/kaslr: add support for R_390_GLOB_DAT relocation type
Date:   Sun, 27 Oct 2019 22:01:17 +0100
Message-Id: <20191027203400.264805187@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald Schaefer <gerald.schaefer@de.ibm.com>

commit ac49303d9ef0ad98b79867a380ef23480e48870b upstream.

Commit "bpf: Process in-kernel BTF" in linux-next introduced an undefined
__weak symbol, which results in an R_390_GLOB_DAT relocation type. That
is not yet handled by the KASLR relocation code, and the kernel stops with
the message "Unknown relocation type".

Add code to detect and handle R_390_GLOB_DAT relocation types and undefined
symbols.

Fixes: 805bc0bc238f ("s390/kernel: build a relocatable kernel")
Cc: <stable@vger.kernel.org> # v5.2+
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/boot/startup.c               |   14 +++++++++++---
 arch/s390/kernel/machine_kexec_reloc.c |    1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -101,10 +101,18 @@ static void handle_relocs(unsigned long
 	dynsym = (Elf64_Sym *) vmlinux.dynsym_start;
 	for (rela = rela_start; rela < rela_end; rela++) {
 		loc = rela->r_offset + offset;
-		val = rela->r_addend + offset;
+		val = rela->r_addend;
 		r_sym = ELF64_R_SYM(rela->r_info);
-		if (r_sym)
-			val += dynsym[r_sym].st_value;
+		if (r_sym) {
+			if (dynsym[r_sym].st_shndx != SHN_UNDEF)
+				val += dynsym[r_sym].st_value + offset;
+		} else {
+			/*
+			 * 0 == undefined symbol table index (STN_UNDEF),
+			 * used for R_390_RELATIVE, only add KASLR offset
+			 */
+			val += offset;
+		}
 		r_type = ELF64_R_TYPE(rela->r_info);
 		rc = arch_kexec_do_relocs(r_type, (void *) loc, val, 0);
 		if (rc)
--- a/arch/s390/kernel/machine_kexec_reloc.c
+++ b/arch/s390/kernel/machine_kexec_reloc.c
@@ -27,6 +27,7 @@ int arch_kexec_do_relocs(int r_type, voi
 		*(u32 *)loc = val;
 		break;
 	case R_390_64:		/* Direct 64 bit.  */
+	case R_390_GLOB_DAT:
 		*(u64 *)loc = val;
 		break;
 	case R_390_PC16:	/* PC relative 16 bit.	*/


