Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA24C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D71241EE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dNbYJBSh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfE2VQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 17:16:47 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:41848 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfE2VQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 17:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559164606; x=1590700606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w01oF4mU+3Ozo2+tH2H+ijQALtPIV7gcFM9ir50d13s=;
  b=dNbYJBShWZ6O/cJDrDcUAlJEuOFbQDYWfwmF422kImr8Lr7SSMkZ9pDp
   aeiHCUD/3C131CrNiaZIeWOb3drW93GJOJHRyYvDezioUFN7xfPmOE1Vf
   Nu8tIT3fP26lYMuL8td67VHYDnziebQ9SMH6pdSHAu5gagvm9FWQkub2g
   zczS8maPqbk4uI31DeU1JbLX5TddBsxgAGXI3+LnZ+HzBzomg3LjI9TK8
   uVSYTVNNU4nhhLjbioDHrieVnBxefYaT5MRN4QwWHy3+t1ki1vpLuMsX8
   FT41hZ9YZTh9atwngSftbQ3LosW4qHE+jZMFE+jqqk8MWjqxEaK4zxMdK
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,527,1549900800"; 
   d="scan'208";a="110604130"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2019 05:16:46 +0800
IronPort-SDR: BfWeA+fOTcGf3++uzzbl0SKt0s3Rpvq/iQGSeq8prtkHZJ9Ek/ZBIDCxNFfY3KE39VBFIzDPkY
 vz64hiPaC0MwGyEV6kOnAVqRV12DE/LjggU5spEzZoMfDMGjSOT1r5O8/TriPyBuHT+9urdIxW
 oeOCdWEJWfeKx+zP65H0Xe6w6NL2W5cZuqxcyX5jiSFKP1KarUZ8k7ZOh1pp8htApbT+MbIvoT
 zDtZAbw9Li+sj94nWjNQUe5nRQfAGQep2eHNIc2i/i6TXZgZafBB4T9vned6rzeBddooljz7/P
 WODIhWIx1Yu+tb50ooMCecH8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 29 May 2019 13:51:55 -0700
IronPort-SDR: puhTT5Dh+G71vM72tVc8ptf1yxDE3pK3IqWqxPilGftHruywYWp7DiUOWLL/8Zl4Wasd5GL6IV
 QI6HPxKaOaJr03MMhGD5qZ/zVNzpOGAXRNmqljAEAkJ7QwtrIMauEM0oXLcpZoHuGTt44l8cTH
 FBG0PPVHtYEOqwQfDLmVSpYAlFXBfIBAC6asxGLXdBNRDj++b7BZWQiK1Vl5YzzZ4llGkIb6gu
 CvOtbf93ldIuIZthY5plMj/ljmYDfW8ZJrflO1dnrib5LGVqvW9BZdTuaQJsJgKnR6O1heiBtR
 8cQ=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 May 2019 14:16:45 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 6/7] base: arch_topology: update Kconfig help description
Date:   Wed, 29 May 2019 14:13:39 -0700
Message-Id: <20190529211340.17087-7-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529211340.17087-1-atish.patra@wdc.com>
References: <20190529211340.17087-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

Commit 5d777b185f6d ("arch_topology: Make cpu_capacity sysfs node as read-only")
made cpu_capacity sysfs node read-only. Update the GENERIC_ARCH_TOPOLOGY
Kconfig help section to reflect the same.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index dc404492381d..28b92e3cc570 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -202,7 +202,7 @@ config GENERIC_ARCH_TOPOLOGY
 	help
 	  Enable support for architectures common topology code: e.g., parsing
 	  CPU capacity information from DT, usage of such information for
-	  appropriate scaling, sysfs interface for changing capacity values at
+	  appropriate scaling, sysfs interface for reading capacity values at
 	  runtime.
 
 endmenu
-- 
2.21.0

