Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4D0C3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2993214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jOt/EPS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbfHUTZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:25:16 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15779 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfHUTZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:25:16 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5d9a9c0000>; Wed, 21 Aug 2019 12:25:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 21 Aug 2019 12:25:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 21 Aug 2019 12:25:15 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 19:25:15 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 19:25:15 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 21 Aug 2019 19:25:15 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d5d9a9b0001>; Wed, 21 Aug 2019 12:25:15 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     "H . Peter Anvin" <hpa@zytor.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <gregkh@linuxfoundation.org>, <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Neil MacLeod <neil@nmacleod.com>, <stable@vger.kernel.org>
Subject: [PATCH] x86/boot: Fix boot failure regression
Date:   Wed, 21 Aug 2019 12:25:13 -0700
Message-ID: <20190821192513.20126-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <CAFbqK8=RUaCnk_WkioodkdwLsDina=yW+eLvzckSbVx_3Py_-A@mail.gmail.com>
References: <CAFbqK8=RUaCnk_WkioodkdwLsDina=yW+eLvzckSbVx_3Py_-A@mail.gmail.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566415516; bh=ucr7rfBqqfedkyuatW9cIEFGnyPN7FoxAX83ufXFfrY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=jOt/EPS3F5WJZf3aR6gpICax9WLuTVMxlu/t5B7ue1oW/cG+/ErojaJ21e+q5MuR0
         zBI11Nv7Pps35tW9m38daZq4ARL9yhu/EeYiED2ZnB2wNRXMRQZKxDmCJxsS9/5hJ+
         R7KXJfTdjOk0fZnWHzXKuYUK59xdvxCyimnb/sHDiVyb4Kn+gjtGFznja6e49j3exO
         mFAhN+cjVv3Z8PVmq1/RtczZ3C6jbKhQ8Q+IKKI4kx+KJHjHCjeN3OQAuBzxN/cyDO
         3aHnA40sYh+S0ON694NqXgXgO5E4xYHNF/8B3nDoWX4+ilC2tu6XKw09k2SWJ3O6VC
         qHCq7xDA/9hqQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit a90118c445cc ("x86/boot: Save fields explicitly, zero out
everything else") had two errors:

    * It preserved boot_params.acpi_rsdp_addr, and
    * It failed to preserve boot_params.hdr

Therefore, zero out acpi_rsdp_addr, and preserve hdr.

Fixes: a90118c445cc ("x86/boot: Save fields explicitly, zero out everything=
 else")
Reported-by: Neil MacLeod <neil@nmacleod.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: stable@vger.kernel.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 arch/x86/include/asm/bootparam_utils.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/bootparam_utils.h b/arch/x86/include/asm/=
bootparam_utils.h
index f5e90a849bca..9e5f3c722c33 100644
--- a/arch/x86/include/asm/bootparam_utils.h
+++ b/arch/x86/include/asm/bootparam_utils.h
@@ -59,7 +59,6 @@ static void sanitize_boot_params(struct boot_params *boot=
_params)
 			BOOT_PARAM_PRESERVE(apm_bios_info),
 			BOOT_PARAM_PRESERVE(tboot_addr),
 			BOOT_PARAM_PRESERVE(ist_info),
-			BOOT_PARAM_PRESERVE(acpi_rsdp_addr),
 			BOOT_PARAM_PRESERVE(hd0_info),
 			BOOT_PARAM_PRESERVE(hd1_info),
 			BOOT_PARAM_PRESERVE(sys_desc_table),
@@ -71,6 +70,7 @@ static void sanitize_boot_params(struct boot_params *boot=
_params)
 			BOOT_PARAM_PRESERVE(eddbuf_entries),
 			BOOT_PARAM_PRESERVE(edd_mbr_sig_buf_entries),
 			BOOT_PARAM_PRESERVE(edd_mbr_sig_buffer),
+			BOOT_PARAM_PRESERVE(hdr),
 			BOOT_PARAM_PRESERVE(e820_table),
 			BOOT_PARAM_PRESERVE(eddbuf),
 		};
--=20
2.22.1

