Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45431C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF2225015
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191388;
	bh=ZeRxG86R+FVc7/S6lyEeqTu71EyFgNs7/FMQs5SVgZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DWFnuSDVN+6OCctdgs56PHpB6F03n4724+O5GVinHehQGZZrQPCmkX9r1i1qa/s6I
	 5ThI7MNszbgEvTzOXtIfaNlLVVD8MllQju7jw4rg5wWzbkHI6iiYQ1izgGKz+tsVsb
	 lWWBq+IBjHDNlctKFeflxoJ82oyUTYmQRmES+LDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388587AbfE3EnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:43:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727527AbfE3DMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:12:13 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA59E2446F;
        Thu, 30 May 2019 03:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185933;
        bh=ZeRxG86R+FVc7/S6lyEeqTu71EyFgNs7/FMQs5SVgZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sqPUmvdpPeslw+ROWE7+wy0At+kdn4LjA5FOEZX4oXSwpEj1jL6UySPFcZV48l+E6
         x1zpmTytGQNn6q3H9rblByy/EbaxaenTL19zgfBZFUmdfu0pUFcqSmollgFjtYH72M
         hbM5TmvIk6PbzIPlOZaK0GwUItl08W+x9KAkE+60=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 329/405] regulator: add regulator_get_linear_step() stub helper
Date:   Wed, 29 May 2019 20:05:27 -0700
Message-Id: <20190530030557.387558374@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 7287275b4301e230be9e4569431c7dacb67ebc13 ]

The regulator header has empty inline functions for most interfaces,
but not regulator_get_linear_step(), which has just grown a user
that does not depend on regulators otherwise:

drivers/clk/tegra/clk-tegra124-dfll-fcpu.c: In function 'get_alignment_from_regulator':
drivers/clk/tegra/clk-tegra124-dfll-fcpu.c:555:19: error: implicit declaration of function 'regulator_get_linear_step'; did you mean 'regulator_get_drvdata'? [-Werror=implicit-function-declaration]
  align->step_uv = regulator_get_linear_step(reg);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~
                   regulator_get_drvdata
cc1: all warnings being treated as errors
scripts/Makefile.build:278: recipe for target 'drivers/clk/tegra/clk-tegra124-dfll-fcpu.o' failed

Add the missing stub along the others.

Fixes: b3cf8d069505 ("clk: tegra: dfll: CVB calculation alignment with the regulator")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/regulator/consumer.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index f3f76051e8b00..aaf3cee704397 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -478,6 +478,11 @@ static inline int regulator_is_supported_voltage(struct regulator *regulator,
 	return 0;
 }
 
+static inline unsigned int regulator_get_linear_step(struct regulator *regulator)
+{
+	return 0;
+}
+
 static inline int regulator_set_current_limit(struct regulator *regulator,
 					     int min_uA, int max_uA)
 {
-- 
2.20.1



