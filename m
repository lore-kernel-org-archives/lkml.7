Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BACC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85BA920656
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414000;
	bh=AY1iS3m9+GEKIgFVbsjGu3o0A//qkZgNRlpeE67SBsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wd83Yv7Eng34BpKx5ntmF3nZ9gcoINWY9HbEvIqtC2ZelLZ42GIo7o2XPQepz3B6u
	 b9KsQtP7xTN8N70Wq74uSapi6ybZZvuq0HqYQVigp3uveaEkzvae0CpHivmNhk4SUI
	 63fiyhnSYFAB5bA3wlRvG5/iHftv7dWtmXXRabWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbfLCW6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:58:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:54936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730121AbfLCW6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:58:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A96420863;
        Tue,  3 Dec 2019 22:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413910;
        bh=AY1iS3m9+GEKIgFVbsjGu3o0A//qkZgNRlpeE67SBsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OsNLBigU69oO5UMJ0cUq5+/52dR4SJ4JSo6aPKCUohOLONiNzKdTyszx3EhWDG0ls
         Aud1q7+MYzvu64OyDegNkhaXYsS5UCZzbCyrDOfvk2a/UNUMGnQYkWP+pIA0oU9sZo
         3m8HdbJquSaz33aggEnsFJhTBilFCV98ownwOByM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 4.19 310/321] clk: stm32mp1: fix mcu divider table
Date:   Tue,  3 Dec 2019 23:36:16 +0100
Message-Id: <20191203223443.274691298@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

commit 140fc4e406fac420b978a0ef2ee1fe3c641a6ae4 upstream.

index 8: ck_mcu is divided by 256 (not 512)

Fixes: e51d297e9a92 ("clk: stm32mp1: add Sub System clocks")
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/clk-stm32mp1.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -269,7 +269,7 @@ static const struct clk_div_table axi_di
 static const struct clk_div_table mcu_div_table[] = {
 	{ 0, 1 }, { 1, 2 }, { 2, 4 }, { 3, 8 },
 	{ 4, 16 }, { 5, 32 }, { 6, 64 }, { 7, 128 },
-	{ 8, 512 }, { 9, 512 }, { 10, 512}, { 11, 512 },
+	{ 8, 256 }, { 9, 512 }, { 10, 512}, { 11, 512 },
 	{ 12, 512 }, { 13, 512 }, { 14, 512}, { 15, 512 },
 	{ 0 },
 };


