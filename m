Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F7CC606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6933220645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599693;
	bh=wulHnAKnIRQXmD5SlTRtiU7beGLqGFFGxwlQru+CWj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MzU+cB7vSDLWX1uM9wWd6I6iZjPEvjG7odVEHYz0rhN7fTp/+goQJFgYjsYDTCgnf
	 R6L8aiV5NW2j6xhc6wyKSDe734KPwL78eDXJ4e9r4gKI6zbbpZYs6V/YOPB77+9oVz
	 6/K1OLG5xm7iJCggkn/ieONC9c/86NVdljiU0iio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389235AbfGHP2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:28:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730098AbfGHP2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:28:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 818F520645;
        Mon,  8 Jul 2019 15:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599689;
        bh=wulHnAKnIRQXmD5SlTRtiU7beGLqGFFGxwlQru+CWj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r4mbpYldFBMk0qiyzuYKghfFNuWYXnnrqR9//1gFPpj3vpQo0mbE9pD7YKb1chwHG
         sLLo8gIjq2S8D7WnMNM4riAaaDVXsM+ZRhUCbqnZF03e0bFBrhvu9LpEgvyyHW9ot2
         IJzRO4zpB9gsgX6HM+uyKaOzFzvor4wRjqvqsCvc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Flax <flatmax@flatmax.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 08/90] ASoC : cs4265 : readable register too low
Date:   Mon,  8 Jul 2019 17:12:35 +0200
Message-Id: <20190708150522.952943044@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150521.829733162@linuxfoundation.org>
References: <20190708150521.829733162@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f3df05c805983427319eddc2411a2105ee1757cf ]

The cs4265_readable_register function stopped short of the maximum
register.

An example bug is taken from :
https://github.com/Audio-Injector/Ultra/issues/25

Where alsactl store fails with :
Cannot read control '2,0,0,C Data Buffer,0': Input/output error

This patch fixes the bug by setting the cs4265 to have readable
registers up to the maximum hardware register CS4265_MAX_REGISTER.

Signed-off-by: Matt Flax <flatmax@flatmax.org>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs4265.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
index 407554175282..68d18aca397d 100644
--- a/sound/soc/codecs/cs4265.c
+++ b/sound/soc/codecs/cs4265.c
@@ -60,7 +60,7 @@ static const struct reg_default cs4265_reg_defaults[] = {
 static bool cs4265_readable_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case CS4265_CHIP_ID ... CS4265_SPDIF_CTL2:
+	case CS4265_CHIP_ID ... CS4265_MAX_REGISTER:
 		return true;
 	default:
 		return false;
-- 
2.20.1



