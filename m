Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5797C41514
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 00:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AABBA217D4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 00:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YVL8hvki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfHAA6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 20:58:53 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:61766 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbfHAA6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 20:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564621121; x=1596157121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OremRQyuncth6RJmwcRirDjBWRulyVTwgRdrAhtDf+0=;
  b=YVL8hvkicD80siH6Zjit5BY9kMgrKXBjxLePjERDB6eCEXpinCqpkDsf
   agSgpbcRQN5wQ1lVUPEKR6IKYWU26yd3L/yZo78pYIQINCwP8j91UPC+R
   IVrjAiiY/bhD20wc5zvqitOV2i7KutnJSszziJCv8K8SPUpLKPEwOPpUj
   ah0A87esnjqnwf1zDFAgJ2KLPqNKRbNp+CYzUqjj/O1I/OVdpRwWkuTjO
   xG/PGttlhGL5sL4m9sUR33nPvCqqxWrl2WigPOB3HmjpRDePpP/35TpRY
   yN/SGtTusgwqEAM/DWfKFy+QAVp58caisu1eSoarcnwZ8vg3yvp9ues8h
   g==;
IronPort-SDR: 6wnYWqtZSU38gVjkgQxoDu6H5DygwCXBnFkdP+tQkEjVywPgosIzP3plPyB5ig9kTJa/m7aAX8
 QcvXEImx0OYwph4YfJ46AP5fxpJw1i/iBAAIbfN39GnPPEWZXiRzm03keZwShcUC929AvJnf1x
 yObh5AlipXLcpfjB7tv2AIwghTskBiZubz1JPg/I5WAg0KeBoWcFqX3A7gsWek2pIhC/1NonBL
 pvWPsEDPi95fDeTYTVaz8JcOGUOipx2S/Ph5wE78OmLiZ6jUGpM4Uq5DJGkCSvRiskF8O4NQsq
 sGE=
X-IronPort-AV: E=Sophos;i="5.64,332,1559491200"; 
   d="scan'208";a="116247220"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2019 08:58:40 +0800
IronPort-SDR: P0jG0d87Vf+xI3jYLnOjh6+DOSBZHbtCPlXdAMLfz5GxhfyS7kASJGkdE3mI/z1VENwCFXI9Ln
 kFTjAfE0OJ6NfMlP8bsa2vH8Ae1u9fam9Qsr5GHT2VHRyEkoK+Ii/0cFe/7M9WxdLdvYxHMSSv
 Z/iJ5JuTfuRgd5KpyfgdCyDo1WEC1Ueb+jjYdwQaEIXiXwRwV6t93MOrTphgLXMNrc2Ytir6Mr
 yD6kx9V+YwrulVBjk1x8NCIX3WGk7ozoRChzEo/LI9rtfh5qhv18VQBtrEvEhW+J8B1pBV55dJ
 v7DAHDg4jTzxCEdlXGO7ruFo
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 17:56:40 -0700
IronPort-SDR: buJklJ1NZhn+ariLbhCXotWJ0iZLK9+V0P+ilob/EJ3b7KF0rougKipOcdZ48jxK65bn8oEu2P
 Zjg8UtNyIcrRjfTB/NiXIejCMibCPCfF43qg+YcUA3ZHDXSquSyQhjE5kqsStoZGkDt1wIvG34
 4LJOzaxTWTVbMCRx1NFstKqIE1JzMDnPqy9AZsrZuoaSVwsAFWBaza8hM5aL/FoZjm3uca2zDs
 CsZXi0pKH1FhccbBXWHCTzWRHvnWGzaNxQZDORnH54HFQlJYdactsLGl17bgjITsftlly8lqIP
 F3Y=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 31 Jul 2019 17:58:39 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup.patel@wdc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, Enrico Weigelt <info@metux.net>,
        Gary Guo <gary@garyguo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v3 5/5] dt-bindings: Update the riscv,isa string description
Date:   Wed, 31 Jul 2019 17:58:43 -0700
Message-Id: <20190801005843.10343-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801005843.10343-1-atish.patra@wdc.com>
References: <20190801005843.10343-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the RISC-V specification states that ISA description strings are
case-insensitive, there's no functional difference between mixed-case,
upper-case, and lower-case ISA strings. Thus, to simplify parsing,
specify that the letters present in "riscv,isa" must be all lowercase.

Suggested-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index c899111aa5e3..4f0acb00185a 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -46,10 +46,12 @@ properties:
           - rv64imafdc
     description:
       Identifies the specific RISC-V instruction set architecture
-      supported by the hart.  These are documented in the RISC-V
+      supported by the hart. These are documented in the RISC-V
       User-Level ISA document, available from
       https://riscv.org/specifications/
 
+      Letters in the riscv,isa string must be all lowercase.
+
   timebase-frequency:
     type: integer
     minimum: 1
-- 
2.21.0

