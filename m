Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD887C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E03D20811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127087;
	bh=JXrIYMk1HEm5HgsJ5WYaBiGjp44leD+iI1UzFa86uAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q8l6DOKyMInFEDA6nzAqPigYJ5AeaJbsyvxtNm4/hv0xh9kpSId6LzL0yhq8DRd3y
	 dALMgVOtYJqe/+ttLeiAEGKVeVnJHYE1I9eqerYbiBFesBbwPgvRlWMYQ5pe0xs0Kc
	 T26UBE2DtLe7+L/xZY8QtROJ274cujD1rusdB5Y4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403801AbfDXRb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:31:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403789AbfDXRbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:31:24 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D454D20811;
        Wed, 24 Apr 2019 17:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127083;
        bh=JXrIYMk1HEm5HgsJ5WYaBiGjp44leD+iI1UzFa86uAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eMC78qt4o2LAQKIFHbIZpCOKo4S9u6S4l3HePREv/iOmWhkx3aebTHOILD6N3/WLl
         Oh5YdcmpUtbtvy8izS0LsjoRserJPPfqREjQPgWJm9/oRaiyzpQOUVJfh8PkgFUOMd
         PgT5igUMJfcENwpDlj+WHxA9IpyYVAYiV9WnKomQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Ulrich Hecht <uli+renesas@fpond.eu>
Subject: [PATCH 4.19 56/96] serial: sh-sci: Fix HSCIF RX sampling point calculation
Date:   Wed, 24 Apr 2019 19:10:01 +0200
Message-Id: <20190424170923.545229462@linuxfoundation.org>
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


