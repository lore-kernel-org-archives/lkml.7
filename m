Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170A3C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D393422BF3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033575;
	bh=CqM/3sez9hDpYLVaIcw1Q3PHotGioltshOsUtlzve/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x1Agr0gJklxxt0pCJ1i/SC6Fu5CUJa3YHmk+TZtQmk6liH+Y9ZVJ7fDaYUM9vzIpW
	 22pKlhjepP413naS3JRrhkd/1UkISIG2MFENDNITX5gV1TAyskR7YENI2ozfrhOJZT
	 M/PJXUjF2EYKle1riMAGc0lOAtKB4jpr0/8zUVws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfGYFqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:46:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405319AbfGYFqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:46:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D05C522BF3;
        Thu, 25 Jul 2019 05:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033570;
        bh=CqM/3sez9hDpYLVaIcw1Q3PHotGioltshOsUtlzve/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OD6qxEmdggZdcMk/RuYadgQBfiKKSX2LfPqbeQm0iqjcJNqW94ttB76KpHqn5TV9q
         iQt1ketJ0pPCALv71Uqw3/UOcaRkB8O16yQACrSLm6k1mYFwZxH5XFa6oW9A5tz/W5
         0QVVAsKsRJw+3egF6+6OGVQoKOotunCtHpwenZwM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 4.19 251/271] gpu: ipu-v3: ipu-ic: Fix saturation bit offset in TPMEM
Date:   Wed, 24 Jul 2019 21:22:00 +0200
Message-Id: <20190724191716.694285664@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve Longerbeam <slongerbeam@gmail.com>

commit 3d1f62c686acdedf5ed9642b763f3808d6a47d1e upstream.

The saturation bit was being set at bit 9 in the second 32-bit word
of the TPMEM CSC. This isn't correct, the saturation bit is bit 42,
which is bit 10 of the second word.

Fixes: 1aa8ea0d2bd5d ("gpu: ipu-v3: Add Image Converter unit")

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: stable@vger.kernel.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/ipu-v3/ipu-ic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/ipu-v3/ipu-ic.c
+++ b/drivers/gpu/ipu-v3/ipu-ic.c
@@ -257,7 +257,7 @@ static int init_csc(struct ipu_ic *ic,
 	writel(param, base++);
 
 	param = ((a[0] & 0x1fe0) >> 5) | (params->scale << 8) |
-		(params->sat << 9);
+		(params->sat << 10);
 	writel(param, base++);
 
 	param = ((a[1] & 0x1f) << 27) | ((c[0][1] & 0x1ff) << 18) |


