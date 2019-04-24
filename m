Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F5AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1B32054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127512;
	bh=JXrIYMk1HEm5HgsJ5WYaBiGjp44leD+iI1UzFa86uAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l9ppohrvJGvtEeAZV7GlP40ZHbp2m2WU/GC+GhrX5LyS88CNNTxpCidGTK/I4LO0Y
	 nhMO3NLzg0uAAr7Hx8Y900WQWhpMzO85gCztQnxSvsXXoOf0xj+1OSHyb03s6ItdX4
	 hB+bMjswWasJQJw9I2gVC7LByZOfLh2CGXblXOWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392424AbfDXRib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:38:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390861AbfDXRi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:38:29 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C98752054F;
        Wed, 24 Apr 2019 17:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127508;
        bh=JXrIYMk1HEm5HgsJ5WYaBiGjp44leD+iI1UzFa86uAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1DXWWbFH81a48NLc6pzLsFi+KHzTGBiO8IMQ4jhM7bsIUOL9KJb4PpC7IcPM9oliI
         mGcqveM1YGBF87EzSKU68XY6f8YpKSl7nrMiqvC0972GM+kREb3AAeCH70b4zHSW9w
         RpaZPQ0JKke/nSwIL1KfYXlSFYT0UCOa8iMuKV6k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Ulrich Hecht <uli+renesas@fpond.eu>
Subject: [PATCH 5.0 074/115] serial: sh-sci: Fix HSCIF RX sampling point calculation
Date:   Wed, 24 Apr 2019 19:10:10 +0200
Message-Id: <20190424170929.367078332@linuxfoundation.org>
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

commit ace965696da2611af759f0284e26342b7b6cec89 upstream.

There are several issues with the formula used for calculating the
deviation from the intended rate:
  1. While min_err and last_stop are signed, srr and baud are unsigned.
     Hence the signed values are promoted to unsigned, which will lead
     to a bogus value of deviation if min_err is negative,
  2. Srr is the register field value, which is one less than the actual
     sampling rate factor,
  3. The divisions do not use rounding.

Fix this by casting unsigned variables to int, adding one to srr, and
using a single DIV_ROUND_CLOSEST().

Fixes: 63ba1e00f178a448 ("serial: sh-sci: Support for HSCIF RX sampling point adjustment")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/sh-sci.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2497,7 +2497,9 @@ done:
 			 * center of the last stop bit in sampling clocks.
 			 */
 			int last_stop = bits * 2 - 1;
-			int deviation = min_err * srr * last_stop / 2 / baud;
+			int deviation = DIV_ROUND_CLOSEST(min_err * last_stop *
+							  (int)(srr + 1),
+							  2 * (int)baud);
 
 			if (abs(deviation) >= 2) {
 				/* At least two sampling clocks off at the


