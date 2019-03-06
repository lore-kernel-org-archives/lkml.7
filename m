Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEE7C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 00:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A31205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 00:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="dPgWgDjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfCFAxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 19:53:53 -0500
Received: from onstation.org ([52.200.56.107]:51254 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbfCFAxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 19:53:53 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id BC8DF3C9;
        Wed,  6 Mar 2019 00:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1551833632;
        bh=9dgb/JkTXa739KeHoSJt8HaLT0U8tkOhGTPq5budb5c=;
        h=From:To:Cc:Subject:Date:From;
        b=dPgWgDjqeqoJxWUj4GCQ1K+Uw8hOkCydFLoNjIdM8XNTPgn9QZDCh+016c/d085v4
         c4/QOLdy9ff2bJexzkk25YNO7tRM39E8ncSooI7FF+naAX4Y/AEXppIfyumH1mBmz5
         CPqHqSg2QvjtZn2+VEEttqtGVzflUAN6w5BINR4s=
From:   Brian Masney <masneyb@onstation.org>
To:     andy.gross@linaro.org
Cc:     david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH 0/8] qcom: spmi/ssbi gpio: correct gpio hogging
Date:   Tue,  5 Mar 2019 19:53:08 -0500
Message-Id: <20190306005316.12232-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some patches that fix gpio hogging for all boards that use
spmi-gpio and ssbi-gpio. These depend on the following two patches
that were merged in 4.20-rc1:

commit 149a96047237 ("pinctrl: qcom: spmi-gpio: fix gpio-hog related
boot issues")

commit 7ed078557738 ("pinctrl: qcom: ssbi-gpio: fix gpio-hog related
boot issues")

I've already fixed pm8941 for the Nexus 5 and that fix is queued to go
into v5.1 during this merge window:

https://lore.kernel.org/lkml/20181101001149.13453-7-masneyb@onstation.org/

Andy: You may want to consider submitting these post rc1 as a fix for
v5.1 and possibly marking these for stable.

Brian Masney (8):
  ARM: dts: qcom: apq8064: add gpio-ranges
  ARM: dts: qcom: mdm9615: add gpio-ranges
  ARM: dts: qcom: msm8660: add gpio-ranges
  ARM: dts: qcom: pma8084: add gpio-ranges
  arm64: dts: qcom: pm8005: add gpio-ranges
  arm64: dts: qcom: pm8998: add gpio-ranges
  arm64: dts: qcom: pmi8994: add gpio-ranges
  arm64: dts: qcom: pmi8998: add gpio-ranges

 arch/arm/boot/dts/qcom-apq8064.dtsi   | 1 +
 arch/arm/boot/dts/qcom-mdm9615.dtsi   | 1 +
 arch/arm/boot/dts/qcom-msm8660.dtsi   | 1 +
 arch/arm/boot/dts/qcom-pma8084.dtsi   | 1 +
 arch/arm64/boot/dts/qcom/pm8005.dtsi  | 1 +
 arch/arm64/boot/dts/qcom/pm8998.dtsi  | 1 +
 arch/arm64/boot/dts/qcom/pmi8994.dtsi | 1 +
 arch/arm64/boot/dts/qcom/pmi8998.dtsi | 1 +
 8 files changed, 8 insertions(+)

-- 
2.20.1

