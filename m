Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3ECC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054DF20818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555093959;
	bh=Lu/9VefXJAzydhxIjej1T+ELCdL9m/fzpv8TsunMCNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o2uWv5ewkycSK6yEINOncq8H2HaqZMGvEkT5dhHJfmp9rdyiBygswvhdh8nM4khnG
	 Ux9z+TyX/DlgYhNBW3sBaUgz31SOKyvDQrqqGr+mZSXnzVAtkXa1ChVI0/m1+ySZOg
	 3HgaHOAsH6DlBTTpon3U4zF140D1uGT2xkDRkV2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfDLScd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:32:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbfDLSbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 14:31:53 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07613218E2;
        Fri, 12 Apr 2019 18:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555093913;
        bh=Lu/9VefXJAzydhxIjej1T+ELCdL9m/fzpv8TsunMCNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QvPLFGT1GXjOboeqPPBAcckRG30U7zHLFyGRg25ud38AwbhLZXd+ikeM5hKtX6JPH
         7Uv5aBBMHFZMZ75QzI+OfTsIqt9AXYoe7fkrdrkyzbN9vnPQz4FJiGti4i/6Rg9L5B
         LUNtqbaZpK02JuyCx2OdHXWRriPk8GSwuM5omh4c=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 4/9] driver core: Let dev_of_node() accept a NULL dev
Date:   Fri, 12 Apr 2019 11:31:45 -0700
Message-Id: <20190412183150.102131-5-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190412183150.102131-1-sboyd@kernel.org>
References: <20190412183150.102131-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'd like to chain this in places where the 'dev' argument might be
NULL. Let this function take a NULL 'dev' so this can work.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---

Please ack/review so I can take this through clk tree.

 include/linux/device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index b425a7ee04ce..0370dd0b3ae7 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1231,7 +1231,7 @@ static inline void device_lock_assert(struct device *dev)
 
 static inline struct device_node *dev_of_node(struct device *dev)
 {
-	if (!IS_ENABLED(CONFIG_OF))
+	if (!IS_ENABLED(CONFIG_OF) || !dev)
 		return NULL;
 	return dev->of_node;
 }
-- 
Sent by a computer through tubes

