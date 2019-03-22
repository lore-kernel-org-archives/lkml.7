Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E612C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C80B218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254598;
	bh=/yVd1tonW2MDl8Dv84mf2MERudNO76yPbrjt6Bkm90c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OTmiDeAxXERrZLZEOM/sK4vYGy6K2vxRaEwlswUxHxHRkv+VLIR2LXgDThlyGAHd7
	 t315Njx8k4BPXbTCdrWnuSUvM0JD/Cs1OhSKXLKgvkbL2n83gOdIaZOfsn6m10dw5T
	 QW21WhXQ3t8CzXi2Bf+X+5I50/MTfUdk6G9aErOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730726AbfCVLgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:36:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730510AbfCVLgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:36:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 778112082C;
        Fri, 22 Mar 2019 11:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254591;
        bh=/yVd1tonW2MDl8Dv84mf2MERudNO76yPbrjt6Bkm90c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2tbbxsWL3B+AN1i1mct4ISKH9ilJKr+1nmEeLp1jc3dr3wIBSBXVTE+SpDjTejFpS
         2JkXn4oFcWJzwWzflTQ+bDiUtEKFtHerJ5XYekGNUjQYiw9S54Lg9k4PLvweWxcAx+
         9pToJ72tvF6ukspqFkvJPJiYrQF5uKGS+1SEW15s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Stuart Menefy <stuart.menefy@mathembedded.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.4 183/230] regulator: s2mpa01: Fix step values for some LDOs
Date:   Fri, 22 Mar 2019 12:15:21 +0100
Message-Id: <20190322111249.625536815@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stuart Menefy <stuart.menefy@mathembedded.com>

commit 28c4f730d2a44f2591cb104091da29a38dac49fe upstream.

The step values for some of the LDOs appears to be incorrect, resulting
in incorrect voltages (or at least, ones which are different from the
Samsung 3.4 vendor kernel).

Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/regulator/s2mpa01.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/regulator/s2mpa01.c
+++ b/drivers/regulator/s2mpa01.c
@@ -303,13 +303,13 @@ static const struct regulator_desc regul
 	regulator_desc_ldo(2, STEP_50_MV),
 	regulator_desc_ldo(3, STEP_50_MV),
 	regulator_desc_ldo(4, STEP_50_MV),
-	regulator_desc_ldo(5, STEP_50_MV),
+	regulator_desc_ldo(5, STEP_25_MV),
 	regulator_desc_ldo(6, STEP_25_MV),
 	regulator_desc_ldo(7, STEP_50_MV),
 	regulator_desc_ldo(8, STEP_50_MV),
 	regulator_desc_ldo(9, STEP_50_MV),
 	regulator_desc_ldo(10, STEP_50_MV),
-	regulator_desc_ldo(11, STEP_25_MV),
+	regulator_desc_ldo(11, STEP_50_MV),
 	regulator_desc_ldo(12, STEP_50_MV),
 	regulator_desc_ldo(13, STEP_50_MV),
 	regulator_desc_ldo(14, STEP_50_MV),
@@ -320,11 +320,11 @@ static const struct regulator_desc regul
 	regulator_desc_ldo(19, STEP_50_MV),
 	regulator_desc_ldo(20, STEP_50_MV),
 	regulator_desc_ldo(21, STEP_50_MV),
-	regulator_desc_ldo(22, STEP_25_MV),
-	regulator_desc_ldo(23, STEP_25_MV),
+	regulator_desc_ldo(22, STEP_50_MV),
+	regulator_desc_ldo(23, STEP_50_MV),
 	regulator_desc_ldo(24, STEP_50_MV),
 	regulator_desc_ldo(25, STEP_50_MV),
-	regulator_desc_ldo(26, STEP_50_MV),
+	regulator_desc_ldo(26, STEP_25_MV),
 	regulator_desc_buck1_4(1),
 	regulator_desc_buck1_4(2),
 	regulator_desc_buck1_4(3),


