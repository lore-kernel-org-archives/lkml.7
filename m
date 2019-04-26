Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3B4C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDF0206BF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="OyvOvzrp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfDZC0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 22:26:07 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:39294 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbfDZC0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 22:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1556245563; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o9aYnbBBsG31bu06WPoCmxnU2t+15WTo2eoyBq5LG9I=;
        b=OyvOvzrpfHxh8GZ2KmKTM1H0N1hi8tw3nYnoi6v61UMPcPwQFa3mJWb83E/hXxsXnJWqkl
        p0W1QC9wC4+HEuWTm79MDoBlQ/3MTTGohKQWxDY8bdNHeGRcQQVPQUiVKbErvmyYdAB/xA
        Z6oYoNZm4X0d8XxtPfekXYjuw+tG7jg=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, od@zcrc.me,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/2] ASoC: simple-card: Read pin switches conf from devicetree
Date:   Fri, 26 Apr 2019 04:25:50 +0200
Message-Id: <20190426022550.31359-2-paul@crapouillou.net>
In-Reply-To: <20190426022550.31359-1-paul@crapouillou.net>
References: <20190426022550.31359-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the routing path between a widget (e.g. "Speaker") and the codec
goes through an external amplifier, having a pin switch for this widget
allows the amplifier to be disabled when the widget is not to be used
(e.g. when using headphones).

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: - Rebase on top of for-next
        - Rename to asoc_simple_parse_pin_switches()

 sound/soc/generic/simple-card.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 335ead0cbb8a..9b568f578bcd 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -464,6 +464,10 @@ static int simple_parse_of(struct asoc_simple_priv *priv)
 	if (ret < 0)
 		return ret;
 
+	ret = asoc_simple_parse_pin_switches(card, PREFIX);
+	if (ret < 0)
+		return ret;
+
 	/* Single/Muti DAI link(s) & New style of DT node */
 	memset(&li, 0, sizeof(li));
 	for (li.cpu = 1; li.cpu >= 0; li.cpu--) {
-- 
2.21.0.593.g511ec345e18

