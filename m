Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF987C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD1E20870
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582353;
	bh=ZACpqakP4sH/Ag6TNxr/ompRfcAFjXJ2oVMoOB9XYp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YXQrxOV39jX+DKJ4a9KEoMul3zdZuxherp0PV3A7/68UqFyIbw8c9qi5+ZwI1eZCj
	 jlV2CD3wX7y1AyyS2PlfZROI/McrGtS/O/ev+UXerMGF3V40O/6e+rNemOLzUmWG44
	 hWtyAxSbbDr4x7q/8bStfHyBxdl4/0RV3Dde5pTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732651AbfCZGjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:39:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732643AbfCZGjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:39:08 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2603F20870;
        Tue, 26 Mar 2019 06:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582347;
        bh=ZACpqakP4sH/Ag6TNxr/ompRfcAFjXJ2oVMoOB9XYp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1fMdPmdVkembP4/hopcyAnWEp0A/ib5UgjUl4hAo9USP9KMfR3dLODf3kSzbjzvq2
         xc1qrhrP64r6vxpZojJF9p3k/9WTmrk5H4m3oNcgSJiNDehgEbyH+ue5lrx5zhe3/c
         08za8gWzrZmJjW7EezaIvr9UdyYk7+OQZkD6scwA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 5.0 28/52] irqchip/gic-v3-its: Fix comparison logic in lpi_range_cmp
Date:   Tue, 26 Mar 2019 15:30:15 +0900
Message-Id: <20190326042702.367847680@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1482,7 +1482,7 @@ static int lpi_range_cmp(void *priv, str
 	ra = container_of(a, struct lpi_range, entry);
 	rb = container_of(b, struct lpi_range, entry);
 
-	return rb->base_id - ra->base_id;
+	return ra->base_id - rb->base_id;
 }
 
 static void merge_lpi_ranges(void)


