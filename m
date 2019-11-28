Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,LONGWORDS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA45C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69506217AB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574948456;
	bh=EhqFrJqZfSSWtQsAhrg5OdFHgcRGwaGySkg1/+rWPw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dxc2xxa6PDcUITTHZhBY5EACr6GKJyQx8NVNLShJL6r6kzJhhqadGgcsCKBC/ayB1
	 Z7Y8kDpvXQ/kaseiM4hfOpmcDaoFvhPLi+I9hmCfj/FqkhKX3D/P4SH8A8rPUlyNSD
	 zWIXtS6hJcN+UartEYncpAgrnNCil3z7fl37FIKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfK1Nky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:40:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbfK1Nkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:40:52 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B406421787;
        Thu, 28 Nov 2019 13:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574948450;
        bh=EhqFrJqZfSSWtQsAhrg5OdFHgcRGwaGySkg1/+rWPw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p+0Y9R2+v3MlCojPtzGLbZCPRTQHy3UqjvMtIhc/iGpAdUi1HXYwh/gnsHJiAMH3y
         QXfdX5sR+H1F7ICe7oCGCGeWbM8y+J5f4f958lBS2Iwmq61eNoGDfV0vgao3Kblg+m
         ZZtbwiGXKV+p8pMf2KlpLZhncQgjnSRHPP5DGCkE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/22] x86/insn: Add some more Intel instructions to the opcode map
Date:   Thu, 28 Nov 2019 10:40:10 -0300
Message-Id: <20191128134027.23726-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128134027.23726-1-acme@kernel.org>
References: <20191128134027.23726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add to the opcode map the following instructions:

	v4fmaddps
	v4fmaddss
	v4fnmaddps
	v4fnmaddss
	vaesdec
	vaesdeclast
	vaesenc
	vaesenclast
	vcvtne2ps2bf16
	vcvtneps2bf16
	vdpbf16ps
	gf2p8affineinvqb
	vgf2p8affineinvqb
	gf2p8affineqb
	vgf2p8affineqb
	gf2p8mulb
	vgf2p8mulb
	vp2intersectd
	vp2intersectq
	vp4dpwssd
	vp4dpwssds
	vpclmulqdq
	vpcompressb
	vpcompressw
	vpdpbusd
	vpdpbusds
	vpdpwssd
	vpdpwssds
	vpexpandb
	vpexpandw
	vpopcntb
	vpopcntd
	vpopcntq
	vpopcntw
	vpshldd
	vpshldq
	vpshldvd
	vpshldvq
	vpshldvw
	vpshldw
	vpshrdd
	vpshrdq
	vpshrdvd
	vpshrdvq
	vpshrdvw
	vpshrdw
	vpshufbitqmb

For information about the instructions, refer Intel SDM May 2019
(325462-070US) and Intel Architecture Instruction Set Extensions May
2019 (319433-037).

The instruction decoding can be tested using the perf tools' "x86
instruction decoder - new instructions" test e.g.

  $ perf test -v "new " 2>&1 | grep -i 'v4fmaddps'
  Decoded ok: 62 f2 7f 48 9a 20                   v4fmaddps (%eax),%zmm0,%zmm4
  Decoded ok: 62 f2 7f 48 9a a4 c8 78 56 34 12    v4fmaddps 0x12345678(%eax,%ecx,8),%zmm0,%zmm4
  Decoded ok: 62 f2 7f 48 9a 20                   v4fmaddps (%rax),%zmm0,%zmm4
  Decoded ok: 67 62 f2 7f 48 9a 20                v4fmaddps (%eax),%zmm0,%zmm4
  Decoded ok: 62 f2 7f 48 9a a4 c8 78 56 34 12    v4fmaddps 0x12345678(%rax,%rcx,8),%zmm0,%zmm4
  Decoded ok: 67 62 f2 7f 48 9a a4 c8 78 56 34 12 v4fmaddps 0x12345678(%eax,%ecx,8),%zmm0,%zmm4

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: x86@kernel.org
Link: http://lore.kernel.org/lkml/20191125125044.31879-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 arch/x86/lib/x86-opcode-map.txt       | 44 +++++++++++++++++++--------
 tools/arch/x86/lib/x86-opcode-map.txt | 44 +++++++++++++++++++--------
 2 files changed, 64 insertions(+), 24 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index 0a0e9112f284..8908c58bd6cd 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -695,16 +695,28 @@ AVXcode: 2
 4d: vrcp14ss/d Vsd,Hpd,Wsd (66),(ev)
 4e: vrsqrt14ps/d Vpd,Wpd (66),(ev)
 4f: vrsqrt14ss/d Vsd,Hsd,Wsd (66),(ev)
-# Skip 0x50-0x57
+50: vpdpbusd Vx,Hx,Wx (66),(ev)
+51: vpdpbusds Vx,Hx,Wx (66),(ev)
+52: vdpbf16ps Vx,Hx,Wx (F3),(ev) | vpdpwssd Vx,Hx,Wx (66),(ev) | vp4dpwssd Vdqq,Hdqq,Wdq (F2),(ev)
+53: vpdpwssds Vx,Hx,Wx (66),(ev) | vp4dpwssds Vdqq,Hdqq,Wdq (F2),(ev)
+54: vpopcntb/w Vx,Wx (66),(ev)
+55: vpopcntd/q Vx,Wx (66),(ev)
 58: vpbroadcastd Vx,Wx (66),(v)
 59: vpbroadcastq Vx,Wx (66),(v) | vbroadcasti32x2 Vx,Wx (66),(evo)
 5a: vbroadcasti128 Vqq,Mdq (66),(v) | vbroadcasti32x4/64x2 Vx,Wx (66),(evo)
 5b: vbroadcasti32x8/64x4 Vqq,Mdq (66),(ev)
-# Skip 0x5c-0x63
+# Skip 0x5c-0x61
+62: vpexpandb/w Vx,Wx (66),(ev)
+63: vpcompressb/w Wx,Vx (66),(ev)
 64: vpblendmd/q Vx,Hx,Wx (66),(ev)
 65: vblendmps/d Vx,Hx,Wx (66),(ev)
 66: vpblendmb/w Vx,Hx,Wx (66),(ev)
-# Skip 0x67-0x74
+68: vp2intersectd/q Kx,Hx,Wx (F2),(ev)
+# Skip 0x69-0x6f
+70: vpshldvw Vx,Hx,Wx (66),(ev)
+71: vpshldvd/q Vx,Hx,Wx (66),(ev)
+72: vcvtne2ps2bf16 Vx,Hx,Wx (F2),(ev) | vcvtneps2bf16 Vx,Wx (F3),(ev) | vpshrdvw Vx,Hx,Wx (66),(ev)
+73: vpshrdvd/q Vx,Hx,Wx (66),(ev)
 75: vpermi2b/w Vx,Hx,Wx (66),(ev)
 76: vpermi2d/q Vx,Hx,Wx (66),(ev)
 77: vpermi2ps/d Vx,Hx,Wx (66),(ev)
@@ -727,6 +739,7 @@ AVXcode: 2
 8c: vpmaskmovd/q Vx,Hx,Mx (66),(v)
 8d: vpermb/w Vx,Hx,Wx (66),(ev)
 8e: vpmaskmovd/q Mx,Vx,Hx (66),(v)
+8f: vpshufbitqmb Kx,Hx,Wx (66),(ev)
 # 0x0f 0x38 0x90-0xbf (FMA)
 90: vgatherdd/q Vx,Hx,Wx (66),(v) | vpgatherdd/q Vx,Wx (66),(evo)
 91: vgatherqd/q Vx,Hx,Wx (66),(v) | vpgatherqd/q Vx,Wx (66),(evo)
@@ -738,8 +751,8 @@ AVXcode: 2
 97: vfmsubadd132ps/d Vx,Hx,Wx (66),(v)
 98: vfmadd132ps/d Vx,Hx,Wx (66),(v)
 99: vfmadd132ss/d Vx,Hx,Wx (66),(v),(v1)
-9a: vfmsub132ps/d Vx,Hx,Wx (66),(v)
-9b: vfmsub132ss/d Vx,Hx,Wx (66),(v),(v1)
+9a: vfmsub132ps/d Vx,Hx,Wx (66),(v) | v4fmaddps Vdqq,Hdqq,Wdq (F2),(ev)
+9b: vfmsub132ss/d Vx,Hx,Wx (66),(v),(v1) | v4fmaddss Vdq,Hdq,Wdq (F2),(ev)
 9c: vfnmadd132ps/d Vx,Hx,Wx (66),(v)
 9d: vfnmadd132ss/d Vx,Hx,Wx (66),(v),(v1)
 9e: vfnmsub132ps/d Vx,Hx,Wx (66),(v)
@@ -752,8 +765,8 @@ a6: vfmaddsub213ps/d Vx,Hx,Wx (66),(v)
 a7: vfmsubadd213ps/d Vx,Hx,Wx (66),(v)
 a8: vfmadd213ps/d Vx,Hx,Wx (66),(v)
 a9: vfmadd213ss/d Vx,Hx,Wx (66),(v),(v1)
-aa: vfmsub213ps/d Vx,Hx,Wx (66),(v)
-ab: vfmsub213ss/d Vx,Hx,Wx (66),(v),(v1)
+aa: vfmsub213ps/d Vx,Hx,Wx (66),(v) | v4fnmaddps Vdqq,Hdqq,Wdq (F2),(ev)
+ab: vfmsub213ss/d Vx,Hx,Wx (66),(v),(v1) | v4fnmaddss Vdq,Hdq,Wdq (F2),(ev)
 ac: vfnmadd213ps/d Vx,Hx,Wx (66),(v)
 ad: vfnmadd213ss/d Vx,Hx,Wx (66),(v),(v1)
 ae: vfnmsub213ps/d Vx,Hx,Wx (66),(v)
@@ -780,11 +793,12 @@ ca: sha1msg2 Vdq,Wdq | vrcp28ps/d Vx,Wx (66),(ev)
 cb: sha256rnds2 Vdq,Wdq | vrcp28ss/d Vx,Hx,Wx (66),(ev)
 cc: sha256msg1 Vdq,Wdq | vrsqrt28ps/d Vx,Wx (66),(ev)
 cd: sha256msg2 Vdq,Wdq | vrsqrt28ss/d Vx,Hx,Wx (66),(ev)
+cf: vgf2p8mulb Vx,Wx (66)
 db: VAESIMC Vdq,Wdq (66),(v1)
-dc: VAESENC Vdq,Hdq,Wdq (66),(v1)
-dd: VAESENCLAST Vdq,Hdq,Wdq (66),(v1)
-de: VAESDEC Vdq,Hdq,Wdq (66),(v1)
-df: VAESDECLAST Vdq,Hdq,Wdq (66),(v1)
+dc: vaesenc Vx,Hx,Wx (66)
+dd: vaesenclast Vx,Hx,Wx (66)
+de: vaesdec Vx,Hx,Wx (66)
+df: vaesdeclast Vx,Hx,Wx (66)
 f0: MOVBE Gy,My | MOVBE Gw,Mw (66) | CRC32 Gd,Eb (F2) | CRC32 Gd,Eb (66&F2)
 f1: MOVBE My,Gy | MOVBE Mw,Gw (66) | CRC32 Gd,Ey (F2) | CRC32 Gd,Ew (66&F2)
 f2: ANDN Gy,By,Ey (v)
@@ -848,7 +862,7 @@ AVXcode: 3
 41: vdppd Vdq,Hdq,Wdq,Ib (66),(v1)
 42: vmpsadbw Vx,Hx,Wx,Ib (66),(v1) | vdbpsadbw Vx,Hx,Wx,Ib (66),(evo)
 43: vshufi32x4/64x2 Vx,Hx,Wx,Ib (66),(ev)
-44: vpclmulqdq Vdq,Hdq,Wdq,Ib (66),(v1)
+44: vpclmulqdq Vx,Hx,Wx,Ib (66)
 46: vperm2i128 Vqq,Hqq,Wqq,Ib (66),(v)
 4a: vblendvps Vx,Hx,Wx,Lx (66),(v)
 4b: vblendvpd Vx,Hx,Wx,Lx (66),(v)
@@ -865,7 +879,13 @@ AVXcode: 3
 63: vpcmpistri Vdq,Wdq,Ib (66),(v1)
 66: vfpclassps/d Vk,Wx,Ib (66),(ev)
 67: vfpclassss/d Vk,Wx,Ib (66),(ev)
+70: vpshldw Vx,Hx,Wx,Ib (66),(ev)
+71: vpshldd/q Vx,Hx,Wx,Ib (66),(ev)
+72: vpshrdw Vx,Hx,Wx,Ib (66),(ev)
+73: vpshrdd/q Vx,Hx,Wx,Ib (66),(ev)
 cc: sha1rnds4 Vdq,Wdq,Ib
+ce: vgf2p8affineqb Vx,Wx,Ib (66)
+cf: vgf2p8affineinvqb Vx,Wx,Ib (66)
 df: VAESKEYGEN Vdq,Wdq,Ib (66),(v1)
 f0: RORX Gy,Ey,Ib (F2),(v)
 EndTable
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index 0a0e9112f284..8908c58bd6cd 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -695,16 +695,28 @@ AVXcode: 2
 4d: vrcp14ss/d Vsd,Hpd,Wsd (66),(ev)
 4e: vrsqrt14ps/d Vpd,Wpd (66),(ev)
 4f: vrsqrt14ss/d Vsd,Hsd,Wsd (66),(ev)
-# Skip 0x50-0x57
+50: vpdpbusd Vx,Hx,Wx (66),(ev)
+51: vpdpbusds Vx,Hx,Wx (66),(ev)
+52: vdpbf16ps Vx,Hx,Wx (F3),(ev) | vpdpwssd Vx,Hx,Wx (66),(ev) | vp4dpwssd Vdqq,Hdqq,Wdq (F2),(ev)
+53: vpdpwssds Vx,Hx,Wx (66),(ev) | vp4dpwssds Vdqq,Hdqq,Wdq (F2),(ev)
+54: vpopcntb/w Vx,Wx (66),(ev)
+55: vpopcntd/q Vx,Wx (66),(ev)
 58: vpbroadcastd Vx,Wx (66),(v)
 59: vpbroadcastq Vx,Wx (66),(v) | vbroadcasti32x2 Vx,Wx (66),(evo)
 5a: vbroadcasti128 Vqq,Mdq (66),(v) | vbroadcasti32x4/64x2 Vx,Wx (66),(evo)
 5b: vbroadcasti32x8/64x4 Vqq,Mdq (66),(ev)
-# Skip 0x5c-0x63
+# Skip 0x5c-0x61
+62: vpexpandb/w Vx,Wx (66),(ev)
+63: vpcompressb/w Wx,Vx (66),(ev)
 64: vpblendmd/q Vx,Hx,Wx (66),(ev)
 65: vblendmps/d Vx,Hx,Wx (66),(ev)
 66: vpblendmb/w Vx,Hx,Wx (66),(ev)
-# Skip 0x67-0x74
+68: vp2intersectd/q Kx,Hx,Wx (F2),(ev)
+# Skip 0x69-0x6f
+70: vpshldvw Vx,Hx,Wx (66),(ev)
+71: vpshldvd/q Vx,Hx,Wx (66),(ev)
+72: vcvtne2ps2bf16 Vx,Hx,Wx (F2),(ev) | vcvtneps2bf16 Vx,Wx (F3),(ev) | vpshrdvw Vx,Hx,Wx (66),(ev)
+73: vpshrdvd/q Vx,Hx,Wx (66),(ev)
 75: vpermi2b/w Vx,Hx,Wx (66),(ev)
 76: vpermi2d/q Vx,Hx,Wx (66),(ev)
 77: vpermi2ps/d Vx,Hx,Wx (66),(ev)
@@ -727,6 +739,7 @@ AVXcode: 2
 8c: vpmaskmovd/q Vx,Hx,Mx (66),(v)
 8d: vpermb/w Vx,Hx,Wx (66),(ev)
 8e: vpmaskmovd/q Mx,Vx,Hx (66),(v)
+8f: vpshufbitqmb Kx,Hx,Wx (66),(ev)
 # 0x0f 0x38 0x90-0xbf (FMA)
 90: vgatherdd/q Vx,Hx,Wx (66),(v) | vpgatherdd/q Vx,Wx (66),(evo)
 91: vgatherqd/q Vx,Hx,Wx (66),(v) | vpgatherqd/q Vx,Wx (66),(evo)
@@ -738,8 +751,8 @@ AVXcode: 2
 97: vfmsubadd132ps/d Vx,Hx,Wx (66),(v)
 98: vfmadd132ps/d Vx,Hx,Wx (66),(v)
 99: vfmadd132ss/d Vx,Hx,Wx (66),(v),(v1)
-9a: vfmsub132ps/d Vx,Hx,Wx (66),(v)
-9b: vfmsub132ss/d Vx,Hx,Wx (66),(v),(v1)
+9a: vfmsub132ps/d Vx,Hx,Wx (66),(v) | v4fmaddps Vdqq,Hdqq,Wdq (F2),(ev)
+9b: vfmsub132ss/d Vx,Hx,Wx (66),(v),(v1) | v4fmaddss Vdq,Hdq,Wdq (F2),(ev)
 9c: vfnmadd132ps/d Vx,Hx,Wx (66),(v)
 9d: vfnmadd132ss/d Vx,Hx,Wx (66),(v),(v1)
 9e: vfnmsub132ps/d Vx,Hx,Wx (66),(v)
@@ -752,8 +765,8 @@ a6: vfmaddsub213ps/d Vx,Hx,Wx (66),(v)
 a7: vfmsubadd213ps/d Vx,Hx,Wx (66),(v)
 a8: vfmadd213ps/d Vx,Hx,Wx (66),(v)
 a9: vfmadd213ss/d Vx,Hx,Wx (66),(v),(v1)
-aa: vfmsub213ps/d Vx,Hx,Wx (66),(v)
-ab: vfmsub213ss/d Vx,Hx,Wx (66),(v),(v1)
+aa: vfmsub213ps/d Vx,Hx,Wx (66),(v) | v4fnmaddps Vdqq,Hdqq,Wdq (F2),(ev)
+ab: vfmsub213ss/d Vx,Hx,Wx (66),(v),(v1) | v4fnmaddss Vdq,Hdq,Wdq (F2),(ev)
 ac: vfnmadd213ps/d Vx,Hx,Wx (66),(v)
 ad: vfnmadd213ss/d Vx,Hx,Wx (66),(v),(v1)
 ae: vfnmsub213ps/d Vx,Hx,Wx (66),(v)
@@ -780,11 +793,12 @@ ca: sha1msg2 Vdq,Wdq | vrcp28ps/d Vx,Wx (66),(ev)
 cb: sha256rnds2 Vdq,Wdq | vrcp28ss/d Vx,Hx,Wx (66),(ev)
 cc: sha256msg1 Vdq,Wdq | vrsqrt28ps/d Vx,Wx (66),(ev)
 cd: sha256msg2 Vdq,Wdq | vrsqrt28ss/d Vx,Hx,Wx (66),(ev)
+cf: vgf2p8mulb Vx,Wx (66)
 db: VAESIMC Vdq,Wdq (66),(v1)
-dc: VAESENC Vdq,Hdq,Wdq (66),(v1)
-dd: VAESENCLAST Vdq,Hdq,Wdq (66),(v1)
-de: VAESDEC Vdq,Hdq,Wdq (66),(v1)
-df: VAESDECLAST Vdq,Hdq,Wdq (66),(v1)
+dc: vaesenc Vx,Hx,Wx (66)
+dd: vaesenclast Vx,Hx,Wx (66)
+de: vaesdec Vx,Hx,Wx (66)
+df: vaesdeclast Vx,Hx,Wx (66)
 f0: MOVBE Gy,My | MOVBE Gw,Mw (66) | CRC32 Gd,Eb (F2) | CRC32 Gd,Eb (66&F2)
 f1: MOVBE My,Gy | MOVBE Mw,Gw (66) | CRC32 Gd,Ey (F2) | CRC32 Gd,Ew (66&F2)
 f2: ANDN Gy,By,Ey (v)
@@ -848,7 +862,7 @@ AVXcode: 3
 41: vdppd Vdq,Hdq,Wdq,Ib (66),(v1)
 42: vmpsadbw Vx,Hx,Wx,Ib (66),(v1) | vdbpsadbw Vx,Hx,Wx,Ib (66),(evo)
 43: vshufi32x4/64x2 Vx,Hx,Wx,Ib (66),(ev)
-44: vpclmulqdq Vdq,Hdq,Wdq,Ib (66),(v1)
+44: vpclmulqdq Vx,Hx,Wx,Ib (66)
 46: vperm2i128 Vqq,Hqq,Wqq,Ib (66),(v)
 4a: vblendvps Vx,Hx,Wx,Lx (66),(v)
 4b: vblendvpd Vx,Hx,Wx,Lx (66),(v)
@@ -865,7 +879,13 @@ AVXcode: 3
 63: vpcmpistri Vdq,Wdq,Ib (66),(v1)
 66: vfpclassps/d Vk,Wx,Ib (66),(ev)
 67: vfpclassss/d Vk,Wx,Ib (66),(ev)
+70: vpshldw Vx,Hx,Wx,Ib (66),(ev)
+71: vpshldd/q Vx,Hx,Wx,Ib (66),(ev)
+72: vpshrdw Vx,Hx,Wx,Ib (66),(ev)
+73: vpshrdd/q Vx,Hx,Wx,Ib (66),(ev)
 cc: sha1rnds4 Vdq,Wdq,Ib
+ce: vgf2p8affineqb Vx,Wx,Ib (66)
+cf: vgf2p8affineinvqb Vx,Wx,Ib (66)
 df: VAESKEYGEN Vdq,Wdq,Ib (66),(v1)
 f0: RORX Gy,Ey,Ib (F2),(v)
 EndTable
-- 
2.21.0

