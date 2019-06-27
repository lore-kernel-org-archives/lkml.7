Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AABC48BE9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 19:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3539A208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 19:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I2jiqjeD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfF0Tze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 15:55:34 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23412 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfF0Tz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 15:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561665328; x=1593201328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w01oF4mU+3Ozo2+tH2H+ijQALtPIV7gcFM9ir50d13s=;
  b=I2jiqjeDZyXU+bYKqcXW+MeVR7bexALyXrQAG1anci02WOgazeWaD6nV
   k9ssAYwMh2LQY/1/AV63p9xGX+UcHYJ/bmcR4sXjv2AWSVxNNcNI968s6
   rbcjdbQLfu3zbGy5KCltmGYBfDFkFCabWAQNAQBxqthXAIe7G3+3ZOZmh
   FAiNRWKNgPxOt/tyF5LYufJp3xSfpt24eBT4HbMADB7vWu1wX5D9p0cEb
   8tuIrEsCl8zVSfvRGCf/QGVwSbb5uWElIZNNl+x8jYgd53xCx9kfGAE1w
   D0jSDxq2MY2fJz/cB82EMy9YSfo3Bsm7oohdJbQKZdHLsemGc5i5ZftCF
   A==;
X-IronPort-AV: E=Sophos;i="5.63,424,1557158400"; 
   d="scan'208";a="112927456"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2019 03:55:28 +0800
IronPort-SDR: hDZS8Xz5k1RT0Gg1CDfltoC9JpbSQTDcuva5DPePEwCUSCrJQMtAtC5Pry9MykA3tfFVMjk3lz
 h5y9RBvvqD1dffqolje0aygw4euabK0Ua6ln+A4rXhCZUafPKSQ9FoP9bZ20/tods1MUf4M82t
 viccSpa+0ImObjTU/W/59zpbi+H5GpsGaF1SnBaQf/0z4CrzoqtN2nT31ksoPAGJksLwu7VW6j
 /M7mBUjlpGGSsAtRnIfFV58TYo9JgGZaXS3uJpUwvJMuJL7poErTuD4AQvUIkBveYjHI9UOLjh
 T/qeVlrda01//QecaO5pGbOI
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 27 Jun 2019 12:54:41 -0700
IronPort-SDR: cFuwpQZFnv4fY5ksJZgcghUH++Gj82pd52xhXGuI2XUesofeMS7iofXp0T7tGzU2h7s8uJZ6E3
 1ZOKk5KdI1xnP5N7d6ESMZiJgkm/GnT/TKRr7Dor2oLmc+cjEldGcuOuRkq+PKeJ0pv78fq7V+
 Bwg3c2sn920F9m7MB8NbTIw/5qZdBcrVpte32YrAxYKwi5Wo5oHxhRcEydraVrcMWuHkPP2NFk
 mRHYQxlKK0vTcAh/ciEYmi+waXg7iilbsze9CoiF+ZqT48xFBu+h7leOGipT8kNpdVgMj8GDPz
 txo=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Jun 2019 12:55:28 -0700
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
        Johan Hovold <johan@kernel.org>,
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
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v8 6/7] base: arch_topology: update Kconfig help description
Date:   Thu, 27 Jun 2019 12:53:01 -0700
Message-Id: <20190627195302.28300-7-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627195302.28300-1-atish.patra@wdc.com>
References: <20190627195302.28300-1-atish.patra@wdc.com>
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

