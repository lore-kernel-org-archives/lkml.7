Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47137C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2122081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099195;
	bh=uyIkaYx4Do60DeM1Fok7P3O2zNsV3shDL6HrAbissfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z8WyaLkPc1E4clROYgx9z6kqg8cmkqcbWsxNt9cpedJO3yoVRp+PlmNo7Bmhp4fG7
	 nHFrb3GOqxrm9cAgSZ+4TG82TcDw0TK9Uz2+959vURM1pOk3zQYQQdWwO0wuXyKDhz
	 HnJZbrep+AFNtHNp1/n5NIq4SnRMmlFUDRC2rdMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732365AbfFIQxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:53:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732351AbfFIQxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:53:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0F42204EC;
        Sun,  9 Jun 2019 16:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099188;
        bh=uyIkaYx4Do60DeM1Fok7P3O2zNsV3shDL6HrAbissfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YxognPBUsw4mwLVo9q2nj0vHhvZ3QQN76XE/YyyJMBILH/saAdDWxA/ZnycfswhGn
         fdjPuULwTz1xBVtGD1DiuaitB3QbSAfF+DueSQtTnm/QjILI0ao9FK+1rPwa1u80fp
         7L/8ys60gJAbd5gEcMUvY0WXGYKYTW90odN8qKkU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Joe Burmeister <joe.burmeister@devtank.co.uk>
Subject: [PATCH 4.9 41/83] tty: max310x: Fix external crystal register setup
Date:   Sun,  9 Jun 2019 18:42:11 +0200
Message-Id: <20190609164131.392566346@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.843327870@linuxfoundation.org>
References: <20190609164127.843327870@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Burmeister <joe.burmeister@devtank.co.uk>

commit 5d24f455c182d5116dd5db8e1dc501115ecc9c2c upstream.

The datasheet states:

  Bit 4: ClockEnSet the ClockEn bit high to enable an external clocking
(crystal or clock generator at XIN). Set the ClockEn bit to 0 to disable
clocking
  Bit 1: CrystalEnSet the CrystalEn bit high to enable the crystal
oscillator. When using an external clock source at XIN, CrystalEn must
be set low.

The bit 4, MAX310X_CLKSRC_EXTCLK_BIT, should be set and was not.

This was required to make the MAX3107 with an external crystal on our
board able to send or receive data.

Signed-off-by: Joe Burmeister <joe.burmeister@devtank.co.uk>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/max310x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -579,7 +579,7 @@ static int max310x_set_ref_clk(struct ma
 	}
 
 	/* Configure clock source */
-	clksrc = xtal ? MAX310X_CLKSRC_CRYST_BIT : MAX310X_CLKSRC_EXTCLK_BIT;
+	clksrc = MAX310X_CLKSRC_EXTCLK_BIT | (xtal ? MAX310X_CLKSRC_CRYST_BIT : 0);
 
 	/* Configure PLL */
 	if (pllcfg) {


