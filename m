Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8026FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADAB20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X2OMaI6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfDJWpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:45:21 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:49968 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfDJWpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1554936312; x=1586472312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6727VdCc/EPDYJfj5RPHOjXG6b1yki4VRIhepLKeGtA=;
  b=X2OMaI6JD+rAlmn68xo4Cueez5OmBWWlkz2gJehVxowZZgWL89uU22L5
   8iDiVSk2YkXHnEobOIlD51SgBy67gYt/UxNQImK2mmGKzhhOKM1R3+PlK
   t2qiup4vutXH2PTei41pE0giga42Rw4//JUyi+oEPSXeAqGxFMq905xEl
   jBNyA6mkwg7INuKZzITWU7RBjIg0JSN1qL82LbmeT7wrLZQN2Gpw7K2vZ
   LBy+hj/7d1U1na61uiErrcjfo+V70nCHZw5vwtsfhkY9RwcpOf92W95gT
   tcehQJuBu7Qu+t4eNXzOds4092kie2uUTPCfrzuleCT6nmZs2oTUAq2ze
   A==;
X-IronPort-AV: E=Sophos;i="5.60,335,1549900800"; 
   d="scan'208";a="105470413"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2019 06:45:12 +0800
IronPort-SDR: bndv9nhEPekbbCwSTfidk0utiMDBpLHfYkf2kYa6AlJimbXBC3PBFQtDrMbeJa6IG7J9sLHBjQ
 F65ZHKjd34IpUZnAYJWK/bYIBTlcA54R/AeG5D0vWh/7t7r75FJC8cpusOooz0h+1kX9ikZC4K
 x+w2GXGbJ50gsvs17Mt6NC8vPlPljp3LScazuYZ2Am11NgaXn7roIM/nS5+7C2MtFItdESAzmC
 bj+9x7+HAYEFBg5qSo78W3JegGB0QuSe/RmUlfQsMy1yjsqViTEVoLffn1X8LQcSW9M73aBExV
 AERYXsLOcIYeU1JLgWORsaNs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 10 Apr 2019 15:22:06 -0700
IronPort-SDR: NXkg6ju7d4Lh0ulI2k5QJZZENFD98F/fotupJh0yskicrEHcAp7YRd9wiDnh/fw6OikcXYXkfg
 q+f8VoRlWmlLKJP0MfVLgB/+sjvP7k1boRWhHHyfXITa7MqmkOg23r/TolK8Cs3j3n6Hlv7k3F
 HVWJT7FqVhKCtpvV9oLxAiKoFIOvzrWotOeT8bkl71aLrcmCs73xEw1z3cWgX2NOBoJeg+IQRS
 3iEvqR83I9WJiZ1ZlhJDic+lfrExjNRVg0M2bDUH6jrPDhyba+Hc+KGrYeGx8jcWmjqq7HAg00
 e+c=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Apr 2019 15:45:11 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Borislav Petkov <bp@alien8.de>, Gary Guo <gary@garyguo.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-riscv@lists.infradead.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [3/3] RISC-V: Add DEBUG_TLBFLUSH option.
Date:   Wed, 10 Apr 2019 15:44:49 -0700
Message-Id: <20190410224449.10877-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190410224449.10877-1-atish.patra@wdc.com>
References: <20190410224449.10877-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TLB flush counters under vmstat seems to be very helpful while
debugging TLB flush performance in RISC-V.

Add the Kconfig option only for debug kernels.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/Kconfig.debug | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/Kconfig.debug b/arch/riscv/Kconfig.debug
index e69de29bb2d1..6a2d3762aeda 100644
--- a/arch/riscv/Kconfig.debug
+++ b/arch/riscv/Kconfig.debug
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config DEBUG_TLBFLUSH
+	bool "Save tlb flush statstics to vmstat"
+	depends on DEBUG_KERNEL
+	help
+
+	Add TLB flush statstics to vmstat. It is really helpful understand tlbflush
+	performance and behavior. It should be enabled only for debugging purpose.
+
+	If in doubt, say "N".
+
-- 
2.21.0

