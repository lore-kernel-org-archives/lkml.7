Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84067C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F5F206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520491;
	bh=HacWDGMaqW5A2Weut8VIS+309yFPzbKi/eyzlpxs6sI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Sn5fMXTD21GRjgi0ku8nP3mLNyoIDhs7en2hIa5GKDrA/ERcaZZoLGNJwesohgz+
	 7n7gAZEs0I4Nmqrm+aQf4VQ8S9O8nOHMsWeznt8SFUt6xGQe+zZPeAuwubOaB0R0gl
	 Cx0hpDj1kP5z12hy6+BT1w7DeRp10xvuKLCO2rxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732258AbfLPSV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:21:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:55222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732244AbfLPSVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:21:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D499206EC;
        Mon, 16 Dec 2019 18:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520482;
        bh=HacWDGMaqW5A2Weut8VIS+309yFPzbKi/eyzlpxs6sI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e8r7dNsiEMy9txrsmlXuAdRQNqrG2G29NnGdPWWDc0pCxSjCx2giwKZFPFtZFk8Qt
         XAsfG2mNFp4U8ZsB8JuYb3ls4EB5IZExgQd4hR3wQHA0DBPblTDO3qbpiZmNFL4v5p
         bidzZMUGopmHlGhc2HG/XEFcd+2bS2vB6KLsOutM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5.4 133/177] pinctrl: samsung: Add of_node_put() before return in error path
Date:   Mon, 16 Dec 2019 18:49:49 +0100
Message-Id: <20191216174844.752023501@linuxfoundation.org>
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

From: Nishka Dasgupta <nishkadg.linux@gmail.com>

commit 3d2557ab75d4c568c79eefa2e550e0d80348a6bd upstream.

Each iteration of for_each_child_of_node puts the previous node, but in
the case of a return from the middle of the loop, there is no put, thus
causing a memory leak. Hence add an of_node_put before the return of
exynos_eint_wkup_init() error path.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc: <stable@vger.kernel.org>
Fixes: 14c255d35b25 ("pinctrl: exynos: Add irq_chip instance for Exynos7 wakeup interrupts")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/samsung/pinctrl-exynos.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -486,8 +486,10 @@ int exynos_eint_wkup_init(struct samsung
 		if (match) {
 			irq_chip = kmemdup(match->data,
 				sizeof(*irq_chip), GFP_KERNEL);
-			if (!irq_chip)
+			if (!irq_chip) {
+				of_node_put(np);
 				return -ENOMEM;
+			}
 			wkup_np = np;
 			break;
 		}


