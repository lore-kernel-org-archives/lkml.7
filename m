Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C0FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE6820863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582236;
	bh=8VNO9OKovcrLuQT8lZ5GcTbzpS/B6LkpQqNh1ftFtNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k6/JxFfYuPeCg4KxeK6/HfKWRJcgrf7ZhUmYg64Ckd1f+0y0Ye8v96is1Vil2KaUV
	 zEye3l7tywtPrP62CPu1xugee3pekFWpr/0ZW2Y0ZH6prwyMIk5PnPmoA2QJwNUGnZ
	 8D0dA5zlRfw9oWSodKiNLik8AcGUADGIkaFgLkHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732345AbfCZGhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:37:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731052AbfCZGhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:37:13 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE5EF2075E;
        Tue, 26 Mar 2019 06:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582232;
        bh=8VNO9OKovcrLuQT8lZ5GcTbzpS/B6LkpQqNh1ftFtNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JTpbWKj6dt2cmyuRXNun1j4dLRPkrCIjxsn0yyWX5GoZsM2HmUnxUJE5Q9qoabuhB
         1kqE3VfQekMC8r8GQ2C3DSrOpH+o24HV05ES08w+LLv8gmlait3y7+sABa3lOu9dap
         C0dpwWu5CbksbvEyArBN3Y+iHXHPQZiRR5E4p2Pg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.19 21/45] irqchip/gic-v3-its: Fix comparison logic in lpi_range_cmp
Date:   Tue, 26 Mar 2019 15:30:04 +0900
Message-Id: <20190326042703.807916087@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042702.565683325@linuxfoundation.org>
References: <20190326042702.565683325@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

commit 89dc891792c2e046b030f87600109c22209da32e upstream.

The lpi_range_list is supposed to be sorted in ascending order of
->base_id (at least if the range merging is to work), but the current
comparison function returns a positive value if rb->base_id >
ra->base_id, which means that list_sort() will put A after B in that
case - and vice versa, of course.

Fixes: 880cb3cddd16 (irqchip/gic-v3-its: Refactor LPI allocator)
Cc: stable@vger.kernel.org (v4.19+)
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-gic-v3-its.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1477,7 +1477,7 @@ static int lpi_range_cmp(void *priv, str
 	ra = container_of(a, struct lpi_range, entry);
 	rb = container_of(b, struct lpi_range, entry);
 
-	return rb->base_id - ra->base_id;
+	return ra->base_id - rb->base_id;
 }
 
 static void merge_lpi_ranges(void)


