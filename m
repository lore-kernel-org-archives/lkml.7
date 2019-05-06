Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EC5C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9882087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153749;
	bh=5EZNgEpUADmHXhL1ByEDZooKAI0poijVu6Mm7T2mV1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JggqTT67hGa5QiK8JIOE2fqvuUi3IBrGvEIoNQ9fOYrw2Cwdl/kmoizPjx+eyeQcf
	 xWO/14ikH8PXXIOEu9BEhTOwtzHU19TOhAzHRC20zZ/wfHEs0h1DEri583myiPSt8O
	 4P3QMcXfTaAgYp7xsCnOneyhhBnX8GySgLGx4flU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfEFOm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:42:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727204AbfEFOmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:42:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 792E520449;
        Mon,  6 May 2019 14:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153745;
        bh=5EZNgEpUADmHXhL1ByEDZooKAI0poijVu6Mm7T2mV1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YroF7Qdl+BplzxDIbj7MXorZuMgYtosdQ7so6AGBfkxoQ1CEyCh5fdgKHedn6aYA9
         oVtNhZAbl27kO2ApR9LC3+9q/NNGJKxpU/+e95uD6AeZP5V2oae3kDNutvyu3m5j8o
         3qXeqpy5RXTpIK2/2i86kBTZMU0le6SGCjJuDknk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 80/99] ASoC: stm32: fix sai driver name initialisation
Date:   Mon,  6 May 2019 16:32:53 +0200
Message-Id: <20190506143101.331595404@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143053.899356316@linuxfoundation.org>
References: <20190506143053.899356316@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaud Pouliquen <arnaud.pouliquen@st.com>

commit 17d3069ccf06970e2db3f7cbf4335f207524279e upstream.

This patch fixes the sai driver structure overwriting which results in
a cpu dai name equal NULL.

Fixes: 3e086ed ("ASoC: stm32: add SAI driver")

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/stm/stm32_sai_sub.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1194,7 +1194,6 @@ static int stm32_sai_sub_dais_init(struc
 	if (!sai->cpu_dai_drv)
 		return -ENOMEM;
 
-	sai->cpu_dai_drv->name = dev_name(&pdev->dev);
 	if (STM_SAI_IS_PLAYBACK(sai)) {
 		memcpy(sai->cpu_dai_drv, &stm32_sai_playback_dai,
 		       sizeof(stm32_sai_playback_dai));
@@ -1204,6 +1203,7 @@ static int stm32_sai_sub_dais_init(struc
 		       sizeof(stm32_sai_capture_dai));
 		sai->cpu_dai_drv->capture.stream_name = sai->cpu_dai_drv->name;
 	}
+	sai->cpu_dai_drv->name = dev_name(&pdev->dev);
 
 	return 0;
 }


