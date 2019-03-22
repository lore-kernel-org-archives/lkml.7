Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7C2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB65620850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255894;
	bh=rMKl+uHl9JDVW1O2rw/6StSy5cJmjt4XGIL2ulQNiJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rJCdHHE4Ezu7rF5poy2BF966ZQO1QgpSwdOgNNu/711BcaDlXTumAAoAUqHQZH+hy
	 hRpiy3rTb5FYGPqAgn6kjmNaHk1Ql91tiT7rMgRvsJfuAg8l6E67YutH2iBXsRKgCO
	 JEonMlIu/y4SLUDHkM4doxiagtVrS64bkHDfDD9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387787AbfCVL6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:58:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387773AbfCVL6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:58:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3442020850;
        Fri, 22 Mar 2019 11:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255888;
        bh=rMKl+uHl9JDVW1O2rw/6StSy5cJmjt4XGIL2ulQNiJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MJow4FGJhdBzO5QVoeaEJu1X6+IEO++KxK7MNRt9/FUKmk8KTDROtmWoMHdm2sY2I
         OTVpjovlC11z5mxKgBUOciYC+Et99bbHbwdrxyiZYdGlgqavrSinKB8kpw1KUiB3U7
         sQa5q7PG8rMyXYcHWZr3lutZeQRU2FlkzJ00a5+A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuming Fan <shumingf@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 027/280] ASoC: rt5682: Correct the setting while select ASRC clk for AD/DA filter
Date:   Fri, 22 Mar 2019 12:13:00 +0100
Message-Id: <20190322111307.825134270@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8077ec011b1ea26abb7ca786f28ecccfb352717f ]

AD/DA ASRC function control two ASRC clock sources separately.
Whether AD/DA filter select which clock source, we enable AD/DA ASRC
function for all cases.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5682.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index afe7d5b19313..79ebcc239786 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -1757,7 +1757,9 @@ static const struct snd_soc_dapm_route rt5682_dapm_routes[] = {
 	{"ADC Stereo1 Filter", NULL, "ADC STO1 ASRC", is_using_asrc},
 	{"DAC Stereo1 Filter", NULL, "DAC STO1 ASRC", is_using_asrc},
 	{"ADC STO1 ASRC", NULL, "AD ASRC"},
+	{"ADC STO1 ASRC", NULL, "DA ASRC"},
 	{"ADC STO1 ASRC", NULL, "CLKDET"},
+	{"DAC STO1 ASRC", NULL, "AD ASRC"},
 	{"DAC STO1 ASRC", NULL, "DA ASRC"},
 	{"DAC STO1 ASRC", NULL, "CLKDET"},
 
-- 
2.19.1



