Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC089C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCC620684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575412778;
	bh=j9FuM004d7noslHy407gvNN4CA2tvw5TnqGfzR6rNZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vEnGBj94tEyybFnxbv0wvvKm+JH1llWpUEiDxcAV0mnpfK0eE/gqkqHps2/NJqruc
	 xiD96phTk8mrVdV/e6j8TZZc5yYKGNnGRC8L9LVIvgr1HvdpmekLDroRax3517tam/
	 ps8mqn9mM9qYbPr59IQ7QYXkG5HU0w4nUORW9BD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfLCWjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:39:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:49958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727918AbfLCWje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:39:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AC702073C;
        Tue,  3 Dec 2019 22:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412773;
        bh=j9FuM004d7noslHy407gvNN4CA2tvw5TnqGfzR6rNZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c47J8bSgurwap9xxhBNR2zDyh9b7MfSnqPbSffcR3hcVyKfNRBK73cnyaYNni4b+Y
         szsj8oCf/wb3gwIxAZ+WvVSssxVnAGhd1xRHw16RmGPLthWCAG7NurHMUA9IGGxxG7
         xEqoJeqeLL5Hg/sE2fJSaL4XpauY/slqeGszSrfo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiaojun Sang <xsang@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 012/135] ASoC: compress: fix unsigned integer overflow check
Date:   Tue,  3 Dec 2019 23:34:12 +0100
Message-Id: <20191203213007.890854179@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaojun Sang <xsang@codeaurora.org>

[ Upstream commit d3645b055399538415586ebaacaedebc1e5899b0 ]

Parameter fragments and fragment_size are type of u32. U32_MAX is
the correct check.

Signed-off-by: Xiaojun Sang <xsang@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Vinod Koul <vkoul@kernel.org>
Link: https://lore.kernel.org/r/20191021095432.5639-1-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/compress_offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 41905afada63f..f34ce564d92c4 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -528,7 +528,7 @@ static int snd_compress_check_input(struct snd_compr_params *params)
 {
 	/* first let's check the buffer parameter's */
 	if (params->buffer.fragment_size == 0 ||
-	    params->buffer.fragments > INT_MAX / params->buffer.fragment_size ||
+	    params->buffer.fragments > U32_MAX / params->buffer.fragment_size ||
 	    params->buffer.fragments == 0)
 		return -EINVAL;
 
-- 
2.20.1



