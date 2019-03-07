Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EECC10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E8D2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY5YaEU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfCGRQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:16:18 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34548 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCGRQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:16:18 -0500
Received: by mail-ed1-f67.google.com with SMTP id a16so14143694edn.1;
        Thu, 07 Mar 2019 09:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q6MtqSnvkN42Z4rq12gEjJsLLTxX1BDFhkW479yq9mE=;
        b=OY5YaEU3lnNl1Qw5EhFInBU/GFJ4+QkrYkp62QOXXS1OStwktgfDC5kFk84WNFGgDF
         v0q11hMORc4bWWamYBAoclh6UfqldBGuxQVweWU+lcp6Lz+MuP9+QYpJLSsX9QZM2yFi
         EDIOH22s4Xvpyxo4jlNyPp/Jk81PV+Vjmv0+2TTSPsF3Wmu6hPiykNbxtebSAxO2eQ93
         nE6KNCtx297wJmHfWgRJtzpHH/ZO5iM8tQjyMIfAnEVUj1Y1T+ON/Qfng7lXPG/bBw7I
         wUDHAHOA27q9k4yrf0DQKcfYxCCYLmduMikr3nplM6rL9nIF6SipE5A82tg/AWuEbAvu
         j95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q6MtqSnvkN42Z4rq12gEjJsLLTxX1BDFhkW479yq9mE=;
        b=n7qHLaQ85ltMd909J4QGShm4ywkTBZEPCTplMkkXiEAMnPt3bYx2V4oVrKl9rYXohy
         T0pEjv44q9MTcj0B2ScIGHIe5TVsKMoyaf5x4DIcKZv0GYsMVoPbhezNuPRxI8eky/LR
         64rPXRUP4kKzTTe72qrkZIWlRbDTTmTHcwIBDA0QgaOQYetbkd/g6gq6eHBBkbs6GXb3
         fKuTd6+CVI4iGBoxCcI6TMrzwdQZQULu8cb8UIliaq2Elp4EeAMIJAjIW377RKPJDlTa
         gUwwQAlIX3FaRNnsk6kRvxkttaCOSQfXUxxIQjpSkqC73zVMClb8b1U2BqaAgd5njkLA
         5n1w==
X-Gm-Message-State: APjAAAUA6ar2kBkdS8cbd/eXyfKnOHMxd3xikeaUcBel2Oue3YgXkMEC
        Xs9zeNkelA/3qVW2ZdjBTxY=
X-Google-Smtp-Source: APXvYqx03/jTxe3alHOPP6+eOYIoxkrPdaREM7KE06BhTI9bfNRMgqApnRYtVPwC4IxdGgC+X3Y8Lw==
X-Received: by 2002:a50:b16e:: with SMTP id l43mr27589347edd.99.1551978975997;
        Thu, 07 Mar 2019 09:16:15 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id v13sm1470608edm.73.2019.03.07.09.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 09:16:15 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Stefan Agner <stefan@agner.ch>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] iio: adc: stmpe-adc: Shuffle an if statement around in stmpe_adc_isr
Date:   Thu,  7 Mar 2019 10:16:04 -0700
Message-Id: <20190307171604.27791-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Wsometimes-uninitialized, Clang warns:

drivers/iio/adc/stmpe-adc.c:204:13: warning: variable 'data' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]

Clang can't tell that data will never be used uninitialized because the
two if statements take care of all cases. Remove the first if statement
and make it the else branch of the second one so that it is apparent to
Clang that all cases are covered.

Link: https://github.com/ClangBuiltLinux/linux/issues/387
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/iio/adc/stmpe-adc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
index 37f4b74a5d32..7921f827c6ec 100644
--- a/drivers/iio/adc/stmpe-adc.c
+++ b/drivers/iio/adc/stmpe-adc.c
@@ -184,9 +184,6 @@ static irqreturn_t stmpe_adc_isr(int irq, void *dev_id)
 	struct stmpe_adc *info = (struct stmpe_adc *)dev_id;
 	u16 data;
 
-	if (info->channel > STMPE_TEMP_CHANNEL)
-		return IRQ_NONE;
-
 	if (info->channel <= STMPE_ADC_LAST_NR) {
 		int int_sta;
 
@@ -205,6 +202,8 @@ static irqreturn_t stmpe_adc_isr(int irq, void *dev_id)
 		/* Read value */
 		stmpe_block_read(info->stmpe, STMPE_REG_TEMP_DATA, 2,
 				(u8 *) &data);
+	} else {
+		return IRQ_NONE;
 	}
 
 	info->value = (u32) be16_to_cpu(data);
-- 
2.21.0

