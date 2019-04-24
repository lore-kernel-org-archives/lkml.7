Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C92C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C554E21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128094;
	bh=m8a22znsMr2CzsgnMSXMk3mQECatXNqkPecNp57vSzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1HzF+8IeKYg06oCJqKihZEJtCU9+bJAbf1zPMxunALD9rzf/OTTSeUF9kopJpr2e1
	 I6YRoFRw0JCauHcp1ZGOULdkNy+Q8q3tx9LY29+bbwVLE5mwKGQgIWpifodzR//hke
	 k0hFG3X0G34V1S6UWUlyFh0jiChyHgXIro35yx0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391472AbfDXRsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:48:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403777AbfDXRbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:31:21 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D8AB2054F;
        Wed, 24 Apr 2019 17:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127080;
        bh=m8a22znsMr2CzsgnMSXMk3mQECatXNqkPecNp57vSzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gZI85NAeOAeN7iv/mNNeca51EYOq67iyDH7ai/MDVwZSCrekyhJElM8MzOS2u4nwX
         FXSnE+g14EyQ1rSXEs5imJ+i0D8xPnNJuA3z8kIuitAioxi6KGbgHXKsh21c0KzBDS
         E/CNWDgkvF6QtODmzItGRGTeHnjZwuBpUq3WupXk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 4.19 55/96] serial: sh-sci: Fix HSCIF RX sampling point adjustment
Date:   Wed, 24 Apr 2019 19:10:00 +0200
Message-Id: <20190424170923.481759417@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 6b87784b53592a90d21576be8eff688b56d93cce upstream.

The calculation of the sampling point has min() and max() exchanged.
Fix this by using the clamp() helper instead.

Fixes: 63ba1e00f178a448 ("serial: sh-sci: Support for HSCIF RX sampling point adjustment")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Dirk Behme <dirk.behme@de.bosch.com>
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/sh-sci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2504,7 +2504,7 @@ done:
 				 * last stop bit; we can increase the error
 				 * margin by shifting the sampling point.
 				 */
-				int shift = min(-8, max(7, deviation / 2));
+				int shift = clamp(deviation / 2, -8, 7);
 
 				hssrr |= (shift << HSCIF_SRHP_SHIFT) &
 					 HSCIF_SRHP_MASK;


