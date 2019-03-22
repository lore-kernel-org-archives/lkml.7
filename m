Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDF4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD8921929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256323;
	bh=5IKZ7jpQwnmRhVAeOsXJRU7CFep5QBdYDXPu1Ith5go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k8sXlCY6MBo1a1pCcozHo/3/Yv8d+pH/AGqS0eZ0oEybEsKeRKyGNSIDkdzJGn+A4
	 j5dUhoGYcdeALU6OKU/0FCmvwQF+aACZ+VrOnXjGNg8tkB2mMvqDO+KWWcwMugwIvM
	 nt4CLWpW5gPwxNcxyOrv+aVaK18oQGkq003zCH5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388809AbfCVMFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:05:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388800AbfCVMFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:05:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A26B321929;
        Fri, 22 Mar 2019 12:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256318;
        bh=5IKZ7jpQwnmRhVAeOsXJRU7CFep5QBdYDXPu1Ith5go=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EbG3yqEHJ7Al07DeUdRyi7YqCp/Z+pfJdcTOgO/yvTUNbiDoOciORWuJx9vXcsO5V
         ZMQZKiQzHGDcwg4G+jtwXjN2aw4VpGJGjqkcw/c5Tpvj2USpBLelAfr6fZlTA8o184
         6jY7Vx94bFUvK24D2zoA2wRrJM2RA5/uc0nnoVGA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zenghui Yu <yuzenghui@huawei.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.19 174/280] irqchip/gic-v3-its: Avoid parsing _indirect_ twice for Device table
Date:   Fri, 22 Mar 2019 12:15:27 +0100
Message-Id: <20190322111325.236155152@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

From: Zenghui Yu <yuzenghui@huawei.com>

commit 8d565748b6035eeda18895c213396a4c9fac6a4c upstream.

In current logic, its_parse_indirect_baser() will be invoked twice
when allocating Device tables. Add a *break* to omit the unnecessary
and annoying (might be ...) invoking.

Fixes: 32bd44dc19de ("irqchip/gic-v3-its: Fix the incorrect parsing of VCPU table size")
Cc: stable@vger.kernel.org
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-gic-v3-its.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1893,6 +1893,8 @@ static int its_alloc_tables(struct its_n
 			indirect = its_parse_indirect_baser(its, baser,
 							    psz, &order,
 							    its->device_ids);
+			break;
+
 		case GITS_BASER_TYPE_VCPU:
 			indirect = its_parse_indirect_baser(its, baser,
 							    psz, &order,


