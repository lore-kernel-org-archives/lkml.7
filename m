Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFBBCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6C02070B
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211351;
	bh=2ZPOl9cUdX5/sAga0CKsMxcp69D8i9gJwHMKO1SyhNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pegF/RjFz23cAWuyQRoFNp+LRKIV012q1D0z6Di5UJ8L73t6IvIdip6tNa5EkkiRg
	 /QiTkrxaWwjVkjFMMU6F+UqAsNy9H6jbyrxFsEz4BirA0RU84wtnaWTu/JMPpjvALu
	 puaDzo0ddi6BpLUE4f2yncD1O+rZOJDKAEqmC1O0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbfJ0VWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:22:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732146AbfJ0VW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:22:27 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6320B2070B;
        Sun, 27 Oct 2019 21:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211346;
        bh=2ZPOl9cUdX5/sAga0CKsMxcp69D8i9gJwHMKO1SyhNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=luGGqku0cGN69QyL+HTLxCVfzOREXwuUimUJRBVd2qxMA446Mn2Q/9kz2zNgcAjTy
         buWn73PURDvHHZzZoQzuwYskzOpUv5QdoM9j+vJDdBROQyeTB3p1CFXhk/GFD/TSnx
         cKVi5I4kSwKxwiW2C+nW6hzZlczk5l7asP9ssrOQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Jiada Wang <jiada_wang@mentor.com>,
        Timo Wischer <twischer@de.adit-jv.com>,
        Junya Monden <jmonden@jp.adit-jv.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.3 118/197] ASoC: rsnd: Reinitialize bit clock inversion flag for every format setting
Date:   Sun, 27 Oct 2019 22:00:36 +0100
Message-Id: <20191027203358.101191673@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junya Monden <jmonden@jp.adit-jv.com>

commit 22e58665a01006d05f0239621f7d41cacca96cc4 upstream.

Unlike other format-related DAI parameters, rdai->bit_clk_inv flag
is not properly re-initialized when setting format for new stream
processing. The inversion, if requested, is then applied not to default,
but to a previous value, which leads to SCKP bit in SSICR register being
set incorrectly.
Fix this by re-setting the flag to its initial value, determined by format.

Fixes: 1a7889ca8aba3 ("ASoC: rsnd: fixup SND_SOC_DAIFMT_xB_xF behavior")
Cc: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Cc: Jiada Wang <jiada_wang@mentor.com>
Cc: Timo Wischer <twischer@de.adit-jv.com>
Cc: stable@vger.kernel.org # v3.17+
Signed-off-by: Junya Monden <jmonden@jp.adit-jv.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/20191016124255.7442-1-erosca@de.adit-jv.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/sh/rcar/core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -761,6 +761,7 @@ static int rsnd_soc_dai_set_fmt(struct s
 	}
 
 	/* set format */
+	rdai->bit_clk_inv = 0;
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		rdai->sys_delay = 0;


