Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CDEC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9709E216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Cvm0zx54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfEJJAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 05:00:38 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:47461 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbfEJJAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 05:00:38 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CC540891AB;
        Fri, 10 May 2019 21:00:32 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1557478832;
        bh=a2N5ljKDh064bmfEmLWhlBmHgOU5t3wv3K3qWa5WcuE=;
        h=From:To:Cc:Subject:Date;
        b=Cvm0zx54BAVHFGb5yrLDvm3P596TBlTy47ZkN75dWg/mLGeqfTgpL3uv843OJLiDm
         GgTWGBMc2t/innLjR1MBVud5NcGpEUTNtpUReV5HGJEp9q3wsS6y9JGuLVGiJon4pw
         BVJV8GA7diEI1I3W/e6krcJerDsxjvw3urxEBSkr9f0Erk8xDSIV5Pt88U8MSBmc67
         LWGEQCY1hlJ1lo9LxfUV+iHKVFcjyXU7jxxeCXdBgx0tx/su9nZvy/X9R1CP5BL4dr
         EvqvwnezDosMEia7t9el1SyMn6vUQdV0xv293mN9k+UjT40SV723VygGv4VcuX9er8
         lSrIee3T6t5mw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5cd53db10000>; Fri, 10 May 2019 21:00:33 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id B1DA213EEA0;
        Fri, 10 May 2019 21:00:32 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 36F901E1D5B; Fri, 10 May 2019 21:00:32 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     keescook@chromium.org, re.emese@gmail.com
Cc:     kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] gcc-plugins: arm_ssp_per_task_plugin: Fix for older GCC < 6
Date:   Fri, 10 May 2019 21:00:25 +1200
Message-Id: <20190510090025.4680-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use gen_rtx_set instead of gen_rtx_SET. The former is a wrapper macro
that handles the difference between GCC versions implementing
the latter.

This fixes the following error on my system with g++ 5.4.0 as the host
compiler

   HOSTCXX -fPIC scripts/gcc-plugins/arm_ssp_per_task_plugin.o
 scripts/gcc-plugins/arm_ssp_per_task_plugin.c:42:14: error: macro "gen_r=
tx_SET" requires 3 arguments, but only 2 given
          mask)),
               ^
 scripts/gcc-plugins/arm_ssp_per_task_plugin.c: In function =E2=80=98unsi=
gned int arm_pertask_ssp_rtl_execute()=E2=80=99:
 scripts/gcc-plugins/arm_ssp_per_task_plugin.c:39:20: error: =E2=80=98gen=
_rtx_SET=E2=80=99 was not declared in this scope
    emit_insn_before(gen_rtx_SET

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 scripts/gcc-plugins/arm_ssp_per_task_plugin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gcc-plugins/arm_ssp_per_task_plugin.c b/scripts/gcc-=
plugins/arm_ssp_per_task_plugin.c
index 89c47f57d1ce..8c1af9bdcb1b 100644
--- a/scripts/gcc-plugins/arm_ssp_per_task_plugin.c
+++ b/scripts/gcc-plugins/arm_ssp_per_task_plugin.c
@@ -36,7 +36,7 @@ static unsigned int arm_pertask_ssp_rtl_execute(void)
 		mask =3D GEN_INT(sext_hwi(sp_mask, GET_MODE_PRECISION(Pmode)));
 		masked_sp =3D gen_reg_rtx(Pmode);
=20
-		emit_insn_before(gen_rtx_SET(masked_sp,
+		emit_insn_before(gen_rtx_set(masked_sp,
 					     gen_rtx_AND(Pmode,
 							 stack_pointer_rtx,
 							 mask)),
--=20
2.21.0

