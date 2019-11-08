Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F4EC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA7A2085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573215172;
	bh=GFSVBNLPJtFDTvTDouENezti5bv31KmrpDsn995p2Sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k/ZPA89TTYMgXxlWlSJvNbBq7JZ5yT9FjfAyg9zDYoAh0nhGVINwhmeQiMg+wZXZO
	 FsvNHwr8cGLz5C83TwxD8WJDOlu16wwEmBU3+8EJbpkl8coQEiUzYto2mGAgAR0V17
	 b5Y8sCY08eB2hdfCNARa/gJPHXbpJY3B4aFu3H70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390867AbfKHMMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:12:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:51496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732721AbfKHLie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:38:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A98021D82;
        Fri,  8 Nov 2019 11:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213113;
        bh=GFSVBNLPJtFDTvTDouENezti5bv31KmrpDsn995p2Sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IEdkKAXNeS/LLb2+iNcfBGi/p8/rmNfOs6bb3i44OF4K3zbnajDYwlAmqG3s1E5Ld
         4gWT7TXMXQbCAjtDkYOrSGolW6K/EJmxOUpsUiKimTVH8UAUVW4t91iAfmcpFNs36/
         wMJwnaIxoHA7Qgu9hpFr+R3atfGeuYdwU4Xc2UB8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 036/205] ASoC: meson: axg-fifo: report interrupt request failure
Date:   Fri,  8 Nov 2019 06:35:03 -0500
Message-Id: <20191108113752.12502-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit dadfab7272b13ca441efdb9aa9117bc669680b05 ]

Return value of request_irq() was irgnored. Fix this and report
the failure if any

Fixes: 6dc4fa179fb8 ("ASoC: meson: add axg fifo base driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/meson/axg-fifo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index 30262550e37b1..0e4f65e654c4b 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -203,6 +203,8 @@ static int axg_fifo_pcm_open(struct snd_pcm_substream *ss)
 
 	ret = request_irq(fifo->irq, axg_fifo_pcm_irq_block, 0,
 			  dev_name(dev), ss);
+	if (ret)
+		return ret;
 
 	/* Enable pclk to access registers and clock the fifo ip */
 	ret = clk_prepare_enable(fifo->pclk);
-- 
2.20.1

