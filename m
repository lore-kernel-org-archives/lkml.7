Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F56C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED202173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893636;
	bh=I7p/ytLeKxZOZQ3RD7E4Z3P9rEx740JImr8gqSxp7lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mr5fzSvdqtPAsXFupF9C/F/RrQNbXypuS6Q7Xfh8KLEU2xCuNNh0tBrSE24UJ7U98
	 toOh429iRPE6VMJBntaf5/h0q865r52RRQMz2nHgFbbwK6TUFTmD+in4YP0/tTyibk
	 JnEs1T2CvfKpamg03y1Tml3RcOf0DywNTdpIkLZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbfH0H50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:57:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730779AbfH0H5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:57:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33A0F206BA;
        Tue, 27 Aug 2019 07:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892635;
        bh=I7p/ytLeKxZOZQ3RD7E4Z3P9rEx740JImr8gqSxp7lk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=piLgIyb3lomrE1Gtw+ftAXDD8y7phtcr3fLC0+fJrllwOypAQD0szUMLtqutu0mN3
         pfy7y43Bm2aeuX1++BwJXFIUJejWHcrPzeDj/D2D0PwfBNfz/0699+G46OVjiH0g3V
         U/SyF88Z9P6HuhH8a7bZvhNd4NFFLGdo2H4GHUkQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.19 62/98] clk: socfpga: stratix10: fix rate caclulationg for cnt_clks
Date:   Tue, 27 Aug 2019 09:50:41 +0200
Message-Id: <20190827072721.565982867@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072718.142728620@linuxfoundation.org>
References: <20190827072718.142728620@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinh Nguyen <dinguyen@kernel.org>

commit c7ec75ea4d5316518adc87224e3cff47192579e7 upstream.

Checking bypass_reg is incorrect for calculating the cnt_clk rates.
Instead we should be checking that there is a proper hardware register
that holds the clock divider.

Cc: stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Link: https://lkml.kernel.org/r/20190814153014.12962-1-dinguyen@kernel.org
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/socfpga/clk-periph-s10.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/socfpga/clk-periph-s10.c
+++ b/drivers/clk/socfpga/clk-periph-s10.c
@@ -37,7 +37,7 @@ static unsigned long clk_peri_cnt_clk_re
 	if (socfpgaclk->fixed_div) {
 		div = socfpgaclk->fixed_div;
 	} else {
-		if (!socfpgaclk->bypass_reg)
+		if (socfpgaclk->hw.reg)
 			div = ((readl(socfpgaclk->hw.reg) & 0x7ff) + 1);
 	}
 


