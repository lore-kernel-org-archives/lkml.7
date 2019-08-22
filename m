Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C69C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E5A21726
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IE9V3zAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbfHVH7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 03:59:01 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:20003 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730431AbfHVH67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 03:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566460740; x=1597996740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zMgrwQo3ioYoX5CQO1W5apOPVVHZ8O/Xw2bhvtHvfOw=;
  b=IE9V3zAURPI/mVnJ1sUct3ATBTOGZxJr24cA3cnV6DQD121JhXzrY7bG
   dsYnvkN3UbU8+FnNeRZUOsJZjXxOuV6Jpo/ocyUNfbPq2vMDv1Ky/hY0/
   HZnlcf+HYEIDM7U9J4/+AwNfmf0a9/S1XMVJkjcqae5G1WxGneVN8yNbS
   1FiB591PHFBr8D12bPqaITTTxfMbVtjRM1sR4Dm7uJyK7oZDZtAIfeysE
   bZo7eWcUNHJlSjtcy0NrBqpr1bl/CkhXJp66vuwFBFV5ZfnUzX5sL0kId
   aI9XDKGWpC6uvMBggMB2DbNFdiGBWToZ9OiHqhglyBPxCaX9et+2Q06fy
   A==;
IronPort-SDR: HoU518b1x4zmaa6VN+71c4unrRg0Vl7FfQFLPSX2Kgycl1uDckKqYckl6QStdm7mxD9PGXfNeq
 EIf8topBLfb3rpBUI6a8HIW0E9T7i4I0J2S9ktOGkcIRQM6ZdroiBZ0BRGVIK/aiVF89FA8XcP
 qWYJBfxuPQdU0diSBMWiDarDvDjZnj1z3NYbD0haTfTl4n3Mo8CUBfGmCwAZU5hpaEAZp/oDFs
 xa+shTw8KLOqNqMU5MnjjB2z73WWyyMuRXtJt4KK77fFpToJrMbGkYtE6LTW5hgj3rMgp07vYk
 NEs=
X-IronPort-AV: E=Sophos;i="5.64,415,1559491200"; 
   d="scan'208";a="116397485"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2019 15:58:59 +0800
IronPort-SDR: XO2D3Pvo3sOykbykkGFoRvsUJAqHOyQU9ju7JA+Eur22Zk/69g7tNOXarEIVLOu/Em2ec/LEGE
 X+yGd9LGfEJeJ4w9uSA3ioROCoSeMauRATNicJwOr8Xb1OwU+ybjPkivjuFb/TIJNALt8PecI7
 qS97DTh6nDr5qXNoiRdlbEi94xwoLyU/FSgpkWP/MLq9pdUl0H7mce/j5EAx8TqyFbZTxVgpY+
 2wiZa7GKuxJ+aVvlDabu3PjT7oHsRN0URZKpdTanWl87LitGvV5SxhNV1evsccEBiVk+rP7JPc
 ZKIiIAxJtcKgrz43nBte5fxL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 00:56:19 -0700
IronPort-SDR: 7VJp5AX1m3dQMbgrglO08YJQbJAypaQXuQTfTNHQ3OB2+NiU57sfGAMfxX/aL2VOobx6ltblnx
 LktuVXVYN25WuohHaGZgbFHpzHBTIBkAER1BV5wVs7vtyLXxeGXzwobK/aDtd+1AXCl4bBByj8
 s/niCGcIiy4ZSwPKQLi7THnQrriAEe/6k1/YEV7A4c9LCcHQBB74I1s8jZcxTTZD4udB2oVhw1
 9Tfo8Ai5rcFo8yWnWPhXzGi8hMGGxcTyc4/qj4d+/v6bs3XmBI/YlGP/JtneDHWSNlgx/R9R3M
 Coc=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Aug 2019 00:58:59 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@lst.de>, Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v4 3/3] RISC-V: Issue a tlb page flush if possible
Date:   Thu, 22 Aug 2019 00:51:51 -0700
Message-Id: <20190822075151.24838-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822075151.24838-1-atish.patra@wdc.com>
References: <20190822075151.24838-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If tlbflush request is for page only, there is no need to do a
complete local tlb shootdown.

Just do a local tlb flush for the given address.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/mm/tlbflush.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 8172fbf46123..b1c04751bcf1 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -27,7 +27,10 @@ static void __sbi_tlb_flush_range(struct cpumask *cmask, unsigned long start,
 
 	if (cpumask_any_but(cmask, cpuid) >= nr_cpu_ids) {
 		/* local cpu is the only cpu present in cpumask */
-		local_flush_tlb_all();
+		if (size <= PAGE_SIZE)
+			local_flush_tlb_page(start);
+		else
+			local_flush_tlb_all();
 	} else {
 		riscv_cpuid_to_hartid_mask(cmask, &hmask);
 		sbi_remote_sfence_vma(cpumask_bits(&hmask), start, size);
-- 
2.21.0

