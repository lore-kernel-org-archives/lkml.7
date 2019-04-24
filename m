Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACA2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9878020675
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127490;
	bh=m8a22znsMr2CzsgnMSXMk3mQECatXNqkPecNp57vSzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MTi1BYUr3e7qdVNq3SqvUIpQlBcajQL8prowfjRxYGxwCA9I0v/Jf0t+8LmpR5zh6
	 vOl/nCrkobPFZuYvufvAoZ/We6lLFwx1aEqo5PsN/zQ3jShyHvaYSIQY71/WXyzt14
	 zt0rh6hMI/v4w3199NgnDKw62UmlR3YEEIzR07j8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392363AbfDXRiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:38:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392345AbfDXRiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:38:07 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B38321903;
        Wed, 24 Apr 2019 17:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127487;
        bh=m8a22znsMr2CzsgnMSXMk3mQECatXNqkPecNp57vSzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QaPitztHx4bBOEsHBQUUnmZ3fnqJ8AJXV7NamwDWG5cPDMK2MF6E0NGa8lEncoOkZ
         vccj0K5T3KOUZop4KchwVKCmsgV326Oj86GZYQCuHzHUFmpBMad37k+FWvNgWL91v0
         u/xx5HOS6yxyL0Ge0nr/T/+K4adJ2PKZrJ5ocfx4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 5.0 073/115] serial: sh-sci: Fix HSCIF RX sampling point adjustment
Date:   Wed, 24 Apr 2019 19:10:09 +0200
Message-Id: <20190424170929.312396893@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
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


