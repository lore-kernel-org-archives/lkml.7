Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4062CC31E5D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BA3206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qYeT+oJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfFQTA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:00:59 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59831 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFQTA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560798058; x=1592334058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w01oF4mU+3Ozo2+tH2H+ijQALtPIV7gcFM9ir50d13s=;
  b=qYeT+oJoGhV9dsRbQ0gNLA9tEB0C67mrWhVs325mp6nra08B1Bz9tmL4
   KWTyipPtOX0hpV7tCkerMPitAxXH/kU12eCVpkzE/FhtWgQMZoEmnDBNh
   0lD5/3jtA5dBiePGImMjEYK5X4W5BxPk84PZTuRlwdyAEjFoBEGbcd6ix
   LX3gTtPcVz8ckCMQrgv7dhQsFjKqe7ekG/zNuScS/u5Iiv9eNRtDmAQW+
   ZILwFKKr8tPnimW+/4Ivwilra0QRWpFAG2DzlfgQZ5mcv7fyLDz59DD4f
   +DCpbD+xIRDQW/23M4A2CTfNUC9ZCy1XNjeNsepfsoE7vXKgPJoC4mMKB
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,386,1557158400"; 
   d="scan'208";a="115695477"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 03:00:58 +0800
IronPort-SDR: wg+kDeW68XLLojpDGlpxphgxRh1V3lc9bIFqjm3gbT4i9PKyxvNPRlr7CVUFWdzpe3hE/ErFC5
 REk6/SEOAANDRie3PRQy5M1k91ONXsdLefBJqitobVHgrxF8OA0Aui5QoUHc2aWep9F798iqER
 Mx/wLK/i7odFwswBts3fW/Eq40287nLWC1EMrVeK7VMkKqE8nvYj0twF0XflXcV/di22BESaSJ
 chmZPQ4Vs/5YCPo1kXXXRcwD3hmc5tkTp0gigqVnVca/UKRr54B1tz088I0qPHkKsUeknVbeLl
 1ykyqdIcxHgfTzBVu0L3kijy
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 17 Jun 2019 12:00:31 -0700
IronPort-SDR: +jMZMAhzuDibHaLiyfpQmADLclEvAfuhSn7u/kRSVLcJdWnMOt1dfn8YD13iPPcnSp2WXFowGF
 uKfHWJZO1yJ58HNfWo3n5vq1O3mxtfuBe2A19UXMkjgodo7/jdQG43cH8huvXUewLCpvHmZdEh
 mN++/OcHTxciwHSss7HH3+yHYwUnaui4Xla47K/AivutUZEVEu58hfp4y0Dtd82UG7miyJQBiF
 6rrnOACCpjVLhECynlzARwfiyroj0jHAsyv7x0y6WSv7YqV0nIyYR7jVcQnegkf8fTn0ifwiTN
 Rq4=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Jun 2019 12:00:56 -0700
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
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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
        Richard Fontana <rfontana@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v7 6/7] base: arch_topology: update Kconfig help description
Date:   Mon, 17 Jun 2019 11:59:19 -0700
Message-Id: <20190617185920.29581-7-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190617185920.29581-1-atish.patra@wdc.com>
References: <20190617185920.29581-1-atish.patra@wdc.com>
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

