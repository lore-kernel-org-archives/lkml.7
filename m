Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867A5CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5782920679
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572212272;
	bh=fMC2KVqM3DIfY3q5vtjxo4yXJnY7/FVmoBRpuqNzRi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OULaCGp65mULVtx2lVAqxDZCjTSrlU2sEwa5JMHM8BmCKjlNn34DLzm6FuHs9jQyq
	 0K7fxUJIQ2LIMi6KjqSa/jaApIrn5iufVWIldaffjCJhLNzIxhwrkb1AW7FE+6l2Ga
	 UsZuNSkIjoJ4+Alwhe5iOj5glUSV2ugfjebTxTeM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfJ0VEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:04:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728651AbfJ0VEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:04:32 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B8CA2064A;
        Sun, 27 Oct 2019 21:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210271;
        bh=fMC2KVqM3DIfY3q5vtjxo4yXJnY7/FVmoBRpuqNzRi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xpt+YiKr5PJWB/BbaIo82SliHbaqWQ7OGp54LegIOuKZVzBnuSNf9gzkLgjZuIk72
         +qa8EgoDDbkqBSQNn0tb0Ca4pR6ZE7lt6H0NAi8sGVUhP2L4AK83b7UFMWRkvJ9b0v
         gfl9zEoYNp5mak1nSh4XpS34YE4f7IUXr+WmDFZA=
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
Subject: [PATCH 4.4 26/41] ASoC: rsnd: Reinitialize bit clock inversion flag for every format setting
Date:   Sun, 27 Oct 2019 22:01:04 +0100
Message-Id: <20191027203121.969779760@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203056.220821342@linuxfoundation.org>
References: <20191027203056.220821342@linuxfoundation.org>
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
@@ -524,6 +524,7 @@ static int rsnd_soc_dai_set_fmt(struct s
 	}
 
 	/* set format */
+	rdai->bit_clk_inv = 0;
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		rdai->sys_delay = 0;


