Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B392C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120AD2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565787173;
	bh=PaFFEUMSci1o0/biRn3xv8VDRFhQvuyzP763r2zkBH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tr4yaiyj0i290+GuGP195jElFRfSfDWXHPweIfBBm8WGcLheXM0mNGi8g3KlxYCYM
	 udTKGrhkyPF5VqQIGmrGfnSJcnx9deyujtmoU7A9k8H2FdZFrocqA7cxUTLTQeYWZD
	 kQFoGFhyf/PGU66VSf6UNZmh2UV1Jjl5Hzp11ris=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbfHNMww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728196AbfHNMwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:52:49 -0400
Received: from localhost.localdomain (unknown [171.76.115.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 875892173E;
        Wed, 14 Aug 2019 12:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565787168;
        bh=PaFFEUMSci1o0/biRn3xv8VDRFhQvuyzP763r2zkBH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FRqPyka0iCZZ6pzB6C5jNao8NN2CWhqHlHcG7dvm0k5frjobehnwwWcRX5TQ7EG1V
         e7JJsTSURpG0k9r4G/qXupAGkM+2QnZWF/55Jk5tsW3GiB78fh4ZGQpHm+vb7JHHWa
         aRjhkVZ4viFf3pT6C3LbrBtlGjbt+0r2brUHhBSU=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        sibis@codeaurora.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/22] arm64: dts: qcom: sm8150-mtp: Add resin node
Date:   Wed, 14 Aug 2019 18:20:06 +0530
Message-Id: <20190814125012.8700-17-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814125012.8700-1-vkoul@kernel.org>
References: <20190814125012.8700-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sm8150-mtp board has a reset button which also works as a volume
down key. Add the node for resin device to handle the resin and volume
down key

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8150-mtp.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
index 43ba14cc0b00..a42f1c154600 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
@@ -26,6 +26,15 @@
 	status = "okay";
 };
 
+&pon {
+	resin {
+		compatible = "qcom,pm8941-resin";
+		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
+		debounce = <15625>;
+		bias-pull-up;
+		linux,code = <KEY_VOLUMEDOWN>;
+	};
+};
 &tlmm {
 	gpio-reserved-ranges = <0 4>, <126 4>;
 };
-- 
2.20.1

