Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEC6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6638620836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688617;
	bh=PCiqS4qx9dzXr1ylZBZ1yAdQ1+PAOngffy9n8W8M4u0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=weYp0uHqkGEz49oJOg+NMf0dBTfVFpr2pZFShEnGAS5WPemMsaFJHWQxC6sjuBDIE
	 RFuMYUmLYaIAMuGcPv3seBikoau87t7WiLd7p0xofXlDd3YhMpVHdBTaAbiauqV5/C
	 wUMLr4/jij4IoJ6PTjqxAlZCn1tlW9BPV1ykj2SM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfCDIg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:36:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728138AbfCDIgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:36:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7E8D21019;
        Mon,  4 Mar 2019 08:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688603;
        bh=PCiqS4qx9dzXr1ylZBZ1yAdQ1+PAOngffy9n8W8M4u0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X4a8NVt6OXrK/04qDK3FF4Ca/DRfO28MjvqLelHpPOZcxT8F47gbdOjk70L4lmXEL
         ey8IsDBberMihB9mLk9Xn/ovqnrleFbsZSXYOsFNjAMSfewJhAgbe9tdy2vnntoqTx
         V2LSTtFZXsacl4vTqXJ48Z3bDZTXNqIKeHmKEozA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Andy Gross <andy.gross@linaro.org>
Subject: [PATCH 4.20 86/88] arm64: dts: qcom: msm8998: Extend TZ reserved memory area
Date:   Mon,  4 Mar 2019 09:23:09 +0100
Message-Id: <20190304081634.102402773@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Gonzalez <marc.w.gonzalez@free.fr>

commit 6e53330909672bd9a8c9f826e989a5945d9d9fdf upstream.

My console locks up as soon as Linux writes to [88800000,88f00000[
AFAIU, that memory area is reserved for trustzone.

Extend TZ reserved memory range, to prevent Linux from stepping on
trustzone's toes.

Cc: stable@vger.kernel.org # 4.20+
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Fixes: c7833949564ec ("arm64: dts: qcom: msm8998: Add smem related nodes")
Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/qcom/msm8998.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -36,7 +36,7 @@
 		};
 
 		memory@86200000 {
-			reg = <0x0 0x86200000 0x0 0x2600000>;
+			reg = <0x0 0x86200000 0x0 0x2d00000>;
 			no-map;
 		};
 


