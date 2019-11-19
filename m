Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CA2C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BD4222DD
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574163251;
	bh=1SdY39UQ7ffccVqoH29pOq4KEjE5+FVCNtIoDQpDfHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n7QFbvhXlDt7iee0E+vBD+/iMibe74EooUTF0tsVNB+NGn/9QhbhP8w5W4ZnFb7I5
	 qWogjiHylmMK7HvTNOiCkMlNuQMVk856kTYDToJQ5BiZJDvR9WBF6+rneezJ2UOea1
	 e2S1/gReuOWLYDmElxRFOYVmkfpqDXbNGTRKuz6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfKSLeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:34:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:48150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbfKSLeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:34:06 -0500
Received: from quaco.ghostprotocols.net (179.176.11.138.dynamic.adsl.gvt.net.br [179.176.11.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D006222D1;
        Tue, 19 Nov 2019 11:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574163245;
        bh=1SdY39UQ7ffccVqoH29pOq4KEjE5+FVCNtIoDQpDfHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IqluQvoMoUulqd/S/I6zqrUu4YR8K6CeNrb9VGGnzHnA5mUEEUW0yESHSVUzbDFjP
         LKf0YLz7gdZQ+2MFs1VP2G1gEjieKPFiSCCLkfn42JGumPXN3LJOy0E12hfVq/EX3l
         uG+YxSdXkHYWf97ZgthNP27oPhS+kwUkHXZikqt4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/25] x86/insn: Add some Intel instructions to the opcode map
Date:   Tue, 19 Nov 2019 08:32:37 -0300
Message-Id: <20191119113245.19593-18-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191119113245.19593-1-acme@kernel.org>
References: <20191119113245.19593-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add to the opcode map the following instructions:
        cldemote
        tpause
        umonitor
        umwait
        movdiri
        movdir64b
        enqcmd
        enqcmds
        encls
        enclu
        enclv
        pconfig
        wbnoinvd

For information about the instructions, refer Intel SDM May 2019
(325462-070US) and Intel Architecture Instruction Set Extensions
May 2019 (319433-037).

The instruction decoding can be tested using the perf tools'
"x86 instruction decoder - new instructions" test as folllows:

  $ perf test -v "new " 2>&1 | grep -i cldemote
  Decoded ok: 0f 1c 00                    cldemote (%eax)
  Decoded ok: 0f 1c 05 78 56 34 12        cldemote 0x12345678
  Decoded ok: 0f 1c 84 c8 78 56 34 12     cldemote 0x12345678(%eax,%ecx,8)
  Decoded ok: 0f 1c 00                    cldemote (%rax)
  Decoded ok: 41 0f 1c 00                 cldemote (%r8)
  Decoded ok: 0f 1c 04 25 78 56 34 12     cldemote 0x12345678
  Decoded ok: 0f 1c 84 c8 78 56 34 12     cldemote 0x12345678(%rax,%rcx,8)
  Decoded ok: 41 0f 1c 84 c8 78 56 34 12  cldemote 0x12345678(%r8,%rcx,8)
  $ perf test -v "new " 2>&1 | grep -i tpause
  Decoded ok: 66 0f ae f3                 tpause %ebx
  Decoded ok: 66 0f ae f3                 tpause %ebx
  Decoded ok: 66 41 0f ae f0              tpause %r8d
  $ perf test -v "new " 2>&1 | grep -i umonitor
  Decoded ok: 67 f3 0f ae f0              umonitor %ax
  Decoded ok: f3 0f ae f0                 umonitor %eax
  Decoded ok: 67 f3 0f ae f0              umonitor %eax
  Decoded ok: f3 0f ae f0                 umonitor %rax
  Decoded ok: 67 f3 41 0f ae f0           umonitor %r8d
  $ perf test -v "new " 2>&1 | grep -i umwait
  Decoded ok: f2 0f ae f0                 umwait %eax
  Decoded ok: f2 0f ae f0                 umwait %eax
  Decoded ok: f2 41 0f ae f0              umwait %r8d
  $ perf test -v "new " 2>&1 | grep -i movdiri
  Decoded ok: 0f 38 f9 03                 movdiri %eax,(%ebx)
  Decoded ok: 0f 38 f9 88 78 56 34 12     movdiri %ecx,0x12345678(%eax)
  Decoded ok: 48 0f 38 f9 03              movdiri %rax,(%rbx)
  Decoded ok: 48 0f 38 f9 88 78 56 34 12  movdiri %rcx,0x12345678(%rax)
  $ perf test -v "new " 2>&1 | grep -i movdir64b
  Decoded ok: 66 0f 38 f8 18              movdir64b (%eax),%ebx
  Decoded ok: 66 0f 38 f8 88 78 56 34 12  movdir64b 0x12345678(%eax),%ecx
  Decoded ok: 67 66 0f 38 f8 1c           movdir64b (%si),%bx
  Decoded ok: 67 66 0f 38 f8 8c 34 12     movdir64b 0x1234(%si),%cx
  Decoded ok: 66 0f 38 f8 18              movdir64b (%rax),%rbx
  Decoded ok: 66 0f 38 f8 88 78 56 34 12  movdir64b 0x12345678(%rax),%rcx
  Decoded ok: 67 66 0f 38 f8 18           movdir64b (%eax),%ebx
  Decoded ok: 67 66 0f 38 f8 88 78 56 34 12       movdir64b 0x12345678(%eax),%ecx
  $ perf test -v "new " 2>&1 | grep -i enqcmd
  Decoded ok: f2 0f 38 f8 18              enqcmd (%eax),%ebx
  Decoded ok: f2 0f 38 f8 88 78 56 34 12  enqcmd 0x12345678(%eax),%ecx
  Decoded ok: 67 f2 0f 38 f8 1c           enqcmd (%si),%bx
  Decoded ok: 67 f2 0f 38 f8 8c 34 12     enqcmd 0x1234(%si),%cx
  Decoded ok: f3 0f 38 f8 18              enqcmds (%eax),%ebx
  Decoded ok: f3 0f 38 f8 88 78 56 34 12  enqcmds 0x12345678(%eax),%ecx
  Decoded ok: 67 f3 0f 38 f8 1c           enqcmds (%si),%bx
  Decoded ok: 67 f3 0f 38 f8 8c 34 12     enqcmds 0x1234(%si),%cx
  Decoded ok: f2 0f 38 f8 18              enqcmd (%rax),%rbx
  Decoded ok: f2 0f 38 f8 88 78 56 34 12  enqcmd 0x12345678(%rax),%rcx
  Decoded ok: 67 f2 0f 38 f8 18           enqcmd (%eax),%ebx
  Decoded ok: 67 f2 0f 38 f8 88 78 56 34 12       enqcmd 0x12345678(%eax),%ecx
  Decoded ok: f3 0f 38 f8 18              enqcmds (%rax),%rbx
  Decoded ok: f3 0f 38 f8 88 78 56 34 12  enqcmds 0x12345678(%rax),%rcx
  Decoded ok: 67 f3 0f 38 f8 18           enqcmds (%eax),%ebx
  Decoded ok: 67 f3 0f 38 f8 88 78 56 34 12       enqcmds 0x12345678(%eax),%ecx
  $ perf test -v "new " 2>&1 | grep -i enqcmds
  Decoded ok: f3 0f 38 f8 18              enqcmds (%eax),%ebx
  Decoded ok: f3 0f 38 f8 88 78 56 34 12  enqcmds 0x12345678(%eax),%ecx
  Decoded ok: 67 f3 0f 38 f8 1c           enqcmds (%si),%bx
  Decoded ok: 67 f3 0f 38 f8 8c 34 12     enqcmds 0x1234(%si),%cx
  Decoded ok: f3 0f 38 f8 18              enqcmds (%rax),%rbx
  Decoded ok: f3 0f 38 f8 88 78 56 34 12  enqcmds 0x12345678(%rax),%rcx
  Decoded ok: 67 f3 0f 38 f8 18           enqcmds (%eax),%ebx
  Decoded ok: 67 f3 0f 38 f8 88 78 56 34 12       enqcmds 0x12345678(%eax),%ecx
  $ perf test -v "new " 2>&1 | grep -i encls
  Decoded ok: 0f 01 cf                    encls
  Decoded ok: 0f 01 cf                    encls
  $ perf test -v "new " 2>&1 | grep -i enclu
  Decoded ok: 0f 01 d7                    enclu
  Decoded ok: 0f 01 d7                    enclu
  $ perf test -v "new " 2>&1 | grep -i enclv
  Decoded ok: 0f 01 c0                    enclv
  Decoded ok: 0f 01 c0                    enclv
  $ perf test -v "new " 2>&1 | grep -i pconfig
  Decoded ok: 0f 01 c5                    pconfig
  Decoded ok: 0f 01 c5                    pconfig
  $ perf test -v "new " 2>&1 | grep -i wbnoinvd
  Decoded ok: f3 0f 09                    wbnoinvd
  Decoded ok: f3 0f 09                    wbnoinvd

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Link: http://lore.kernel.org/lkml/20191115135447.6519-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 arch/x86/lib/x86-opcode-map.txt       | 18 ++++++++++++------
 tools/arch/x86/lib/x86-opcode-map.txt | 18 ++++++++++++------
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index e0b85930dd77..0a0e9112f284 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -333,7 +333,7 @@ AVXcode: 1
 06: CLTS
 07: SYSRET (o64)
 08: INVD
-09: WBINVD
+09: WBINVD | WBNOINVD (F3)
 0a:
 0b: UD2 (1B)
 0c:
@@ -364,7 +364,7 @@ AVXcode: 1
 # a ModR/M byte.
 1a: BNDCL Gv,Ev (F3) | BNDCU Gv,Ev (F2) | BNDMOV Gv,Ev (66) | BNDLDX Gv,Ev
 1b: BNDCN Gv,Ev (F2) | BNDMOV Ev,Gv (66) | BNDMK Gv,Ev (F3) | BNDSTX Ev,Gv
-1c:
+1c: Grp20 (1A),(1C)
 1d:
 1e:
 1f: NOP Ev
@@ -792,6 +792,8 @@ f3: Grp17 (1A)
 f5: BZHI Gy,Ey,By (v) | PEXT Gy,By,Ey (F3),(v) | PDEP Gy,By,Ey (F2),(v)
 f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v)
 f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
+f8: MOVDIR64B Gv,Mdqq (66) | ENQCMD Gv,Mdqq (F2) | ENQCMDS Gv,Mdqq (F3)
+f9: MOVDIRI My,Gy
 EndTable
 
 Table: 3-byte opcode 2 (0x0f 0x3a)
@@ -943,9 +945,9 @@ GrpTable: Grp6
 EndTable
 
 GrpTable: Grp7
-0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B)
-1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B)
-2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B)
+0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B)
+1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B)
+2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
 3: LIDT Ms
 4: SMSW Mw/Rv
 5: rdpkru (110),(11B) | wrpkru (111),(11B)
@@ -1020,7 +1022,7 @@ GrpTable: Grp15
 3: vstmxcsr Md (v1) | WRGSBASE Ry (F3),(11B)
 4: XSAVE | ptwrite Ey (F3),(11B)
 5: XRSTOR | lfence (11B)
-6: XSAVEOPT | clwb (66) | mfence (11B)
+6: XSAVEOPT | clwb (66) | mfence (11B) | TPAUSE Rd (66),(11B) | UMONITOR Rv (F3),(11B) | UMWAIT Rd (F2),(11B)
 7: clflush | clflushopt (66) | sfence (11B)
 EndTable
 
@@ -1051,6 +1053,10 @@ GrpTable: Grp19
 6: vscatterpf1qps/d Wx (66),(ev)
 EndTable
 
+GrpTable: Grp20
+0: cldemote Mb
+EndTable
+
 # AMD's Prefetch Group
 GrpTable: GrpP
 0: PREFETCH
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index e0b85930dd77..0a0e9112f284 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -333,7 +333,7 @@ AVXcode: 1
 06: CLTS
 07: SYSRET (o64)
 08: INVD
-09: WBINVD
+09: WBINVD | WBNOINVD (F3)
 0a:
 0b: UD2 (1B)
 0c:
@@ -364,7 +364,7 @@ AVXcode: 1
 # a ModR/M byte.
 1a: BNDCL Gv,Ev (F3) | BNDCU Gv,Ev (F2) | BNDMOV Gv,Ev (66) | BNDLDX Gv,Ev
 1b: BNDCN Gv,Ev (F2) | BNDMOV Ev,Gv (66) | BNDMK Gv,Ev (F3) | BNDSTX Ev,Gv
-1c:
+1c: Grp20 (1A),(1C)
 1d:
 1e:
 1f: NOP Ev
@@ -792,6 +792,8 @@ f3: Grp17 (1A)
 f5: BZHI Gy,Ey,By (v) | PEXT Gy,By,Ey (F3),(v) | PDEP Gy,By,Ey (F2),(v)
 f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v)
 f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
+f8: MOVDIR64B Gv,Mdqq (66) | ENQCMD Gv,Mdqq (F2) | ENQCMDS Gv,Mdqq (F3)
+f9: MOVDIRI My,Gy
 EndTable
 
 Table: 3-byte opcode 2 (0x0f 0x3a)
@@ -943,9 +945,9 @@ GrpTable: Grp6
 EndTable
 
 GrpTable: Grp7
-0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B)
-1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B)
-2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B)
+0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B)
+1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B)
+2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
 3: LIDT Ms
 4: SMSW Mw/Rv
 5: rdpkru (110),(11B) | wrpkru (111),(11B)
@@ -1020,7 +1022,7 @@ GrpTable: Grp15
 3: vstmxcsr Md (v1) | WRGSBASE Ry (F3),(11B)
 4: XSAVE | ptwrite Ey (F3),(11B)
 5: XRSTOR | lfence (11B)
-6: XSAVEOPT | clwb (66) | mfence (11B)
+6: XSAVEOPT | clwb (66) | mfence (11B) | TPAUSE Rd (66),(11B) | UMONITOR Rv (F3),(11B) | UMWAIT Rd (F2),(11B)
 7: clflush | clflushopt (66) | sfence (11B)
 EndTable
 
@@ -1051,6 +1053,10 @@ GrpTable: Grp19
 6: vscatterpf1qps/d Wx (66),(ev)
 EndTable
 
+GrpTable: Grp20
+0: cldemote Mb
+EndTable
+
 # AMD's Prefetch Group
 GrpTable: GrpP
 0: PREFETCH
-- 
2.21.0

