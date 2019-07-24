Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A001C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536AF2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999239;
	bh=+mBgDTHX626pF5vBCtD6RPqgeKtvu0Nlkai0i99PfMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d2p6hm1NjKw+yvC0rmdS/keIXrFUsmg1hU9zLzF0ugwWEeGTy6frIdSp7H4/f3K6T
	 hcXOJf2R4DBwMdn7W94dbKJlG5vA9PdCuMXDwNu+zLbKOODqxsv17l44u/hDn6YYfs
	 Nq0G5x+Kk5Nc21nrcitl7zsej2inCd0qxqdVxaQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404775AbfGXUN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:13:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388123AbfGXTzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:55:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD59C205C9;
        Wed, 24 Jul 2019 19:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998154;
        bh=+mBgDTHX626pF5vBCtD6RPqgeKtvu0Nlkai0i99PfMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KwQJ9c9sGnEOtyMu830h7VI+Y5vVSGbRcHoyyK25aYsKRWn0EUHCepxOoDrPuvM9T
         lN9bu61EwvqlSgetX7Uv/8WhbnhlQ+2egZQEyvdKvH7C75G2nkUT1VycIq9/Srejxe
         8pu+jk5dhcgaxPJPAJuXotfdauTiT/7F2ljL2Jko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.1 266/371] regulator: s2mps11: Fix ERR_PTR dereference on GPIO lookup failure
Date:   Wed, 24 Jul 2019 21:20:18 +0200
Message-Id: <20190724191744.390594072@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

commit 70ca117b02f3b1c8830fe95e4e3dea2937038e11 upstream.

If devm_gpiod_get_from_of_node() call returns ERR_PTR, it is assigned
into an array of GPIO descriptors and used later because such error is
not treated as critical thus it is not propagated back to the probe
function.

All code later expects that such GPIO descriptor is either a NULL or
proper value.  This later might lead to dereference of ERR_PTR.

Only devices with S2MPS14 flavor are affected (other do not control
regulators with GPIOs).

Fixes: 1c984942f0a4 ("regulator: s2mps11: Pass descriptor instead of GPIO number")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/regulator/s2mps11.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -826,6 +826,7 @@ static void s2mps14_pmic_dt_parse_ext_co
 		else if (IS_ERR(gpio[reg])) {
 			dev_err(&pdev->dev, "Failed to get control GPIO for %d/%s\n",
 				reg, rdata[reg].name);
+			gpio[reg] = NULL;
 			continue;
 		}
 		if (gpio[reg])


