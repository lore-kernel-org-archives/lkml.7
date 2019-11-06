Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B467C5DF60
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 00:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6606214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 00:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KngW0n+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfKFAG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 19:06:59 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:2563 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbfKFAG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 19:06:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1572998819; x=1604534819;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9+9EDzlFDTNp9/Z8GOSoCt1TUGGrH1xywpXlR2HtQmI=;
  b=KngW0n+dUhjVzCyfsc+vaqvi9K6MSCBuagY6aqnn+x279iCYUCKlf+cB
   VlmyHkMnE+DDVauw90/WBLUHHf9CSvbsa4ut/qox/beTfHhSE8euWMlRg
   aK5aCIuomvzG3qqswZaR2fNXVZQmeAU0ZJapD0j6puafw7kL5EZlb55cp
   MINuw79PRPTGJWxQF7SEqfBH815NMb6NRhF3fEDB9kuvWi05o+XBIob+0
   EYxIIOsQ9K5VOGcSqeiliVlr34gSUw7wKeDQKoVvceF80HpBmBXS2P61P
   TutL4aX/2rWPyayfG6xom88aviPeul+EidsCQ9SnGYFSy/QhC+jTeWTpq
   Q==;
IronPort-SDR: eDefiXdZwHee1smZz4gDSiq6Xf/vz8fDb0U+JTKMqnB45QRuSlDraRPykJKgAfRhlxKuEvLAiW
 PlBYuMTQeUc/3xB6idf+YQ1Q1WIDvX2JDt0AP46ikqi3y61/gI/9GbZz641hXY5h0FRozIvYMH
 K478Htqtx2f+7snLwX1xNhPF5kOig1NyFfyBDLcFh/rJB9XQOTFVny524XIBYp+G15yn7IkP6u
 llbOoHlcH7VNlbj5xi8zaXvTeecjoMp7cwo6VybBm0A2FtJ/uwHw+B0GaR67BIHzZmaiV+79SW
 Yyk=
X-IronPort-AV: E=Sophos;i="5.68,271,1569254400"; 
   d="scan'208";a="123838558"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2019 08:06:58 +0800
IronPort-SDR: ZO/3uHRJGoWYOPTUBx0CuJ/bkASTSjwldWsD0xiHTi+AC0AphuIlB6pUcLGJU0rRnvDliwNNrX
 VCZwWCEeIQ0+6SBySyqP8hnDvoOGh38tRq3tgjqGHp1IeKqruDm2wfvl+Zcaply9sk+2od1RLk
 X1iucNKrr/CpLPQ1lPbB2sEiZi2rHg2JS8aSv+e/1TEwo9JwX+Yo+yxcIf+NH4I963DV6LBpIb
 ccvYo3ju8F1kZ819lh1CPklO5kpnodvg9w7QLrBCFfYzaGDsl116S3Hx+gDIkxcW97Y3dZtrBd
 v590NdcT4ZGFZNwwfgUj160X
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 16:02:11 -0800
IronPort-SDR: vh7cUu24VmQmVXEdKsm4LuWH9m0ZsRfp77NEUxJhWkKhEXJXYChdhjvup9hikb6x+KE2pPuAOD
 hdm7fc96/jeIBGZ7nMYyKFoNnasKxt/vmA8UB4jDiH6hxH/bRikK7uDxMrB0dpAEu0V4DV6LPi
 KXqxX/xzIJwaoUxXekMJbI1RKigPE9V3c7X6bbBdqRb4nSAf0VWGNvOXxRIcE9mDDlFN1GxAZV
 dRZn7Wg0k4jWgvEHmtZWWhfT2xYbV9NWLE46Dfy0as6J5WajHCKsJ+r6ZapH+CnkVi63SaA5G0
 cqk=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Nov 2019 16:06:58 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH] RISC-V: Add multiple compression image format.
Date:   Tue,  5 Nov 2019 16:06:52 -0800
Message-Id: <20191106000652.8370-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there is only support for .gz compression type
for generating kernel Image.

Add support for other compression methods(lzma, lz4, lzo, bzip2)
that helps in generating a even smaller kernel image. Image.gz
will still be the default compressed image.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/boot/Makefile | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
index 0990a9fdbe5d..88356650c992 100644
--- a/arch/riscv/boot/Makefile
+++ b/arch/riscv/boot/Makefile
@@ -24,6 +24,18 @@ $(obj)/Image: vmlinux FORCE
 $(obj)/Image.gz: $(obj)/Image FORCE
 	$(call if_changed,gzip)
 
+$(obj)/Image.bz2: $(obj)/Image FORCE
+	$(call if_changed,bzip2)
+
+$(obj)/Image.lz4: $(obj)/Image FORCE
+	$(call if_changed,lz4)
+
+$(obj)/Image.lzma: $(obj)/Image FORCE
+	$(call if_changed,lzma)
+
+$(obj)/Image.lzo: $(obj)/Image FORCE
+	$(call if_changed,lzo)
+
 install:
 	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
 	$(obj)/Image System.map "$(INSTALL_PATH)"
-- 
2.21.0

