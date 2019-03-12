Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9656C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803FA2183F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410942;
	bh=OHDs3zdTczPUcYzBfCvuy1uaFmgIWqDgdaBdOlUF3C4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lYv995GUbEVNvyV5xt47k/OcI79016kikMDZvOTA7lq6E4l+WBSyaGWItvvhkMcu1
	 Z9Jgoxw6TNvrn6MySwI/SYyztQ70otX0nUxmu0d/rVEexB21XYOxRMG+/sZyJrwpSO
	 hpt+/YZ3pXVLvXFiflG9ZUHt0Jy/Jfx+J7JpV0s8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfCLRPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:15:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728538AbfCLROx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:53 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C2272171F;
        Tue, 12 Mar 2019 17:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410893;
        bh=OHDs3zdTczPUcYzBfCvuy1uaFmgIWqDgdaBdOlUF3C4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zxoF1gBIH0KR0lz++4ZnOMyBXznHhnVqpr6D/PXzpyoJ7OvBnO3tzXXATpZ/oU01M
         MMfHSiqhYe6Ptw5VD83LZ6n7kyH5Zgv8KT+dUJkoqZRecKQ8XYLeTrZ8z9QIn73bVw
         1yYkSPhzN/4IchIfSFU7qH/uGQuuu9T5Pb04UDxs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 083/149] irqchip/gic-v3-its: Gracefully fail on LPI exhaustion
Date:   Tue, 12 Mar 2019 10:08:21 -0700
Message-Id: <20190312170356.680239192@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

[ Upstream commit 45725e0fc3e7fe52fedb94f59806ec50e9618682 ]

In the unlikely event that we cannot find any available LPI in the
system, we should gracefully return an error instead of carrying
on with no LPI allocated at all.

Fixes: 38dd7c494cf6 ("irqchip/gic-v3-its: Drop chunk allocation compatibility")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index d9a880108315..15579cba1a88 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1581,6 +1581,9 @@ static unsigned long *its_lpi_alloc(int nr_irqs, u32 *base, int *nr_ids)
 		nr_irqs /= 2;
 	} while (nr_irqs > 0);
 
+	if (!nr_irqs)
+		err = -ENOSPC;
+
 	if (err)
 		goto out;
 
-- 
2.19.1



