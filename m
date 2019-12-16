Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE81DC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAA820717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520565;
	bh=RpOfKwscbcP3jTQZONthTaLFEsK4492fK/8v35MsLPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lmnuoW2193jYjg8Xy6gRNCH0jYKijX5fgzrZrSp/NAZl3Mrr9HHmrLvRti72dlG24
	 Blx/CHJbVBxguE7iLl3f+uU/Q88utnzBVHhzv+VImxANxTCJwTHZ5Cuk2vSvesL0QQ
	 LMMq7GGnKqsnVd2XSZTjXPvmDf236n6lXjTvTLx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfLPSWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:22:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:53700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732197AbfLPSVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:21:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 268BE206EC;
        Mon, 16 Dec 2019 18:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520465;
        bh=RpOfKwscbcP3jTQZONthTaLFEsK4492fK/8v35MsLPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vcoPVK7KxAFqGZz+5b5IoAlL2g+XTxmsMojpuzecSFXoPzKUF2IjurFOrDfnNqhr/
         xmY3NhhKEkn7iC11NHhCD+aBsWYO3EsxV3XAao6C+mjfRGcMR8AKEc0RHAkxKHMGf7
         O8E0FLHr7DxADFc47g5gMWiY2vDOKNM4okn39Tj4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Elaine Zhang <zhangqing@rock-chips.com>,
        Joseph Chen <chenjh@rock-chips.com>,
        Daniel Schultz <d.schultz@phytec.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 5.4 165/177] mfd: rk808: Fix RK818 ID template
Date:   Mon, 16 Dec 2019 18:50:21 +0100
Message-Id: <20191216174849.716089396@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Schultz <d.schultz@phytec.de>

commit 37ef8c2c15bdc1322b160e38986c187de2b877b2 upstream.

The Rockchip PMIC driver can automatically detect connected component
versions by reading the ID_MSB and ID_LSB registers. The probe function
will always fail with RK818 PMICs because the ID_MSK is 0xFFF0 and the
RK818 template ID is 0x8181.

This patch changes this value to 0x8180.

Fixes: 9d6105e19f61 ("mfd: rk808: Fix up the chip id get failed")
Cc: stable@vger.kernel.org
Cc: Elaine Zhang <zhangqing@rock-chips.com>
Cc: Joseph Chen <chenjh@rock-chips.com>
Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/mfd/rk808.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -610,7 +610,7 @@ enum {
 	RK808_ID = 0x0000,
 	RK809_ID = 0x8090,
 	RK817_ID = 0x8170,
-	RK818_ID = 0x8181,
+	RK818_ID = 0x8180,
 };
 
 struct rk808 {


